$fn = 200;

include <parameters-design-rules.scad>;
include <vitamins/gt2-parameters.scad>;
include <vitamins/nema17-parameters.scad>;
include <vitamins/v-slot-parameters.scad>;

x_carriage_bolt_s = 25;

y_carriage_slider_bolt = "M3";
y_carriage_slider_bolt_d = "M3";

y_carriage_slider_l = 140;
y_carriage_slider_w0 = 68;
y_carriage_slider_w1 = 80;

// Measured in CAD:
v6_hotend_mount_w = 35;
v6_hotend_mount_h = 12;
v6_hotend_mount_l = 11.5;

x_v_slot_l = 200;
y_v_slot_l = 300;
z_v_slot_l = 300;

bed_w = 150;
bed_l = 140;

// Measured on the outer hinge component in CAD, very important to keep consistent,
// otherwise you skew the Z extrusions one way or the other.
frame_z_x_offset = 7;
// Offset between the outside edge of the Y- X extrusion and the
// edge of the Z extrusion.
frame_z_y_offset = 130;

// Distance between the outer edges of the Y extrusions in the Z axis.
frame_y_z_offset = 80;
