use <../vitamins/v-slot.scad>;
include <../parameters.scad>;

module x_axis_assembly () {
  rotate([0, 90, 0]) v_slot_mockup(x_v_slot_l);
}
