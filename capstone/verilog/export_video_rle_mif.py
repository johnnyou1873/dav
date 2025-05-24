#!/usr/bin/env python3
"""
export_video_rle_mif.py

Convert a video into an RLE-encoded B/W block bitstream and emit an Altera MIF:
 - 40×30 blocks (16×16 pixels per block) → 1200 bits per frame
 - exactly 11.9047619 FPS sampling (no integer skipping)
 - flatten all blocks into one long 0/1 stream
 - run-length encode into 6-bit words: [bit<<5 | (run_len−1)], run_len ∈ [1..32]
 - output MIF with WIDTH=6, DEPTH=#runs
"""

import cv2
import argparse
import sys

def process_video(path, target_fps, blocks_w, blocks_h, thresh):
    """
    Read video frames and sample at exactly target_fps by timestamp.
    Resize each sampled frame to (blocks_w × blocks_h), threshold to B/W,
    and flatten into bits.
    """
    cap = cv2.VideoCapture(path)
    if not cap.isOpened():
        raise IOError(f"Cannot open video {path!r}")

    orig_fps = cap.get(cv2.CAP_PROP_FPS)
    if orig_fps <= 0 or target_fps <= 0:
        raise ValueError("Invalid original FPS or target FPS")

    interval = 1.0 / target_fps   # seconds between samples
    next_time = 0.0

    bits = []
    frame_idx = 0
    while True:
        ret, frame = cap.read()
        if not ret:
            break

        # current timestamp in seconds
        t = frame_idx / orig_fps
        if t + 1e-9 >= next_time:
            # sample this frame
            small = cv2.resize(frame, (blocks_w, blocks_h),
                               interpolation=cv2.INTER_AREA)
            gray = cv2.cvtColor(small, cv2.COLOR_BGR2GRAY)
            _, bw = cv2.threshold(gray, thresh, 1, cv2.THRESH_BINARY)
            for row in bw:
                bits.extend(int(b) for b in row)
            next_time += interval

        frame_idx += 1

    cap.release()
    return bits

def rle_encode(bits):
    """
    Run-length encode bits into 6-bit words:
      word = (bit<<5) | (run_len−1), enabling run_len up to 32.
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
    # 6 bits → needs 2 hex digits
    hex_digits = 2
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
        description="Video → RLE MIF (16×16 blocks, 6-bit runs, exact 11.9047619 FPS)"
    )
    p.add_argument("input",     help="input video file")
    p.add_argument("output",    help="output .mif file")
    p.add_argument("--fps",      type=float, default=11.9047619,
                   help="exact target FPS (default: 11.9047619)")
    p.add_argument("--blocks-w", type=int, default=40,
                   help="blocks per row (640/16 = 40)")
    p.add_argument("--blocks-h", type=int, default=30,
                   help="blocks per column (480/16 = 30)")
    p.add_argument("--thresh",   type=int, default=127,
                   help="B/W threshold (0–255)")
    args = p.parse_args()

    bits = process_video(
        args.input,
        args.fps,
        args.blocks_w,
        args.blocks_h,
        args.thresh
    )
    num_blocks = args.blocks_w * args.blocks_h
    num_frames = len(bits) // num_blocks
    print(f"# Sampled {num_frames} frames at {args.fps} FPS → {len(bits)} bits",
          file=sys.stderr)

    rle = rle_encode(bits)
    print(f"# Encoded into {len(rle)} runs (6-bit words)", file=sys.stderr)

    write_mif(rle, args.output)
    print(f"# Written RLE-MIF: {args.output}", file=sys.stderr)

if __name__ == "__main__":
    main()
