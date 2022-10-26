use <../hinge-outer.scad>;
use <../z-gantry-left.scad>;
use <../z-idler.scad>;
module z_left_assembly () {
translate([x_v_slot_l / 2 + z_x_frame_offset + v_slot_d / 2, 0]) {
   v_slot_mockup(z_v_slot_l);

  translate([0, 0, z_v_slot_l / 2])
    mirror([1, 0, 0]) z_gantry_left();
  translate([0, 0, z_v_slot_l])
    mirror([1, 0, 0]) top_corner();

  translate([-z_x_frame_offset - v_slot_d / 2, 0, frame_v_slot_z_spacing / 2])
    outer_hinge();

  mirror([1, 0, 0])
    translate([0, 0, frame_v_slot_z_spacing + slack]) z_idler();

  to_z_belt_y_center () belt_mockup(z_v_slot_l);
}

translate([-x_v_slot_l / 2, 0, z_v_slot_l / 2 + v_slot_d / 2 + v_slot_wall_t])
  rotate([0, 90, 0])
    v_slot_mockup(x_v_slot_l);
}
