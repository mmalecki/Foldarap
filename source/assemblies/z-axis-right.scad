use <../z-gantry-right.scad>;
use <z-axis.scad>;
include <../parameters.scad>;

// Where the gantry is.
z = 0;

module z_axis_right_assembly (z) {
  z_axis_assembly(z)
    z_gantry_right();
}
z_axis_right_assembly(z);
