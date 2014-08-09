use <hexnut.scad>

module idlercover(radius=8, height=2){
  width = face+(2*sqrt((face*face)/2));
  difference() {
    union() {
      cylinder(r=radius,h=height);
      for(nutangle=[0:90:360]) {
        rotate(nutangle,[0,0,1]) translate([24.5/2+5,0,0]) {
          cylinder(r=5,h=8);
        }
      }
    }
    cylinder(r=8.5,h=height);
    for(nutangle=[0:90:360]) {
      rotate(nutangle,[0,0,1]) translate([24.5/2+5,0,0]) {
        translate([0,0,4.5]) hexnut(flats=5.3,h=3.5);
        cylinder(r=2,h=8.5);
      }
    }
  }
}


idlercover(radius=(24.5/2)+10);
