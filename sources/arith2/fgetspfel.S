/*M
.SH NAME
fgetspfel - file get special p-adic field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel fgetspfel(p, pf)  
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
Let A be an element in Qp, and let a be the approximation of the expansion in a series of A.
.PP 
fgetspfel read the digits of a from the file *pf and returns a as an element of type pfel (s.itopfel), or ERROR in case of an error occurs. 
.PP
Following rules must be considered:
 1. The end of the element must be marked with '#'.
 2. Only non negative and integral coefficients
    c_i < p (say) are allowed. For c_i = 0, the
    input is not necessary, provided that there is
    a c_j != 0, with j > i.
 3. The coefficients are seperated to each other by
    '_'.
 4. The coefficients must be given in ascending
    order (with regard to the appendant exponents).
    The change from the coefficients of negative
    exponents to non negative exponents had to be
    marked with '.' instead of '_'.

.SH NOTES   
If the input as a expansion in a series is favoured , please use fgetnfel.

.SH SEE ALSO
 itopfel
 fgetpfel
 getspfel

M*/                  
     
/*H
	Version 1       26.06.1990      Christine Hollinger
   DATE fgetspfel     : 901120.9301__
H*/

#include <_arith2.h>

pfel fgetspfel( p,pf )
single p;
FILE *pf;
{
	single ci, v = 0, err = 0;
	char c, h, *enr;
	pfel a = _0;
	bind( a );

	if( ( c = fgetcs( pf ) ) == EOF )
	{       err = 1; enr = "PF001"; }
	else if( c == '#' )             /*** Leere Datei ***/
	     {  err = 1; enr = "PF003"; }
	if( err )
	{       errmsgio( "fgetspfel",enr );
		return( ERROR );
	}
	/*** Aufbau von pfel-Struktur ***/

	if( c == '.' )  /*** nichtnegative Bewertung ***/
	{       do
		{       if( ( c = fgetcs( pf ) ) == EOF )
			{       err = 1; enr = "PF001"; break;  }
			if( c == '#' )  break;
			if( ungetc( c,pf ) == EOF )
			{       err = 1; enr = "PF002"; break;  }

			/*** Ziffer ***/

			if( isdigit( c ) )
			{       if( ( ci = fgeti( pf ) ) == ERROR )
				{       err = 1; enr = "PF001"; break;  }
				if( issingle( ci ) )
				{       if( ci >= p || ci < 0 )
					{       err = 1; enr = "PF004";
						break;
					}
					else
					{       if( ci || a != _0 )
							a = lsuffix( a,ci );
						else    v++;
					}
				}
				else
				{       err = 1; enr = "PF004"; break;  }
			}
			else
			{       err = 1; enr = "PF004"; break;  }
			if( ( c = fgetcs( pf ) ) == EOF )
			{       err = 1; enr = "PF001"; break;  }

			/*** Abtrennungszeichen "_" ***/

			if( c != '_' && c != '#' )
			{       err = 1; enr = "PF004"; break;  }
		}
		while( c != '#' );
		if( a == _0 )
		{       if( v == 1 )    return( 0 );
			else
			{       err = 1; enr = "PF004"; }
		}
	}
	else    /*** negative Bewertung ***/
	{       single sch = 1;

		if( ungetc( c,pf ) == EOF )
		{       errmsgio( "fgetspfel","PF002" );
			return( ERROR );
		}
		do
		{       if( ( c = fgetcs( pf ) ) == EOF )
			{       err = 1; enr = "PF001"; break;  }
			if( c == '#' )  break;
			if( ungetc( c,pf ) == EOF )
			{       err = 1; enr = "PF002"; break;  }

			/*** Ziffer ***/

			if( isdigit( c ) )
			{       if( ( ci = fgeti( pf ) ) == ERROR )
				{       err = 1; enr = "PF001"; break;  }
				if( issingle( ci ) )
				{       if( ci >= p || ci < 0 )
					{       err = 1; enr = "PF004";
						break;
					}
					else
					{       if( a == _0 && ci == 0 )
						{       err = 1; enr = "PF004";
							break;
						}
						else
						{       a = lsuffix( a,ci );
							if( sch )       v--;
						}
					}
				}
				else
				{       err = 1; enr = "PF004"; break;  }
			}
			else
			{       err = 1; enr = "PF004"; break;  }
			if( ( c = fgetcs( pf ) ) == EOF )
			{       err = 1; enr = "PF001"; break;  }

			/*** Abtrennungszeichen "_" ***/

			if( c == '.' )
			{       if( sch )       sch = 0;
				else
				{       err = 1; enr = "PF004"; break;  }
			}
			else if( c != '_' && c != '#' )
			     {  err = 1; enr = "PF004"; break;  }
		}
		while( c != '#' );
		if( sch || a == _0 )    /*** u.a. Punkt gesetzt? ***/
		{       err = 1; enr = "PF004"; }
	}

	/*** Rueckgabe ***/

	if( err )
	{       errmsgio( "fgetspfel",enr );
		a = ERROR;
	}
	else    /*** Grad d und Bewertung v ***/
	{       err = llength( a );
		err--;
		err += v;
		a = lcomp2( err, v, a );
	}
	return( a );
}
