include <parameters.scad>;
use <catchnhole/catchnhole.scad>;
use <vitamins/v-slot.scad>;
use <top-corner.scad>;

h = gt2_16t_idler_d + loose_fit;

function z_idler_l () = abs(z_belt_z_v_slot_y_offset()) - v_slot_d / 2 - v_slot_wall_t + nut_wall_d;

function z_idler_h () = h;

module z_idler () {
  // This should be movable pretty freely:
  d = v_slot_d + 2 * v_slot_wall_t;

  difference () {
    v_slot_conduit(h, fit = tight_fit);

    translate([0, 0, h / 2]) {
      translate([-v_slot_d / 2, 0])
        rotate([0, 270, 0])
          bolt(frame_bolt, length = v_slot_wall_t);

      translate([v_slot_d / 2, 0])
        rotate([0, 90, 0])
          bolt(frame_bolt, length = v_slot_wall_t);
    }
  }

  idler_d_fit = gt2_16t_idler_d + loose_fit;
  idler_h_fit = gt2_16t_idler_h + loose_fit;
  idler_total_l = z_idler_l();
  idler_mount_w = idler_h_fit + bolt_wall_h + nut_wall_h;

  difference () {
    hull () {
      translate([-idler_mount_w / 2,  -v_slot_d / 2 - v_slot_wall_t - idler_total_l / 2, 0]) {
        cube([idler_mount_w, idler_total_l / 2, h]);
      }
      translate([0, 0, h / 2]) {
        rotate([0, 90, 0])
          to_z_belt_y_center() {
            cylinder(d1 = nut_wall_d, d2 = bolt_wall_d, h = idler_mount_w, center = true);
          }
      }
    }

    translate([0, 0, h / 2]) {
      rotate([0, 90, 0]) {
        to_z_belt_y_center() {
          translate([0, 0, -idler_mount_w / 2]) {
            bolt(bolt, length = idler_mount_w, countersink = 0.5, kind = "socket_head");
            nutcatch_parallel(bolt);
          }

          // Clearance for the idler itself:
          cylinder(d = idler_d_fit, h = idler_h_fit, center = true);
        }
      }

      to_z_belt_y_center() {
        // Clearance for the belt path:
        translate([-(gt2_16t_idler_h + loose_fit) / 2, 0 / 2, 0])
          cube([idler_h_fit, gt2_16t_idler_d / 2 + loose_fit, h / 2]);
      }
    }
  }
}

z_idler();
