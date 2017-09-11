
//  helix.scad
//  Library File

//  This module generates helices. Given parameters that describe the
//  dimensions and characteristics of a helix, this module will display the
//  helix when ```helix(...)``` is called.

/**** Parameters:

    helix_dia         =  Total diameter of the helix.
    wire_dia          =  Diameter of the wire of the helix.
    turn_elev         =  Height gained per turn of the helix. The distance
                         between the top of the wire on a given turn and the top
                         of the wire on the turn directly above.
    degrees           =  Degrees of turn. 360 degrees equals a single turn. 720
                         degrees is equal to two turns.
    is_clockwise      =  Handedness of the helix. A value of 1 creates a helix
                         that spirals upwards in a clockwise direction. A value
                         of 1 creates a helix that spirals upwards in an
                         anticlockwise direction.
    degrees_per_step  =  Resolution of rendering. A value of 10 will create 36
                         (360 / 10) conntected segments for a single turn. A
                         value of 6 will create 60 (360 / 6) connected segments
                         for a single turn.
                         
*/

/**** Principle of Operation:

    The helix is created through joining of trimmed cylinders in a upward,
    spiraling, curve. The very first trimmed cylinder is created at the bottom
    of what will be the helix. It consists of the ```hull()``` operation used on
    two very thin cylinders. This connects them and creates the trimmed
    cylinder. The next trimmed cylinder is created using the higher thin cylinder
    from the first operation and another cylinder that is rotated upwards.
    Finally, once all of the trimmed cylinders have been created (inside the
    ```for()``` loop), they are joined together with a ```union()```.

    The mathematics behind the helix involve the use of trigonometric functions
    and rotation to create each thin cylinder in the correct position. The x and
    y coordinates are determined by the sine and cosine of the angle, which is
    multiplied by the degrees per step. The y coordinate will become
    continuously negative, instead of continuously positive, if the
    ```clockwise``` value is 0. Next, the thin cylinder is elevated the proper
    amount, given by the turn elevation times the amount of turns that have been
    completed. Finally, the rotation is given by the amount of rotation of the
    helix that has progressed. A value of 0 for ```clockwise``` will flip the
    circle the other direction. The thin cylinder presented here and the thin
    cylinder located at the next number of degrees per step are combined with a
    ```hull()``` operation.
    
*/

/**** Example

      helix(helix_dia=60, wire_dia=4, turn_elev=10, degrees=1440, is_clockwise=0,
          degrees_per_step=10);

    In this example, a spring is created with 4 full turns (1440/360) and an
    anticlockwise rotation. The spring has a diameter of 60 mm and an elevation
    per turn of 10 mm. The resolution of the spring is 10 degrees, which means
    that there are 36 (360/10) segments per turn.
    
*/


module helix(helix_dia, wire_dia, turn_elev, degrees, is_clockwise, degrees_per_step) {
    union() {
        for (i = [0 : (degrees / degrees_per_step) - 1]) {
            hull() {
                translate([
                        ((helix_dia-wire_dia)/2)*sin(i*degrees_per_step),
                        ((helix_dia-wire_dia)/2)*((2*is_clockwise)-1)*cos(i*degrees_per_step),
                        (turn_elev * i*degrees_per_step/360) + (wire_dia/2)])
                          rotate([i*degrees_per_step,((2*is_clockwise)-1) * 90,0])
                            cylinder(r=wire_dia/2, h=0.01);
    
                translate([
                        ((helix_dia-wire_dia)/2)*sin((i+1)*degrees_per_step),
                        ((helix_dia-wire_dia)/2)*((2*is_clockwise)-1)*cos((i+1)*degrees_per_step),
                        (turn_elev * (i+1)*degrees_per_step/360) + (wire_dia/2)])
                          rotate([(i+1)*degrees_per_step,((2*is_clockwise)-1) * 90,0])
                            cylinder(r=wire_dia/2, h=0.01);
            }
        }
    }
}