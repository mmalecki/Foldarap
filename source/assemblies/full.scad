// How much to explode the view.
e = 10;

// Whether to display the bottom frame
frame = true;

// Whether to display the X axis
x_axis = true;

// Z axis Y rotation (as in folding - 90 degrees for folded position, 0 for upright).
z_axis_x_rotation = 0;

// Where the gantry is (in absolute physical Z axis position, e.g. 0 means you're buying a
// new nozzle/bed).
z = 0;

include <../parameters.scad>;
include <../vitamins/gt2-parameters.scad>;
use <../vitamins/v-slot.scad>;
use <frame.scad>;
use <x-axis.scad>;
use <z-axis-left.scad>;
use <z-axis-right.scad>;
use <z-axis.scad>;

module full_assembly (e = 0, frame = true, x_axis = true) {
  rotate([ z_axis_x_rotation, 0 ]) {
    // The right Z axis (when looking from the front).
    translate([ -x_v_slot_l / 2 - frame_z_x_offset - v_slot_d / 2, 0 ]) {
      z_axis_right_assembly(e, z);
    }

    // The left gantry (when looking from the front).
    // Carries the extruder at the moment.
    translate([ x_v_slot_l / 2 + frame_z_x_offset + v_slot_d / 2, 0 ]) {
      z_axis_left_assembly(e, z);
    }

    if (x_axis) {
      translate([
        -x_v_slot_l / 2, 0,
        frame_y_z_offset / 2 + z_axis_x_v_slot_bottom_offset() + z + v_slot_d / 2
      ]) x_axis_assembly();
    }

    translate([
      -x_v_slot_l / 2, 0, z_v_slot_l - frame_y_z_offset / 2 + v_slot_d / 2 -
      v_slot_d
    ]) rotate([ 0, 90, 0 ]) v_slot_mockup(x_v_slot_l);
  }

  if (frame) {
    frame_assembly(e);
  }
}

full_assembly(e = e, frame = frame, x_axis = x_axis);
