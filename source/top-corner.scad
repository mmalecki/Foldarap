use <catchnhole/catchnhole.scad>;
use <v-slot.scad>;
include <parameters.scad>;
// How much of the Z extrusion we want to hold at the top corner. Measured in CAD.
z_hold_h = 20;

// How much of the top extrusion we want to hold at the top corner. Measured in CAD.
top_hold_w = 13;

module side_bolt_pair () {
  translate([0, -v_slot_d / 2, v_slot_d / 2]) rotate([90, 0, 0])
    bolt(frame_bolt, length = v_slot_wall_t);

  translate([0, v_slot_d / 2, v_slot_d / 2]) rotate([-90, 0, 0])
    bolt(frame_bolt, length = v_slot_wall_t);
}

// Top corner.
// Part is centered around the top of the Z extrusion.
module top_corner () {
  w = v_slot_wall_t + v_slot_d + z_x_frame_offset + top_hold_w;
  h = z_hold_h + v_slot_wall_t;
  l = v_slot_d + 2 * v_slot_wall_t;

  difference () {
    translate([-v_slot_wall_t - v_slot_d / 2, -v_slot_wall_t - v_slot_d / 2])
      cube([w, l, h]);

    v_slot_clearance(h = z_hold_h);

    translate([0, 0, z_hold_h])
      bolt(frame_tap_bolt, length = v_slot_wall_t);

    translate([-v_slot_d / 2, 0, v_slot_d / 2]) rotate([0, -90, 0])
      bolt(frame_bolt, length = v_slot_wall_t);

    side_bolt_pair();

    translate([v_slot_d / 2 + z_x_frame_offset, 0]) {
      translate([0, 0, v_slot_d / 2]) rotate([0, 90, 0])
        v_slot_clearance(h = x_v_slot_l);

      translate([top_hold_w / 2, 0]) {
        translate([0, 0, z_hold_h])
          bolt(frame_bolt, length = v_slot_wall_t);

        side_bolt_pair();
      }
    }
  }
}

top_corner();
