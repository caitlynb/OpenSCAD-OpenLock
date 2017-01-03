include <demosurface.scad>

xsize = 100;
ysize = 100;
zmin = 1; // dont set lower than ~0.01  (e.g., make greater than 0 to prevent degenerate polyhedrons.)
zmax = 2;
center=false;

//polyhedron_from_surface(image_data, xsize, ysize, zmin, zmax,center);

module polyhedron_from_surface(surface_data, xsize=100,ysize=100,zmin=1,zmax=2,center=false){

    offsetx = center==true?-xsize/2:0;
    offsety = center==true?-ysize/2:0;

    zdelta = zmax-zmin;

    ydim = len(surface_data);
    xdim = len(surface_data[0]);

    surface_zmax = max([for (idx = [0:1:ysize-1]) max(surface_data[idx])]); 
    surface_zmin = min([for (idx = [0:1:ysize-1]) min(surface_data[idx])]);
    surface_delta = surface_zmax-surface_zmin;
    zscale = zdelta/surface_delta;

    xstep = xsize/(xdim-1);
    ystep = ysize/(ydim-1);
    echo("Stepsize = [",xstep,", ",ystep,"]");

    surface_points = [for (y = [0:1:ydim-1], x = [0:1:xdim-1]) [offsetx+xstep*x, offsety+ystep*y, surface_data[y][x]>0.01?zmin + zscale*(surface_data[y][x]-surface_zmin):zmin]];
    wallminy_points = [for (x = [0:1:xdim-1]) [offsetx+xstep*x,offsety,0]]; //-y wall
    wallmaxy_points = [for (x = [0:1:xdim-1]) [offsetx+xstep*x,offsety+ysize,0]]; // +y wall
    wallminx_points = [for (y = [1:1:ydim-2]) [offsetx,offsety+ystep*y,0]]; // -x wall
    wallmaxx_points = [for (y = [1:1:ydim-2]) [offsetx+xsize,offsety+ystep*y,0]]; // +x wall
    centerpoint = [[offsetx+xsize/2, offsety+ysize/2, 0]]; 


    points = concat(surface_points, wallminy_points, wallmaxy_points, wallminx_points, wallmaxx_points,centerpoint);
    //echo(points=points);
    surface_triangles = flatten([for (y = [0:1:ydim-2], x=[0:1:xdim-2]) [[y*xdim+x,y*xdim+xdim+x,y*xdim+x+1],[y*xdim+x+1,y*xdim+xdim+x,y*xdim+xdim+x+1]]]);

    wallminy_triangles = flatten([for (x = [0:1:xdim-2]) [[x,xdim*ydim+x+1,xdim*ydim+x],[x,x+1,xdim*ydim+x+1]]]);
    wallmaxy_triangles = flatten([for (x = [0:1:xdim-2]) [[x+(ydim-1)*xdim, xdim*ydim+xdim+x, xdim*ydim+xdim+x+1], [x+(ydim-1)*xdim,xdim*ydim+xdim+x+1,x+(ydim-1)*xdim+1 ] ]]);
    wallminx_triangles = flatten([for (y = [1:1:ydim-3]) [[y*xdim, ydim*xdim+xdim*2+y-1,ydim*xdim+xdim*2+y],[y*xdim, ydim*xdim+xdim*2+y,(y+1)*xdim] ] ]);
    wallmaxx_triangles = flatten([for (y = [1:1:ydim-3]) [[y*xdim+xdim-1, xdim*ydim+xdim*2+ydim-2+y,xdim*ydim+xdim*2+ydim-2+y-1], [y*xdim+xdim-1, (y+1)*xdim+xdim-1,xdim*ydim+xdim*2+ydim-2+y ]]]);
    edge_triangles = [[0,xdim*ydim,xdim*ydim+xdim*2],[0,xdim*ydim+xdim*2,xdim],[(ydim-2)*xdim, xdim*ydim+xdim*2+ydim-3, xdim*ydim+xdim], [(ydim-1)*xdim,(ydim-2)*xdim,xdim*ydim+xdim],[xdim-1,xdim*2-1,xdim*ydim+xdim*2+ydim-2],[xdim-1,xdim*ydim+xdim*2+ydim-2, xdim*ydim+xdim-1], [xdim*(ydim-2)+xdim-1, xdim*ydim-1, xdim*ydim+xdim*2-1], [xdim*(ydim-2)+xdim-1,xdim*ydim+xdim*2-1,xdim*ydim+xdim*2+ydim-4+ydim-1],[xdim*ydim, len(points)-1, xdim*ydim+xdim*2], [xdim*ydim+xdim*2+ydim-3,, len(points)-1,  xdim*ydim+xdim], [len(points)-1, xdim*ydim+xdim-1,xdim*ydim+xdim*2+ydim-2], [len(points)-1,xdim*ydim+xdim*2+(ydim-2)*2-1, xdim*ydim+xdim*2-1]];

    floor_trianglesx = flatten( [for (x = [0:1:xdim-2]) [[len(points)-1, xdim*ydim+x,xdim*ydim+x+1], [xdim*ydim+xdim+x, len(points)-1, xdim*ydim+xdim+x+1] ] ]);
    floor_trianglesy = flatten( [for (y = [1:1:ydim-3]) [[ydim*xdim+xdim*2+y,ydim*xdim+xdim*2+y-1,len(points)-1],[xdim*ydim+xdim*2+ydim-2+y-1,xdim*ydim+xdim*2+ydim-2+y,len(points)-1 ] ] ] );

    faces = concat(surface_triangles,wallminy_triangles, wallmaxy_triangles, wallminx_triangles, wallmaxx_triangles,edge_triangles, floor_trianglesx,floor_trianglesy);
    //faces = concat(wallminy_trianglesa,wallminy_trianglesb);
    //echo(triangles=triangles);

    polyhedron(points = points, faces = faces, convexity = 20);
}

function flatten(l) = [ for (a = l) for (b = a) b ] ;
function arroffset(arr,off) = [for (idx = [0:1:len(arr)-1]) arr[idx]+off];
