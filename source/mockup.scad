// Whether to show the exploded view or not.
explode = true;

// How much to explode the view.
e = 10;

// With what diameter to show belt centers (0 to disable).
belt_centers = 2;

// With what diameter to show belts (0 to disable).
belts = 3;

include <parameters.scad>;
include <parameters-gt2.scad>;
use <top-corner.scad>;
use <z-gantry-left.scad>;
use <z-gantry-right.scad>;
use <v-slot.scad>;

module v_slot_mockup (length) {
  color("silver") v_slot(length);
}

module belt_mockup (length) {
  for (side = [-1, 1]) {
    translate([0, side * gt2_16t_pulley_pitch_d / 2])
      color("black") cylinder(d = belts, h = length);
  }
  color("gray") cylinder(d = belt_centers, h = length);
}

// The right gantry (when looking from the front).
translate([-x_v_slot_l / 2 - z_x_frame_offset - v_slot_d / 2, 0]) {
  color("silver") v_slot(z_v_slot_l);

  translate([0, 0, z_v_slot_l / 2])
    z_gantry_right();
  translate([0, 0, z_v_slot_l])
    top_corner();

  to_z_belt_y_center () belt_mockup(z_v_slot_l);
}

// The left gantry (when looking from the front).
// Carries the extruder at the moment.
translate([x_v_slot_l / 2 + z_x_frame_offset + v_slot_d / 2, 0]) {
  color("silver") v_slot(z_v_slot_l);

  translate([0, 0, z_v_slot_l / 2])
    z_gantry_left();
  translate([0, 0, z_v_slot_l])
    mirror([1, 0, 0]) top_corner();

  to_z_belt_y_center () belt_mockup(z_v_slot_l);
}

translate([-x_v_slot_l / 2, 0, z_v_slot_l / 2 + v_slot_d / 2]) rotate([0, 90, 0]) v_slot_mockup(x_v_slot_l);
