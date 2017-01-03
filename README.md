# Welcome!

*The files in this directory are for making your own OpenSCAD based OpenLock dungeon tiles, typically for 3D Printing.*

If you simply want to copy the STL files, simply look in the STLs folder!

## Naming Convention for STL files:
OSOL-A-Imperial-8.0-Cobble-var2.stl =  
OSOL: OpenSCAD OpenLock file  
A: The OpenLock tile format  
Imperial:  
* Imperial = 1" scale
* Metric = 25mm scale
8.0: Height (in millimeters) to the top of the tile  
Cobble:  
* None = No texture
* Cobble = Cobblestone like texture
* Slate = Rock / Slate / Cave like texture
* Grass = Outdoors / Grass / Dirt like texture
var2: Which random variant is this file (somefiles only have var0)

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
* polyhedron.scad:  The functions that take a heightmap and generate a polyhedron.  (Similar to OpenSCAD's surface(), however, since it uses a heightmap we can use it in Thingiverse's Customizer app
* hardware.scad:  Some other helper stuff
* DemoSurface.scad:  Used by the polyhedron.scad file to show the smiley face

