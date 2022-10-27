// Whether to show the exploded view or not.
explode = true;

slack = 0.1;

// How much to explode the view.
e = 10;

// Z axis Y rotation (as in folding - 90 degrees == folded, 0 == upright).
z_axis_x_rotation = 0;

// Where the gantry is (in absolute physical Z axis position, e.g. 0 means
// you're buying a new nozzle/bed).
z = 0;

include <../parameters.scad>;
include <../vitamins/gt2-parameters.scad>;
use <../vitamins/v-slot.scad>;
use <common.scad>;
use <z-axis.scad>;
use <z-axis-right.scad>;
use <z-axis-left.scad>;
use <x-axis.scad>;

rotate([z_axis_x_rotation, 0]) {
  // The right Z axis (when looking from the front).
  translate([-x_v_slot_l / 2 - z_x_frame_offset - v_slot_d / 2, 0]) {
    z_axis_right_assembly(z);
  }

  // The left gantry (when looking from the front).
  // Carries the extruder at the moment.
  translate([x_v_slot_l / 2 + z_x_frame_offset + v_slot_d / 2, 0]) {
    z_axis_left_assembly(z);
  }

  translate([-x_v_slot_l / 2, 0, frame_v_slot_z_spacing + z_axis_x_v_slot_bottom_offset() + z + v_slot_d / 2])
    x_axis_assembly();
}
