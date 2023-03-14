include <../parameters.scad>;
use <../hinge-outer.scad>;
use <../sizing.scad>;
use <../top-corner.scad>;
use <../vitamins/gt2.scad>;
use <../vitamins/mgn12.scad>;
use <../vitamins/v-slot.scad>;
use <../z-gantry.scad>;
use <../z-idler.scad>;
use <top-corner.scad>;

function z_axis_gantry_offset () = z_idler_h() - outer_hinge_z_idler_clearance();
// Offset from the bottom of the X axis extrusion to the top of the frame extrusion
// when Z = 0.
function z_axis_x_v_slot_bottom_offset () = z_axis_gantry_offset() + z_gantry_h() - v_slot_d
                                            - v_slot_wall_t;

// Offset from edge of bed to center of the belt.
function z_axis_belt_x_offset () =
  // Starting from the bed:
  (x_v_slot_s() - bed_w) / 2 +      // end of bed to inner edge of Y extrusion
  v_slot_d +                        // Y extrusion
  frame_z_x_offset + v_slot_d / 2;  // middle of belt

// A Z axis assembly. Accepts the gantry as a child.
module z_axis_assembly (e = 0, z = 0) {
  translate([ 0, 0, -frame_y_z_offset / 2 ]) {
    v_slot_mockup(z_v_slot_l);

    rail_offset = frame_y_z_offset + z_idler_h();
    translate([ 0, -v_slot_d / 2, rail_offset ]) rotate([ 0, 0, 180 ])
      mgn12_mockup(z_v_slot_l - rail_offset - v_slot_d);

    translate([ 0, 0, z_v_slot_l + e - v_slot_d ]) {
      top_corner_assembly();
    }
  }

  mirror([ 1, 0, 0 ]) translate([ -frame_z_x_offset - v_slot_d / 2, 0, 0 ]) outer_hinge();

  translate([ 0, 0, frame_y_z_offset / 2 - outer_hinge_z_idler_clearance() + e ]) {
    z_idler();

    to_z_belt_y_center() gt2_belt_mockup(z_v_slot_l - frame_y_z_offset);
  }

  echo(str(
    "z-axis travel distance available: ",
    z_v_slot_l - frame_y_z_offset - top_corner_h() - z_idler_h()
  ));
  echo(str("z-axis belt x offset (for M671): ", z_axis_belt_x_offset()));
}

z_axis_assembly();
