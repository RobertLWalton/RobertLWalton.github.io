// FUNCTIONS:

function hypotenuse(x,y) = sqrt ( x*x + y*y );

// PARAMETERS:

// All distances are in inches.
//
tread_width = 3*12;
    // Tread width.
stringer_space = 27.5;
    // Distance between stringer centers.
trapezoid_long = 3;
trapezoid_short = 1.5;

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
        cube ([5.5,tread_width,1.5]);
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
    for (dx = [0:6+stretch:section_length]) {
        translate ([dx + 5.5 - bearing,0,0]) tread();
    }
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

