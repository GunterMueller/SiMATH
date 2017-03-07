/*M
.SH NAME
fgetpfel - file get p-adic field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel fgetpfel(p, pf)  
single p; 
FILE *pf; 

.SH DESCRIPTION
.TP 4
.B p
is a single prime.    
.TP 4
.B pf
points on the input file *pf.
.PP
Let A be an element in Qp.
.PP     
fgetpfel reads the approximation of the expansion in a series of A from the file *pf and returns it as an element of type pfel (s.itopfel), or ERROR in case of an error occurs.
.PP
Following rules must be considered:
 1. The end of the element must be marked with '#'.
 2. Only non negative and integral coefficients
    c_i < p (say) are allowed. For c_i = 0, the
    input is not necessary, provided that there is
    a c_j != 0, with j > i.
 3. The exponents are marked by the prefix '^' and
    given in ascending order.
 4. '+' and '^' can be seperated by blank to the
    coefficient and exponents, respectively.

.SH NOTES
If the input in digits is favoured, please use fgetspfel.
  
.SH SEE ALSO
 itopfel
 getpfel
 fgetspfel   

M*/                                    

/*H
	Version 1       11.06.1990      Christine Hollinger
   DATE fgetpfel      : 901120.9301__
H*/

#include <_arith2.h>

pfel fgetpfel( p,pf )
single p;
FILE *pf;
{
	single ci, el, exp, vz, err = 0, sch = 0;
	char c, h, *enr;
	pfel a;
	init( a );

	/*** Ist 0 aus Qp auf Datei? ***/

	if( ( c = fgetcs( pf ) ) == EOF )
	{       err = 1; enr = "PF001"; }
	else if( c == '#' )             /*** Leere Datei ***/
	     {  err = 1; enr = "PF003"; }
	     else if( c == '0' )
		if( ( h = fgetcs( pf ) ) == EOF )
		{       err = 1; enr = "PF001"; }
		else if( h == '#' )     /*** a = 0 ***/
			return( 0 );
		     else               /*** c_vp( A ) = 0 ***/
		     {  err = 1; enr = "PF004"; }
	if( err )
	{       errmsgio( "fgetpfel",enr );
		return( ERROR );
	}
	if( ungetc( c,pf ) == EOF )
	{       errmsgio( "fgetpfel","PF002" );
		return( ERROR );
	}
	/*** Summandenweises Bearbeiten der Reihenentwicklungen ***/
	do
	{       if( ( c = fgetcs( pf ) ) == EOF )
		{       err = 1; enr = "PF001"; break;  }
		if( c == '#' )
		{       err = 1; enr = "PF004"; break;  }
		if( ungetc( c,pf ) == EOF )
		{       err = 1; enr = "PF002"; break;  }

		/*** Koeffizient ***/

		if( isdigit( c ) )
		{       if( ( ci = fgeti( pf ) ) == ERROR )
			{       err = 1; enr = "PF001"; break;  }
			if( issingle( ci ) )
			{       if( ci >= p || ci < 0 )
				{       err = 1; enr = "PF004"; break;  }
			}
			else
			{       err = 1; enr = "PF004"; break;  }
		}
		else
		{       err = 1; enr = "PF004"; break;  }
		if( ( c = fgetcs( pf ) ) == EOF )
		{       err = 1; enr = "PF001"; break;  }
		if( c != '*' )
		{       err = 1; enr = "PF004"; break;  }
		if( ( c = fgetcs( pf ) ) == EOF )
		{       err = 1; enr = "PF001"; break;  }
		if( c == '#' )
		{       err = 1; enr = "PF004"; break;  }
		if( ungetc( c,pf ) == EOF )
		{       err = 1; enr = "PF002"; break;  }

		/*** p ***/

		if( isdigit( c ) )
		{       if( ( el = fgeti( pf ) ) == ERROR )
			{       err = 1; enr = "PF001"; break;  }
			if( issingle( el ) )
			{       if( el != p )
				{       err = 1; enr = "PF004"; break;  }
			}
			else
			{       err = 1; enr = "PF004"; break;  }
		}
		else
		{       err = 1; enr = "PF004"; break;  }
		if( ( c = fgetcs( pf ) ) == EOF )
		{       err = 1; enr = "PF001"; break;  }
		if( c != '^' )
		{       err = 1; enr = "PF004"; break;  }
		if( ( c = fgetcs( pf ) ) == EOF )
		{       err = 1; enr = "PF001"; break;  }
		if( c == '#' )
		{       err = 1; enr = "PF004"; break;  }
		if( c == '-' )  /*** negativer Exponent ***/
		{       if( ( c = fgetcs( pf ) ) == EOF )
			{       err = 1; enr = "PF001"; break;  }
			else    vz = 1;
		}
		else    vz = 0;
		if( ungetc( c,pf ) == EOF )
		{       err = 1; enr = "PF002"; break;  }

		/*** Exponent ***/

		if( isdigit( c ) )
		{       if( ( el = fgeti( pf ) ) == ERROR )
			{       err = 1; enr = "PF001"; break;  }
			if( issingle( el ) )
			{       if( vz )        el = ineg( el );
				if( sch )
				{       if( el > exp )
					{       exp++;
						for( ; exp < el; exp++ )
							a = lsuffix( a,0 );
						a = lsuffix( a,ci );
					}
					else
					{       err = 1; enr = "PF004";
						break;
					}
				}
				else    /*** vp( a ) abspeichern ***/
				{       exp = el;
					sch = 1;
					a = list2( exp,ci );
				}
			}
			else
			{       err = 1; enr = "PF004"; break;  }
		}
		else
		{       err = 1; enr = "PF004"; break;  }
		if( ( c = fgetcs( pf ) ) == EOF )
		{       err = 1; enr = "PF001"; break;  }
		if( c == '#' )  break;
		else if( c != '+' )
		     {  err = 1; enr = "PF004"; break;  }
	}
	while( c != '#' );

	/*** Rueckgabe ***/

	if( err )
	{       errmsgio( "fgetpfel",enr );
		a = ERROR;
	}
	else    /*** Grad d ***/
		a = lcomp( exp,a );
	return( a );
}
