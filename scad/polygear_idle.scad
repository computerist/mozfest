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
        for(angle=[0:(360/sides):360-(360/sides)]){
          rotate(angle,[0,0,1]){
            translate([0,o,0]) toothcurve(edge=face, height=height, cutout=cutout);
          }
        }
        for(angle=[0:(360/sides):360-(360/sides)]){
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
        //for(angle=[0:(360/sides):360-(360/sides)]){
        //  linear_extrude(height=2) {
        //    rotate(angle,[0,0,1]){
        //      polygon(points=[[0,0],[-width/2,-o],[-width/2,-(o+cutout/2)],[width/2,-(o+cutout/2)],[width/2,-o]], paths=[[0,1,2,3,4]]);
        //    }
        //  }
        //}
      }
    }
    union() {
      for(angle=[0:(360/sides):360-(360/sides)]){
        rotate(angle,[0,0,1]){
          translate([face/2,o,0]) cylinder(r=cutout/2,h=height);
        }
      }
      translate([0,0,0])cylinder(r=(width/2)-((cutout/2)),h=height);
    }
  }
}

module centre(face=30, cutout=8, sides=12, height=11, wall=2, motorshaft, nutheight) {
  o = (face/2) * tan((180-(360/sides))/2);
  width = o*2;
  difference() {
    union() {
      // spokes, screw hole bodies
      for(nutangle=[0:90:360]) {
        rotate(nutangle,[0,0,1]) {
          translate([22.5/2,-2.5,0]) cube([(width/2)-((cutout/2))-(22.5/2),5,8]);
          translate([24.5/2+5,0,0]) cylinder(r=5,h=8);
        }
      }

      // bearing trap
      // bottom
      difference() {
        cylinder(r=(24.5/2)+10,h=1);
        cylinder(r=8.5,h=height);
      }
      // sides
      difference() {
        cylinder(r=(24.5/2)+10,h=8);
        cylinder(r=22.5/2,h=8);
      }
    }
    // screw holes
    for(nutangle=[0:90:360]) {
      rotate(nutangle,[0,0,1]) translate([24.5/2+5,0,0]) {
        cylinder(r=3.25,h=3,$fn=20);
        cylinder(r=1.5,h=8.5,$fn=20);
      }
    }
  }
}

module body(face=30, sides=12, motorshaft, nutheight, height, cutout) {

}

module gear(face=30, cutout=8, sides=12, height=11, wall=2, motorshaft=5.5, nutheight=4) {
  profile(face=face, cutout=cutout, sides=sides, height=height, wall=2);
  centre(face=face, cutout=cutout, sides=sides, height=height, wall=2, motorshaft=motorshaft, nutheight=nutheight);
  body(face=face, sides=sides, motorshaft=motorshaft, nutheight=nutheight, height=height, cutout=cutout);
}

gear();
