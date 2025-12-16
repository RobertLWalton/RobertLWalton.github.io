// FUNCTIONS:

function hypotenuse(x,y) = sqrt ( x*x + y*y );

// PARAMETERS:

// All distances are in inches.
//
tread_width = 3*12;
    // Tread width.
stringer_space = 27.5;
    // Distance between stringer centers.
tapered_long = 3;
tapered_short = 1.5;

angle = 30; // Degrees

// Stringers are 2x8's.  Sill is 6x6.

stringer_short_length = 3*12;
stringer_long_length = stringer_short_length
                     + stringer_space * tan ( angle / 2 );
sill_center = ( stringer_short_length
                +
		stringer_long_length )
	    / 2;

// COMPONENTS:

module tread()
{
    color ("SandyBrown")
    translate ( [0,-3.5,7.25] )
    cube ([5.5,tread_width,1.5]);
}
module tapered(angle,displacement)
{
    color ("SandyBrown")
    translate ( [0,-3.5 - displacement,7.25] )
    rotate ( [0,0,- angle] )
    linear_extrude ( 1.5 )
    {
	polygon ( [ [0,0], [0,tread_width,],
		    [tapered_long,tread_width],
		    [tapered_short,0] ] );
    }
}
module stringer( length )
{
    color ("Chocolate")
        cube ([length,1.5,7.25]);
}
module sill()
{
    color ("LightGray")
        cube ([5.5,tread_width,5.5]);
}

// ASSEMBLIES:

module treads()
{
    for (dx = [0:6:18]) {
        translate ([4 + dx,0,0]) tread();
    }
    translate ([28,0,0]) tapered(0,0);
    translate ([30,0,0]) tapered(3,0.2);
    translate ([32,0,0]) tapered(6,0.5);
    translate ([34,0,0]) tapered(10,0.8);
}
module stringers()
{
    stringer ( stringer_short_length );
    translate ( [0, stringer_space, 0] )
        stringer ( stringer_long_length );

    translate ( [stringer_short_length, 0, 0] )
    rotate ( [0, 0, - angle] )
    stringer ( stringer_short_length );

    translate ( [stringer_long_length, stringer_space, 0] )
    rotate ( [0, 0, - angle] )
    stringer ( stringer_long_length );

}
module sills() {
    translate ([sill_center,0.75 + stringer_space / 2,0])
    rotate ( [0, 0, - angle / 2] )
    translate ( [ -5.5 / 2, - tread_width / 2, - 5.5] )
    sill();
}

stringers();
sills();
treads();

