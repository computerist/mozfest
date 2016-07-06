phone_x = 71;
phone_y = 9.3;

height = 50;
grip = 2; // how much material protrudes in front of the phone to hold it in place

wall_thickness = 2;
stick_r = 3.5;
stick_height = 20;
camera_x = 52;
charger_y = 4;

module phone_void() {
	cube([phone_x, phone_y, height]);
}

module holder() {
	viewport_x = phone_x - (grip * 2);
	difference() {
		minkowski() {
			phone_void();
			cylinder(r=wall_thickness, h=0.01);
		}
		translate([0, 0, wall_thickness]) phone_void();
		translate([grip, -wall_thickness, wall_thickness + grip]) cube([viewport_x, wall_thickness, height]);
		translate([phone_x / 2, charger_y, 0]) {
			cylinder(r = 7, h = wall_thickness);
		}
	}
	translate([camera_x, stick_r + phone_y + wall_thickness, 0]) difference() {
		cylinder(r = stick_r + wall_thickness, h = stick_height);
		cylinder(r = stick_r, h = stick_height - wall_thickness);
	}
}

holder();