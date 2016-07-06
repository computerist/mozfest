shaft_dia = 6.5;
screw_dia = 2;
thickness = 2;
screw_offset = 15;
height = 50;

module support() {
  difference() {
    union() {
      hull() {
        translate([-screw_offset,0,0]) cylinder(r=3, h=thickness);
        translate([screw_offset,0,0]) cylinder(r=3, h=thickness);
        cylinder(r=(shaft_dia/2)+thickness, h=thickness);
      }
      hull() {
        translate([-(screw_offset - 5), -thickness/2, 0]) cube([(screw_offset-5)*2, thickness, thickness]);
        translate([-((shaft_dia/2)+thickness),-thickness/2, 0]) cube([shaft_dia+thickness*2, thickness, height]);
      }
      cylinder(r=(shaft_dia/2)+thickness, h=height);
    }
    union() {
      translate([-screw_offset,0,0]) cylinder(r=screw_dia/2, h=thickness);
      translate([screw_offset,0,0]) cylinder(r=screw_dia/2, h=thickness);
      cylinder(r=shaft_dia/2, h=height);
    }
  }
}

support();
