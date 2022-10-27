use <vitamins/v-slot.scad>;
use <top-corner.scad>;
use <vitamins/gt2.scad>;
use <z-gantry.scad>;
use <catchnhole/catchnhole.scad>;
include <parameters.scad>;
include <vitamins/gt2-parameters.scad>;
include <vitamins/nema17.scad>;
include <vitamins/nema17-parameters.scad>;

// Source: https://www.bondtech.se/wp-content/uploads/2021/01/LGX-DD-FF-setups-Technical-Drawings.pdf
lgx_top_bolt_s = 23;
lgx_top_side_bolt_center_offset = 8;
lgx_d = 42;

// This still needs to be mirrored. Do that for part preview, but leave the module
// as is for the gantry assembly to be rotated as a whole.
module z_gantry_left () {
  z_gantry_common();
  h = z_gantry_h();
  translate([
    -v_slot_d / 2 - v_slot_wall_t - bolt_wall_d,
    v_slot_d / 2 + v_slot_wall_t - stepper_mount_plate_t,
  ]) {
    translate([0, 0, h - stepper_mount_plate_t]) {
      difference () {
        cube([bolt_wall_d, stepper_mount_plate_t + lgx_d, stepper_mount_plate_t]);
        translate([bolt_wall_d / 2, stepper_mount_plate_t + lgx_d / 2]) {
          for (spot = [-1, 1]) {
            translate([0, spot * lgx_top_bolt_s / 2])
              bolt(bolt, length = stepper_mount_plate_t);
          }
        }
      }

      translate([bolt_wall_d, stepper_mount_plate_t])
        linear_extrude (stepper_mount_plate_t)
        polygon([
          [0, 0],
          [0, lgx_d / 4],
          [lgx_d / 2, 0]
        ]);
    }

    translate([0, 0, h - lgx_d / 2 - stepper_mount_plate_t]) {
      side_mount_h = lgx_d / 2 + stepper_mount_plate_t;
      difference () {
        union () {
          cube([bolt_wall_d, stepper_mount_plate_t, side_mount_h]);
          rotate([90, 0, 90]) {
            linear_extrude (bolt_wall_d)
              polygon([
                [0, 0],
                [-v_slot_d / 2, side_mount_h],
                [0, side_mount_h]
              ]);
          }
        }

        // We're mounting it upside down:
        translate([bolt_wall_d / 2, stepper_mount_plate_t, lgx_top_side_bolt_center_offset])
          rotate([90, 0])
            bolt(bolt, length = stepper_mount_plate_t, kind = "socket_head", head_top_clearance = v_slot_d / 2);
      }
    }
  }
}

mirror([1, 0, 0])
  z_gantry_left();
