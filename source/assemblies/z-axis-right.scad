include <../parameters.scad>;
use <../z-gantry-right.scad>;
use <z-axis.scad>;

// How much to explode the view.
e = 0;
// Where the gantry is.
z = 0;

module z_axis_right_assembly(e = 0, z = 0) {
  z_axis_assembly(e, z) z_gantry_right();
}
z_axis_right_assembly(e, z);
