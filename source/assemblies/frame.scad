include <../parameters.scad>;
use <common.scad>;
use <../vitamins/v-slot.scad>;

module frame_square_assembly () {
  // Extrusions parallel to X axis:
  translate([0, v_slot_d]) rotate([0, 90, 0]) v_slot_mockup(x_v_slot_l);
  translate([0, -y_v_slot_l]) rotate([0, 90, 0]) v_slot_mockup(x_v_slot_l);

  // Extrusions parallel to Y axis:
  translate([v_slot_d / 2, v_slot_d / 2])
    rotate([90, 0, 0]) v_slot_mockup(y_v_slot_l);
  translate([x_v_slot_l - v_slot_d / 2, v_slot_d / 2])
    rotate([90, 0, 0]) v_slot_mockup(y_v_slot_l);
}

// 130
module frame_assembly () {
  translate([-x_v_slot_l / 2, y_v_slot_l -z_y_frame_offset, -frame_v_slot_z_spacing / 2]) {
    translate([0, 0, v_slot_d / 2]) frame_square_assembly();
    translate([0, 0, frame_v_slot_z_spacing - v_slot_d / 2]) frame_square_assembly();
  }
}
