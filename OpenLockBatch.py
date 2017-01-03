import subprocess
import os

# parts = ['d','e','r','s','u']
parts = ['a','b','c','d','e','r','s','u','v','f','sa','sb','g']
# parts = ['v','f','sa','sb','g']
partscount = {'a':10,'b':10,'c':10,'d':6,'e':10,'f':4,'g':4,'v':1,'r':4,'s':6,'sa':4,'sb':3,'u':1}
# textures = ['None','Cobble','Grass','Slate']
# textures = ['None','Cobble','Grass','Slate']
textures = ['None']
# arraysizes = ['None','Small','FF','i3']
arraysizes = ['None']
# units = ['Imperial','Metric']
units = ['Imperial']
# heightsi = [8,25.4,50.8]
# heightsm = [8,25,50]
heightsi = [8]
heightsm = [8]
# parts = ['d']
# textures = ['None','Grass']
# arraysizes = ['None','Small']
# units = ['Imperial']
# heightsi = [8]
# heightsm = [8,25,50]
markers = 'Yes'


command = 'C:\\Program Files\\OpenSCAD\\openscad.com'
cwd = os.getcwd()
scadfl = os.path.join(cwd, 'OpenLockMasters_v0-10.scad')
print('Command = %s' % command)

for part in parts:
    for texture in textures:
        for arraysize in arraysizes:
            for unit in units:
                if 'Imperial' in unit:
                    heights = heightsi
                else:
                    heights = heightsm
                for height in heights:
                    if texture is 'None':
                        numparts = 1
                    else:
                        numparts = partscount[part]
                    for i in range(numparts):
                        outflname = os.path.join(cwd, 'outstls\OSOL-%s-%s-%.1f-%s-%s.stl' % (part.upper(),unit,height,texture,'var%d'%i))
                        params = '-o "%s" -D array=\\"%s\\" -D Texture=\\"%s\\" -D part=\\"%s\\" -D Units=\\"%s\\" -D TileMarkers=\\"%s\\" -D WallHeight=%.1f "%s"' % (outflname, arraysize, texture, part, unit,  markers, height,  scadfl)
                        commandline = command + ' ' + params
                        print commandline
                        # print("Working %s" % outflname)
                        subprocess.call(commandline)
