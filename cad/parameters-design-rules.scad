use <catchnhole/catchnhole.scad>;

press_fit = 0;
v_slot_sliding_fit = 0.021; // H7/h6 over a 20 mm "shaft"
tight_fit = 0.1;
fit = 0.2;
loose_fit = 0.5;

// Thickness of a wall holding onto aluminium extrusion.
v_slot_wall_t = 4;
// And a length of the bolt going through said wall, and into a t-nut
// in the extrusion.
v_slot_wall_t_bolt_l = 8;

// Thickness of a wall holding onto a belt.
belt_wall_t = 2;

// Thickness of a wall holding a stepper.
stepper_mount_plate_t = 5;
// How much of a bolt should go into a stepper at minimum.
stepper_bolt_l = 4;

bolt = "M3";
// Minimal amount of material around a bolt hole for our standard bolt (M3):
bolt_wall_d = 7;
// Minimal height of a bolt hole for our standard bolt (M3):
bolt_wall_h = 3;
// Minimal amount of material around a nut for our standard bolt (M3):
nut_wall_d = 9;
nut_wall_h = nut_height(bolt) + 2/3 * bolt_wall_h;

// The bolt size we're going to use to put the frame together:
frame_bolt = "M4";
frame_bolt_wall_d = 7.5;

// And here's the bolt you could tap into the end of extrusions, if so inclined.
frame_tap_bolt = "M5";

endstop_wall_t = 1.6;
endstop_fit = fit;
