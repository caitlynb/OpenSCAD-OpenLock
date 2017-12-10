include <Slate.scad>
include <Cobble.scad>
include <Grass.scad>
include <hardware.scad>
include <polyhedronhelper.scad>

// Changes the Part that you will create
part = "v"; 
/* [a:Part A, 2x0.5 edge (1 clip)
    b:Part B, 2x0.5 edge (2 clips)
    c:Part C, 2.5x0.5 edge (2 clips)
    d:Part D, 3x0.5 edge (3 clips)
    e:Part E, 2x2
    r:Part R, 4x2
    s:Part S, 1x2
    u:Part U, 4x4
    f:Part F, 2x2 corner, w/clip
    v:Part V, 4x4 corner, 3 clips
    sa:Part SA, 1x3
    sb:Part SB, 1x4
    g:Part G, 2x2 1/4 circle edge, fits "f"
] */

// Do you want an array?
array = "None"; // [None:No Array,Small:Array for a ~4.5"x4.5" printer,FF:Array for a Makerbot/Flashforge style printer,i3:Array for a i3 style printer]

// Changes the default layerheight - Match this to your print settings!
layerheight = 0.2; // [0.05:0.025:0.25]

// Change the units settings for an Imperial (1") or Metric (25mm) grid
Units = "Imperial";  // [Imperial,Metric]

// Do you want to include the built in supports in the model?
Supports = "Yes";   // [Yes,No]

// Do you want to generate some texture on the part?
Texture = "None"; // [None,Cobble,Slate,Grass]

// How high should the pieces be? (mm)
WallHeight = 8; // [8,10,12.7,25,25.4,50,50.8,75,76.2,100,101.6]

// Should the model have 1" square markers?
TileMarkers = "Yes"; // [Yes,No]


/* [Hidden] */

buffer=2;

/*********
*
* NOTE TO USERS
* This file uses a random function.  Everytime you preview the file with a
* texture selected, it will appear different.  This is normal and expected.
*
*********/

print_part();
//floors();

function unit() = (Units == "Imperial") ? 25.4 : 25;

module print_part(){
    if (part == "e")            part_e(unit());
    else if (part == "a")       part_a(unit());
    else if (part == "b")       part_b(unit());
    else if (part == "c")       part_c(unit());
    else if (part == "d")       part_d(unit());
    else if (part == "f")       part_f(unit());
    else if (part == "g")       part_g(unit());
    else if (part == "u")       part_u(unit());
    else if (part == "r")       part_r(unit());
    else if (part == "s")       part_s(unit());
    else if (part == "sa")      part_sa(unit());
    else if (part == "sb")      part_sb(unit());
    else if (part == "v")       part_v(unit());
    else                        part_e(unit());
}

module part_d(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                basepiece(unitwidth, 0.5, 3);
                for (y = [-1:1:1]){
                    translate([unitwidth/4,y*unitwidth,0])
                    clipcut();
                }
            }
            if (Supports == "Yes"){
                for (y = [-1:1]){
                    translate([unitwidth/4,y*unitwidth,0])
                    clipsupport();
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-.25:0.5:.25]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*3.5, r=0.75, $fn=8, center=true);
            }
            for (y = [-1.5:1:1.5]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth, r=0.75, $fn=8, center=true);
            }
        }
        
//        for (x = [-0.25:0.5:0.25], y = [-0.25:0.5:0.25]){
//            translate([x*unitwidth,y*unitwidth,0])
//            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
//        }
        for (x = [-0.25,0.25]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1.5,1.5]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
    }
}

module part_c(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                basepiece(unitwidth, 0.5, 2.5);
                for (y = [-.25,.75]){
                    translate([unitwidth/4,y*unitwidth,0])
                    clipcut();
                }
            }
            if (Supports == "Yes"){
                for (y = [-.25,.75]){
                    translate([unitwidth/4,y*unitwidth,0])
                    clipsupport();
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-.25,.25]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*3.5, r=0.75, $fn=8, center=true);
            }
            for (y = [-1.25,-.25,.75,1.25]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth, r=0.75, $fn=8, center=true);
            }
        }
        
//        for (x = [-0.25:0.5:0.25], y = [-0.25:0.5:0.25]){
//            translate([x*unitwidth,y*unitwidth,0])
//            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
//        }
        for (x = [-0.25,0.25]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1.25,1.25]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
    }
}

module part_a(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                basepiece(unitwidth, 0.5, 2);
                for (y = [0]){
                    translate([unitwidth/4,y*unitwidth,0])
                    clipcut();
                }
            }
            if (Supports == "Yes"){
                for (y = [0]){
                    translate([unitwidth/4,y*unitwidth,0])
                    clipsupport();
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-.25,0.25]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*3.5, r=0.75, $fn=8, center=true);
            }
            for (y = [-1,0,1]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth, r=0.75, $fn=8, center=true);
            }
        }
        
//        for (x = [-0.25:0.5:0.25], y = [-0.25:0.5:0.25]){
//            translate([x*unitwidth,y*unitwidth,0])
//            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
//        }
        for (x = [-0.25,0.25]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1,1]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
    }
}

module part_b(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                basepiece(unitwidth, 0.5, 2);
                for (y = [-.5,.5]){
                    translate([unitwidth/4,y*unitwidth,0])
                    clipcut();
                }
            }
            if (Supports == "Yes"){
                for (y = [-0.5,0.5]){
                    translate([unitwidth/4,y*unitwidth,0])
                    clipsupport();
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-.25,0.25]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*3.5, r=0.75, $fn=8, center=true);
            }
            for (y = [-1,-0.5,0.5,1]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth, r=0.75, $fn=8, center=true);
            }
        }
        
//        for (x = [-0.25:0.5:0.25], y = [-0.25:0.5:0.25]){
//            translate([x*unitwidth,y*unitwidth,0])
//            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
//        }
        for (x = [-0.25,0.25]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1,1]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
    }
}

module part_e(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                basepiece(unitwidth, 2, 2);
                for (r = [0:90:360]){
                    rotate([0,0,r])
                    translate([0,unitwidth,0])
                    rotate([0,0,90])
                    clipcut();
                }
            }

            if (Supports == "Yes"){
                for (r = [0:90:360]){
                    rotate([0,0,r])
                    translate([0,unitwidth,0])
                    rotate([0,0,90])
                    clipsupport();
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-1:1:1]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*3, r=0.75, $fn=8, center=true);
            }
            for (y = [-1:1:1]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth*3, r=0.75, $fn=8, center=true);
            }
        }
        for (x = [-0.25:0.5:0.25], y = [-0.25:0.5:0.25]){
            translate([x*unitwidth,y*unitwidth,0])
            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
        }
        for (x = [-1,1]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1,1]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
    }
    
}

module part_f(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                intersection(){
                    basepiece(unitwidth, 2, 2);
                    translate([-unitwidth,-unitwidth,0])
                    cylinder(r=unitwidth*2,h=WallHeight,$fn=64);
                }
                for (r = [90,180]){
                    rotate([0,0,r])
                    translate([0,unitwidth,0])
                    rotate([0,0,90])
                    clipcut();
                }
                translate([-unitwidth,-unitwidth,0])
                rotate(45)
                translate([unitwidth*2,0,0])
                clipcut();
            }

            if (Supports == "Yes"){
                for (r = [90,180]){
                    rotate([0,0,r])
                    translate([0,unitwidth,0])
                    rotate([0,0,90])
                    clipsupport();
                }
                translate([-unitwidth,-unitwidth,0])
                rotate(45)
                translate([unitwidth*2,0,0])
                clipsupport();
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-1:1:1]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*3, r=0.75, $fn=8, center=true);
            }
            for (y = [-1:1:1]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth*3, r=0.75, $fn=8, center=true);
            }
        }
        for (x = [-0.25], y = [-0.25]){
            translate([x*unitwidth,y*unitwidth,0])
            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
        }
        for (x = [-1]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        translate([-unitwidth,-unitwidth,0])
        rotate_extrude($fn=64)
        translate([unitwidth*2,0,0])
        rotate(45)
        square(1,center=true);
    }
    
}

module part_g(unitwidth=25.4){
    difference(){
        intersection(){
            difference(){
                cylinder(r=unitwidth*2.5,h=WallHeight,$fn=64);
                translate([0,0,-1])
                cylinder_outer(WallHeight+2,unitwidth*2,64);
            }
            cube([unitwidth*3,unitwidth*3,WallHeight]);
            translate([(unitwidth*2.5)/2,(unitwidth*2.5)/2,0])
            basepiece(unitwidth,2.5,2.5);
        }
        for (r=[22.5,45,67.5]){
            rotate(r)
            translate([unitwidth*2,0,0])
            rotate(180)
            clipcut();
        }
        rotate_extrude($fn=64)
        translate([unitwidth*2,0,0])
        rotate(45)
        square(1,center=true);
        rotate_extrude($fn=64)
        translate([unitwidth*2.5,0,0])
        rotate(45)
        square(1,center=true);
        rotate([0,90,0])
        rotate(45)
        cube([1,1,unitwidth*10],center=true);
        rotate([90,0,0])
        rotate(45)
        cube([1,1,unitwidth*10],center=true);
        
        if (TileMarkers == "Yes"){
            for (x = [0:1:3]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*10, r=0.75, $fn=8, center=true);
            }
            for (y = [0:1:3]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth*10, r=0.75, $fn=8, center=true);
            }
        }
    }
    if (Supports == "Yes"){
        for (r=[22.5,45,67.5]){
            rotate(r)
            translate([unitwidth*2,0,0])
            rotate(180)
            clipsupport();
        }
    }
}

module part_r(unitwidth=25.4){
    difference(){
        union(){
            
            difference(){
                basepiece(unitwidth,4,2);
                for (r = [0,180]){
                    rotate([0,0,r]){
                        for (x = [-1:1:1]){
                            translate([x*unitwidth,unitwidth,0])
                            rotate([0,0,90])
                            clipcut();
                        }
                        translate([unitwidth*2, 0, 0])
                        clipcut();
                    }
                }
            }

            if (Supports == "Yes"){
                for (r = [0,180]){
                    rotate([0,0,r]){
                        for (x = [-1:1:1]){
                            translate([x*unitwidth,unitwidth,0])
                            rotate([0,0,90])
                            clipsupport();
                        }
                        translate([unitwidth*2, 0, 0])
                        clipsupport();
                    }
                }
            }
            
        }
        if (TileMarkers == "Yes"){
            for (x = [-2:1:2]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*3, r=0.75, $fn=8, center=true);
            }
            for (y = [-1:1:1]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth*5, r=0.75, $fn=8, center=true);
            }
        }
        for (x = [-1.25:0.5:1.25], y = [-0.25:0.5:0.25]){
            translate([x*unitwidth,y*unitwidth,0])
            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
        }
        for (x = [-2,2]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1,1]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
    }
    
}

module part_s(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                basepiece(unitwidth, 1,2);
                for (r = [0,180]){
                    rotate([0,0,r]){
                        for (x = [0]){
                            translate([x*unitwidth,unitwidth,0])
                            rotate([0,0,90])
                            clipcut();
                        }
                        translate([unitwidth/2, 0, 0])
                        clipcut();
                    }
                }
            }

            if (Supports == "Yes"){
                for (r = [0,180]){
                    rotate([0,0,r]){
                        for (x = [0]){
                            translate([x*unitwidth,unitwidth,0])
                            rotate([0,0,90])
                            clipsupport();
                        }
                        translate([unitwidth/2, 0, 0])
                        clipsupport();
                    }
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-0.5:1:0.5]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*3, r=0.75, $fn=8, center=true);
            }
            for (y = [-1:1:1]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth*3, r=0.75, $fn=8, center=true);
            }
        }
//        for (x = [-0.25:0.5:0.25], y = [-0.25:0.5:0.25]){
//            translate([x*unitwidth,y*unitwidth,0])
//            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
//        }
        for (x = [-00.5,0.5]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1,1]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
    }
    
}

module part_sa(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                basepiece(unitwidth, 1,3);
                for (r = [0,180]){
                    rotate([0,0,r]){
                        for (y = [-0.5,0.5]){
                            translate([unitwidth/2,y*unitwidth,0])
//                            rotate([0,0,90])
                            clipcut();
                        }
                        translate([0,unitwidth*1.5,0])
                        rotate([0,0,90])
                        clipcut();
                        
                    }
                }
            }

            if (Supports == "Yes"){
                for (r = [0,180]){
                    rotate([0,0,r]){
                        for (y = [-0.5,0.5]){
                            translate([unitwidth/2,y*unitwidth,0])
//                            rotate([0,0,90])
                            clipsupport();
                        }
                        translate([0,unitwidth*1.5,0])
                        rotate([0,0,90])
                        clipsupport();
                    }
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-0.5:1:0.5]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*3, r=0.75, $fn=8, center=true);
            }
            for (y = [-1.5:1:1.5]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth*5, r=0.75, $fn=8, center=true);
            }
        }
//        for (x = [-0.25:0.5:0.25], y = [-0.25:0.5:0.25]){
//            translate([x*unitwidth,y*unitwidth,0])
//            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
//        }
        for (x = [-0.5,0.5]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1.5,1.5]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
    }
    
}

module part_sb(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                basepiece(unitwidth, 1,4);
                for (r = [0,180]){
                    rotate([0,0,r]){
                        for (y = [-1,0,1]){
                            translate([unitwidth/2,y*unitwidth,0])
//                            rotate([0,0,90])
                            clipcut();
                        }
                        translate([0,unitwidth*2,0])
                        rotate([0,0,90])
                        clipcut();
                        
                    }
                }
            }

            if (Supports == "Yes"){
                for (r = [0,180]){
                    rotate([0,0,r]){
                        for (y = [-1,0,1]){
                            translate([unitwidth/2,y*unitwidth,0])
//                            rotate([0,0,90])
                            clipsupport();
                        }
                        translate([0,unitwidth*2,0])
                        rotate([0,0,90])
                        clipsupport();
                    }
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-0.5:1:0.5]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*5, r=0.75, $fn=8, center=true);
            }
            for (y = [-2:1:2]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth*3, r=0.75, $fn=8, center=true);
            }
        }
//        for (x = [-0.25:0.5:0.25], y = [-0.25:0.5:0.25]){
//            translate([x*unitwidth,y*unitwidth,0])
//            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
//        }
        for (x = [-0.5,0.5]){
            translate([x*unitwidth, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-2,2]){
            translate([0,y*unitwidth, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
    }
    
}

module part_v(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                intersection(){
                    basepiece(unitwidth,4,4);
                    translate([-unitwidth*2,-unitwidth*2,0])
                    cylinder(r=unitwidth*4,h=WallHeight,$fn=128);
                }
                for (r = [90,180]){
                    for (i = [-1:1:1]){
                        rotate([0,0,r])
                        translate([i*unitwidth,unitwidth*2,0])
                        rotate([0,0,90])
                        clipcut();
                    }
                }
                translate([-unitwidth*2,-unitwidth*2,0])
                for (r=[22.5,45,67.5]){
                    rotate(r)
                    translate([unitwidth*4,0,0])
                    clipcut();
                }
                
            }
            if (Supports == "Yes"){
                for (r = [90,180]){
                    for (i = [-1:1:1]){
                        rotate([0,0,r])
                        translate([i*unitwidth,unitwidth*2,0])
                        rotate([0,0,90])
                        clipsupport();
                    }
                }
                translate([-unitwidth*2,-unitwidth*2,0])
                for (r=[22.5,45,67.5]){
                    rotate(r)
                    translate([unitwidth*4,0,0])
                    clipsupport();
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-2:1:2]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*5, r=0.75, $fn=8, center=true);
            }
            for (y = [-2:1:2]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth*5, r=0.75, $fn=8, center=true);
            }
        }
        for (x = [-1.25:0.5:1.25], y = [-1.25:0.5:1.25]){
            if( pow((x*unitwidth+unitwidth*2),2)+pow((y*unitwidth+unitwidth*2),2) < pow(unitwidth*3.4,2)){
                translate([x*unitwidth,y*unitwidth,0])
                cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
            }
        }
        for (x = [-1]){
            translate([x*unitwidth*2, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1]){
            translate([0,y*unitwidth*2, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        translate([-unitwidth*2,-unitwidth*2,0])
        rotate_extrude($fn=128)
        translate([unitwidth*4,0,0])
        square(1,center=true);
            
    }
    
}


module part_u(unitwidth=25.4){
    difference(){
        union(){
            difference(){
                basepiece(unitwidth,4,4);
                for (r = [0:90:360]){
                    for (i = [-1:1:1]){
                        rotate([0,0,r])
                        translate([i*unitwidth,unitwidth*2,0])
                        rotate([0,0,90])
                        clipcut();
                    }
                }
                
            }
            if (Supports == "Yes"){
                for (r = [0:90:360]){
                    for (i = [-1:1:1]){
                        rotate([0,0,r])
                        translate([i*unitwidth,unitwidth*2,0])
                        rotate([0,0,90])
                        clipsupport();
                    }
                }
            }
        }
        if (TileMarkers == "Yes"){
            for (x = [-2:1:2]){
                translate([x*unitwidth, 0, WallHeight])
                rotate([90,0,0])
                cylinder(h = unitwidth*5, r=0.75, $fn=8, center=true);
            }
            for (y = [-2:1:2]){
                translate([0, y*unitwidth, WallHeight])
                rotate([0,90,0])
                cylinder(h = unitwidth*5, r=0.75, $fn=8, center=true);
            }
        }
        for (x = [-1.25:0.5:1.25], y = [-1.25:0.5:1.25]){
            translate([x*unitwidth,y*unitwidth,0])
            cube([unitwidth/2-3, unitwidth/2-3, 1],center=true);
        }
        for (x = [-1,1]){
            translate([x*unitwidth*2, 0, 0])
            rotate([90,0,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
        for (y = [-1,1]){
            translate([0,y*unitwidth*2, 0])
            rotate([0,90,0])
            rotate([0,0,45])
            cube([1,1,unitwidth*5],center=true);
        }
            
    }
    
}

module floors(){
    unitmeasure = 25.4;
    // Change these lines... {
    numycopies = 2;
    ywide = unitmeasure*2;
    numxcopies = 6;
    xwide = unitmeasure;
    spacing = 2;
    // }
    
    for (y = [-(numycopies-1)/2:1:(numycopies-1)/2], x = [-(numxcopies-1)/2:1:(numxcopies-1)/2]){
        translate([x*(xwide+spacing),y*(ywide+spacing),0])    
        
        render()
		// ************
        // And change this line        
        part_s(unitmeasure, texture);
        // ************
        
        translate([x*(xwide+spacing),y*(ywide+spacing),0]){
            for (sx = [-xwide/2:unitmeasure/2:xwide/2]){
                if (abs(sx) == xwide/2){
                    translate([sx-abs(sx)/sx*spacing/2, -ywide/2-spacing/2, layerheight/2])
                    cube([2,spacing+2,layerheight],center=true);
                    translate([sx-abs(sx)/sx*spacing/2, ywide/2+spacing/2, layerheight/2])
                    cube([2,spacing+2,layerheight],center=true);
                } else {                
                    translate([sx, -ywide/2-spacing/2, layerheight/2])
                    cube([2,spacing+2,layerheight],center=true);
                    translate([sx, ywide/2+spacing/2, layerheight/2])
                    cube([2,spacing+2,layerheight],center=true);
                }
            }
            for (sy = [-ywide/2:unitmeasure/2:ywide/2]){
                if (abs(sy) == ywide/2){
                    translate([xwide/2+spacing/2, sy-abs(sy)/sy*spacing/2, layerheight/2])
                    cube([spacing+2,2,layerheight],center=true);
                    translate([-xwide/2-spacing/2, sy-abs(sy)/sy*spacing/2, layerheight/2])
                    cube([spacing+2,2,layerheight],center=true);
                } else {                
                    translate([xwide/2+spacing/2, sy, layerheight/2])
                    cube([spacing+2,2,layerheight],center=true);
                    translate([-xwide/2-spacing/2, sy, layerheight/2])
                    cube([spacing+2,2,layerheight],center=true);
                }
            }
        }
    }
    
    //border
    difference(){
        translate([0,0,layerheight*1.5/2])
        cube([xwide*numxcopies+10+(numxcopies)*spacing,ywide*numycopies+10+(numycopies)*spacing,layerheight*1.5],center=true);
        cube([xwide*numxcopies+(numxcopies)*spacing,ywide*numycopies+(numycopies)*spacing,4],center=true);
        
    }
    
}

cutoutheight = 4.2;
cutoutstartz = 1.4;
cutoutwide1 = 14;
cutoutdeep1 = 2;
cutoutdeep2 = 2;
cutoutwide2 = 12;
cutoutwide3 = 10;
cutoutdeep3 = 5;

module clipsupport(){
    translate([-(cutoutdeep3+1)/2,0,cutoutstartz+layerheight+(cutoutheight-layerheight*2)/2])
    difference(){
        cube([cutoutdeep3+1, 6, cutoutheight-layerheight*2],center=true);
        cube([cutoutdeep3-1, 4, cutoutheight+layerheight*2],center=true);
    }
        
}

module clipcut(){
    translate([0,0,cutoutheight/2+cutoutstartz])
    rotate([0,0,90])
    linear_extrude(cutoutheight,center=true)
    polygon([[-cutoutwide1/2,-2],[-cutoutwide1/2,cutoutdeep1],
            [-cutoutwide2/2, cutoutdeep2],[-cutoutwide3/2,cutoutdeep3],
            [-cutoutwide3/2,cutoutdeep3+2],[cutoutwide3/2,cutoutdeep3+2],
            [cutoutwide3/2,cutoutdeep3],[cutoutwide2/2,cutoutdeep2],
            [cutoutwide1/2,cutoutdeep1],[cutoutwide1/2,-2]]);
    
    translate([-8.35,0,(cutoutheight+cutoutstartz)/2-1])
    cube([4.7,18,cutoutheight+cutoutstartz+2],center=true);
    
    translate([-8.35,0,(cutoutheight+cutoutstartz+layerheight*2)/2])
    cube([4.7,14,cutoutheight+cutoutstartz+layerheight],center=true);

}

module basepiece(unitwidth, xmult, ymult){
    // Assumes that the textures are designed for 4" squares.
    
    xdiff = 4-xmult;
    ydiff = 4-ymult;
    xrand = rands(-xdiff/2, xdiff/2, 4)[0]*unitwidth;
    yrand = rands(-ydiff/2, ydiff/2, 4)[0]*unitwidth;
    
    if (Texture == "Slate"){
        intersection(){
            translate([xrand,yrand,-0.5])
            polyhedron_from_surface(slate_data, unitwidth*4, unitwidth*4, WallHeight-1, WallHeight+1, true);
            translate([0,0,(WallHeight)/2])
            cube([unitwidth*xmult,unitwidth*ymult,WallHeight],center=true);
        }
        
    } else if (Texture == "Cobble") {
        intersection(){
            translate([xrand,yrand,-0.5])
            polyhedron_from_surface(cobble_data, unitwidth*4, unitwidth*4, WallHeight-1, WallHeight+1, true);
            translate([0,0,(WallHeight)/2])
            cube([unitwidth*xmult,unitwidth*ymult,WallHeight],center=true);
        }
        
    } else if (Texture == "Grass") {
        intersection(){
            translate([xrand,yrand,-1])
            polyhedron_from_surface(grass_data, unitwidth*4, unitwidth*4, WallHeight-1, WallHeight+1, true);
            translate([0,0,(WallHeight)/2])
            cube([unitwidth*xmult,unitwidth*ymult,WallHeight],center=true);
        }
    } else {
        translate([0,0,(WallHeight)/2])
        cube([unitwidth*xmult,unitwidth*ymult,WallHeight],center=true);
    }
                
}
