/*C
			calc_isint( k )

	"Calculator is integer?"
	single calc_isint( k );
	obj k;

	calc_isint gibt 1 zurueck, falls k eine integer- Zahl ist,
	0 sonst.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      7.12.1987       C.Hollinger/U.Schneiders
H*/
/*cS
	calc_isint ruft auf:

		     Macros: lsecond
Sc*/

# include <_calc.h>

single calc_isint( k )
obj k;

{
	bind( k );
	if ( k == 0 ) return( 1 );
	if ( lsecond( k ) == 1 ) return( 1 );
	return( 0 );
}
