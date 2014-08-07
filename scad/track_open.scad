use <hexnut.scad>

module hingeprofile(width=20, depth=4, thickness=1){
  dropdepth = (depth/2)/tan(22.5/2);
  cutoffdepth = dropdepth-((depth/2)+thickness);

  difference() {
    translate([0,0,depth/2]) rotate(rotation,[1,0,0])union() {
      translate([0,0,0]) rotate(90,[0,1,0]) cylinder(r=depth/2,h=width,center=true, $fn=12);
      rotate(270,[0,1,0]) linear_extrude(height=width, center=true) polygon(points=[[0,-depth/2],[0,depth/2],[-dropdepth,0]],paths=[[0,1,2]]);
    }
    translate([-width/2,-depth/2,-(cutoffdepth+thickness+1)]) cube([width+1,depth,cutoffdepth+1]);
  }
}

module base(width=20, length=20, thickness=2) {
  translate([-width/2,-length/2,0]) cube([width, length, thickness]);
}

module sidewall(width=5, length=20, depth=4) {
  translate([-width/2,-length/2,0]) cube([width,length,depth]);
}

module fixingcutout(nut=[5,3.5],screw=[3,42.5,4.5,2.5], depth=6, wiggle=0.3) {
  nutflats = nut[0]+wiggle;
  screwhead = screw[2]+wiggle;
  shaft = screw[0]+wiggle;
  translate([-screw[1]/2,0,depth/2])
      rotate(90,[0,1,0])
      union() {
        cylinder(r=shaft/2,h=screw[1],$fn=10);
        cylinder(r=screwhead/2,h=screw[3],$fn=10);
        translate([0,0,screw[1]-nut[1]]) hexnut(flats=nutflats,depth=nut[1]);
      }
}

module hingefront(width=20,track=10, depth=5, thickness=1){
  wallwidth=(width-track)/2;
  cutline = (wallwidth/3) * 2;
  // hinge shape
  translate([-(width/2)+cutline,-depth/2,-thickness]) cube([(track+cutline),depth,depth+thickness]);
}

module hingeback(width=20,track=10, depth=5, thickness=1){
  wallwidth=(width-track)/2;
  cutline = (wallwidth/3) * 2;
  // hinge shape
  union() {
    translate([(-width/2)-0.5,-depth/2,-thickness]) cube([cutline+1,depth,depth+thickness]);
    translate([(width/2)-(cutline+0.5),-depth/2,-thickness]) cube([cutline+1,depth,depth+thickness]);
  }
}

module cutout(length=30, depth=6, track=10, bevel=2){
  translate([0,length/2,0]) rotate(90,[1,0,0]) linear_extrude(height=length)
      polygon(points=[[-track/2,0],[-track/2,depth/2],[(-track/2)-bevel,depth],[(track/2)+bevel,depth],[track/2,depth/2],[track/2,0]],paths=[[0,1,2,3,4,5]]);
}

module tread(width=32.5, length=30, depth=7, thickness=1, track=12, support=true, tread=2, bevel=1) {
  wallwidth=(width-track)/2;
  cutline = (wallwidth/3) * 2;
  difference() {
    union() {
      base(width, length, thickness);
      translate([0,0,thickness]) union() {
        translate([0,length/2],0) hingeprofile(width=width, depth=depth, thickness=thickness);
        translate([0,-length/2],0) hingeprofile(width=width, depth=depth, thickness=thickness);
        difference(){
          translate([-width/2,-length/2,0])cube([width,length,depth]);
          cutout(length=length, track=track, depth=depth, bevel=bevel);
          //translate([(width/2)-(wallwidth/2),0,0]) sidewall(wallwidth,length,depth);
          //translate([(-width/2)+(wallwidth/2),0,0]) sidewall(wallwidth,length,depth);
        }
      }
    }
    translate([0,0,thickness]) union() {
      // fixing cutouts
      translate([0,length/2,0]) fixingcutout(nut=[4.9,3.4],screw=[2.7,32.15,4.5,2.45], depth=depth);
      translate([0,-length/2,0]) fixingcutout(nut=[4.9,3.4],screw=[2.7,32.15,4.5,2.45], depth=depth);
      translate([0,-length/2,0]) hingefront(width=width,track=track, depth=depth, thickness=thickness);
      translate([0,length/2,0]) hingeback(width=width,track=track, depth=depth, thickness=thickness);
    }
    if(tread > 0) {
      for(offset=[(-length/2)-(depth/2):tread*2:(length/2)+(depth/2)])
                                        translate([-width/2,(-tread/2)+offset,0])cube([width,tread,0.6]);
    }
    translate([-(width/2),-((length+depth)/2),-1]) cube([width,(length+depth),1]);
  }
  if(support) {
    for(offset=[(-length/2)-(depth/2)+tread:tread*2:(length/2)+depth/2])
      translate([-(width+4)/2,(-tread/2)+offset,0])cube([width+4,1,0.3]);
  }
}

module support(width, length) {
  translate([-width/2,-length/2,0]){
    difference() {
      cube([width,length,1]);
      translate([1,1,0]) cube([width-2,length-2,1]);
    }
  }
}

module single_segment() {
  difference(){
    union() {
      support(32,30,7);
      tread(width=32, length=30, depth=7, thickness=0, track=12, support=true, tread=2.1);
    }
    translate([-16.25,-20,-1]) cube([32.5,40,1]);
  }
}

module many_tracks(wide=4, high=3) {
  width=32;
  length=37;
  wpad=2;
  lpad=1;

  totalwidth = width*wide+(wide)*wpad; echo(totalwidth);
  totallength = length*high+(high-1)*lpad; echo(totallength);

  support((width*wide)+(wide+2)*wpad, length*high + (high*lpad) + (lpad*2), 0);
  for(xoffset=[(-totalwidth/2)+(width/2)+(wpad/2):width+wpad:totalwidth/2]){
    for(yoffset=[(-totallength/2)+(length/2):length+lpad:totallength/2]){
      translate([xoffset,yoffset,0]) tread(width=32, length=30, depth=7, thickness=0, track=12, support=true, tread=2.1);
    }
  }
}

//single_segment();
//cutout();
rotate(90,[0,0,1])
  many_tracks(wide=3,high=2);
