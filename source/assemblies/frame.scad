include <../parameters.scad>;
use <common.scad>;
use <../vitamins/v-slot.scad>;

module frame_square_assembly () {
  rotate([0, 90, 0]) v_slot_mockup(x_v_slot_l);
  translate([-v_slot_d / 2, v_slot_d / 2]) rotate([90, 0, 0]) v_slot_mockup(y_v_slot_l);
  translate([x_v_slot_l + v_slot_d / 2, v_slot_d / 2]) rotate([90, 0, 0]) v_slot_mockup(y_v_slot_l);
  translate([0, -y_v_slot_l + v_slot_d]) rotate([0, 90, 0]) v_slot_mockup(x_v_slot_l);
}

translate([-x_v_slot_l / 2, 0]) {
  frame_square_assembly();
  translate([0, 0, frame_v_slot_z_spacing]) frame_square_assembly();
}
