use <top-corner.scad>;
use <vitamins/gt2.scad>;
use <vitamins/v-slot.scad>;
use <catchnhole/catchnhole.scad>;
include <parameters.scad>;
include <vitamins/gt2-parameters.scad>;
include <vitamins/mgn12-parameters.scad>;

mgn = false;

h = max(2 * gt2_pitch * gt2_clamp_min_teeth + 2 * belt_wall_t, mgn ? mgn12_carriage_l : 0);

x_hold_w = z_x_frame_offset + frame_bolt_wall_d;

module z_gantry_common () {
  slider_d = v_slot_d + 2 * v_slot_wall_t;
  belt_holder_w = gt2_w + 2 * belt_wall_t + fit;
  // belt_holder_w = slider_d;
  difference () {
    union () {
      linear_extrude (h) {
        difference () {
          translate([-slider_d / 2, -slider_d / 2])
            square([slider_d, slider_d]);

          v_slot_2d_clearance(loose_fit);
        }

        v_slot_2d_slider(loose_fit);
      }

      to_z_belt_y_center () {
        translate([-belt_holder_w / 2, 0])
          cube([belt_holder_w , -z_belt_z_v_slot_y_offset() - slider_d / 2, h]);
      }

    }

    clamp_w = gt2_w + (belt_holder_w - gt2_w) / 2;
    to_z_belt_y_center () {
      translate([0, gt2_16t_pulley_pitch_d / 2]) {
        translate([(belt_holder_w - clamp_w) / 2, 0, h])
          rotate([-15, 0, 0])
            rotate([0, 90, 180])
              gt2_clearance(gt2_clamp_min_teeth, width = clamp_w);

        resize([
          for (dimension = gt2_tensioner_clamp_size(gt2_clamp_min_teeth)) dimension + fit
        ])
          hull()
            gt2_tensioner_clamp(gt2_clamp_min_teeth);

        to_gt2_tensioner_clamp_bolt()
          bolt(bolt, length = h, kind = "socket_head", countersink = 1);
      }
    }
  }

  // The part that holds the X axis:
  difference () {
    v_slot_hold_offset = h - v_slot_d - v_slot_wall_t;

    translate([slider_d / 2, slider_d / 2, 0]) {
      rotate([90, 0, 0]) linear_extrude (slider_d) {
        polygon([
          [0, h],
          [x_hold_w, h],
          [x_hold_w, h - v_slot_wall_t],
          // Only hold on to a little bit from the sides:
          [0, v_slot_hold_offset + v_slot_d * 3 / 4],
        ]);
      }
    }

    translate([v_slot_d / 2 + v_slot_wall_t, 0, v_slot_d / 2 + v_slot_hold_offset]) {
      rotate([0, 90, 0])
        v_slot_clearance(x_v_slot_l, fit = tight_fit);

      translate([0, 0, v_slot_d / 2]) {
        hull () {
          for (spot = [x_hold_w / 2, x_hold_w])
            translate([spot, 0])
              bolt(frame_bolt, length = v_slot_wall_t);
        }
      }
    }

  }
}

z_gantry_common();
