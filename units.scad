
//  units.scad
//  Library File

// This module is used for unit conversion of shapes. By defining a unit
// conversion factor at the beginning of the SCAD file where this is included,
// there can be simple ```scale()``` transformations before each shape in order
// to make the figures the appropriate size.

/**** Instructions

    Initialize scale setup with:
    
      conv_units_multiplier = units[X][Y];
                                                                              
    X is the input unit in the SCAD file, and Y is the output unit in the STL.
    One of these values works for either entry:
    
    0(mm)        1(cm)        2(m)         3(in)        4(ft)

    Set up a shape to be converted to proper units:

      scale([conv_units_multiplier,conv_units_multiplier,conv_units_multiplier])

*/

/**** Example
    
      conv_units_multiplier = units[3][0]; // inches to mm
    
      inch_measurement = 61/64;
      
      scale([conv_units_multiplier,conv_units_multiplier,conv_units_multiplier])
        cube(inch_measurement);
        
    In this example, inches are used as the input unit in the SCAD file, and
    millimeters are used as the output. This is shown on the first line, with
    the input unit inches (3) and the output unit millimeters (0). On the
    following line, a measurement is made in inches.  Then, a cube that has inch
    dimensions is scaled to the proper export size, which is in millimeters.
    
*/


units = [
//                        OUTPUT
//  0(mm)        1(cm)        2(m)         3(in)        4(ft)       
  [ 1,           0.1,         0.001,       0.1/2.54,    0.1/12/2.54 ], // 0(mm)
  [ 10,          1,           0.01,        1/2.54,      1/12/2.54   ], // 1(cm)
  [ 1000,        100,         1,           100/2.54,    100/12/2.54 ], // 2(m)  INPUT
  [ 10*2.54,     2.54,        2.54/100,    1,           1/12        ], // 3(in)
  [ 10*12*2.54,  12*2.54,     12*2.54/100, 12,          1           ]  // 4(ft)
];