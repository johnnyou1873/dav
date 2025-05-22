bits = "00010100100010101"
"""
def condense_bits(bits_in):
    new_string = ""
    new_array = []
    c_val = bits_in[0]
    new_string += str(bits_in[0])
    new_array = []
    c_count = 1
    for i in range(1,len(bits_in)):
        if(bits_in[i]==c_val):
            c_count += 1
        else:
            new_string += ","
            new_string += str(c_count)
            new_string += " "
            c_count = 1
            c_val = bits_in[i]
            new_string += c_val

    return new_string

print(condense_bits(bits))
"""

frames_2D_in = [[0,1,1],[0,1,1],[0,0,0],[0,0,1]]

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

print(rle(frame_delta(frames_2D_in)))