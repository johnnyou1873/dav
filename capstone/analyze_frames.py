import ast
import itertools
import matplotlib.pyplot as plt

with open("./hex_frames.csv", "r") as file:
    vals = file.read()
data = ast.literal_eval(vals)
print(data[0])

flattend_data = list(itertools.chain.from_iterable(data))
#print(flattend_data)

def plot_tuple_pairs(data):
  """
  Plots tuple pairs from a list of tuples.

  Args:
    data: A list of tuples, where each tuple contains two numeric values (x, y).
  """
  x_values, y_values = zip(*data)
  plt.scatter(x_values, y_values, marker='o')
  plt.xlabel("x values")
  plt.ylabel("y values")
  plt.title("Plot of Tuple Pairs")
  plt.grid(True)
  plt.show()

#plt.rcParams['agg.path.chunksize'] = 10000
#plot_tuple_pairs(flattend_data)

def tup_to_binary(tup):
   bit_string = ""
   bit_string += str(tup[0])
   bit_string += bin(tup[1])[2:]
   return bit_string
# 2D array of bits of each frame
vals = []
for arr in data:
    arr_bins = []
    for tup in arr:
      arr_bins.append(tup_to_binary(tup))
    vals.append(arr_bins)

# create hash table
num_bits = 0
flatvals = list(itertools.chain.from_iterable(vals))
bin_hash = {}
count = 0
for bins in flatvals:
    if bins not in bin_hash:
      num_bits += len(bins)
      bin_hash[bins] = count
      count += 1
    else:
      continue
print(bin_hash)
for val in bin_hash:
   print(f" lut[{bin_hash[val]}] = 11'b{val};")
print("TOTAL BITS IN DICT: " + str(num_bits))
print("")
hashed_vals = []
for val in vals:
    this_hash = []
    for bin in val:
       this_hash.append(bin_hash[bin])
    hashed_vals.append(this_hash)
   

with open("./juicy_data.csv", "w") as file:
    file.truncate(0)  # Truncate the file, effectively clearing its content
    for num in list(itertools.chain.from_iterable(hashed_vals)):
     file.write(str(num)+'\n')
    #file.write(str(vals))
    #for tup in flattend_data:
       #file.write(tup_to_binary(tup)+'\n')
