#!/bin/python
import os, sys
import argparse
import math
import numpy as np
import glob

from PIL import Image

def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('directory')
    args = parser.parse_args()

    num_files = len(glob.glob1(args.directory,"*.tif"))
    print ("{0} files found.".format(  num_files  ))

    with open('data.sc', 'w') as w:
        for f in sorted(os.listdir(args.directory)):
            if f.endswith(".tif"):

                img = Image.open(args.directory+'/'+f)
                pix = img.load()

                r = 0
                g = 1
                b = 2
                width = img.size[0]     # 1
                height = img.size[1]    # 12

                rgb = np.zeros(36)

                for x in range (width):
                    for y in range (height):
                        rgb[x+(y*width)+(2*height)] = pix[x,y][r]/255
                        rgb[x+(y*width)+(1*height)] = pix[x,y][g]/255
                        rgb[x+(y*width)+(0*height)] = pix[x,y][b]/255

                bv = rgb[0:12] # slice
                bv[:] = bv[::-1] # reverse order

                gv = rgb[12:24] # slice
                gv[:] = gv[::-1] # reverse order

                rv = rgb[24:36] # slice
                rv[:] = rv[::-1] # reverse order

                rgb = np.concatenate((bv, gv, rv))

                for v in rgb:
                    w.write('%f,' % ( v ))
                w.write('\n')


if __name__ == '__main__':
    main()

