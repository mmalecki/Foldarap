use <top-corner.scad>;
use <gt2-tensioner-clamp.scad>
use <vitamins/gt2.scad>;
use <vitamins/v-slot.scad>;
use <catchnhole/catchnhole.scad>;
include <parameters.scad>;
include <vitamins/gt2-parameters.scad>;

clamp_rot = 15;
clamp_teeth = gt2_clamp_min_teeth + 1;
clamp_idle = 1;
clamp_idle_l = clamp_idle * gt2_pitch;

clamp_l = gt2_pitch * clamp_teeth;

tensioner_clamp_teeth = gt2_clamp_min_teeth + 1;

tensioner_size = gt2_tensioner_clamp_size(tensioner_clamp_teeth);
h = (cos(clamp_rot) * clamp_l) +
    (cos(clamp_rot) * clamp_idle_l) +
    tensioner_size[2] +
    belt_wall_t;

x_fit = 0.2;

function z_gantry_h () = h;
function z_gantry_x_fit() = x_fit;

module z_gantry_common () {
  slider_d = v_slot_d + 2 * v_slot_wall_t;
  belt_holder_w = gt2_w + 2 * belt_wall_t + fit;
  belt_holder_l = belt_wall_t + tensioner_size[1] + sin(clamp_rot) * clamp_l;

  difference () {
    union () {
      linear_extrude (h) {
        difference () {
          square([slider_d, slider_d], center = true);
          v_slot_2d_clearance(loose_fit);
        }

        v_slot_2d_slider(loose_fit);
      }

      translate([-belt_holder_w / 2, -belt_holder_l - slider_d / 2])
        cube([belt_holder_w , belt_holder_l, h]);

    }

    clamp_w = gt2_w + (belt_holder_w - gt2_w) / 2;
    to_z_belt_y_center () {
      translate([0, gt2_16t_pulley_pitch_d / 2]) {
        translate([(belt_holder_w - clamp_w) / 2, 0, h]) {
          // These rotations allow us to both fit more belt in the same space,
          // as well as increase the resilience of the teeth, and remove the need
          // for supports (as they are no longer aligned with layers, and don't
          // need to be painted in the air).
          rotate([-clamp_rot, 0, 180])
            translate([-clamp_w / 2, -gt2_pld, -clamp_idle_l - sin(clamp_rot) * gt2_t])
              cube([clamp_w, gt2_t, clamp_idle_l + 2 * sin(clamp_rot) * gt2_t]);

          translate([0, clamp_idle_l * tan(clamp_rot), -clamp_idle_l * cos(clamp_rot)])
            rotate([-clamp_rot, 0, 0])
              rotate([0, 90, 180])
                gt2_clearance(clamp_teeth, width = clamp_w);
        }

        resize([
          for (dimension = tensioner_size) dimension + fit
        ])
          hull()
            gt2_tensioner_clamp(clamp_teeth);

        to_gt2_tensioner_clamp_bolt()
          bolt(bolt, length = h, kind = "socket_head", countersink = 1);
      }
    }
  }

  // The part that holds the X axis:
  difference () {
    v_slot_hold_offset = h - v_slot_d - v_slot_wall_t;
    x_hold_offset = v_slot_d / 2 + z_x_frame_offset - x_fit;

    union () {
      // We could also extrude this in the next part, but it's cleaner that way:
      translate([v_slot_d / 2, -slider_d / 2, v_slot_hold_offset]) {
        cube([z_x_frame_offset, slider_d, v_slot_d + v_slot_wall_t]);
      }

      translate([x_hold_offset, slider_d / 2, 0]) {
        rotate([90, 0, 0]) linear_extrude (slider_d) {
          polygon([
            [0, h],
            [frame_bolt_wall_d, h],
            [frame_bolt_wall_d, h - v_slot_wall_t],
            // Only hold on to a little bit from the sides:
            [0, v_slot_hold_offset + v_slot_d * 3 / 4],
          ]);
        }
      }
    }

    translate([x_hold_offset, 0, v_slot_d / 2 + v_slot_hold_offset]) {
      rotate([0, 90, 0])
        v_slot_clearance(x_v_slot_l, fit = fit);

      // The bolt holding the X axis:
      translate([0, 0, v_slot_d / 2]) {
        hull () {
          for (spot = [frame_bolt_wall_d / 2, frame_bolt_wall_d])
            translate([spot, 0])
              bolt(frame_bolt, length = v_slot_wall_t);
        }
      }
    }

  }
}

z_gantry_common();
