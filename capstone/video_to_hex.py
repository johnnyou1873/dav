"""
VIDEO TO HEX CONVERTER
 - Python script to convert an mp4 into an array of hex values 
   for use in a VGA controlled by an FPGA
"""
import cv2
import os
from PIL import Image

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

for filename in os.listdir("./frames"):
    if filename.lower().endswith(('.jpg', '.jpeg')):
        file_path = os.path.join("./frames", filename)
        try:
            img = Image.open(file_path)
            # Perform operations on the image here, e.g.,
            # img.show()
            # img.save("new_location/modified_" + filename)
            print(f"Processed: {filename}")
            img.close()
        except Exception as e:
            print(f"Error processing {filename}: {e}")

