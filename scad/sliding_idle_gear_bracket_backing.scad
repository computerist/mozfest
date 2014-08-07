use <Hexnut.scad>

module countersunk_trough(r1=2.15, r2=4, length=10, depth=3) {
	rotate(90,[1,0,0]) linear_extrude(height=length, center=true) polygon(points=[[-r1,-depth],[-r2,0],[r2,0],[r1,-depth]],paths=[[0,1,2,3]]);
	translate([0,-length/2,-depth])cylinder(r1=r1, r2=r2, h=depth);
	translate([0,length/2,-depth])cylinder(r1=r1, r2=r2, h=depth);
}

module trough(){
	translate([7,5,0]) cylinder(r=1.5,h=10,$fn=20);
			translate([7,5,4.5]) hexnut(flats=5.3,h=3.5);
			translate([7,5,0]) cylinder(r=2,h=8.5);
}

module body(height=5, width=11, length=20) {
	bracket_radius = 12;
	nut_depth = 7.5;
	nut_flats = 13.2;
	axle_radius = 4.2;
	difference() {
		union() {
			translate([-5.5,0,0]) cube([width+7.5,length,2]);
			translate([0,5,0]) cylinder(r=5,h=8);
			translate([0,27,0]) cylinder(r=5,h=8);
			translate([7,13.5,0]) cylinder(r=5,h=8);
		}
		union() {
			translate([-7,0,0]) trough();
			translate([-7,22,0]) trough();
			translate([0,8.5,0]) trough();
		}
	}
}

translate([6.5,0,0]) body(height=12, width=11, length=40);
mirror([1,0,0]) translate([6.5,0,0]) body(height=12, width=11, length=40);