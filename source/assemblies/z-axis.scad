use <common.scad>;
use <../top-corner.scad>;
use <../hinge-outer.scad>;
use <../z-idler.scad>;
use <../z-gantry.scad>;
include <../parameters.scad>;

function z_axis_gantry_offset () = z_idler_h() - outer_hinge_z_idler_clearance();
// Offset from the bottom of the X axis extrusion to the top of the frame extrusion
// when Z = 0.
function z_axis_x_v_slot_bottom_offset () = z_axis_gantry_offset() + z_gantry_h() - v_slot_d - v_slot_wall_t;

// A Z axis assembly. Accepts the gantry as a child.
module z_axis_assembly (
  z = 0,
  slack = 0.1
) {
  v_slot_mockup(z_v_slot_l);

  mirror([1, 0, 0])
    translate([-z_x_frame_offset - v_slot_d / 2, 0, frame_v_slot_z_spacing / 2])
      outer_hinge();

  translate([0, 0, frame_v_slot_z_spacing - outer_hinge_z_idler_clearance() + slack]) {
    z_idler();

    translate([0, 0, z_idler_h() + z + slack]) children();

    to_z_belt_y_center () belt_mockup(z_v_slot_l - frame_v_slot_z_spacing);
  }


  translate([0, 0, z_v_slot_l])
    top_corner();
}

z_axis();
