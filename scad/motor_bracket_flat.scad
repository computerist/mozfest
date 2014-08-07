module motor_bracket(){
  union() {
    difference() {
      union() {
        cube([50,2,30]);
        translate([0,6,0])
            cube([50,2,30]);
        linear_extrude(height = 1)
            polygon(points=[[0,-17],[0,17],[50,8],[50,0]], paths=[[0,1,2,3]]);
        translate([0,0,0]) cylinder(r=17,h=30,$fn=50);
      }
      union() {
        translate([0,0,1]) cylinder(r=15.5,h=60,$fn=50);
        translate([0,-5.5,0]) cylinder(r=5.25,h=2,center=true,$fn=20);
        translate([-12.5,0,0]) cylinder(r=1.75,h=2,center=true,$fn=20);
        translate([12.5,0,0]) cylinder(r=1.75,h=2,center=true,$fn=20);
        translate([25,0,15]) rotate(270,[1,0,0]) cylinder(r=1.5,h=10,$fn=20);
        translate([40,0,15]) rotate(270,[1,0,0]) cylinder(r=1.5,h=10,$fn=20);
      }
    }
  }
}

//mirror([0,1,0])
motor_bracket();
