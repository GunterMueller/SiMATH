/*M
.SH NAME
ecqnftatealg - elliptic curve over quadratic number field, Tate's algorithm

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnftatealg( D, LC, LTV, P, pi, z, n )
int D; 
list LC, LTV, P; 
nfel pi; 
single z, n;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
.PP
Let K be the quadratic number field Q(D^(1/2)), and O_K the ring of integers of K, then
.TP 4
.B LC
= (a1 a2 a3 a4 a6)  nfel a1, a2, a3, a4, a6; is a list of elements of O_K, beeing the coefficients of an elliptic curve, say E.
.TP 4
.B LTV
= (b2 b4 b6 b8 c4) nfel b2, b4, b6, b8, c4; is a list, containing the Tate values of the curve E/K.
.TP 4
.B P
is a prime ideal in O_K over a prime number p. P divides the discriminant of E/K.
.TP 4
.B pi
is a locally uniformizing parameter of P.
.TP 4
.B z
specifies the law of decomposition of p, z = 0, 1 or 2, for p inertial, ramified or split respectively.
.TP 4
.B n
is the largest integer number, so that P^n divides the discriminant of the curve E/K.
.PP
ecqnftatealg computes with help of  Tate's algorithm
.IP
 the reduction type of the curve E modulo P,
 the exponent of the local conductor of E at P,
 the c_P value of E modulo P.
.PP         
ecqnftatealg returns
.PP
 - if an error occurs, the list (x), where x is in 1,...,9, specifying the point of the algoritm, where no further transformation of E was found.
 - if the actual model of E mod P not minimal, a list of five number field elements, being the coefficients of another model of E, so that the discriminant of the new model is equal to P^(-12) * D_ac, where D_ac denotes the discriminant of the actual model of E/K.
 - else, a list of three elements (exp rtyp c_P), where
.PP
 exp  is the exponent of the local conductor,
 rtyp is the reduction typ according the table below,
 c_P  = #E(K)/E0(K), where
      E0(K) = {S in E(K) | S = (0 : 1 : 0) mod P}.
.IP                                                 
 | rtyp   | Kodaira  | Neron  |  c_p-Wert   |
 |--------|----------|--------|-------------|
 | -n < 0 |    In    |   Bn   |  1, 2 or n  |
 |--------|----------|--------|-------------|
 |    1   |    II    |   C1   |      1      |
 |--------|----------|--------|-------------|
 |    2   |   III    |   C2   |      2      |
 |--------|----------|--------|-------------|
 |    3   |    IV    |   C3   |    1 or 3   |
 |--------|----------|--------|-------------|
 |    5   |    I0*   |   C4   |    2 or 4   |
 |--------|----------|--------|-------------|
 | 10 + v |    In    |  C5,v  |    2 or 4   |
 |--------|----------|--------|-------------|
 |    6   |    IV*   |   C6   |    1 or 3   |
 |--------|----------|--------|-------------|
 |    7   |   III*   |   C7   |      2      |
 |--------|----------|--------|-------------|
 |    8   |    II*   |   C8   |      1      |
 --------------------------------------------

.SH SEE ALSO
 Literature: J.T.Tate,
             Algorithm for finding the type of a singular
             fiber in an elliptic pencil.
             Modular functions in one variable IV. Antwerp
             1972.                                                    

M*/
             
/*H
	Version 1       22.06.1993      Josef Gebel u. Claude Grasser
	Version 2       26.03.1996      Fehler beseitigt. JG.
	Version 2.1     21.04.1997      dito (insb. Trafos) (Sus)
	Version 2.2     24.09.1997      dito (insb. Nullst.) (Sus)
   DATE ecqnftatealg  : 931130.960501
H*/

#include<_ec2.h>

static nfel transqnf_a1(int,single*,nfel);
static nfel transqnf_a2(int,single*,nfel,nfel);
static nfel transqnf_a3(int,single*,nfel,nfel);
static nfel transqnf_a4(int,single*,nfel,nfel,nfel,nfel);
static nfel transqnf_a6(int,single*,nfel,nfel,nfel,nfel,nfel);
static nfel transqnf_b2(int,single*,nfel);
static nfel transqnf_b6(int,single*,nfel,nfel,nfel);
static nfel transqnf_b8(int,single*,nfel,nfel,nfel,nfel);
static list qnfpol3numro(int,list,nfel,single,nfel,nfel,nfel);
static qnfpol2rinOP(int,list,nfel,single,nfel,nfel,nfel);

single D_flag;     /***   Sei {1, w} die Ganzheitsbasis          ***/
                   /***             / 1, falls D = 1 mod 4       ***/
                   /***   D_flag = <   d.h.  w = [1+D^(1/2)]/2   ***/
                   /***             \ 0 sonst, d,h. w = D^(1/2)  ***/

list ecqnftatealg( D, LC, LTV, P, pi, z, n )
int    D;
list   LC, LTV, P;
nfel   pi;
single z, n;
{
    single exp, cp, rtyp;
    nfel   c4;

    init( c4 );
    bind( D, LC, LTV, P, pi );

    c4 = lfifth( LTV );  

    if( ( n <= 2 ) && !isqnfppihom0( D, P, 1, pi, z, c4 ) )
    {
	/***   E/K hat multiplikative Reduktion modulo P.  ***/
        /***   Um den c_P-Wert zu berechnen, muss die      ***/
        /***   Gleichung transformiert werden.             ***/
        /***   Im Fall n = 1 oder n = 2 ist das nicht      ***/
        /***   noetig, da in allen Faellen c_P = n ist.    ***/
        /***                                               ***/
        /***   REDUKTIONSTYP: Bn bzw. In, n = 1 = v_p( D ) ***/
        /***                         oder n = 2 = v_p( D ) ***/
        /***                                               ***/
        /***   c_P = n (immer, siehe unten)                ***/

	exp  = 1;
	rtyp = (-1) * n;
        cp   = n;

	return( list3( exp, rtyp, cp ) );
    }{
    single a, b, k, tr[6];
    nfel  a1,  a2,  a3,  a4,  a6,  b2,  b4,  b6,  b8,
         a11, a21, a31, a41, a61;
    list L;

    extern single D_flag;

    init( a1, a2, a3, a4, a6, b2, b4, b6, b8 );
    init( a11, a21, a31, a41, a61 );
    init( L );
    	
    a1 = lfirst ( LC );  
    a2 = lsecond( LC );  
    a3 = lthird ( LC );  
    a4 = lfourth( LC );  
    a6 = lfifth ( LC );  
    
    b2 = lfirst ( LTV );  
    b4 = lsecond( LTV );  
    b6 = lthird ( LTV );  
    b8 = lfourth( LTV );  


    if( m4hom( D ) == 1 )
    {
	D_flag = 1;
    }
    else
    {
	D_flag = 0;
    }

    /***   Transformiere E so, dass pi die     ***/
    /***   Koeffizienten a3, a4 und a6 teilt.  ***/
    
    k = 1;

    while( k && ( k < 7 ) )
    {
	L = qnfsysrmodpi( D, P, pi, z, k );
        k++;

	a = lfirst ( L );
	b = lsecond( L );

	for( tr[0] = 0; tr[0] <= a && k; tr[0]++ )
	for( tr[1] = 0; tr[1] <= b && k; tr[1]++ )
	for( tr[2] = 0; tr[2] <= a && k; tr[2]++ )
	for( tr[3] = 0; tr[3] <= b && k; tr[3]++ )
	for( tr[4] = 0; tr[4] <= a && k; tr[4]++ )
	for( tr[5] = 0; tr[5] <= b && k; tr[5]++ )
	{
            a31 = transqnf_a3( D, tr, a1, a3 );
            if( isqnfppihom0( D, P, 1, pi, z, a31 ) )
            {
		a41 = transqnf_a4( D, tr, a1, a2, a3, a4 );
                if( isqnfppihom0( D, P, 1, pi, z, a41 ) )
                {
                    a61 = transqnf_a6( D, tr, a1, a2, a3, a4, a6 );
                    if( isqnfppihom0( D, P, 1, pi, z, a61 ) )
                    {
                        a6 = a61;
                        a4 = a41;
                        a3 = a31;
                        a2 = transqnf_a2( D, tr, a1, a2 );
                        a1 = transqnf_a1( D, tr, a1 );
 
                        b8 = transqnf_b8( D, tr, b2, b4, b6, b8 );
                        b6 = transqnf_b6( D, tr, b2, b4, b6 );
	                b2 = transqnf_b2( D, tr, b2 );

			k = 0;
                    }
                }
            }
        }
    }
    if( k )
    {
	/***   Keine Transformation gefunden   ***/
	return( list1( 1 ) );
    }

    if( !isqnfppihom0( D, P, 1, pi, z, b2 ) )
    {
        /***   Multiplikative Reduktion.                       ***/
        /***                                                   ***/
        /***   REDUKTIONSTYP: Bn bzw. In, n = v_p( D) > 1.     ***/
        /***                                                   ***/
        /***   P(Y) = Y^2 + a1 Y - a2 in O_P[ Y ]              ***/
	/***   hat 2 verschiedene Nullstellen                  ***/
        /***   (im ganzen Abschluss von O_P).                  ***/
        /***                                                   ***/
        /***                                                   ***/
	/***           / n, falls die Nullstellen von P(Y)     ***/
	/***          |     in O_P liegen                      ***/
	/***          |  2, falls die Nullstellen von P(Y)     ***/
        /***   c_P = <      nicht in O_P liegen und 2 | n      ***/
        /***          |  1, falls die Nullstellen von P(Y)     ***/
        /***           \    nicht in O_P liegen und (2,n) = 1  ***/

	exp  = 1;
	rtyp = (-1) * n;

	a11 = a1;
	a21 = qnfneg( D, a2 );
	a31 = list3( 1, 0, 1);
	
        if( qnfpol2rinOP( D, P, pi, z, a31, a11, a21 ) )
        {
            /***   Beide Nullstellen liegen      ***/
            /***   in O_P: c_P = n               ***/
            cp = n;
        }
        else
        {
            /***   Die Nullstellen liegen nicht  ***/
            /***   in O_P: c_P = 1 oder 2 (s.o.) ***/
	    if( n % 2 )
	    {
                cp = 1;
	    }
	    else
	    {
                cp = 2;
	    }
        }

        return( list3( exp, rtyp, cp ) );
    }{
    nfel pi2;
    init( pi2 );
    
    pi2 = qnfsquare( D, pi );
 
    
    /********************************************************/
    /***                                                  ***/
    /***   Ab hier: E/K hat additive Reduktion modulo P   ***/
    /***                                                  ***/
    /********************************************************/

    if( !isqnfppihom0( D, P, 2, pi, z, a6 ) )
    {
        /***   REDUKTIONSTYP: C1 bzw. II.  ***/
	/***   c_P = 1 (immer).            ***/
 
        exp  = n;
        rtyp = 1;
        cp   = 1;
 
        return( list3( exp, rtyp, cp ) );
    }{
 
    /***   Ab hier gilt: pi^2 teilt a6 (<==> pi^2 teilt b8)   ***/
 
    nfel pi3;
    init( pi3 );
 
    pi3 = qnfprod( D, pi, pi2 );
    
    if( !isqnfppihom0( D, P, 3, pi, z, b8 ) )
    {
	/***   REDUKTIONSTYP: C2 bzw. III.  ***/
        /***   c_P = 2 (immer).             ***/
 
        exp  = n - 1;
        rtyp = 2;
        cp   = 2;
 
        return( list3( exp, rtyp, cp ) );
    }
 
    if( !isqnfppihom0( D, P, 3, pi, z, b6 ) )
    {
        /***   P(Y) :=  Y^2 + a3 Y - a6 in O_P[ Y ]           ***/
        /***   hat zwei verschiedene Nullstellen              ***/
        /***   (im ganzen Abschluss von F_p).                 ***/
        /***                                                  ***/
        /***   REDUKTIONSTYP: C3 bzw.  IV.                    ***/
        /***                                                  ***/
        /***          / 3, falls die Nullstellen von P(Y)     ***/
        /***   c_P = <                      in F_p liegen     ***/
        /***          \ 1 sonst.                              ***/

	a61 = qnfquot( D, a6, pi2 );
	a31 = qnfquot( D, a3, pi  );
	a61 = qnfneg ( D, a61 );
	a11 = list3( 1, 0, 1);
	
	exp  = n - 2;
	rtyp = 3;
        if( qnfpol2rinOP( D, P, pi, z, a11, a31, a61 ) )
        {
            /***   Beide Nullstellen liegen      ***/
            /***   in O_P: c_P = 3               ***/
            cp = 3;
        }
        else
        {
            /***   Die Nullstellen liegen nicht  ***/
            /***   in O_P: c_P = 1               ***/
            cp = 1;
        }

        return( list3( exp, rtyp, cp ) );
    }

    /***   An dieser Stelle gilt:         pi^3 teilt b6       ***/
 
    k = 1;
    while( k && ( k < 7 ) )
    {
        /***   Transformiere E so, dass gilt:   ***/
        /***                pi   teilt a1, a2   ***/
        /***                pi^2 teilt a3, a4   ***/
        /***                pi^3 teilt a6       ***/
 
        L = qnfsysrmodpi( D, P, pi, z, k );
        k++;
 
        a = lfirst ( L );
	b = lsecond( L );
 
	for( tr[0] = 0; tr[0] <= a && k; tr[0]++ )
	for( tr[1] = 0; tr[1] <= b && k; tr[1]++ )
	for( tr[2] = 0; tr[2] <= a && k; tr[2]++ )
	for( tr[3] = 0; tr[3] <= b && k; tr[3]++ )
	for( tr[4] = 0; tr[4] <= a && k; tr[4]++ )
	for( tr[5] = 0; tr[5] <= b && k; tr[5]++ )
	{
            a11 = transqnf_a1( D, tr, a1 );
            if( isqnfppihom0( D, P, 1, pi, z, a11 ) )
            {
		a21 = transqnf_a2( D, tr, a1, a2 );
                if( isqnfppihom0( D, P, 1, pi, z, a21 ) )
 		{
		    a31 = transqnf_a3( D, tr, a1, a3 );
                    if( isqnfppihom0( D, P, 2, pi, z, a31 ) )
		    {
		        a41 = transqnf_a4( D, tr, a1, a2, a3, a4 );
		        if( isqnfppihom0( D, P, 2, pi, z, a41 ) )
		        {
			    a61 = transqnf_a6( D, tr, a1, a2, a3, a4, a6 );
                            if( isqnfppihom0( D, P, 3, pi, z, a61 ) )
	                    {
				a1 = a11;
				a2 = a21;
				a3 = a31;
				a4 = a41;
				a6 = a61;
 
				k = 0;
		            }
		        }
		    }
                }
            }
        }
    }
    if( k )
    {
	/***   Keine Transformation gefunden   ***/
	return( list1( 2 ) );
    }

    a21 = qnfquot( D, a2, pi  );
    a41 = qnfquot( D, a4, pi2 );
    a61 = qnfquot( D, a6, pi3 );

    a21 = qnfpihom( D, P, pi, z, a21 );
    a41 = qnfpihom( D, P, pi, z, a41 );
    a61 = qnfpihom( D, P, pi, z, a61 );

    /***   Sei P(T) = T^3 + a21 * T^2 + a41 * T + a61.       ***/
    /***   k ist die Anzahl der  v e r s c h i e d e n e n   ***/
    /***   Nullstellen von P(T) im ganzen Abschluss von O_P. ***/

    L = qnfpol3numro( D, P, pi, z, a21, a41, a61 );
    k = lfirst( L );

    if( k == 3 )
    {
        /***   REDUKTIONSTYP: C4 bzw. IV*.              ***/
	exp  = n - 4;
	rtyp = 5;

	k = llength( L );

	if( k == 4 )
	{
	    /***   Alle Nullstellen von P(T) in O_P      ***/
	    cp = 4;
	}
	else if( k == 2 )
	{
	    /***   Nur eine Nullstelle von P(T) in O_P   ***/
	    cp = 2;
	}
	else
	{
	    /***   Keine Nullstelle von P(T) in O_P      ***/
	    cp = 1;
	}
        
	return( list3( exp, rtyp, cp ) );
    }{
    nfel hq;
    int ch;

    init( hq );
    init( ch );

    if( k == 2 )
    {
	/***   REDUKTIONSTYP: C5,v bzw. Iv*              ***/
	/***   (v muss noch bestimmt werden)             ***/
	/***                                             ***/
	/***   P(T) hat 2 verschiedene Nullstellen       ***/
	/***   Transformiere E so, dass die doppelte     ***/
	/***   Nullstelle bei 0 liegt.                   ***/
	/***                                             ***/

	single l, v, k2, k3, k4, k5, k6;
	nfel   a22, a32, a42, a62, h1, h2, h3, h4, h5, h6;

	init( a22, a32, a42, a62, h1, h2, h3, h4, h5, h6 );
	v = 0;
	k = 1;
	
        while( k && ( k < 7 ) )
        {
            /***   Transformiere E so, dass gilt:   ***/
            /***        pi   teilt       a2         ***/
            /***        pi   teilt nicht a2         ***/
            /***        pi^3 teilt       a4         ***/
            /***        pi^4 teilt       a6         ***/
     
            L = qnfsysrmodpi( D, P, pi, z, k );
            k++;
     
            a = lfirst ( L );
	    b = lsecond( L );
	    tr[2] = 0;
	    tr[3] = 0;
	    tr[4] = 0;
	    tr[5] = 0;
 
	    for( tr[0] = 0; tr[0] <= a && k; tr[0]++ )
	    for( tr[1] = 0; tr[1] <= b && k; tr[1]++ )
	    {
		a21 = transqnf_a2( D, tr, a1, a2 );
                if( isqnfppihom0( D, P, 1, pi, z, a21 ) 
                && !isqnfppihom0( D, P, 2, pi, z, a21 ) )
		{
		    a41 = transqnf_a4( D, tr, a1, a2, a3, a4 );
		    if( isqnfppihom0( D, P, 3, pi, z, a41 ) )
		    {
			a61 = transqnf_a6( D, tr, a1, a2, a3, a4, a6 );
                        if( isqnfppihom0( D, P, 4, pi, z, a61 ) )
	                {
		            a6 = a61;
		            a4 = a41;
		            a3 = transqnf_a3( D, tr, a1, a3 );
		            a2 = a21;
			    a1 = transqnf_a1( D, tr, a1 );
 
			    k = 0;
	                }
	            }
	        }
	    }
	}
	if( k )
	{
	    /***   Keine Transformation gefunden   ***/
	    return( list1( 3 ) );
	}

	/** Bestimmung der Charakteristik **/

	if(z)
	{ /***  p zerlegt oder verzweigt: P = ( 1  p*s  x  s ) ***/
       		ch = lsecond( P );
       		ch = isquot( ch, lfourth( P ) );
    	}
    	else
   	{ /***  p traege: P = ( p  s  x  s ) ***/
       		ch = lfirst( P );
    	}

	/***   Bestimmung von v   ***/

	while( 1 )
	{
	    h1 = pi;
	    k2 = 2;  /*?S?*/
	    k3 = 3;  /*?S?*/
	    k5 = 3;  /*?S?*/
	    k6 = 4;  /*?S?*/

	    for( l = 1; l <= 15; l++ )
	    {
		h1 = qnfprod( D, h1, pi );
		h2 = qnfprod( D, h1, pi );
		h3 = qnfprod( D, h2, pi );
		h4 = qnfprod( D, h1, h1 );
		h5 = qnfprod( D, h4, pi );
		h6 = qnfprod( D, h5, pi );

/**
		k1 *= 2;
		k2 = k1 + 1;
		k3 = k2 + 1;
		k5 = 2 * k1 + 1;
		k6 = k5 + 1;
**/ /*?S?*/

		k2 = k2+1;
		k3 = k3+1;
		k5 = k5+2;
		k6 = k6+2;

		v++;

		a32 = qnfquot( D,  a3, h1 );
	        a62 = qnfquot( D,  a6, h4 );
	        a62 = qnfneg ( D, a62     );


		a32 = qnfpihom( D, P, pi, z, a32 );
		a62 = qnfpihom( D, P, pi, z, a62 );

		if(!icomp(ch,2)) hq = a32;
		else
		{
			hq = qnfiprod( D, a62, 4 );
			hq = qnfdif( D, hq, qnfsquare( D, a32 ) );
		}
		
		if( !isqnfppihom0( D, P, 1, pi, z, hq ) )
		{
		    /***   Q(Y) = Y^2 + a32 Y + a62 hat 2    ***/
		    /***   verschiedene Nullstellen in O_P   ***/

		    a22 = list3( 1, 0, 1 );
		    if( qnfpol2rinOP( D, P, pi, z, a22, a32, a62 ) )
		    {
			/***   Beide Nullstellen liegen      ***/
			/***   in O_P: c_P = 4               ***/
			cp = 4;
		    }
		    else
		    {
			/***   Die Nullstellen liegen nicht  ***/
			/***   in O_P: c_P = 2               ***/
			cp = 2;
		    }

	            exp  = n - 4 - v;
	            rtyp = 10 + v;
		    
		    return( list3( exp, rtyp, cp ) );
		}

		/***   Q(Y) = Y^2 + a32 Y + a62 hat eine    ***/
		/***   doppelte Nullstelle y in O_P.        ***/
		/***   Transformiere E so, dass y = 0,      ***/
		/***   d.h. pi^3 teilt a3, pi^6 teilt a6.   ***/

		v++;
	        k = 1;

                while( k && ( k < 7 ) )
                {
                    L = qnfsysrmodpi( D, P, pi, z, k );
                    k++;
     
                    a = lfirst ( L );
	            b = lsecond( L );
	            tr[0] = 0;
	            tr[1] = 0;
	            tr[2] = 0;
	            tr[3] = 0;
 
	            for( tr[4] = 0; tr[4] <= a && k; tr[4]++ )
	            for( tr[5] = 0; tr[5] <= b && k; tr[5]++ )
	            {
		        a31 = transqnf_a3( D, tr, a1, a3 );
                        if( isqnfppihom0( D, P, k2, pi, z, a31 ) )
		        {
		            a61 = transqnf_a6( D, tr, a1, a2, a3, a4, a6 );
		            if( isqnfppihom0( D, P, k5, pi, z, a61 ) )
		            {
		                a6 = a61;
		                a4 = transqnf_a4( D, tr, a1, a2, a3, a4 );
		                a3 = a31;
			        a2 = transqnf_a2( D, tr, a1, a2 );
			        a1 = transqnf_a1( D, tr, a1 );
 
		                
			        k = 0;
	                    }
	                }
	            }
	        }
	        if( k )
	        {
	            /***   Keine Transformation gefunden   ***/
	            return( list1( 4 ) );
	        }

		a22 = qnfquot( D, a2, pi );
		a42 = qnfquot( D, a4, h2 );
		a62 = qnfquot( D, a6, h5 );

		a22 = qnfpihom( D, P, pi, z, a22 );
		a42 = qnfpihom( D, P, pi, z, a42 );
		a62 = qnfpihom( D, P, pi, z, a62 );

		/***   Sei k die Anzahl der verschiedenen Null-   ***/
		/***   stellen von R(X) = a22 X^2 + a24 X + a26   ***/
		/***   im ganzen Abschluss von O_P.               ***/

		if( !a22 )
		{
	            /***   R kein quadratisches Polynom     ***/
	            return( list1( 5 ) );
		}

		if(!icomp(ch,2)) hq = a42;
		else
		{
			hq = qnfiprod( D, a22,   4 );
			hq = qnfprod ( D, a22, a62 );
			hq = qnfdif( D, hq, qnfsquare( D, a42 ) );
		}

		if( !isqnfppihom0( D, P, 1, pi, z, hq ) )
		{
		    /***   R(X) = a22 X^2 + a24 X + a26     ***/
		    /***   hat 2 verschiedene Nullstellen   ***/
		    
		    if( qnfpol2rinOP( D, P, pi, z, a22, a42, a62 ) )
		    {
			/***   Beide Nullstellen liegen      ***/
			/***   in O_P: c_P = 4               ***/
			cp = 4;
		    }
		    else
		    {
			/***   Die Nullstellen liegen nicht  ***/
			/***   in O_P: c_P = 2               ***/
			cp = 2;
		    }

	            exp  = n - 4 - v;
	            rtyp = 10 + v;
		    
		    return( list3( exp, rtyp, cp ) );
		}

		/***   R(Y) = a22 Y^2 + a42 Y + a62 hat     ***/
		/***   eine doppelte Nullstelle y in O_P.   ***/
		/***   Transformiere E so, dass y = 0,      ***/
		/***   d.h. pi^4 teilt a4, pi^6 teilt a6.   ***/

	        k = 1;

                while( k && ( k < 7 ) )
                {
                    L = qnfsysrmodpi( D, P, pi, z, k );
                    k++;
     
                    a = lfirst ( L );
	            b = lsecond( L );
	            tr[2] = 0;
	            tr[3] = 0;
	            tr[4] = 0;
	            tr[5] = 0;
 
	            for( tr[0] = 0; tr[0] <= a && k; tr[0]++ )
	            for( tr[1] = 0; tr[1] <= b && k; tr[1]++ )
	            {
		        a21 = transqnf_a2( D, tr, a1, a2 );
                        if( isqnfppihom0( D, P, 1, pi, z, a21 ) 
                        && !isqnfppihom0( D, P, 2, pi, z, a21 ) )
		        {
		            a41 = transqnf_a4( D, tr, a1, a2, a3, a4 );
		            if( isqnfppihom0( D, P, k3, pi, z, a41 ) )
		            {
		                a61 = transqnf_a6( D, tr, a1, a2, a3, a4, a6 );
		                if( isqnfppihom0( D, P, k6, pi, z, a61 ) )
		                {
		                    a6 = a61;
		                    a4 = a41;
			            a3 = transqnf_a3( D, tr, a1, a3 );
		                    a2 = a21;
			            a1 = transqnf_a1( D, tr, a1 );
 
		                    
			            k = 0;
	                        }
	                    }
	                }
	            }
	        }
	        if( k )
	        {
	            /***   Keine Transformation gefunden   ***/
	            return( list1( 6 ) );
		}
	    }   /***   Ende: 'for( l = 1; l <= 15; l++ )'   ***/
	}   /***   Ende: 'while( 1 )'                       ***/
    }  /***   Ende: 'P(T) hat 2 verschiedene Nullstellen'   ***/
    
    /***   Beginn: 'P(T) hat eine (dreifache) Nullstelle'   ***/

    /***   Transformiere E so, dass 0 diese Nullstelle ist  ***/

    while( k && ( k < 7 ) )
    {
        L = qnfsysrmodpi( D, P, pi, z, k );
        k++;
         
        a = lfirst ( L );
        b = lsecond( L );
   
        tr[2] = 0;
        tr[3] = 0;
        tr[4] = 0;
        tr[5] = 0; 
         
        for( tr[0] = 0; tr[0] <= a && k; tr[0]++ )
        for( tr[1] = 0; tr[1] <= b && k; tr[1]++ )
        {
            a21 = transqnf_a2( D, tr, a1, a2 );
            if( isqnfppihom0( D, P, 1, pi, z, a21 ) ) /** Original*/
            /**if( isqnfppihom0( D, P, 2, pi, z, a21 ) ) ** SSSSSS**/
            {
                a41 = transqnf_a4( D, tr, a1, a2, a3, a4 );
                if( isqnfppihom0( D, P, 3, pi, z, a41 ) )
                {
                    a61 = transqnf_a6( D, tr, a1, a2, a3, a4, a6 );
                    if( isqnfppihom0( D, P, 4, pi, z, a61 ) )
                    {
                        a6 = a61;
                        a4 = a41;
                        a3 = transqnf_a3( D, tr, a1, a3 );
                        a2 = a21;
                        a1 = transqnf_a1( D, tr, a1 );
 
         
                        k = 0;
                    }
                }
            }
        }
    }
    if( k )
    {
        /***   Keine Transformation gefunden   ***/
        return( list1( 7 ) );
    }
    {
    nfel pi4, hq;

    init( pi4, hq );

    /** Bestimmung der Charakteristik **/

    if(z)
    { /***  p zerlegt oder verzweigt: P = ( 1  p*s  x  s ) ***/
   	ch = lsecond( P );
       	ch = isquot( ch, lfourth( P ) );
    }
    else
    { /***  p traege: P = ( p  s  x  s ) ***/
      	ch = lfirst( P );
    }

    pi4 = qnfprod( D, pi3, pi );

    a31 = qnfquot( D, a3, pi2 );
    a61 = qnfquot( D, a6, pi4 );
    a61 = qnfneg ( D, a61 );

    a31 = qnfpihom( D, P, pi, z, a31 );
    a61 = qnfpihom( D, P, pi, z, a61 );

    if(!icomp(ch,2)) hq = a31;
    else
    {
    	hq = qnfiprod( D, a61, 4 );
    	hq = qnfdif( D, hq, qnfsquare( D, a31 ) );
    }
    
    if( !isqnfppihom0( D, P, 1, pi, z, hq ) )
    {
	a11 = list3( 1, 0, 1 );
        /***   S(Y) = Y^2 + a31 Y - a61         ***/
        /***   hat 2 verschiedene Nullstellen   ***/
	/***                                    ***/
	/***   REDUKTIONSTYP C6 bzw. IV*        ***/
	/***                                    ***/
	/***   c_P = 3, falls die Nullstellen   ***/
	/***            in O_P liegen;          ***/
	/***   c_P = 1  sonst.                  ***/
         
	exp = n - 6;
	rtyp = 6;

        if( qnfpol2rinOP( D, P, pi, z, a11, a31, a61 ) )
        {
            /***   Beide Nullstellen liegen      ***/
            /***   in O_P: c_P = 3               ***/
            cp = 3;
        }
        else
        {
            /***   Die Nullstellen liegen nicht  ***/
            /***   in O_P: c_P = 1               ***/
            cp = 1;
        }		
	return( list3( exp, rtyp, cp ) );
    }{
    /***   S(Y) hat eine doppelte Nullstelle     ***/
    /***   Transformiere E so, dass S(0) = 0.    ***/

    nfel pi6;
    init( pi6 );

    pi6 = qnfprod( D, pi4, pi );   /***   pi6 = pi^5  ***/
    k = 1;

    while( k && ( k < 7 ) )
    {
        L = qnfsysrmodpi( D, P, pi, z, k );
        k++;
         
        a = lfirst ( L );
        b = lsecond( L );
        tr[0] = 0;
        tr[1] = 0;
        tr[2] = 0;
        tr[3] = 0;
 
        for( tr[4] = 0; tr[4] <= a && k; tr[4]++ )
        for( tr[5] = 0; tr[5] <= b && k; tr[5]++ )
        {
            a31 = transqnf_a3( D, tr, a1, a3 );
            if( isqnfppihom0( D, P, 3, pi, z, a31 ) )
            {
                a61 = transqnf_a6( D, tr, a1, a2, a3, a4, a6 );
                if( isqnfppihom0( D, P, 5, pi, z, a61 ) )
                {
                    a6 = a61;
                    a4 = transqnf_a4( D, tr, a1, a2, a3, a4 );
                    a3 = a31;
                    a2 = transqnf_a2( D, tr, a1, a2 );
                    a1 = transqnf_a1( D, tr, a1 );
 
         
                    k = 0;
                }
            }
        }
    }
    if( k )
    {
    /***   Keine Transformation gefunden   ***/
        return( list1( 8 ) );
    }

    if( isqnfppihom0( D, P, 3, pi, z, a4 ) )
    {
        if( !isqnfppihom0( D, P, 4, pi, z, a4 ) )
        {
	    /***   REDUKTIONSTYP C7 bzw. III*       ***/
	    /***                                    ***/
	    /***   c_P = 2 (immer)                  ***/

	    exp = n - 7;
	    rtyp = 7;
            cp = 2;
	    
	    return( list3( exp, rtyp, cp ) );
        }

        pi6 = qnfprod( D, pi6, pi );   /***  pi6 = pi^6  ***/
 
        if( !lsecond( pi6 ) )
        {
	    /***   pi^6 in Z: Normiere pi^6 > 0    ***/
	    if( lthird( pi6 ) < 0 )
	    {
	        pi6 = qnfneg( D, pi6 );
	    }
	}
        
	if( !isqnfppihom0( D, P, 6, pi, z, a6 ) )
        {
	    /***   REDUKTIONSTYP C8 bzw. II*        ***/
	    /***                                    ***/
	    /***   c_P = 1 (immer)                  ***/
         
	    exp = n - 8;
	    rtyp = 8;
            cp = 1;
	    
	    return( list3( exp, rtyp, cp ) );
        }

	/***   pi^i teilt ai fuer i = 1, 2, 3, 4, 6   ***/
	/***   ==> die Gleichung fuer E war nicht     ***/
	/***       minimal bei P. Neue Gleichung:     ***/
	/***   ai' = ai / pi^i  (i = 1, 2, 3, 4, 6)   ***/

	a1 = qnfquot( D, a1, pi  );
	a2 = qnfquot( D, a2, pi2 );
	a3 = qnfquot( D, a3, pi3 );
	a4 = qnfquot( D, a4, pi4 );
	a6 = qnfquot( D, a6, pi6 );

	return( list5( a1, a2, a3, a4, a6 ) );
    }
    /***   Fehler im Algorihtmus    ***/
    return( list1( 9 ) );
}}}}}}}

/****************   Ende von  q n f t a t e a l g   ****************/

/*c
                    transqnf_a1( D, tr, a1 )

       "transformation of a1"
       static nfel transqnf_a6( D, tr, a1 ) 
	      int D; nfel a1; single tr[6];
       transqnf_a1 transformiert birational den Koeffizienten a1
       einer elliptischen Kurve E/Q(D^(1/2)) gemaess  
	   a1' = a1 + 2s,
       wobei s = tr[2] + tr[3] *D^(1/2) bzw.
	     s = tr[2] + tr[3] * (1+D^(1/2))/2 .
       transqnf_a1 ist ein static-Modul zu ecqnftatealg.
c*/

static nfel transqnf_a1( D, tr, a1 )
int D;
nfel a1;
single *tr;
{
    bind( D, a1 );

    if( tr[3] )
    {
	if( D_flag )
	{
            return( qnfsum( D, a1, list4( 1, 1, tr[3], 2 * tr[2] + tr[3] ) ) );
	}
	else
	{
            return( qnfsum( D, a1, list4( 1, 1, 2 * tr[3], 2 * tr[2] ) ) );
	}
    }
    if( tr[2] )
    {
        return( qnfsum( D, a1, list3( 1, 0, 2 * tr[2] ) ) );
    }
    
    return( a1 );
}

/****************   Ende von  t r a n s q n f _ a 1   ****************/

/*c
                transqnf_a2( D, tr, a1, a2 )

       "transformation of a2"
       static nfel transqnf_a2( D, tr, a1, a2 ) 
	      int D; nfel a1, a2; single tr[6];
       transqnf_a2 transformiert birational den Koeffizienten a2
       einer elliptischen Kurve E/Q(D^(1/2)) gemaess  
	   a2' = a2 - s*a1 + 3*r - s^2,
       wobei r = tr[0] + tr[1] *D^(1/2), s = tr[2] + tr[3] *D^(1/2).
       transqnf_a2 ist ein static-Modul zu ecqnftatealg.
c*/

static nfel transqnf_a2( D, tr, a1, a2 )
int D;
nfel a1, a2;
single *tr;
{
    nfel a21, r, s;

    bind( D, a1, a2 );
    init( a21, r, s );

    if( tr[1] )
    {
	if( D_flag )
	{
	    r = list4( 2, 1, 3 * tr[1], 6 * tr[0] + 3 * tr[1] );
	}
	else
	{
	    r = list4( 1, 1, 3 * tr[1], 3 * tr[0] );
	}
    }
    else if( tr[0] )
    {
	r = list3( 1, 0, 3 * tr[0] );
    }
    else
    {
        r = 0;
    }

    if( tr[3] )
    {
	if( D_flag )
	{
	    /**s = list4( 2, 1, tr[3], -2 * tr[2] + -tr[3] );**/
	    s = list4( 2, 1, tr[3], -2 * tr[2] - tr[3] ); /*** SSS ***/
	}
	else
	{
	    s = list4( 1, 1, -tr[3], -tr[2] );
	}
    }
    else if( tr[2] )
    {
	s = list3( 1, 0, -tr[2] );
    }
    else
    {
        s = 0;
    }

    if( s )
    {
        /**a21 = qnfsum ( D,  a1,   s );**/
        a21 = qnfdif ( D,  a1,   s );		/**SSSSSSS **/
        a21 = qnfprod( D, a21,   s );
    }
    if( r )
    {
        a21 = qnfsum( D, a21, r );
    }
    a21 = qnfsum( D, a21, a2 );

    return( a21 );
}

/****************   Ende von  t r a n s q n f _ a 2   ****************/

/*c
                transqnf_a3( D, tr, a1, a3 )

       "transformation of a3"
       static nfel transqnf_a3( D, tr, a1, a3 ) 
	      int D; nfel a1, a3; single tr[6];
       transqnf_a3 transformiert birational den Koeffizienten a3
       einer elliptischen Kurve E/Q(D^(1/2)) gemaess  
	   a3' = a3 + r*a1 + 2*t,
       wobei r = tr[0] + tr[1] *D^(1/2), t = tr[4] + tr[5] *D^(1/2).
       transqnf_a3 ist ein static-Modul zu ecqnftatealg.
c*/

static nfel transqnf_a3( D, tr, a1, a3 )
int D;
nfel a1, a3;
single *tr;
{
    nfel a31, r, t;

    bind( D, a1, a3 );
    init( a31, r, t );

    if( tr[1] )
    {
	if( D_flag )
	{
	    r = list4( 2, 1, tr[1], 2 * tr[0] + tr[1] );
	}
	else
	{
	    r = list4( 1, 1, tr[1], tr[0] );
	}
    }
    else if( tr[0] )
    {
        r = list3( 1, 0, tr[0] );
    }
    else
    {
        r = 0;
    }

    if( tr[5] )
    {
	if( D_flag )
	{
	    t = list4( 1, 1, tr[5], 2 * tr[4] + tr[5] );
	}
	else
	{
	    t = list4( 1, 1, 2 * tr[5], 2 * tr[4] );
	}
    }
    else if( tr[4] )
    {
	t = list3( 1, 0, 2 * tr[4] );
    }
    else
    {
        t = 0;
    }

    if( r && t && a1 )
    {
        a31 = qnfprod( D,  a1,   r );
        a31 = qnfsum ( D, a31,  a3 );
        a31 = qnfsum ( D, a31,   t );
    }
    else if( r && a1 )
    {
        a31 = qnfprod( D,  a1,   r );
        a31 = qnfsum ( D, a31,  a3 );
    }
    else if( t )
    {
        /**a31 = qnfsum( D, a31, t );**/
        a31 = qnfsum( D, a3, t );	/*** SSSS ***/
    }
    else
    {
        return( a3 );
    }

    return( a31 );
}

/****************   Ende von  t r a n s q n f _ a 3   ****************/

/*c
                transqnf_a4( D, tr, a1, a2, a3, a4 )

       "transformation of a4"
       static nfel transqnf_a6( D, tr, a1, a2, a3, a4 ) 
	      int D; nfel a1, a2, a3, a4; single tr[6];
       transqnf_a4 transformiert birational den Koeffizienten a4
       einer elliptischen Kurve E/Q(D^(1/2)) gemaess  
	   a4' = a4 - s*a3 + 2*r*a2 - (t + r*s)*a1 + 3*r^2 - 2*s*t,
       wobei r = tr[0] + tr[1] *D^(1/2), s = tr[2] + tr[3] *D^(1/2),
       t = tr[4] + tr[5] *D^(1/2).
       transqnf_a4 ist ein static-Modul zu ecqnftatealg.
c*/


static nfel transqnf_a4( D, tr, a1, a2, a3, a4 )
int D;
nfel a1, a2, a3, a4;
single *tr;
{
    nfel a41, r, s, t;

    init( a41, r, s, t );
    bind( D, a1, a2, a3, a4 );

    if( tr[1] )
    {
	if( D_flag )
	{
	    r = list4( 2, 1, tr[1], 2 * tr[0] + tr[1] );
	}
	else
	{
	    r = list4( 1, 1, tr[1], tr[0] );
	}
    }
    else if( tr[0] )
    {
	r = list3( 1, 0, tr[0] );
    }
    else
    {
        r = 0;
    }

    if( tr[3] )
    {
	if( D_flag )
	{
	    s = list4( 2, 1, tr[3], 2 * tr[2] + tr[3] );
	}
	else
	{
	    s = list4( 1, 1, tr[3], tr[2] );
	}
    }
    else if( tr[2] )
    {
	s = list3( 1, 0, tr[2] );
    }
    else
    {
        s = 0;
    }

    if( tr[5] )
    {
	if( D_flag )
	{
	    t = list4( 2, 1, tr[5], 2 * tr[4] + tr[5] );
	}
	else
	{
	    t = list4( 1, 1, tr[5], tr[4] );
	}
    }
    else if( tr[4] )
    {
	t = list3( 1, 0, tr[4] );
    }
    else
    {
        t = 0;
    }

    if( r && s && t )
    {
        a41 = qnfprod( D,   r,   s );
        a41 = qnfsum ( D, a41,   t );
        a41 = qnfprod( D, a41,  a1 );
        a41 = qnfdif ( D,  a4, a41 );
        t   = qnfiprod( D, t, 2 );
        t   = qnfsum ( D,  a3,   t );
        t   = qnfprod( D,   t,   s );
        a41 = qnfdif ( D, a41,   t );
        t   = qnfiprod( D, r, 3 );
        s   = qnfiprod( D, a2, 2 );
        t   = qnfsum ( D,   s,   t );
        t   = qnfprod( D,   t,   r );
        a41 = qnfsum ( D, a41,   t );
    }
    else if( r && s )
    {
        /***   t = 0   ***/
        a41 = qnfiprod( D,   r,  3 );
        t   = qnfprod ( D,  a1,  s );
        a41 = qnfdif  ( D, a41,  t );
        t   = qnfiprod( D,  a2,  2 );
        a41 = qnfsum  ( D, a41,  t );
        a41 = qnfprod ( D, a41,  r );
        t   = qnfprod ( D,  a3,  s );
        a41 = qnfdif  ( D, a41,  t );
        a41 = qnfsum  ( D, a41, a4 );
    }
    else if( r && t )		
    {
        /***   s = 0   ***/
        a41 = qnfiprod( D,   r,  3 );
        s   = qnfiprod( D,  a2,  2 );
        a41 = qnfsum  ( D, a41,  s );
        a41 = qnfprod ( D, a41,  r );
        s   = qnfprod ( D,  a1,  t );
        a41 = qnfdif  ( D, a41,  s );
        a41 = qnfsum  ( D, a41, a4 );
    }
    else if( t && s )
    {
        /***   r = 0   ***/
        a41 = qnfiprod( D,   s,  2 );
        a41 = qnfsum  ( D, a41, a1 );
        a41 = qnfprod ( D, a41,  t );
        r   = qnfprod ( D,  a3,  s );
        a41 = qnfsum  ( D, a41,  r );
        a41 = qnfdif  ( D, a4, a41 );
    }
    else if( r )
    {
        /***   s = t = 0   ***/
        a41 = qnfiprod( D,   r,  3 );
        t   = qnfiprod( D,  a2,  2 );
        a41 = qnfsum  ( D, a41,  t );
        a41 = qnfprod ( D, a41,  r );
        a41 = qnfsum  ( D, a41, a4 );
    }
    else if( s )
    {
        /***   r = t = 0   ***/
        a41 = qnfprod( D, a3,   s );
        a41 = qnfdif ( D, a4, a41 );
    }
    else if( t )
    {
        /***   r = s = 0   ***/
        a41 = qnfprod( D, a1,   t );
        a41 = qnfdif ( D, a4, a41 );
    }
    else
    {
        /***   r = s = t = 0   ***/
        return( a4 );
    }

    return( a41 );
}

/****************   Ende von  t r a n s q n f _ a 4   ****************/

/*c
                transqnf_a6( D, tr, a1, a2, a3, a4, a6 )

       "transformation of a6"
       static nfel transqnf_a6( D, tr, a1, a2, a3, a4, a6 ) 
	      int D; nfel a1, a2, a3, a4, a6; single tr[6];
       transqnf_a6 transformiert birational den Koeffizienten a6
       einer elliptischen Kurve E/Q(D^(1/2)) gemaess  
	   a6' = a6 + r*a4 + r^2*a2 + r^3 - t*a3 - r*t*a1 -t^2,
       wobei r = tr[0] + tr[1] *D^(1/2), t = tr[4] + tr[5] *D^(1/2).
       transqnf_a6 ist ein static-Modul zu ecqnftatealg.
c*/

static nfel transqnf_a6( D, tr, a1, a2, a3, a4, a6 )
int D;
nfel a1, a2, a3, a4, a6;
single *tr;
{
    nfel a61, r, t;

    bind( D, a1, a2, a3, a4, a6 );
    init( a61, r, t );

    if( tr[1] )
    {
	if( D_flag )
	{
	    r = list4( 2, 1, tr[1], 2 * tr[0] + tr[1] );
	}
	else
	{
	    r = list4( 1, 1, tr[1], tr[0] );
	}
    }
    else if( tr[0] )
    {
	r = list3( 1, 0, tr[0] );
    }
    else
    {
        r = 0;
    }

    a61 = qnfsum ( D,  a2,   r );
    a61 = qnfprod( D, a61,   r );
    a61 = qnfsum ( D, a61,  a4 );
    a61 = qnfprod( D, a61,   r );
    a61 = qnfsum ( D, a61,  a6 );

    if( tr[5] )
    {
	if( D_flag )
	{
	    t = list4( 2, 1, tr[5], 2 * tr[4] + tr[5] );
	}
	else
	{
	    t = list4( 1, 1, tr[5], tr[4] );
	}
    }
    else if( tr[4] )
    {
	t = list3( 1, 0, tr[4] );
    }
    else
    {
        t = 0;
    }

    r   = qnfprod( D,  a1,   r );
    r   = qnfsum ( D,  a3,   r );
    r   = qnfsum ( D,   t,   r );
    r   = qnfprod( D,   t,   r );
    a61 = qnfdif ( D, a61,   r );

    return( a61 );
}

/****************   Ende von  t r a n s q n f _ a 6   ****************/

/*c
                transqnf_b2( D, tr, b2 )

       "transformation of b2"
       static nfel transqnf_b2( D, tr, b2 ) 
	      int D; nfel b2; single tr[6];
       transqnf_b2 transformiert birational den Koeffizienten b2
       einer elliptischen Kurve E/Q(D^(1/2)) gemaess  
	   b2' = b2 + 12*r
       wobei r = tr[0] + tr[1] *D^(1/2).
       transqnf_b2 ist ein static-Modul zu ecqnftatealg.
c*/

static nfel transqnf_b2( D, tr, b2 )
int D;
nfel b2;
single *tr;
{
    nfel b21, r;

    bind( D, b2 );
    init( b21, r );

    if( tr[1] )
    {
	if( D_flag )
	{
	    r = list4( 1, 1, 6 * tr[1], 12 * tr[0] + 6 * tr[1] );
	}
	else
	{
	    r = list4( 1, 1, 12 * tr[1], 12 * tr[0] );
	}
    }
    else if( tr[0] )
    {
	r = list3( 1, 0, 12 * tr[0] );
    }
    else
    {
        return( b2 );
    }

    b21 = qnfsum ( D, b2, r );

    return( b21 );
}

/**************   Ende von  t r a n s q n f _ b 2   ****************/

/*c
                transqnf_b6( D, tr, b2, b4, b6 )

       "transformation of b6"
       static nfel transqnf_b6( D, tr, b2, b4, b6 ) 
	      int D; nfel b2, b4, b6; single tr[6];
       transqnf_b6 transformiert birational den Koeffizienten b6
       einer elliptischen Kurve E/Q(D^(1/2)) gemaess  
	   b6' = b6 + 2*r*b4 + r^2*b2 + 4*r^3
       wobei r = tr[0] + tr[1] *D^(1/2).
       transqnf_b6 ist ein static-Modul zu ecqnftatealg.
c*/

static nfel transqnf_b6( D, tr, b2, b4, b6 )
int D;
nfel b2, b4, b6;
single *tr;
{
    nfel b61, r, h;

    bind( D, b2, b4, b6 );
    init( b61, r, h );

    if( tr[1] )
    {
	if( D_flag )
	{
	    r = list4( 2, 1, tr[1], 2 * tr[0] + tr[1] );
	}
	else
	{
	    r = list4( 1, 1, tr[1], tr[0] );
	}
    }
    else if( tr[0] )
    {
	r = list3( 1, 0, tr[0] );
    }
    else
    {
        return( b6 );
    }

    b61 = qnfiprod( D, r, 4 );
    b61 = qnfsum ( D, b61, b2 );
    b61 = qnfprod( D, b61,  r );
    h   = qnfiprod( D, b4, 2 );
    b61 = qnfsum ( D, b61,  h );
    b61 = qnfprod( D, b61,  r );
    b61 = qnfsum ( D, b61, b6 );

    return( b61 );
}

/**************   Ende von  t r a n s q n f _ b 6   ****************/

/*c
                transqnf_b8( D, tr, b2, b4, b6, b8 )

       "transformation of b8"
       static nfel transqnf_b8( D, tr, b2, b4, b6, b8 ) 
	      int D; nfel b2, b4, b6, b8; single tr[6];
       transqnf_b8 transformiert birational den Koeffizienten b8
       einer elliptischen Kurve E/Q(D^(1/2)) gemaess  
	   b8' = b8 + 3*r*b6 + 3*r^2*b4 + r^3*b2 + 3*r^4
       wobei r = tr[0] + tr[1] *D^(1/2).
       transqnf_b8 ist ein static-Modul zu ecqnftatealg.
c*/

static nfel transqnf_b8( D, tr, b2, b4, b6, b8 )
int D;
nfel b2, b4, b6, b8;
single *tr;
{
    nfel b81, r, h;

    bind( D, b2, b4, b6, b8 );
    init( b81, r, h );

    if( tr[1] )
    {
	if( D_flag )
	{
	    r = list4( 2, 1, tr[1], 2 * tr[0] + tr[1] );
	}
	else
	{
	    r = list4( 1, 1, tr[1], tr[0] );
	}
    }
    else if( tr[0] )
    {
	r = list3( 1, 0, tr[0] );
    }
    else
    {
        return( b8 );
    }

    b81 = qnfiquot( D,  b2,  3 );
    b81 = qnfsum  ( D, b81,  r );
    b81 = qnfprod ( D, b81,  r );
    b81 = qnfsum  ( D, b81, b4 );
    b81 = qnfprod ( D, b81,  r );
    b81 = qnfsum  ( D, b81, b6 );
    b81 = qnfprod ( D, b81,  r );
    b81 = qnfiprod( D, b81,  3 );
    b81 = qnfsum  ( D, b81, b8 );

    return( b81 );
}

/**************   Ende von  t r a n s q n f _ b 8   ****************/

/*c
			qnfpol3numro( D, P, pi, z, a, b, c )

        "quadratic number field polynomial of degree 3, number of roots"
        static list qnfpol3numro( D, P, pi, z, a, b, c ) 
	    int D; list P; nfel pi, a, b, c; single z;
        L = qnfpol3numro( D, P, pi, z, a, b, c );
        qnfpol3numro ist static zu ecqnftatealg.
	Dabei gilt: D, P, pi, z wie in Dokumentation von ecqnfcPvalue.
	a, b, c sind Elemente aus K, die bzgl P ganz sind, d.h.
	v_P-Wert groesser oder gleich Null haben. 
	Sei h mit 0 <= h <= 3 die Anzahl der verschiedenen Nullstellen 
	des Polynoms f(X) = X^3 + a * X^2 + b * X + c im ganzen
	Abschluss von O_P, und seien x1,..., xh diese Nullstellen:
		     F(X) = (X-x1) * (x-x2) * (X-x3).
        Rueckgabe: 
	  ( 3, x1, x2, x3 ) falls h = 3 ist und x1, x2, x3 in O_P liegen,
          ( 3, x1 ) nfel x1; falls h = 3 ist und x1 in O_P und x2,
	         x3 nicht in O_P liegen,,
          ( 3 ), falls h = 3 ist und keines der xi in O_P liegt,
          ( 2, x1, x2 ) nfel x1, x2; falls h = 2 ist und x1 ( = x3)    
		 doppelte und x2 einfache Nullstelle von f(X) in O_P,
          ( 1, x1 ), falls h = 1 ist und x1 = x2 = x3 3-fache Nullstelle
		 von f(X) in O_P ist.
        Dabei sind x1, x2 bzw. x3 vom Typ nfel.
c*/

static list qnfpol3numro( D, P, pi, z, a, b, c )
int    D;
list   P;
single z;
nfel   pi, a, b, c;
{
    single h, i, j, x, y;
    list   L;
    nfel   x1, x2, x3;
    nfel omega;

    init( L );
    init( x1, x2, x3 );
    init(omega);
    bind( D, P, pi, a, b, c );

    L = qnfsysrmodpi( D, P, pi, z, 1 );

    x = lfirst ( L );
    y = lsecond( L );

    h  = 0;

    L = _0;

    if(D_flag) omega = list4(2,1,1,1);
    else       omega = list4(1,1,1,0);

    for( i = 0; i <= x; i++ )
    {
	x1 = list3( 1, 0, i );
        for( j = 0; j <= y; j++ )
        {
	    x2 = qnfsum ( D, x1,  a );
	    x2 = qnfprod( D, x2, x1 );
	    x2 = qnfsum ( D, x2,  b );
	    x2 = qnfprod( D, x2, x1 );
	    x2 = qnfsum ( D, x2,  c );

	    if( isqnfppihom0( D, P, 1, pi, z, x2 ) )
	    {
		/***   x1 Nullstelle   ***/
		h++;

		x2 = qnfiprod( D,  a,  2 );
		x3 = qnfiprod( D, x1,  3 );
	        x2 = qnfsum  ( D, x2, x3 );
	        x2 = qnfprod ( D, x2, x1 );
	        x2 = qnfsum  ( D, x2,  b );
	        if( isqnfppihom0( D, P, 1, pi, z, x2 ) )
	        {
		    /***   x1 mehrfache Nullstelle   ***/

		    x2 = qnfiprod( D, x1, 3 );
		    x2 = qnfsum(D,x2,a);
	            if( isqnfppihom0( D, P, 1, pi, z, x2 ) )
	            {
		        /***   x1 dreifache Nullstelle   ***/
			return( list2( 1, x1 ) );
	            }
		    else
		    {
		        /***   x1 doppelte Nullstelle   ***/
			if( L != _0 )
			{
			    /***   Nullstelle y != x1 bereits   ***/
			    /***   gefunden und in Liste L      ***/
			    /***  --> fertig!                   ***/
			    L = lcomp( x1, L );
			    L = lcomp( 2, L );
			    return( L );
			}
			else
			{
		            /***   x1 erste gefundene Nullstelle   ***/
			    h = -2;   /***   Dient zur Steuerung   ***/
			    L = list1( x1 );
			}
		    }
	        }
		else
		{
		    /***   x1 einfache Nullstelle   ***/

		    if( h < 0 )
		    {
			/***  Doppelte Nullstellle y != x1    ***/
			/***  bereits gefunden und in L.      ***/
			/***  --> fertig!                     ***/
			return( list3( 2, lfirst( L ), x1 ) );
		    }
		    else
		    {
			/***   Bisher nur einfache    ***/
			/***   Nullstellen gefunden   ***/
			L = lcomp( x1, L );
		    }
		}
	        if( h == 3 )
		{
		    /***   Alle 3 Nullstellen gefunden   ***/
		    return( lcomp( 3, L ) );
		}
	    }
	    x1 = qnfsum(D, x1, omega);
	}
    }
    if( h )
    {
	/***   Eine einfache Nullstelle x1 gefunden   ***/
	/***   ==> 3 verschiedene Nullstellen         ***/
	return( lcomp( 3, L ) );
    }
    return( list1( 3 ) );
}

/**************   Ende von  q n f p o l 3 n u m r o   **************/

/*c
           	    qnfpol2rinOP( D, P, pi, z, a, b, c )

        "quadratic number field polynomial of degree 2, are roots in O_P?"
        static single qnfpol2rinOP( D, P, pi, z, a, b, c ) 
	    int D; list P; nfel pi, a, b, c; single z;
        s = qnfpol2rinOP( D, P, pi, z, a, b, c );
        qnfpol2rinOP( ist static zu ecqnftatealg.
	Dabei muss gelten:
	  - D ist aus Z\{0,1} und quadratfrei
	  - P = ( p, pi, e )  int p; nfel pi; single e; ist ein
	    Primideal im Ganzheitsring von K = Q(D^(1/2)). P setzt p auf
	    K fort, wobei pi eine zugehoerige Ortsuniformisierende ist
	    und e das Zerlegungsgesetz von p in K angibt. (e = 1, 2 
	    oder 3, falls p in K traege, verzweigt bzw. zerlegt ist.)
	  - a, b, c sind Elemente aus K, die bzgl P ganz sind, d.h.
	    v_P-Wert groesser oder gleich Null haben. 
        qnfpol2rinOP ueberprueft, ob die Nullstellen des Polynoms 
	     f(X) = a X^2 + b X + c  in O_P[X]
        in O_P liegen. 
        Rueckgabe: 1, falls die Nullstellen von f(X) in O_P liegen,
 		   0, sonst.
c*/

static qnfpol2rinOP( D, P, pi, z, a, b, c )
int    D;
list   P;
nfel   pi, a, b, c;
single z;
{
    single h, i, j, x, y;
    list   L;
    nfel   x1, x2;
    nfel omega;

    init( L );
    init( x1, x2 );
    init( omega );
    bind( D, P, pi, a, b, c );

    L = qnfsysrmodpi( D, P, pi, z, 1 );

    x = lfirst ( L );
    y = lsecond( L );

    if(D_flag) omega = list4(2,1,1,1);
    else       omega = list4(1,1,1,0);

    for( i = 0; i <= x; i++ )
    {
	x1 = list3( 1, 0, i );
        for( j = 0; j <= y; j++ )
        {
	    x2 = qnfprod( D, x1,  a );
	    x2 = qnfsum ( D, x2,  b );
	    x2 = qnfprod( D, x2, x1 );
	    x2 = qnfsum ( D, x2,  c );

	    if( isqnfppihom0( D, P, 1, pi, z, x2 ) )
	    {
		/***   x1 und conj(x1) Nullstellen in O_P   ***/
		return( 1 );
            }
	    x1 = qnfsum( D, x1, omega );
        }
    }
    return( 0 );
}

/**************   Ende von  q n f p o l 2 i n O P   ****************/
