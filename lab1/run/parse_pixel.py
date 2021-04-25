try:
    from PIL import Image
except ImportError:
    import Image
import sys

if len(sys.argv) < 2:
    print('Usage %s output.pixel [output.img]' % (sys.argv[0]))
    sys.exit(0)

file = open(sys.argv[1], "r")
meta_line = file.readline()
meta_arr = meta_line.split()
height = int(meta_arr[0])
width = int(meta_arr[1])
data_arr = meta_arr[2:]

img = Image.new('L', (width, height)) # Read a grayscale image
data = img.load()
i = 0
j = 0
for item in data_arr:
    data[j, i] = int(data_arr[i * width + j]) # img data is put in [width_j, height_i] order in PIL
    j += 1
    if j == width: 
        j = 0
        i += 1
    if i == height:
        break

outputfile = "image-out.jpg"
if len(sys.argv) > 2:
    outputfile = sys.argv[2]
    img.save(outputfile)
else:
    img.show()
