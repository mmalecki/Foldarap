// Whether to show the exploded view or not.
explode = true;

// How much to explode the view.
e = 10;

include <parameters.scad>;
use <top-corner.scad>;
use <z-gantry-left.scad>;
use <v-slot.scad>;

translate([-x_v_slot_l / 2 - z_x_frame_offset, 0]) {
  color("silver") v_slot(z_v_slot_l);

  translate([0, 0, z_v_slot_l / 2])
    z_gantry_left();
  translate([0, 0, z_v_slot_l])
    top_corner();

}
