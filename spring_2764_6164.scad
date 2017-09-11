include <helix.scad>;
include <units.scad>;

// ***** PARAMETERS *****

// spring measurements and info

$fs = 0.01; // minimum fragment size

conv_units_multiplier = units[3][0]; // inches to mm

wire_diameter = 3/64;
spring_height = 61/64;
spring_diameter = 27/64;

top_twists = 1;
full_twists = 7.5;
bottom_twists = 1;

spring_clockwise = 0;

// tuning
spring_deg_per_step = 6; // use multiple of (full_twists * 360)


// ***** SPRING PARTS *****

color([0.7,1,1]) scale([conv_units_multiplier,conv_units_multiplier,conv_units_multiplier]) // conversion to mm
  union() {
      // top
      translate([0,0,spring_height-(2*wire_diameter)])
        rotate([0,0,180])
          helix(helix_dia=spring_diameter, wire_dia=wire_diameter, turn_elev=wire_diameter, degrees=360, is_clockwise=spring_clockwise, degrees_per_step=spring_deg_per_step);
    
       // middle
      translate([0,0,wire_diameter])
        helix(helix_dia=spring_diameter, wire_dia=wire_diameter, turn_elev=(spring_height-(wire_diameter*3))/full_twists, degrees=360 * full_twists, is_clockwise=spring_clockwise, degrees_per_step=spring_deg_per_step);
    
       // bottom
      translate([0,0,0])
        helix(helix_dia=spring_diameter, wire_dia=wire_diameter, turn_elev=wire_diameter, degrees=360, is_clockwise=spring_clockwise, degrees_per_step=spring_deg_per_step);
  }


% scale([conv_units_multiplier,conv_units_multiplier,conv_units_multiplier]) // millimeter conversion
    translate([0,0,spring_height/2])
      cube([spring_diameter, spring_diameter, spring_height], center=true);