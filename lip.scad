include <OpenLock.scad>

// Important!!! rotate_extrude() requires recent OpenSCAD (I'm using 17.12).
//

// Changes the Part that you will create
part = "oo";
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
    o: custom edge with a lip
    oo: custom corner with a lip
    x: shape of the chamfer around the lip, for debugging...
    ]
*/

layerheight = 0.2; // [0.05:0.025:0.25]
Supports = "Pillar";   // [Yes,No,Pillar]
WallHeight = 8; // [8,10,12.7,25,25.4,50,50.8,75,76.2,100,101.6]
TileMarkers = "Yes"; // [Yes,No]

sqrt2 = sqrt(2);

module print_part() {
    unit = (Units == "Imperial") ? 25.4 : 25;
//    rotate(-7.5,[0,10,0])
    {
         if (part == "e")  part_e(unit);
    else if (part == "a")  part_a(unit);
    else if (part == "b")  part_b(unit);
    else if (part == "c")  part_c(unit);
    else if (part == "d")  part_d(unit);
    else if (part == "f")  part_f(unit);
    else if (part == "g")  part_g(unit);
    else if (part == "u")  part_u(unit);
    else if (part == "r")  part_r(unit);
    else if (part == "s")  part_s(unit);
    else if (part == "sa") part_sa(unit);
    else if (part == "sb") part_sb(unit);
    else if (part == "v")  part_v(unit);
    else if (part == "o")  part_o(unit);
    else if (part == "oo") part_oo(unit);
    else if (part == "x")  print_chamfer();
    else                   part_e(unit);
    }
}

module chamfer(length,r=1) {
    rotate([0,0,45]) cube([r,r,length],center=true);
}

function edge_polygon(w=WallHeight) = [
    [-1,0],
    [w*.5,0],
    [w*1.5,w],
    [w*1.75,w*1.5],
    [w*1.75,w*2],
    [w*1.5,w*2.75],
    [w*1,w*3.5],
    [w*1,w*3],
    [w*1.25,w*2.5],
    [w*1.25,w*2],
    [w*1,w*1.5],
    [0,w],
    [-2,w]
];

function poly_angle(p, i) = atan2(p[i+1][1] - p[i][1], p[i+1][0] - p[i][0]);
function poly_length(p, i) = sqrt((p[i+1][0] - p[i][0])*(p[i+1][0] - p[i][0]) +
        (p[i+1][1] - p[i][1])*(p[i+1][1] - p[i][1]));

module poly_chamfer(poly, r=1) {
    count = len(poly)-1;
    union() {
        for (i = [0 : count-1]) {
            f = poly[i];
            t = poly[i+1];
            length = poly_length(poly, i);
            pa = poly_angle(poly, i);
            angle = (pa < 0) ? pa + 360 : pa;
            translate([f[0],0,f[1]])
                rotate(-angle, [0,1,0])
                rotate(45, [1,0,0]) translate([0,-r/2,-r/2]) cube([length,r,r],center=false);
            if (poly[i+2] != undef) {
                // corner in the middle of polygon. Do a rotate_extrude() to join the segments:-
                na = poly_angle(poly, i+1);
                next = (na < 0) ? na + 360 : na;
                delta = next - angle;
//                echo(from=f, to=t, length=length, angle=angle, next=next, delta=(next-angle));
                translate([t[0],r*sqrt2/2,t[1]])
                rotate(delta >= 0 ? 90-angle+1 : 270-angle-1, [0,1,0])
                rotate(90,[1,0,0])
                rotate_extrude(angle = delta >= 0 ? delta+2 : delta-2, $fn=32)
                polygon([[0,0],[r*sqrt2/2,r*sqrt2/2], [0,r*sqrt2]]);
            }
        }
    }
}

module print_chamfer(r=10) {
    poly_chamfer(edge_polygon());
}

module edge(unit, nx, ny) {
    poly = edge_polygon();
    difference() {
        translate ([nx*unit/2, ny*unit/2]) rotate ([90,0,0]) {
            linear_extrude(height=ny*unit, center=false, convexity=10, twist=0) {
                offset(r = 1, $fn=32) {
                    offset(delta = -1) {
                        polygon(poly);
                    }
                }
            }
        }
        translate([nx*unit/2,-ny*unit/2,0]) poly_chamfer(poly);
        translate([nx*unit/2, ny*unit/2,0]) poly_chamfer(poly);
    }
}

// square
module corner (unit, n) {
    poly = edge_polygon();
    difference() {
        translate ([-n*unit/2,-n*unit/2,0]) 
        intersection() {
            rotate_extrude($fn=256) {
                offset(r = 1, $fn=32) {
                    offset(delta = -1) {
                        translate([n*unit,0]) polygon(poly);
                    }
                }
            }
            cube([(n+1)*unit,(n+1)*unit,unit*1],center=false);
        }
        translate([n*unit/2,-n*unit/2,0]) poly_chamfer(poly);
        translate([-n*unit/2,n*unit/2,0]) rotate(90,[0,0,1]) poly_chamfer(poly);
    }
}

module part_o(unit=25.4,nx=3,ny=3){
    nsx = nx-2;
    nsy = ny-2;
    union() {
        difference() {
            union() {
                difference(){
                    basepiece(unit, nx,ny);
                    for (x = [-nsx/2:1:nsx/2]) {
                        translate([x*unit,ny*unit/2,0]) rotate([0,0,90]) clipcut();
                        rotate([0,0,180]) translate([x*unit,ny*unit/2,0]) rotate([0,0,90]) clipcut();
                    }
                    for (y = [-nsy/2:1:nsy/2]) {
                        rotate([0,0,180]) translate([nx*unit/2,y*unit,0]) clipcut();
                    }
                }
            }
            // Anti-stick pads
            px = 0.25 + .5*(nx-2);
            py = 0.25 + .5*(ny-2);
            for (x = [-px:.5:px+.5], y = [-py:.5:py]){
                translate([x*unit,y*unit,0])
                cube([unit/2-3, unit/2-3, 1],center=true);
            }
            // Chamfers
            translate([-nx*unit/2, 0, 0]) rotate([90,0,0]) chamfer(ny*unit);
            translate([0,-ny*unit/2, 0]) rotate([0,90,0]) chamfer(nx*unit);
            translate([0, ny*unit/2, 0]) rotate([0,90,0]) chamfer(nx*unit);
        }
        edge(unit,nx,ny);
    }
}

module part_oo(unit=25.4,n=3){    
    union() {
        difference(){
            union(){
                difference(){
                    intersection(){
                        basepiece(unit, n, n);
                        translate([-n*unit/2,-n*unit/2,0])
                        cylinder(r=unit*n,h=WallHeight,$fn=64);
                    }
                    for (i = [-(n/2-1):1:(n/2-1)])
                        translate([i*unit,-n*unit/2,0]) rotate([0,0,-90]) clipcut();
                    for (i = [-(n/2-1):1:(n/2-1)])
                        translate([-n*unit/2,i*unit,0]) rotate([0,0,180]) clipcut();
                }
            }
            // Anti-stick pads
            p = 0.25 + .5*(n-2);
            for (x = [-p:.5:+p+.5], y = [-p:.5:p+.5]){
                translate([x*unit,y*unit,0])
                cube([unit/2-3, unit/2-3, 1],center=true);
            }
            // Chamfers
            translate([-n*unit/2, 0, 0]) rotate([90,0,0]) chamfer(n*unit);
            translate([0,-n*unit/2, 0]) rotate([0,90,0]) chamfer(n*unit);
        }
        corner(unit,n);
    }
}
