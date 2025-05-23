#!/usr/bin/env python3
"""
export_video_rle_mif.py

Convert a video into an RLE‐encoded B/W block bitstream and emit an Altera MIF:
 - 40×30 blocks (16×16 pixels per block) → 1200 bits per frame
 - ~15 FPS sampling
 - flatten all blocks into one long 0/1 stream
 - run‐length encode into 6‐bit words: [bit<<5 | (run_len−1)], run_len ∈ [1..32]
 - output MIF with WIDTH=6, DEPTH=#runs
"""

import cv2
import argparse
import sys

def process_video(path, fps, blocks_w, blocks_h, thresh):
    """
    Capture video frames at ~fps, resize each to (blocks_w × blocks_h),
    threshold to B/W, and flatten into a list of bits.
    """
    cap = cv2.VideoCapture(path)
    if not cap.isOpened():
        raise IOError(f"Cannot open video {path!r}")
    orig_fps = cap.get(cv2.CAP_PROP_FPS) or fps
    skip     = max(1, int(round(orig_fps / fps)))

    bits = []
    idx = 0
    while True:
        ret, frame = cap.read()
        if not ret:
            break
        if idx % skip == 0:
            small = cv2.resize(frame, (blocks_w, blocks_h), interpolation=cv2.INTER_AREA)
            gray  = cv2.cvtColor(small, cv2.COLOR_BGR2GRAY)
            _, bw = cv2.threshold(gray, thresh, 1, cv2.THRESH_BINARY)
            for row in bw:
                bits.extend(int(b) for b in row)
        idx += 1
    cap.release()
    return bits

def rle_encode(bits):
    """
    Run‐length encode a list of bits into 6‐bit words:
      each word = (bit<<5) | (run_len−1), allowing run_len up to 32.
    """
    if not bits:
        return []
    out = []
    curr = bits[0]
    cnt = 1
    for b in bits[1:]:
        if b == curr and cnt < 32:
            cnt += 1
        else:
            out.append((curr << 5) | (cnt - 1))
            curr = b
            cnt = 1
    out.append((curr << 5) | (cnt - 1))
    return out

def write_mif(rle_words, fname):
    """
    Write the RLE words into an Altera MIF file with WIDTH=6.
    """
    width = 6
    depth = len(rle_words)
    hex_digits = (width + 3) // 4  # = 2 hex digits for 6 bits
    with open(fname, 'w') as f:
        f.write(f"WIDTH={width};\n")
        f.write(f"DEPTH={depth};\n\n")
        f.write("ADDRESS_RADIX = DEC;\n")
        f.write("DATA_RADIX    = HEX;\n\n")
        f.write("CONTENT BEGIN\n")
        for addr, val in enumerate(rle_words):
            f.write(f"  {addr} : {val:0{hex_digits}X};\n")
        f.write("END;\n")

def main():
    p = argparse.ArgumentParser(
        description="Video → RLE MIF (16×16 blocks, 6‐bit runs)"
    )
    p.add_argument("input",     help="input video file")
    p.add_argument("output",    help="output .mif file")
    p.add_argument("--fps",      type=int, default=15, help="target FPS")
    p.add_argument("--blocks-w", type=int, default=40,
                   help="blocks per row (640/16 = 40)")
    p.add_argument("--blocks-h", type=int, default=30,
                   help="blocks per col (480/16 = 30)")
    p.add_argument("--thresh",   type=int, default=127, help="B/W threshold")
    args = p.parse_args()

    bits = process_video(
        args.input,
        args.fps,
        args.blocks_w,
        args.blocks_h,
        args.thresh
    )
    num_frames = len(bits) // (args.blocks_w * args.blocks_h)
    print(f"# Captured {num_frames} frames × "
          f"{args.blocks_w}×{args.blocks_h} blocks → {len(bits)} bits",
          file=sys.stderr)

    rle = rle_encode(bits)
    print(f"# Encoded into {len(rle)} runs (6‐bit words)", file=sys.stderr)

    write_mif(rle, args.output)
    print(f"# Written RLE‐MIF: {args.output}", file=sys.stderr)

if __name__ == "__main__":
    main()
