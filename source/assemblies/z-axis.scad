include <../parameters.scad>;
use <../hinge-outer.scad>;
use <../sizing.scad>;
use <../top-corner.scad>;
use <../vitamins/gt2.scad>;
use <../vitamins/v-slot.scad>;
use <../z-gantry.scad>;
use <../z-idler.scad>;
use <top-corner.scad>;

function z_axis_gantry_offset() = z_idler_h() - outer_hinge_z_idler_clearance();
// Offset from the bottom of the X axis extrusion to the top of the frame extrusion
// when Z = 0.
function z_axis_x_v_slot_bottom_offset() = z_axis_gantry_offset() + z_gantry_h() - v_slot_d
                                           - v_slot_wall_t;

// Offset from edge of bed to center of the belt.
function z_axis_belt_x_offset() =
  // Starting from the bed:
  (x_v_slot_s() - bed_w) / 2 +      // end of bed to inner edge of Y extrusion
  v_slot_d +                        // Y extrusion
  z_x_frame_offset + v_slot_d / 2;  // middle of belt

// A Z axis assembly. Accepts the gantry as a child.
module z_axis_assembly(e = 0, z = 0) {
  translate([ 0, 0, -frame_v_slot_z_spacing / 2 ]) {
    v_slot_mockup(z_v_slot_l);
    translate([ 0, 0, z_v_slot_l + e ]) {
      top_corner_assembly();
    }
  }

  mirror([ 1, 0, 0 ]) translate([ -z_x_frame_offset - v_slot_d / 2, 0, 0 ]) outer_hinge();

  translate([ 0, 0, frame_v_slot_z_spacing / 2 - outer_hinge_z_idler_clearance() + e ]) {
    z_idler();

    translate([ 0, 0, z_idler_h() + z ]) children();

    to_z_belt_y_center() gt2_belt_mockup(z_v_slot_l - frame_v_slot_z_spacing);
  }

  echo(str(
    "z-axis travel distance available: ",
    z_v_slot_l - frame_v_slot_z_spacing - top_corner_h() - z_idler_h()
  ));
  echo(str("z-axis belt x offset (for M671): ", z_axis_belt_x_offset()));
}

z_axis_assembly();
