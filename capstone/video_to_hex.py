"""
VIDEO TO HEX CONVERTER
 - Python script to convert an mp4 into an array of hex values 
   for use in a VGA controlled by an FPGA
"""
import cv2
from pillow import Image, ImageOps
import numpy as np

# PROGRAM VARS
# number of visible pixels per horizontal line: 640
# number of visible horizontal lines per frame: 480
# aspect ratio: 4:3
video_path = "bad_appleMV.mp4"     # path to directory of mp4 file
num_frames = 10      # number of desired frames
pix_width = 0       # number of pixels wide per frame 
pix_height = 0      # number of pixels tall per frame 
num_colors = 0      # number of colors over all frames

# PROGRAM OUTPUTS
frames_output = []                                      #generates a list of each array of hex values
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
        print(f"TEST: {total_frames/num_frames}")

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
                print('Read a new frame: ', success) 
                saved_count += 1
                frame_count = 0

            success,frame = vidcap.read()
            frame_count += 1
        vidcap.release()

# INTERPRET IMAGES WITH PILLOW
# turn each frame in ./frames into an array of hex values

# create function to get path to each frame
def get_next_path(num):
    place = 3
    num_adjusted = "0000"
    while(num != 0):
        num_adjusted[place] = num%10
        place -= 1
        num /= 10
    path = f"capstone/frames/frame_"+num_adjusted+".jpg"
    return path

for i in range (0, num_frames + 1):
    path = get_next_path(i)
    image_path = "your_image.jpg"  # Replace with your image path
    try:
        image = Image.open(image_path)

        image = image.resize((pix_width, pix_height))
        image = image.convert("RGB")

        pixels = image.getdata()
        hex_array = []

        for pixel in pixels:
            r, g, b = pixel
            hex_color = f'#{r:02x}{g:02x}{b:02x}'
            hex_array.append(hex_color)


        print(f"Frame{i}: ", hex_array)
    except FileNotFoundError:
        print(f"Error: Image not found at {image_path}")
        break
