import math

stringer_space = 27.5
tread_long = 3.0
tread_short = 1.5
cantilever = 3.5
tread_width = 36.0
tapered_diff = \
             + ( ( ( tread_width - 2 * cantilever ) \
                   / tread_width ) \
               * ( tread_long - tread_short ) )

print ( 'Gap Differences:' )
print ( '   ', end='' )
for N in range (2,11):
    print ( ' {:4d}'.format ( N ), end='' )
print ( '' )
for I in range (38,51):
    A = 0.1*I
    print ( '{:2.1f}:'.format ( A ), end='' )
    for N in range (2,11):
        corner_angle = N*A
        radians = math.radians ( corner_angle )
        gap_diff = ( ( 2 * math.tan ( radians/2 ) \
                       * stringer_space ) \
                     / N ) \
                 - tapered_diff;
        print ( ' {:2.2f}'.format (gap_diff), end='' )
    print ('')



