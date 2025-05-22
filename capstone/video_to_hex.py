"""
VIDEO TO HEX CONVERTER
 - Python script to convert an mp4 into an array of hex values 
   for use in a VGA controlled by an FPGA
"""
import cv2
from PIL import Image, ImageOps
import os
import numpy as np

# PROGRAM VARS
# number of visible pixels per horizontal line: 640
# number of visible horizontal lines per frame: 480
# aspect ratio: 4:3
video_path = "bad_appleMV.mp4"     # path to directory of mp4 file
num_frames = 3285      # number of desired frames
pix_width = 64       # number of pixels wide per frame 
pix_height = 48      # number of pixels tall per frame 

# PROGRAM OUTPUTS
bit_frames_output = []                                      #generates a list of each array of bit values
bit_string_output = []
hex_frames_output = []                                      # generates a list of each frame as a hex string
frame_color = {"#FFFFFF":"WHITE", "#000000":"BLACK"}    #dictionary that associates each hex value with a color name
new_fps = 0                                             #indicates new fps for fpga to use

# CAPTURE VIDEO WITH CV2
vidcap = cv2.VideoCapture(video_path)
# store each frame in a folder as a jpeg
if not vidcap.isOpened():
    print("BAD FILE :-(")
else:
    success,frame = vidcap.read()
    # determine how many frames to capture and set
    if not success:
        print("BAD FRAMES :-(")
    else: 
        # find total frames / seconds
        total_frames = int(vidcap.get(cv2.CAP_PROP_FRAME_COUNT))
        default_fps = vidcap.get(cv2.CAP_PROP_FPS)
        print(f"default number of frames: {total_frames}, default fps: {default_fps}")
        total_seconds = total_frames / default_fps
        new_fps = num_frames / total_seconds
        print(f"Total Seconds: {total_seconds}")

        # read each frame
        frame_count = int(total_frames/num_frames)
        saved_count = 0
        vidcap.set(cv2.CAP_PROP_FPS, new_fps)
        while success:
            if(frame_count == int(total_frames/num_frames)):
                # Construct the output file name
                output_path = os.path.join("./frames", f"frame_{saved_count:04d}.jpg")
                # Save the frame as an image
                cv2.imwrite(f"./frames/frame_{saved_count:04d}.jpg", frame) 
                #print('Read a new frame: ', success) 
                saved_count += 1
                frame_count = 0

            success,frame = vidcap.read()
            frame_count += 1
        vidcap.release()

# INTERPRET IMAGES WITH PILLOW
# turn each frame in ./frames into an array of hex values

# create function to get path to each frame
def get_next_path(num):
    num_str = f"{num:04d}"  # zero-pads the number to 4 digits
    path = f"./frames/frame_{num_str}.jpg"
    return path

for i in range (0, num_frames + 1):
    bit_string = ""
    image_path = get_next_path(i)
    #print(os.path.exists(image_path))
    try:
        image = Image.open(image_path)

        image = image.resize((pix_width, pix_height))
        image = image.convert("RGB")

        pixels = image.getdata()
        hex_array = []

        # turn into hex values
        for pixel in pixels:
            r, g, b = pixel
            hex_color = f'#{r:02x}{g:02x}{b:02x}'
            if hex_color != "#000000":
                bit_string += '1'
                hex_array.append(1)
            else:
                hex_array.append(0)
                bit_string += '0'
        #print(f"Frame{i}: ", hex_array)
        bit_frames_output.append(hex_array)
        bit_string_output.append(bit_string)
        
    except FileNotFoundError:
        print(f"Error: Image not found at {image_path}")
        break
"""
# convert values to hex
for frame_array in bit_frames_output:
    #get bit string that is a multiple of 4
    bit_string = ""
    for bit in frame_array:
        bit_string += str(bit)
    if(len(bit_string) %4 != 0):
        bit_string += f"{0:0{bit_string%4}d}"
        print("Added extra bits at ends pls ignore :( - ", bit_string%4, "bits")

    hex_string = ""
    for i in range(0, len(bit_string), 4):
        chunk = bit_string[i:i+4]              #single hex value
        decimal_value = int(chunk, 2)
        hex_string += hex(decimal_value)[2:].upper()  # [2:] removes "0x" prefix
    hex_frames_output.append(hex_string)
"""

"""
# CONDENSE WITH RLE + FRAME DELTA
def rle_encode(bitstring):
    #Run-length encode a bit string.
    encoded = []
    current_bit = bitstring[0]
    count = 1
    
    for bit in bitstring[1:]:
        if bit == current_bit:
            count += 1
        else:
            encoded.append((current_bit, count))
            current_bit = bit
            count = 1
    encoded.append((current_bit, count))
    return encoded


def frame_delta(curr_frame, prev_frame):
    #Calculate the delta frame: '1' where bits changed, '0' otherwise.
    return ''.join('1' if c != p else '0' for c, p in zip(curr_frame, prev_frame))


def encode_frames(frames):
    #Encode a list of bitstring frames using RLE + Delta Encoding.
    
    #First frame is RLE encoded.
    #Subsequent frames are delta-encoded (against previous), then RLE encoded.
    if not frames:
        return []

    encoded = []

    # First frame: store full RLE
    first_frame = frames[0]
    encoded.append(('full', rle_encode(first_frame)))

    # Remaining frames: delta + RLE
    prev_frame = first_frame
    for frame in frames[1:]:
        delta = frame_delta(frame, prev_frame)
        rle = rle_encode(delta)
        encoded.append(('delta', rle))
        prev_frame = frame

    return encoded

encoded = encode_frames(bit_string_output)

with open("./hex_frames.csv", "w") as file:
    file.truncate(0)  # Truncate the file, effectively clearing its content
    file.write(f"FRAMES")
    file.write(str(encoded))
"""
def frame_delta(frames_2D):
    #1st frame is same as 1st initial frame in, later arrays have 1 if bit from prior frame flips
    total_frame_dif = []
    total_frame_dif.append(frames_2D[0])
    
    old_frame = frames_2D[0]
    for i in range(1,len(frames_2D)):
        frame_dif = []
        for j in range(0,len(old_frame)):
            if (old_frame[j]) == frames_2D[i][j]:
                frame_dif.append(0)
            else:
                frame_dif.append(1)
        old_frame = frames_2D[i]
        total_frame_dif.append(frame_dif)
    return total_frame_dif

def rle(frames_2D):
    rle_frames = []
    # for each frame in frames 2D
    for i in range (0, len(frames_2D)):
        data = frames_2D[i]
        encoded = []
        count = 1
        prev_bit = data[0]

        for bit in data[1:]:
            if bit == prev_bit:
                count += 1
            else:
                encoded.append((prev_bit, count))
                count = 1
                prev_bit = bit

        encoded.append((prev_bit, count))
        rle_frames.append(encoded)

    return rle_frames

delta_frames = frame_delta(bit_frames_output)
rle_frames = rle(delta_frames)

with open("./hex_frames.csv", "w") as file:
    file.truncate(0)  # Truncate the file, effectively clearing its content
    file.write(str(rle_frames))

print("Program Success!!!!")
#print(f"NUM OF HEX VALS PER FRAME: {len(hex_frames_output[0])}")
print(f"NUM OF BIT VALS PER FRAME: {len(bit_frames_output[0])}")
print(f"NUM FRAMES: {len(hex_frames_output)}")
print(f"SECONDS PER FRAME: {1/new_fps}")

numpairs_counter = 0
for i in range(0,len(rle_frames)):
    numpairs_counter += len(rle_frames[i])
print(f"TOTAL NUM PAIRS: {numpairs_counter}")


