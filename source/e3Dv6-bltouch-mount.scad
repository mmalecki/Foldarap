use <e3Dv6-mount.scad>;
use <catchnhole/catchnhole.scad>;
include <parameters.scad>;

// How much clearance the top and the bottom of the hotend mount have from the fan duct.
v6_hotend_mount_top_duct_clearance = 0.648;
v6_hotend_mount_bottom_duct_clearance = 3.938;

bltouch_mount_inset = 4;

// Now, BLTouch spec says 2.3 ~ 4.3 mm away from the nozzle in retracted state,
// and the total retracted height is 40 ~ 40.3 mm, so say 40.15 mm (exactly what
// mine measures!).
bltouch_h = 40.15;
bltouch_bolt_s = 18;
bltouch_bolt = "M3";

bltouch_core_access_hole = 5;

echo(str("Bottom of hot-end to bottom of nozzle: ", e3Dv6_mount_bottom_to_nozzle()));
bltouch_arm_h = e3Dv6_mount_bottom_to_nozzle() - bltouch_h - ((2.3 + 4.3) / 2);
echo(str("BLTouch arm height: ", bltouch_arm_h));

// Need some space from the duct and hotend:
bltouch_mount_offset = 10;

bltouch_arm_w = v6_hotend_mount_bottom_duct_clearance - fit + bltouch_mount_inset;
module e3Dv6_bltouch_mount () {
  e3Dv6_mount();
  translate([v6_hotend_mount_w / 2, v6_hotend_mount_l / 2]) {
    translate([0, 0, v6_hotend_mount_h])
      rotate([90, 0, 0]) linear_extrude(v6_hotend_mount_l) bltouch_arm();

    translate([-bltouch_mount_inset, 0, -bltouch_arm_h]) {
      difference () {
        cube([
          bltouch_arm_w,
          bltouch_mount_offset + bltouch_bolt_s + standoff_d,
          standoff_h
        ]);

        translate([bltouch_arm_w / 2, bltouch_mount_offset]) {
          bolt(bltouch_bolt, length = 10);

          translate([0, bltouch_bolt_s / 2]) 
            cylinder(d = bltouch_core_access_hole, h = standoff_h);

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
    [v6_hotend_mount_bottom_duct_clearance - fit, -v6_hotend_mount_h - bltouch_arm_h],
    [-bltouch_mount_inset, -v6_hotend_mount_h - bltouch_arm_h],
    [-bltouch_mount_inset, -v6_hotend_mount_h],
    [0, -v6_hotend_mount_h]
  ]);
}

e3Dv6_bltouch_mount();
