use <catchnhole/catchnhole.scad>;
use <vitamins/v-slot.scad>;
include <parameters.scad>;

plunger_wall_t = 3;

kipp0334_210_d = 10;
kipp0334_210_l = 13.5;
kipp0334_210_flange_l = 2.5;
kipp0334_210_flange_d = 12;
kipp0334_210_relaxed_d = 7.5;

h = frame_v_slot_z_spacing;
// I like the "X" shape, let's keep it. No chamfer though, sorry.
separator = 2;
// Increase the separator width a little to allow for more material around the
// centering bolts and move out of the way of the screw holding the frame.
separator_w = 54;
section = (h - separator) / 2;
straight = 20;
slope = section - straight;

chamfer_depth = 8;

depth = 17;
w = 80;

v_slot_mount_d = v_slot_d + 2 * v_slot_wall_t;

module outer_hinge_back_plate_2d (middle_chamfer = false) {
  chamfer_offset = middle_chamfer ? straight / 2 : 0;
  for (mirrors = [[0, 0, 0], [1, 0, 0]]) {
    mirror(mirrors)
      translate([-w / 2, -h / 2])
        polygon(points = [
          [0, 0],
          [0, straight - chamfer_offset],
          [middle_chamfer ? (w - v_slot_d) / 2 - v_slot_wall_t : (w - separator_w) / 2, section - chamfer_offset],
          [middle_chamfer ? (w - v_slot_d) / 2 - v_slot_wall_t : (w - separator_w) / 2, section + separator + chamfer_offset],
          [0, h - straight + chamfer_offset],
          [0, h],
          [w / 2, h],
          [w / 2, 0],
          [0, 0]
        ]);
  }
}

module outer_hinge () {
  difference () {
    union () {
      rotate([90, 0, 90]) {
        difference () {
          union () {
          linear_extrude (depth - chamfer_depth)
            outer_hinge_back_plate_2d();
          translate([0, 0, depth - chamfer_depth]) {
            linear_extrude (chamfer_depth)
              outer_hinge_back_plate_2d(true);
          }
          }

          // In Foldarap 4, these plungers were located centrally within the
          // extrusion channel, mating with it with considerable slop in the
          // upright position.
          // However, here we move them to the ends of tolerance zones, so that
          // in the 2 stable positions, they mate with the slot in the extrusion
          // on one side only, but with tight tolerances.
          end_of_fit_offset = (v_slot_slot_outer_w - kipp0334_210_relaxed_d) / 2;
          slot_offset = (h - v_slot_d) / 2;
          y_offset = 27.5;

          // Bottom plungers.
          for (spot = [-1, 1]) {
            // We're later rotated, so the plunger Y offset happens in X for us:
            translate([spot * y_offset , -slot_offset - end_of_fit_offset, kipp0334_210_l])
              rotate([180, 0, 0]) plunger_clearance();
          }

          // Top plungers:
          for (spot = [-1, 1]) {
            translate([spot * y_offset, slot_offset + end_of_fit_offset, kipp0334_210_l])
              rotate([180, 0, 0]) plunger_clearance();
          }
        }
      }

      translate([z_x_frame_offset + v_slot_d / 2, 0, -h / 2]) {
        linear_extrude (h) {
          square([v_slot_mount_d, v_slot_mount_d], center = true);
        }
      }
    }

    // Make some space for a metal washer here:
    rotate([0, 90, 0])
      bolt(frame_bolt, length = z_x_frame_offset, kind = "socket_head", head_diameter_clearance = 2, countersink = 1);

    for (spot = [-1, 1]) {
      translate([0, spot * (v_slot_mount_d / 2 + (separator_w - v_slot_mount_d) / 4)])
      rotate([0, 90, 0])
        bolt(frame_bolt, length = depth - chamfer_depth, kind = "socket_head", countersink = 0);
    }

    // The bolt access hole:
    translate([z_x_frame_offset + v_slot_d, 0]) {
      rotate([0, 90, 0])
        cylinder(d = 10, h = v_slot_wall_t);
    }

    translate([z_x_frame_offset + v_slot_d / 2, 0]) {
      translate([0, v_slot_d / 2])
        rotate([0, 90, 90])
          bolt(frame_bolt, length = v_slot_wall_t);

      translate([0, -v_slot_d / 2])
        rotate([0, 90, 270])
          bolt(frame_bolt, length = v_slot_wall_t);
    }


    translate([z_x_frame_offset + v_slot_d / 2, 0, -h / 2])
      v_slot_clearance(z_v_slot_l);
  }
}

module plunger_clearance (fit = 0) {
  cylinder(d = kipp0334_210_d + fit, h = kipp0334_210_l);
  translate([0, 0, kipp0334_210_l - kipp0334_210_flange_l + fit])
    cylinder(d = kipp0334_210_flange_d + fit, h = kipp0334_210_flange_l);

  // Access hole for the plungers, on the off chance you need to push them out.
  translate([0, 0, -depth]) {
    cylinder(d = 3.5, h = depth);
  }
}

outer_hinge();
