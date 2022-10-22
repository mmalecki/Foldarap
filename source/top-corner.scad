use <catchnhole/catchnhole.scad>;
use <v-slot.scad>;
use <nema17.scad>;
include <parameters.scad>;
// How much of the Z extrusion we want to hold at the top corner. Measured in CAD.
z_hold_h = 20;

// How much of the top extrusion we want to hold at the top corner. Measured in CAD.
top_hold_w = 13;

// We want to move the stepper close to the extrusion (forward in Y axis)
// to save space. Calculate how close.
z_stepper_y_inset = (nema17_d - nema17_shaft_plate_fit_d) / 2;
z_stepper_bolt_l = stepper_bolt_l + stepper_mount_plate_t;

module side_bolt_pair () {
  translate([0, -v_slot_d / 2, v_slot_d / 2]) rotate([90, 0, 0])
    bolt(frame_bolt, length = v_slot_wall_t);

  translate([0, v_slot_d / 2, v_slot_d / 2]) rotate([-90, 0, 0])
    bolt(frame_bolt, length = v_slot_wall_t);
}

// Top corner, `mirror([0, 1, 0])` to get the other one.
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

  translate([-v_slot_d / 2, 0, h - nema17_d / 2]) {
    to_z_belt_y_center() {
      rotate([-90, 0, 90]) {
        difference () {
          nema17_mount_plate();

          translate([0, 0, stepper_bolt_l + stepper_mount_plate_t]) {
            translate([-nema17_bolt_s / 2, -nema17_bolt_s / 2]) {
              rotate([180, 0, 0])
                bolt(bolt, length = z_stepper_bolt_l);
            }
            translate([-nema17_bolt_s / 2, nema17_bolt_s / 2]) {
              rotate([180, 0, 0])
                bolt(bolt, length = z_stepper_bolt_l);
            }

            translate([nema17_bolt_s / 2, nema17_bolt_s / 2]) {
              // This bolt needs to be countersunk to clear the Z extrusion.
              rotate([180, 0, 0])
                bolt(bolt, length = z_stepper_bolt_l, kind = "countersunk");
            }
          }
        }
      }
    }
  }
}

// Translates from the center of the Z extrusion to Y of the center of the belt path.
module to_z_belt_y_center () {
  translate([0, -v_slot_d / 2 - v_slot_wall_t - nema17_d / 2 + z_stepper_y_inset]) children();
}

top_corner();
