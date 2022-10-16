use <catchnhole/catchnhole.scad>;
use <x-carriage.scad>;
include <parameters.scad>;

//
// This intends to be a 1:1 OpenSCAD representation of  e3D-lite6 component, except a tighter fit around the groove.

v6_hotend_mount_x_carriage_bolt_l = 30;

v6_groove_h = 6;
v6_groove_d = 12;

v6_ridge_d = 16;
v6_ridge_h = 3; // This goes up to 3.7, but we're only holding onto this much.

module v6_groove () {
  cylinder(d = v6_ridge_d, h = v6_ridge_h);
  translate([0, 0, v6_ridge_h])
    cylinder(d = v6_groove_d, h = v6_groove_h - tight_fit);
  translate([0, 0, v6_ridge_h + v6_groove_h - tight_fit])
    cylinder(d = v6_ridge_d, h = v6_ridge_h + tight_fit);
}

module e3Dv6_mount () {
  difference () {
    translate([-v6_hotend_mount_w / 2, -v6_hotend_mount_l / 2])
      cube([v6_hotend_mount_w, v6_hotend_mount_l, v6_hotend_mount_h]);
    translate([0, -v6_groove_d / 2]) v6_groove();

    translate([0, v6_hotend_mount_l / 2 - v6_hotend_mount_x_carriage_bolt_l, v6_hotend_mount_h / 2])
      rotate([90, 0, 180]) x_carriage_bolts(v6_hotend_mount_x_carriage_bolt_l, kind = "countersunk");
  }
}

// The dimensions come from these drawings:
// * https://e3d-online.zendesk.com/hc/en-us/article_attachments/360016173737/V6-175-ASSM.pdf
// * https://e3d-online.zendesk.com/hc/en-us/article_attachments/360016173777/V6-175-SINK.pdf
function e3Dv6_mount_bottom_to_nozzle () =
  // Total heatsink height minus the groove and ridges gives us the length of
  // the heatsink below us:
  42.7 - (3.7 + 3 + v6_groove_h) +
  // Which we then sum with the dimensions below the heatsink on the assembled drawing:
  15.5 + 4;


e3Dv6_mount();
