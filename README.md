# 3D Printed Tracked Vehicle

## Why?

I needed a design for a tracked vehicle for an educational robotics project.
I looked around and couldn't find anything that suited. So I made one.

## What's needed to build one?

To make the parts, you'll need a 3D Printer, some slicer software, [openscad](http://www.openscad.org/)
and the specifications of the motors (dimensions, mount offset, etc.) you
want to use. If you're not using the same motors I did, you'll need to
modify the motor mounts.

To put the parts together you'll need various screws and nuts. I used
stainless steel M25 screws and stainless lock nuts. Fixing the track
segements together with rivets may also work well.

To use the parts, you'll need a power source (I used a drill battery), some
motors (and something to drive them with). I used the EMG30 motors and
MD25 motor driver from [robot-electronics.co.uk](http://robot-electronics.co.uk/acatalog/Drive_Systems.html).

You'll also need some kind of controller. I've used both Raspberry Pis and
Arduinos with good success.
