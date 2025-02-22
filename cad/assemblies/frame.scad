include <../parameters.scad>;
use <../vitamins/v-slot.scad>;

e = 0;

module frame_square_assembly (e = 0) {
  // Extrusions parallel to X axis:
  translate([ 0, v_slot_d ]) rotate([ 0, 90, 0 ]) v_slot_mockup(x_v_slot_l);
  translate([ 0, -y_v_slot_l ]) rotate([ 0, 90, 0 ]) v_slot_mockup(x_v_slot_l);

  // Extrusions parallel to Y axis:
  translate([ v_slot_d / 2, v_slot_d / 2 ]) rotate([ 90, 0, 0 ]) v_slot_mockup(y_v_slot_l);
  translate([ x_v_slot_l - v_slot_d / 2, v_slot_d / 2 ]) rotate([ 90, 0, 0 ])
    v_slot_mockup(y_v_slot_l);
}

module frame_assembly (e = 0) {
  translate([ -x_v_slot_l / 2, y_v_slot_l - frame_z_y_offset, -frame_y_z_offset / 2 ]) {
    translate([ 0, 0, v_slot_d / 2 ]) frame_square_assembly();
    translate([ 0, 0, frame_y_z_offset - v_slot_d / 2 ]) frame_square_assembly();
  }
}

frame_assembly(e);
