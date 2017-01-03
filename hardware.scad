// CC-BY-SA
// Created by Caitlyn Byrne
// last modified 05 November 2016

// [machine screw diameter, socket head diameter, socket head len, socket head hex key size, pan head diameter, pan head len, pan head hex key size, nut wide, nut thick]

m3 = [3,
5.5, 3, 2.5, 
5.7, 1.65, 2,
5.5, 2.4];

m4 = [4,
7, 4, 3,
7.6, 2.2, 2.5,
7, 3.2];

m5 = [5,
8.5, 5, 4,
9.5, 2.75, 3,
8, 4];

m6 = [6,
10, 6, 5,
10.5, 3.3, 4,
10,5];

m8 = [8,
13,8,6,
14,4.4, 5,
13,6.5];

m10 = [10,
16,10,8,
17.5, 5.5, 6,
17,8];

m12 = [12,
18,12,10,
21,6.6, 8,
19,10];

i1_4 = [1/4*25.4,
3/8*25.4, 1/4*25.4, 3/16*25.4,
0.492*25.4, 0.175*25.4, 5/32*25.4,
7/16*25.4, 7/32*25.4];


/// indicies
machine_screw_diameter = 0;
socket_head_diameter = 1;
socket_head_len = 2;
socket_head_hex_key = 3;
pan_head_diameter = 4;
pan_head_len = 5;
pan_head_hex_key = 6;
nut_wide = 7;
nut_thick = 8;


e3d_clearance = 20;

groove_top_thick = 4;
groove_top_dia = 16;
groove_mid_thick = 6;
groove_mid_dia = 12;
groove_bot_thick = 4;
groove_bot_dia = 16;

lm8uu_diameter = 15;
lm8uu_long = 24;
lm8uu_shaft_diameter = 8;

//lm8uu_hor(zip_ties=true);

small_ziptie_wide = 3;
small_ziptie_thick = 2;

module lm8uu_hor(zip_ties=false){
    
    translate([-lm8uu_long/2,0,0])
    rotate([0,90,0])
    cylinder_outer(lm8uu_long, lm8uu_diameter/2, 32);
    if (zip_ties == "outer"){
        for(x = [1,-1]){
            translate([x*lm8uu_long/3-small_ziptie_wide/2,0,0])
            rotate([0,90,0])
            difference(){
                cylinder_outer(small_ziptie_wide, lm8uu_diameter/2+1+small_ziptie_thick, 32);
                translate([0,0,-1])
                cylinder_outer(small_ziptie_wide+2, lm8uu_diameter/2+1, 32);
            }
        }
    }
    if (zip_ties == "inner"){
        for(x = [1,-1]){
            translate([x*lm8uu_long/4-small_ziptie_wide/2,0,0])
            rotate([0,90,0])
            difference(){
                cylinder_outer(small_ziptie_wide, lm8uu_diameter/2+1+small_ziptie_thick, 32);
                translate([0,0,-1])
                cylinder_outer(small_ziptie_wide+2, lm8uu_diameter/2+1, 32);
            }
        }
    }
    if (zip_ties == "center"){
        for(x = [0]){
            translate([x*lm8uu_long/3-small_ziptie_wide/2,0,0])
            rotate([0,90,0])
            difference(){
                cylinder_outer(small_ziptie_wide, lm8uu_diameter/2+1+small_ziptie_thick, 32);
                translate([0,0,-1])
                cylinder_outer(small_ziptie_wide+2, lm8uu_diameter/2+1, 32);
            }
        }
    }
}


module groove(){
    translate([0,-groove_mid_thick/2-groove_bot_thick])
    rotate([-90,0,0])
    union(){
        translate([0,0,.5])
        cylinder_outer(groove_top_thick+groove_mid_thick+groove_bot_thick-1, groove_mid_dia/2, 36);
        cylinder_outer(groove_bot_thick, groove_bot_dia/2, 36);
        translate([0,0,groove_bot_thick+groove_mid_thick])
        cylinder_outer(groove_top_thick, groove_top_dia/2, 36);
    }
}

module nut(nut_wide = 5.7, nut_thick = 3, bolt_dia = 3.5, extend = false, layer_height = 0.25){
    // extend = go below 0 for z, to allow a clean cut.
    if (extend == true){
        translate([0,0,-1])
        cylinder_outer(nut_thick+1,nut_wide/2, 6);
    } else {
        cylinder_outer(nut_thick, nut_wide/2, 6);
    }
    intersection(){
        cylinder_outer(nut_thick*2, nut_wide/2, 6);
        union(){
            translate([0,0,nut_thick])
            cube([nut_wide*2, bolt_dia, layer_height*2], center=true);
            translate([0,0,nut_thick+layer_height])
            cube([bolt_dia, bolt_dia, layer_height*2], center=true);
        }
    }
}

module bolt_head(bolt_head_dia = 5.7, head_thick = 3.5, bolt_dia = 3.5, extend = false, layer_height = .25){
    if (extend == true){
        translate([0,0,-1])
        cylinder_outer(head_thick+1,bolt_head_dia/2, 18);
    } else {
        cylinder_outer(head_thick,bolt_head_dia/2, 18);
    }
    intersection(){
        cylinder_outer(head_thick*2,bolt_head_dia/2, 18);
        union(){
            translate([0,0,head_thick])
            cube([bolt_head_dia*2, bolt_dia, layer_height*2], center=true);
            translate([0,0,head_thick+layer_height])
            cube([bolt_dia, bolt_dia, layer_height*2], center=true);
        }
    }
}

module rounded_cube(size, r=3, center=false, fn=32){
    hull(){
        for (x = [-1,1], y=[1,-1]){
            translate([x*(size[0]/2-r),y*(size[1]/2-r),0])
            if(center==true){
                rotate([0,0,360/(fn*2)])
                cylinder_outerc(size[2],r,fn);
            } else {
                rotate([0,0,360/(fn*2)])
                cylinder_outer(size[2],r,fn);
            }
        }
    }
}

module spherical_cube(size, r=3, center=false, fn=32){
    render()
    hull(){
        for (x = [-1,1], y=[1,-1], z=[-1,1]){
            translate([x*(size[0]/2-r),y*(size[1]/2-r),z*(size[2]/2-r)])
            if(center==true){
                rotate([0,0,360/(fn*2)])
                sphere(r,$fn=fn);
            } else {
                rotate([0,0,360/(fn*2)])
                sphere(r,$fn=fn);
            }
        }
    }
}

module wall(pointslist,r=1.5,center=false,fn=32){
    union(){
        for (idx = [0:1:len(pointslist)-2]){
            hull(){
                if (center==false){
                    translate([pointslist[idx][0],pointslist[idx][1],0])
                    cylinder_outer(pointslist[idx][2], r, fn);
                    translate([pointslist[idx+1][0],pointslist[idx+1][1],0])
                    cylinder_outer(pointslist[idx+1][2], r, fn);
                } else {
                    translate([pointslist[idx][0],pointslist[idx][1],0])
                    cylinder_outerc(pointslist[idx][2], r, fn);
                    translate([pointslist[idx+1][0],pointslist[idx+1][1],0])
                    cylinder_outerc(pointslist[idx+1][2], r, fn);
                }
                
            }
        }
    }
}

module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}
   
module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}
   
module cylinder_outerc(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn,center=true);}

module cylinder_outer2(height,r1,r2,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r1=r1*fudge,r2=r2*fudge,$fn=fn);}
   
module cylinder_outer2c(height,r1,r2,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r1=r1*fudge,r2=r2*fudge,$fn=fn,center=true);}

module circle_outer(radius,fn){
   fudge = 1/cos(180/fn);
   circle(r=radius*fudge,$fn=fn);}