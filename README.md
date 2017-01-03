# Welcome!

*The files in this directory are for making your own OpenSCAD based OpenLock dungeon tiles, typically for 3D Printing.*

If you simply want to copy the STL files, simply look in the STLs folder!

## For Makers and Hackers:

`OSOL = OpenSCAD OpenLock`

Inside this directory, the main items are:
* OpenLock.scad:  The master OSOL file
* OpenLockBatch.py:  The Python script I use to generate random variations of each tile
* STLs:  The directory with all the sample files
* Surfaces.psd:  The master surfaces (textures) photoshop file
* imagetoopenscad.py:  The Python script that reads images, and turns them into OpenSCAD 'heightmaps' for the polyhedron code.

## Other items included:

There are a few included errata items:
* OSOL-Customizer.scad:  The ugly mess that Thingiverse's Customizer app uses
* Cobble.scad:  The heightmap of the cobble pattern
* Slate.scad:  The heightmap of the slate pattern
* Grass.scad:  The heightmap of the grass pattern
* PolyhedronHelper.scad:  The functions that take a heightmap and generate a polyhedron.  (Similar to OpenSCAD's surface(), however, since it uses a heightmap we can use it in Thingiverse's Customizer app
* utility.scad:  Some other helper stuff

