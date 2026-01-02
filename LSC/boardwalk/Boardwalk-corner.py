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
print ( '                                N')
print ( 'A:', end='' )
for N in range (1,26):
    print ( ' {:3d}'.format ( N ), end='' )
print ( '' )
for A in range (5,76,5):
    print ( '{:1.0f}:'.format ( A ), end='' )
    for N in range (1,26):
        radians = math.radians ( A )
        gap_diff = ( ( 2 * math.tan ( radians/2 ) \
                       * stringer_space ) \
                     / N ) \
                 - tapered_diff;
        if gap_diff < 0.0 or gap_diff > 1:
            print ( '   -', end='' )
        else:
            print ( ' {:2.1f}'.format (gap_diff), end='' )
    print ('')



