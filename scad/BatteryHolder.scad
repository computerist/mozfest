include<hexnut.scad>;

width=84;
length=114;
height=30;

module post() {
  //cylinder(r=5,h=4.5);
}

module hole() {
  translate([0,0,-2]) hexnut(flats=5.3,h=7.5);
  translate([0,0,-15]) cylinder(r=2,h=30);
}

module surround(s_width, s_height, end_width=0, extra_top=0) {
  translate([0,0,-s_height/2]) {
    translate([width/2,-length/2,0]) cube([s_width, length+end_width,s_height+extra_top]);
    translate([(-width/2)-s_width,-length/2,0]) cube([s_width, length+end_width,s_height+extra_top]);
    translate([-width/2,length/2,0]) cube([width,end_width,s_height+extra_top]);
  }
}

module body(end_block) {
  difference() {
    union() {
      translate([-width/2,length/2,0]) {
        cube([width,end_block,height]);	
      }
      translate([-width/2,-length/2,0]) cube([width,length,30]);
    }
    translate([0,0,1]) scale(v = [1,1.03]) linear_extrude(layer = "Layer 1",
        height = 30, convexity = 10) {
      import(file = "Battery_shape.dxf");
    }
  }
}

module holder() {
  screws = [[(-width/2)-5,15],[(width/2)+5,15],[(-width/2)-5,-15],[(width/2)+5,-15],[(-width/2)-5,45],[(width/2)+5,45],[(-width/2)-5,-45],[(width/2)+5,-45]];
  difference() {
    union() {
      body(10);
      translate([0,0,height/2]){
        surround(10,10,10,2);
      }
      for(screw=screws) {
        translate([screw[0],screw[1],(height/2)+5]) post();
      }
    }
    union() {
      translate([0,0,height/2]){
        surround(10,3,10);
      }
      for(screw=screws) {
        translate([screw[0],screw[1],(height/2)+5]) hole();
      }
    }
  }
}

//holder();

difference() {
  union() {
    translate([0,-2,length/2]) rotate(90,[1,0,0]) holder();
    translate([0,2,(length/2)+10]) rotate(270,[1,0,0]) holder();
  }
  translate([-(width+30)/2,-((height*2)+10)/2,(length+10)/2]) cube([width+30,(height*2)+10,length]);
}
