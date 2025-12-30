// FUNCTIONS:

function hypotenuse(x,y) = sqrt ( x*x + y*y );

// PARAMETERS:

// All distances are in inches.
//
corner_angle = 30;  // Degrees, angle of corner.
corner_long = 36;   // Length of long side covered by
		    // tapered treads.
number_tapered = 10; // Number of tapered treads.

// PARAMETERS USUALLY NOT CHANGED:
//
// Stringers are 2x8's.  Sill is 6x6.
//
tread_width = 3*12;	// Tread width.
stringer_space = 27.5;	// Distance between stringer centers.
tapered_long = 3;	// Length long end of tapered tread.
tapered_short = 1.5;	// Length short end of tapered tread.
stringer_short_length = 3*12;  // Length shorter stringer.

// z axis is vertical; x axis it along boardwalk;
// y axis is across boardwalk.
//
// Origin is center of sills top.  z == 0 is bottom of
// treads.

// COMPONENTS:

module sill()
{
    color ("LightGray")
	    cube ([5.5,tread_width,5.5]);
}
module stringer( length )
{
    color ("Chocolate")
        cube ([length,1.5,7.25]);
}

module tread()
{
    color ("SandyBrown")
    translate ( [0,-3.5,7.25] )
    cube ([5.5,tread_width,1.5]);
}

// Computed so the line joining the halfway points of
// the long and short ends aligns with the y axis and
// has the origin as its center.
//
module tapered_tread()
{
    bisector_angle = atan2 ( (3.0-1.5)/2, tread_width);
    color ("SandyBrown")
    rotate ( [0,0,bisector_angle] )
    translate ( [-(1.5+3.0)/4,-tread_width/2,0] )
    linear_extrude ( 1.5 )
    {
	polygon ( [ [0,0], [0,tread_width,],
		    [tapered_long,tread_width],
		    [tapered_short,0] ] );
    }
}

// ASSEMBLIES:

module sills() {
    translate ([-5.5/2,-tread_width/2,-5.5-7.25])
	sill();
}
module stringers()
{

    stringer_long_length =
          stringer_short_length
	+ stringer_space * tan ( corner_angle / 2 );

    translate([0,-stringer_space/2,0])
	rotate ([0,0,-corner_angle/2])
	    translate ([0.5,-1.5/2,-7.25])
		stringer ( stringer_short_length );

    translate([0,-stringer_space/2,0])
	rotate ([0,0,corner_angle/2])
	    translate ([-stringer_short_length-0.5,-1.5/2,-7.25])
		stringer ( stringer_short_length );

    translate([0,stringer_space/2,0])
	rotate ([0,0,-corner_angle/2])
	    translate ([0.5,-1.5/2,-7.25])
		stringer ( stringer_long_length );

    translate([0,stringer_space/2,0])
	rotate ([0,0,corner_angle/2])
	    translate ([-stringer_long_length-0.5,-1.5/2,-7.25])
		stringer ( stringer_long_length );

}

sills();
// stringers();
tapered_tread();

