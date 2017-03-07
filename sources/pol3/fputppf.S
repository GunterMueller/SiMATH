/*M
.SH NAME
fputppf - file put polynomial over p-adic field

.SH SYNOPSIS
.nf
#include<_pol3.h>

single fputppf(r, p, P, V, pf)  
single p, r; 
pol P;
list V; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp (s. itopfel).
.TP 4
.B V
is a list, containing the variables names used by P (s. pmakevl).
.TP 4
.B pf
points to an input file.    
.PP
fputppf writes P to the file *pf, the end of P will be marked with '#'.
fputppf returns 0 by success and ERROR else.

.SH SEE ALSO
.nf
itopfel
pmakevl
                            
M*/
           
/*H
	Version 1       29.10.1990      Christine Hollinger
	Version 2       05.06.1991      r und p vertauscht.  CH
   DATE fputppf       : 910915.9301__
H*/

#include<_pol3.h>

single fputppf( r, p, P, V, pf )
single r,p;
pol P;
list V;
FILE *pf;
{
	single sch = 1;         /*** steht fuer 1.Argument ***/
	single eP, err = 0, hi, i, j, namax, zv = 0;
	char *e, *fn, h[ 12 ], *k, vz;
	char *malloc();
	pfel kP;
	list ePV, ePVS, Vi;
	pol PS;
	init( kP, ePV, ePVS, Vi, PS );
	bind( P,V );

	/*** P gleich 0 ***/

	if( !P )
	{       if( fputs( "( 0# )#",pf ) == EOF )
		{       err = ERROR; fn = "P201"; }
	}

	/*** r = 0 ***/

	else if( !r )
	{       /*** Platz fuer k reservieren ***/

		PS = lred2( P );
		i = 0;
		while( PS != _0 )
		{       j = lfirst( PS );
			PS = lred( PS );
			j = ilog2( j )/3;
			j += 9;
			i += j;
		}
		j = lsecond( P );
		j = ilog2( j ) / 3;
		j = j + ( ilog2( p )/3 );
		j += 9;
		i = i * j;
		if( ( k = malloc( i ) ) == NULL )
		{       i = ineg( 1 ); err = ERROR; }
		if( !err && sputpf( p, P, k ) == EOF )  err = ERROR;
		if( !err && getocnt( pf ) &&
		    ( getocnt( pf ) + strlen( k ) + 6 ) > LN_SIZE )
		{       if( fputc( '\n',pf ) == EOF )   err = ERROR; }
		if( !err && fputs( "( ",pf ) == EOF )   err = ERROR;
		if( !err && fputs( k,pf ) == EOF )      err = ERROR;
		if( !err && fputs( "# )#",pf ) == EOF ) err = ERROR;
		if( i != ineg( 1 ) )    free( k );
		if( err )       fn = "P201";
	}

	/*** allgemeiner Fall: A,r ungleich 0 ***/

	else
	{       namax = isvarl( r,V );
		P = ptosdp( r,P );

		/*** Platz fuer e, k reservieren ***/

		PS = P;
		i = 3;
		while( PS != _0 )
		{       kP = lfirst( PS );
			PS = lred2( PS );
			ePV = lsecond( kP );
			kP = lred2( kP );
			j = 0;
			while( kP != _0 )       /*** Platz fuer Koeff. ***/
			{       hi = lfirst( kP );
				kP = lred( kP );
				hi = ilog2( hi ) / 3;
				hi += 9;
				j += hi;
			}
			ePV = ilog2( ePV )/3;
			ePV = ePV + ( ilog2( p )/3 );
			ePV += 9;
			j = j * ePV;
			i = smax( i,j );
		}
		i += 9;
		if( ( k = malloc( i ) ) == NULL )
		{       j = 1; err = ERROR; fn = "P220";        }

		/*** Platz fuer Variable mit Exponent ***/

		if( !err )
		{       j = 12 + namax;
			j = r * j;
			j += 3;
			if( ( e = malloc( j ) ) == NULL )
			{       j = 2; err = ERROR; fn = "P220"; }
		}
		while( !err && P != _0 )
		{       kP = lfirst( P );
			ePV = lsecond( P );
			P = lred2( P );
			if( sputpf( p, kP, k ) == EOF )
			{       err = ERROR; fn = "P221"; break;        }

			/*** Bearbeiten des Exponentenvektors ***/

			ePV = lcinv( ePV );
			ePVS = ePV;
			*e = '\0';
			while( ePVS != _0 )
			{       if( ePVS != ePV )       strcat( e," " );
				eP = lfirst( ePVS );
				i = lsecond( ePVS );
				ePVS = lred2( ePVS );

				/*** Variable Vi ***/

				Vi = lelt( V,i );
				i = strlen( e );
				while( Vi != _0 )
				{       *( e + i++ ) = ( char )lfirst( Vi );
					Vi = lred( Vi );
				}
				*( e + i ) = '\0';
				if( eP > 1 )
				{       strcat( e,"^" );
					if( sputi( eP,h ) == EOF )
					{       err = ERROR; fn = "P221";
						break;
					}
					strcat( e,h );
				}
			}
			if( err )       break;
			i = strlen( e ) + strlen( k );
			if( i > LN_SIZE )       zv = 1;
			if( (i+getocnt(pf)+8) > LN_SIZE && getocnt(pf) )
			{       if( !( getocnt(pf) == 80 && LN_SIZE == 80
				      && isatty(fileno(pf)) ) )
				{       if( fputc('\n',pf ) == EOF )
					{       err = ERROR; fn = "P201";
						break;
					}
				}
			}
			if( !sch )
			{       if( fputs( " + ",pf ) == EOF )
				{       err = ERROR; fn = "P201"; break; }
			}
			sch = 0;        /*** d.h. nicht mehr 1.Arg. ***/

			/*** Koeffizient ausgeben ***/

			if( fputs( "( ",pf ) == EOF )
			{       err = ERROR; fn = "P201"; break;        }
			if( fputs( k,pf ) == EOF )
			{       err = ERROR; fn = "P201"; break; }
			if( fputs( "# )",pf ) == EOF )
			{       err = ERROR; fn = "P201"; break;        }
			ePVS = ePV;
			while( ePVS != _0 )
			{       *e = '\0';
				if( ePVS != ePV )       strcat( e," " );
				eP = lfirst( ePVS );
				i = lsecond( ePVS );
				ePVS = lred2( ePVS );

				/*** Variable Vi ***/

				Vi = lelt( V,i );
				i = strlen( e );
				while( Vi != _0 )
				{       *( e + i++ ) = (char)lfirst( Vi );
					Vi = lred( Vi );
				}
				*( e + i ) = '\0';
				if( eP > 1 )
				{       strcat( e,"^" );
					if( sputi( eP,h ) == EOF )
					{       err = ERROR; fn = "P221";
						break;
					}
					strcat( e,h );
				}
				if( ( strlen( e ) + getocnt( pf ) ) > LN_SIZE
				    && getocnt( pf ) )
				{       if( !( getocnt(pf) == 80 && LN_SIZE == 80
					    && isatty(fileno(pf)) ) )
					{       if( fputc('\n',pf ) == EOF )
						{       err = ERROR;
							fn = "P201"; break;
						}
					}
				}

				/*** Exponentenvektor ausgeben ***/

				if( fputs( e,pf ) == EOF )
				{       err = ERROR; fn = "P201"; break; }
				if( zv && P != _0 )
				{       if( fputc( '\n',pf ) == EOF )
					{       err = ERROR; fn = "P201";
						break;
					}
					zv = 0;
				}
			}
		}
		if( !err && fputs( " #",pf ) == EOF )
		{       err = ERROR; fn = "P201";       }
		switch( j )
		{       case 1: break;
			case 2: free( k );
				break;
			default:free( e ); free( k );
				break;
		}
	}
	if( err )       errmsgio( "fputppf",fn );
	return( err );
}
