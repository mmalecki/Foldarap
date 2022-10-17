use <e3Dv6-mount.scad>;
use <catchnhole/catchnhole.scad>;
include <parameters.scad>;

// How much clearance the top and the bottom of the hotend mount have from the fan duct
// (these are measured in the CAD):
v6_hotend_mount_top_duct_clearance = 0.648;
v6_hotend_mount_bottom_duct_clearance = 3.938;

bltouch_mount_inset = 5;

// Now, BLTouch spec says 2.3 ~ 4.3 mm away from the nozzle in retracted state,
// and the total retracted height is 40 ~ 40.3 mm, so say 40.15 mm (exactly what
// mine measures!).
bltouch_h = 40.15;
bltouch_bolt_s = 18;
bltouch_bolt = "M3";

bltouch_core_access_hole = 4;

echo(str("Bottom of hot-end to bottom of nozzle: ", e3Dv6_mount_bottom_to_nozzle()));
bltouch_arm_h = e3Dv6_mount_bottom_to_nozzle() - bltouch_h - ((2.3 + 4.3) / 2);
echo(str("BLTouch arm height: ", bltouch_arm_h));

// Need some space from the duct and hotend:
bltouch_mount_offset = 6;

// How much clearance we have from the duct at `bltouch_arm_h` (measured in situ):
bltouch_arm_bottom_duct_clearance = 0.75;
bltouch_arm_w = v6_hotend_mount_bottom_duct_clearance + bltouch_arm_bottom_duct_clearance - fit + bltouch_mount_inset;
bltouch_mount_h = 3.4;

// We're inverted in X in comparison to printer coordinates.
bltouch_x_offset = -v6_hotend_mount_w / 2 + bltouch_mount_inset - bltouch_arm_w / 2;
bltouch_y_offset = v6_hotend_mount_l / 2 + bltouch_mount_offset + bltouch_bolt_s / 2;
echo(str("BLTouch XY offset: ", [bltouch_x_offset, bltouch_y_offset]));

translate([-bltouch_x_offset, bltouch_y_offset, 0]) color("red") cylinder(d = 3, h = 10);

module e3Dv6_bltouch_mount () {
  e3Dv6_mount();
  translate([v6_hotend_mount_w / 2, v6_hotend_mount_l / 2]) {
    // Idea: hull() the bltouch_arm() and the bltouch_mount_offset part of the
    // cube for a nice, sturdy organic look that however gets in the way of the
    // mounting bolts.
    translate([0, 0, v6_hotend_mount_h])
      rotate([90, 0, 0]) linear_extrude(v6_hotend_mount_l) bltouch_arm();

    translate([-bltouch_mount_inset, 0, -bltouch_arm_h]) {
      difference () {
        cube([
          bltouch_arm_w,
          bltouch_mount_offset + bltouch_bolt_s + standoff_d,
          bltouch_mount_h
        ]);

        translate([bltouch_arm_w / 2, bltouch_mount_offset]) {
          bolt(bltouch_bolt, length = 10);

          translate([0, bltouch_bolt_s / 2]) 
            cylinder(d = bltouch_core_access_hole, h = bltouch_mount_h);

          translate([0, bltouch_bolt_s]) 
            bolt(bltouch_bolt, length = 10);
        }

      }
    }
  }

}

module bltouch_arm () {
  polygon([
    [0, 0],
    [v6_hotend_mount_top_duct_clearance - fit, 0],
    [v6_hotend_mount_bottom_duct_clearance - fit, -v6_hotend_mount_h],
    [v6_hotend_mount_bottom_duct_clearance - fit, -v6_hotend_mount_h],
    [v6_hotend_mount_bottom_duct_clearance + bltouch_arm_bottom_duct_clearance - fit, -v6_hotend_mount_h - bltouch_arm_h + bltouch_mount_h],
    [v6_hotend_mount_bottom_duct_clearance + bltouch_arm_bottom_duct_clearance - fit, -v6_hotend_mount_h - bltouch_arm_h],
    [-bltouch_mount_inset, -v6_hotend_mount_h - bltouch_arm_h],
    [-bltouch_mount_inset, -v6_hotend_mount_h],
    [0, -v6_hotend_mount_h]
  ]);
}

e3Dv6_bltouch_mount();
