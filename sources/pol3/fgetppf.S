/*M
.SH NAME
fgetppf - file get polynomial over p-adic field

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol fgetppf(r, p, VL, pf)  
single r, p; 
list VL; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B VL
is the list of variables names of lenght >= r (s. pmakevl). 
.TP 4
.B pf
points to an output file.
.PP  
fgetppf reads a polynomial in r variables over Qp from the file *pf.
.TP 4
Following rules must be considered:
 1. The end of the polynomial must be marked with '#'.
 2. Only positive exponents are allowed. They must be
    marked by the prefix '^' or '**'. The input of the
    powers 1 or 0 is not necessary, but in the second
    case, the input of the according variable had to
    remain undone too.
 3. Coefficients of any size are allowed. The
    coefficient and its sign can be seperated by
    blanks, the coefficient and the according
    variables can be seperated by any blanks and/or
    '*'. These seperations are not necessary. The
    input of the coefficient 1 is not necessary.
 4. Variable names must be mentioned in VL, they are
    not allowed to be seperated by special
    characters.
    Single variables and its exponents can be 
    seperated to other variables by any blanks and/or
    '*'. This seperation is only necessary if no
    exponent was specified.
 5. Appears a variable in a single monomial more than
    once, the several occurances will be merged.
    Appears a monomial more than once, the several
    occurances will be merged.
.PP
fgetppf returns the polynomial by success, ERROR else.

M*/
                                      
/*H
	Version 1       19.09.1990      Christine Hollinger
	Version 2       05.06.1991      r und p vertauscht.  CH
   DATE fgetppf       : 910915.9301__
H*/

#include <_pol3.h>

pol fgetppf( r, p, V, pf )
single p,r;
list V;
FILE *pf;
{
	single err = 0, i, kg, kPsign, namax, vil, sch = 0;
	char c,*fn;
	int kPevi;
	pfel kP;
	list kPev,vi;
	pol P = 0;
	bind( V,P );
	init( kP, kPevi, kPev, vi);

	namax = isvarl( r,V );          /*** max. Variablenlaenge ***/

	/*** r = 0 ***/

	if( !r )
	{       c = ' ';
		while( c != '#' )
		{       if( (c = fgetcs( pf )) == EOF )
			{       err = 1; break; }
			if( c != '(' )
			{       err = 2; fn = "P213"; break; }
			if( (kP = fgetpfel( p,pf )) <= ERROR )
			{       err = 1; break; }
			P = pfsum( p, kP, P );
			if( (c = fgetcs( pf )) == EOF )
			{       err = 1; break; }
			if( c != ')' )
			{       err = 2; fn = "P213"; break; }
			if( (c = fgetcs( pf )) == EOF )
			{       err = 1; break; }
			if( ungetc( c,pf ) == EOF )
			{       err = 1; break; }
			if( c != '#' && c != '-' && c != '+' )
			{       err = 2; fn = "P213"; break; }
		}
		if( err )
		{       while( (c = fgetcs( pf )) != EOF && c != '#' );
			if( err == 1 )   fn = "P211";
		}
	}
 
	/*** r > 0 ***/

	else
	{       do      /*** Lese Monom ! ***/
		{       if( (c = fgetcs( pf )) == EOF )
			{       err = 1; fn = "P211"; break; }
			if( c == '#' )
			{       err = 1; fn = "P212"; break; }
			if( sch && index( "+-",c ) == NULL )
			{       err = 1; fn = "P213"; break; }
			sch = 1;

			/*** Bestimmung des Vorzeichens ***/

			switch( c )
			{       case '-': kPsign = ineg( 1 );
					  break;
				case '+': kPsign = 1;
					  break;
				default : kPsign = 1;
					  c = ungetc( c,pf );
					  break;
			}
			if( c == EOF )
			{       err = 1; fn = "P211"; break; }
			kg = 0;
			if( (c = fgetcs( pf )) == EOF )
			{       err = 1; fn = "P211"; break; }

			/*** Einlesen des Koeffizienten ***/

			if( c != '(' )
			{       err = 1; fn = "P213"; break; }
			if( (c = fgetcs( pf )) == EOF )
			{       err = 1; fn = "P211"; break; }
			if( ungetc( c,pf ) == EOF )
			{       err = 1; fn = "P211"; break; }
			if( isdigit( c ) )
			{       if( (kP = fgetpfel( p,pf )) == ERROR )
				{       err = 1; fn = "P211"; break; }
				if( (c = fgetcs( pf )) == EOF )
				{       err = 1; fn = "P211"; break; }
				if( c != ')' )
				{       err = 1; fn = "P213"; break; }
				kg = 1;
			}
			else    kP = list3( 0,0,1 );
			if( kPsign == ineg( 1 ) )
				kP = pfneg( p,kP );
			if( (c = fgetcs( pf )) == EOF )
			{       err = 1; fn = "P211"; break; }
			if( !kg && !isalpha( c ) )
			{       err = 1; fn = "P213"; break; }
			else if( c == '*' )
			{       if( (c = fgetcs( pf )) == EOF )
				{       err = 1; fn = "P211"; break; }
			}
			if( ungetc( c,pf ) == EOF )
			{       err = 1; fn = "P211"; break; }

			/*** Vorbesetzung des Exponentenvektors ***/

			kPev = _0;
			for( i = r; i; i-- )    kPev = lcomp( 0,kPev );

			/*** Einlesen der Variablen ***/

			while( isalpha( c ) )
			{       vil = 0;
				vi = _0;
				if( (c = fgetcs( pf )) == EOF )
				{       err = 1; fn = "P211"; break; }
				while( index( "+-^*#",c ) == NULL &&
				       !isspace( c ) && vil <= namax )
				{       if( !isalnum( c ) )
					{       err = 1; fn = "P213"; break; }
					vi = lcomp( c,vi );
					vil++;
					if( (c = fgetc( pf )) == EOF )
					{       err = 1; fn = "P211"; break; }
				}
				if( err )       break;
				if( vil == isum( namax,1 ) )
				{       err = 1; fn = "P214"; break; }
				else    vi = linv( vi );
				if( !( i = lsrch( vi,V ) ) )
				{       err = 1; fn = "P214"; break; }
				if( ungetc( c,pf ) == EOF )
				{       err = 1; fn = "P211"; break; }
				if( (c = fgetcs( pf )) == EOF )
				{       err = 1; fn = "P211"; break; }

				/*** Bestimmung des Exponenten ***/

				if( c == '*' )
				{       if( (c = fgetc( pf )) == EOF )
					{       err = 1; fn = "P211"; break; }
					if( c != '*' )
					{       kPevi = isum(1,lelt(kPev,i));
						if( kPevi >= BASIS )
						{       err = 1; fn = "P215";
							break; }
						leset( kPev, i, kPevi );
						if( ungetc( c,pf ) == EOF )
						{       err = 1; fn = "P211";
							break; }
						if( (c = fgetcs( pf )) == EOF )
						{       err = 1; fn = "P211";
							break;
						}
						if( ungetc( c,pf ) == EOF )
						{       err = 1; fn = "P211";
							break;
						}
						if( !isalpha( c ) )
						{       err = 1; fn = "P213";
							break;
						}
						continue;
					}
				}
				if( c == '^' || c == '*' )
				{       if( (kPevi = fgeti( pf )) == ERROR )
					{       err = 1; fn = "P211"; break; }
					if( kPevi )
					{       if( isign( kPevi ) < 0 )
						{       err = 1; fn = "P216";
							break; }
						kPevi = isum( kPevi,lelt( kPev,i ) );
						if( kPevi >= BASIS )
						{       err = 1; fn = "P215"; break; }
						leset( kPev, i, kPevi );
					}
				}
				else
				{       kPevi = isum( 1,lelt( kPev,i ) );
					if( kPevi >= BASIS )
					{       err = 1; fn = "P215"; break; }
					leset( kPev, i, kPevi );
					if( ungetc( c,pf ) == EOF )
					{       err = 1; fn = "P211"; break; }
				}
				if( (c = fgetcs( pf )) == EOF )
				{       err = 1; fn = "P211"; break; }
				if( c == '*' )
				{       if( (c = fgetcs( pf )) == EOF )
					{       err = 1; fn = "P211"; break; }
				}
				if( ungetc( c,pf ) == EOF )
				{       err = 1; fn = "P211"; break; }
			}
			if( err )       break;
			if( kP )
			{       /*** Red. des Exponentenvektors ***/

				while( kPev != _0 )
				{       kPevi = lfirst( kPev );
					kPev = lred( kPev );
					kP = list2( kPevi,kP );
				}
				/*** Einfuegen des Monoms in P ***/

				P = ppfsum( p, r, P, kP );
			}
		}
		while( c != '#' );
		while( c != EOF && c != '#' )
		{       if( (c = fgetc( pf )) == EOF )
			{       err = 1; fn = "P211"; break; }
		}
	}
	if( err )
	{       P = ERROR;
		errmsgio( "fgetppf",fn );
	}
	else    fgetc( pf );
	return( P );
}
