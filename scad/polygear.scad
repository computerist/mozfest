use <hexnut.scad>

module toothcurve(edge=30,height=5,cutout=8,wiggle=1) {
  intersection() {
    translate([edge/2,0,0])cylinder(r=edge-(cutout/2),h=height,$fn=100);
    translate([-edge/2,0,0])cylinder(r=edge-(cutout/2),h=height,$fn=100);
  }
}

module profile(face=30, cutout=8, sides=12, height=11, wall=2){
  o = (face/2) * tan((180-(360/sides))/2);
  width = o*2;
  difference() {
    intersection() {
      union() {
        cylinder(r=o-10,h=height);
        for (angle=[0:(360/sides):360-(360/sides)]){
          rotate(angle,[0,0,1]){
            translate([0,o,0]) toothcurve(edge=face, height=height, cutout=cutout);
          }
        }
        for (angle=[0:(360/sides):360-(360/sides)]){
          linear_extrude(height=height) {
            rotate(angle,[0,0,1]){
              polygon(points=[[0,0],[-face/2,-o],[-face/2,-(o+cutout/2)],[face/2,-(o+cutout/2)],[face/2,-o]], paths=[[0,1,4]]);
            }
          }
        }
      }
      union() {
        cylinder(r=o+(cutout/2),h=height,$fn=100);
        // replace cylinder above with polygons below if tracks aren't open
        //for (angle=[0:(360/sides):360-(360/sides)]){
        //  linear_extrude(height=2) {
        //    rotate(angle,[0,0,1]){
        //      polygon(points=[[0,0],[-width/2,-o],[-width/2,-(o+cutout/2)],[width/2,-(o+cutout/2)],[width/2,-o]], paths=[[0,1,2,3,4]]);
        //    }
        //  }
        //}
      }
    }
    union() {
      for (angle=[0:(360/sides):360-(360/sides)]){
        rotate(angle,[0,0,1]){
          translate([face/2,o,0]) cylinder(r=cutout/2,h=height);
        }
      }
      translate([0,0,0])cylinder(r=(width/2)-((cutout/2)),h=height);
    }
  }
}

module centre(face=30, cutout=8, sides=12, height=11, wall=2, motorshaft, nutheight){
  o = (face/2) * tan((180-(360/sides))/2);
  width = o*2;
  nutflats = 5;// nut, flat to flat
  screwshaft =  3.5; // screw shaft diameter
  screwhead = 5; // screw head diameter
  screwlength = 30; // screw length
  motorshaftlength = 10;
  motorflatdepth=1;
  cutout_r = cutout/2;

  difference(){

    translate([0,0,0])cylinder(r=(motorshaft/2)+3+nutheight+5,h=height);
    union() {
      translate([0,0,1]) cylinder(r=motorshaft/2,h=motorshaftlength);
      translate([-nutflats/2,((motorshaft/2)+3),height/2]) cube([nutflats,nutheight,height/2]);
      translate([0,0,height/2]) rotate(270,[1,0,0]) cylinder(r=screwshaft/2,h=width);
      translate([0,screwlength,height/2]) rotate(270,[1,0,0]) cylinder(r=screwhead/2,h=width);
      translate([0,((motorshaft/2)+3),height/2]) rotate(270,[10,0,0]) rotate(90,[0,0,1]) hexnut(flats=nutflats,depth=nutheight);
    }
  }
}

module body(face=30, sides=12, motorshaft, nutheight, height) {
  o = (face/2) * tan((180-(360/sides))/2);
  for (angle=[45:90:315]) {
    rotate(angle,[0,0,1])
        translate([-2.5,(motorshaft/2)+3+nutheight+3,0])
        cube([5,o-((motorshaft/2)+3+nutheight+5),height]);
  }
}

module gear(face=30, cutout=8, sides=12, height=11, wall=2, motorshaft=5.5, nutheight=4) {
  difference() {
    union(){
      profile(face=face, cutout=cutout, sides=sides, height=height, wall=2);
      centre(face=face, cutout=cutout, sides=sides, height=height, wall=2, motorshaft=motorshaft, nutheight=nutheight);
      body(face=face, sides=sides, motorshaft=motorshaft, nutheight=nutheight, height=height);
    }
    translate([0, face/2, height/2]) {
      rotate(270,[1,0,0]){
        cylinder(r=5/2, h=200);
      }
    }
  }
}

//toothcurve();

gear(sides=12);
