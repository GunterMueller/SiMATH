/*M
.SH NAME
fgetpnf - file get polynomial over number field

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol fgetpnf(r, F, VL, Vnf, pf)  
single r; 
pol F; 
list VL, Vnf; 
FILE *pf;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B VL
is the list of variables names of lenght >= r (s. pmakevl).
.TP 4
.B Vnf
is a list which contains one element, representing the name of a zero of F.   
.TP 4
.B pf
points to an output file.
.PP
fgetpnf reads a polynomial in r variables over K from the file *pf.
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
fgetpnf returns the polynomial by success, ERROR else.

M*/                                      
                 
/*H
	Version 1       08.03.1991      A. Stein
   DATE fgetpnf       : 910715.9301__
H*/


#include <_pol3.h>

pol fgetpnf(r,F,V,Vnf,pf)
single r;
pol F;
list V, Vnf;
FILE *pf;
{
	single n,e,i,deg; 
	int HNa, N, Z;
        nfel a;
	list eV,L;
	pol P, PS;
	bind(F,L);
	init(P,PS,a,HNa,N,Z);

/* Einlesen Polynom */

	V = lcconc(Vnf,V);
	if ((P = fgetpr(r+1,V,pf)) == ERROR) errmsgio("fgetpnf","P211");

/* Reduziere P */
         
	F = dptop( 1,F );
	F  = pitopr( 1,F );
	n = lfirst(F); 
        L = _0;
	if (r  &&  P) {
		P = ptodip(r,P);
		PS = _0;
		while (P != _0) {
			a = lfirst(P);
			P = lred(P); 
			if ( a )  { 
				e = lfirst(a);
				if ( e >= n ) a = prrem( 1, a, F );
			}	    	
  
                        HNa = 1;  
			if( a ) {

				/*** Hauptnenner HNa bestimmen. ***/
				i = e;
				while( a !=  _0 )
				{       deg = lfirst( a );

					/*** Koeffizient von x^i ist 0. ***/
					if( deg != i )  L = lcomp( 0,L );
					else
					{       a = lred( a );
						N = lfirst( a );
						L = lcomp( N,L );
						if( N )
						{       N = lsecond( N );
							HNa = ilcm( HNa, N );
						}
						a = lred( a );
					}
					i--;
				}
				for( ; i >= 0; i-- )
					L = lcomp( 0,L );

				/*** Aufbau von a. ***/
				while( L != _0 )
				{       Z = lfirst( L );
					if( Z )
					{       N = lsecond( Z );
						Z = lfirst( Z );
						if( N != HNa );
						{       N = iquot( HNa,N );
							Z = iprod( Z,N );
						}
					}
					a = lcomp( Z,a );
					L = lred( L );
				}
				a = lcomp2( HNa, e, a );
			} 

			if (a) eV = lfirst(P), PS = lcomp2(eV,a,PS);
			P = lred(P); 

		} /*while*/  
                 
		if (PS != _0) PS = linv(PS), P = diptop(r,PS);
		else P = 0;
	}                           
	else if ( P )  { 
			e = lfirst(P);
			if ( e >= n )  P = prrem( 1, P, F );
		    	if( P ) {
                                HNa = 1;
				/*** Hauptnenner HNa bestimmen. ***/
				i = e;
				while( P !=  _0 )
				{       deg = lfirst( P );

					/*** Koeffizient von x^i ist 0. ***/
					if( deg != i )  L = lcomp( 0,L );
					else
					{       P = lred( P );
						N = lfirst( P );
						L = lcomp( N,L );
						if( N )
						{       N = lsecond( N );
							HNa = ilcm( HNa, N );
						}
						P = lred( P );
					}
					i--;
				}
				for( ; i >= 0; i-- )
					L = lcomp( 0,L );

				/*** Aufbau von P. ***/
				while( L != _0 )
				{       Z = lfirst( L );
					if( Z )
					{       N = lsecond( Z );
						Z = lfirst( Z );
						if( N != HNa );
						{       N = iquot( HNa,N );
							Z = iprod( Z,N );
						}
					}
					P = lcomp( Z,P );
					L = lred( L );
				}
				P = lcomp2( HNa, e, P );
			}	 
	}


/* Ausgabe */

	return(P);
}
