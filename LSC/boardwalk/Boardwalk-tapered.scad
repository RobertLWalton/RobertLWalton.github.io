// PARAMETERS:

// PARAMETERS USUALLY NOT CHANGED:
//
// Stringers are 2x8's.  Sill is 6x6.
//
tread_length = 3*12;	// Tread length.
normal_gap = 0.5; 	// Gap between normal treads.
normal_width = 5.5;	// Normal tread width;

// Tread short and long lengths can be negated to
// flip tread across y axis.
//
module treads ( short_length = 1.5,
                long_length = 4.0 )
{
    color ("SandyBrown")
    polygon ( [ [0,0],
		[0,tread_length,],
		[long_length,tread_length],
		[short_length,0] ] );
    color ("SandyBrown")
    polygon ( [ [short_length + normal_gap,0],
		[long_length + normal_gap,tread_length,],
		[normal_width+normal_gap,tread_length],
		[normal_width+normal_gap,0] ] );
}

treads();
translate ( [10,0,0] )
treads(1.5,5.5);
