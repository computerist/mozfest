/* a phone-on-a-stick holder for a flame */
width=70;
depth=10.5;
height=75;
thickness=1;
flange=5;
shaft_dia=6.5;
shaft_thickness=2;
module holder(){
  difference() {
    union() {
      hull() {
        translate([0,(-(depth+2*thickness)/2)-(shaft_dia/2)-shaft_thickness, 0]) {
          cylinder(r=(shaft_dia/2)+shaft_thickness, h=(height/2)+shaft_thickness, $fn=100);
        }
        translate([-width/4, -(depth+2*thickness)/2,0]) cube([width/2, depth+2*thickness, (height/2)+(width/4)]);
      }
      translate([-(width+2*thickness)/2, -(depth+2*thickness)/2,0]) cube([width+2*thickness, depth+2*thickness, height+thickness]);
    }
    union() {
      translate([-width/2,-depth/2,thickness]) cube([width,depth,height]);
      translate([-(width-flange*2)/2,-depth/2,thickness+flange]) cube([width-2*flange, depth+thickness, height+flange]);
      translate([0,(-(depth+2*thickness)/2)-(shaft_dia/2)-shaft_thickness, 0]) {
        cylinder(r=(shaft_dia/2), h=height/2);
      }
      translate([-depth/2, -depth/2, 0]) cube([depth, depth, thickness]);
    }
  }
}

holder();
