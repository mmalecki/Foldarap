// Whether to show the exploded view or not.
explode = true;

// How much to explode the view.
e = 10;

// With what diameter to show belt centers (0 to disable).
belt_centers = 2;

include <parameters.scad>;
include <vitamins/gt2-parameters.scad>;
use <top-corner.scad>;
use <z-gantry-left.scad>;
use <z-gantry-right.scad>;
use <vitamins/v-slot.scad>;
use <hinge-outer.scad>;
use <z-idler.scad>;

module v_slot_mockup (length) {
  color("silver") v_slot(length);
}

module belt_mockup (length) {
  for (side = [-1, 1]) {
    translate([0, side * gt2_16t_pulley_pitch_d / 2])
      color("black") cylinder(d = gt2_t, h = length);
  }
  color("gray") cylinder(d = belt_centers, h = length);
}

// The right gantry (when looking from the front).
translate([-x_v_slot_l / 2 - z_x_frame_offset - v_slot_d / 2, 0]) {
  v_slot_mockup(z_v_slot_l);

  translate([0, 0, z_v_slot_l / 2])
    z_gantry_right();
  translate([0, 0, z_v_slot_l])
    top_corner();

  mirror([1, 0, 0]) translate([-z_x_frame_offset - v_slot_d / 2, 0]) outer_hinge();

  translate([0, 0, frame_v_slot_z_spacing]) z_idler();

  to_z_belt_y_center () belt_mockup(z_v_slot_l);
}

// The left gantry (when looking from the front).
// Carries the extruder at the moment.
translate([x_v_slot_l / 2 + z_x_frame_offset + v_slot_d / 2, 0]) {
   v_slot_mockup(z_v_slot_l);

  translate([0, 0, z_v_slot_l / 2])
    mirror([1, 0, 0]) z_gantry_left();
  translate([0, 0, z_v_slot_l])
    mirror([1, 0, 0]) top_corner();

  translate([-z_x_frame_offset - v_slot_d / 2, 0]) outer_hinge();

  to_z_belt_y_center () belt_mockup(z_v_slot_l);
}

translate([-x_v_slot_l / 2, 0, z_v_slot_l / 2 + v_slot_d / 2 + v_slot_wall_t]) rotate([0, 90, 0]) v_slot_mockup(x_v_slot_l);
