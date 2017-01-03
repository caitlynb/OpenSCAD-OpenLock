""" convert from a image to an openSCAD heightmap declaration
    for inclusion in an openSCAD script
  parameters
    1 image file name
    2 scad file name

   uses  PIL, numpy
   Chris Wallace March 2015
   edits by Caitlyn Byrne December 2016

"""

from PIL import Image
import numpy, sys


def surface_to_openSCAD_heightmap(surface, imgfilename, f):

    f.write("// Image_data 0,0 = Bottom Left Corner\n")
    f.write("")
    f.write('image_file = "' + imgfilename + '";\n')
    maxx = surface.shape[1]
    maxy = surface.shape[0]
    f.write('image_data = [ \n')
    for y in range(maxy-1, -1, -1):
        f.write("[ // Row %d\n" % (maxy-1-y))
        for x in range(0, maxx):
            f.write(str(surface[y][x]))
            if x < maxx-1:
                f.write(', ')
            else:
                f.write('  ')
            if (x+1) % 5 == 0:
                f.write("// Col: %d - %d\n" % (x-4,x))
        f.write("]")
        if y > 0:
            f.write(', // End of Row %d\n' % (maxy-1-y))
        else:
            f.write('  // End of Row %d\n' % (maxy-1-y))
    f.write("];\n")


imgfilename = sys.argv[1]
# width = float(sys.argv[2])
# invert = int(sys.argv[3])
# name = sys.argv[4]
scadflname = sys.argv[2]
pic = Image.open(imgfilename)
dim = pic.size
print("Image size = %d x %d" % (dim[0], dim[1]))
# ratio = width / dim[0]
# dim_resize = (int(dim[0] * ratio), int(dim[1] * ratio))
# pic_resize = pic.resize(dim_resize, Image.ANTIALIAS)
pic_greyscale = pic.convert("L")
print("grayscale size = %d x %d" % (pic_greyscale.size[0], pic_greyscale.size[1]) )
# pic_array = numpy.array(pic_greyscale).reshape((dim_resize[1], dim_resize[0]))
pic_array = numpy.array(pic_greyscale)
pic_array2 = pic_array / 256.0
print("Array size = %d x %d" % (pic_array2.shape[0], pic_array2.shape[1]))
with open(scadflname, 'wb') as scadfl:
    surface_to_openSCAD_heightmap(pic_array2, imgfilename, scadfl)
