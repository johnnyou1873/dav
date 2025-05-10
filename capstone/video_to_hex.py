"""
VIDEO TO HEX CONVERTER
 - Python script to convert an mp4 into an array of hex values 
   for use in a VGA controlled by an FPGA
"""
import cv2

# program vars

# number of visible pixels per horizontal line: 640
# number of visible horizontal lines per frame: 480
# aspect ratio: 4:3
video_path = ""     # path to directory of mp4 file
num_frames = 0      # number of desired frames
pix_width = 0       # number of pixels wide per frame 
pix_height = 0      # number of pixels tall per frame 
num_colors = 0      # number of colors over all frames

vidcap = cv2.VideoCapture(video_path)

if not vidcap.isOpened():
    print("BAD FILE :(")
else:
    success,image = vidcap.read()
    # determine how many frames to capture and set
    if not success:
        print("BAD FRAMES :(")
    else: 
        # find total frames / seconds
        total_frames = int(vidcap.get(cv2.CAP_PROP_FRAME_COUNT))
        default_fps = vidcap.get(cv2.CAP_PROP_FPS)
        total_seconds = total_frames / default_fps

        calc_fps = num_frames / total_seconds

        # turn each frame into a jpg image
        vidcap.set(cv2.CAP_PROP_FPS, calc_fps)
        while success:
            cv2.imwrite("frame%d.jpg" % count, image)     # save frame as JPEG file      
            success,image = vidcap.read()
            print('Read a new frame: ', success)
            count += 1
        vidcap.release()
