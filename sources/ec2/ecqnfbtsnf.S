/*M
.SH NAME 
ecqnfbtsnf - elliptic curve over quadratic number field birational 
transformation to short normal form

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfbtsnf(E)
list   E;

.SH DESCRIPTION
ecqnfbtsnf() returns the birational transformation BT=(r, s, t, u) with
number field elements r,s,t,u. The transformation BT transforms the 
actual model of the curve E to a model in short normal form. If the
transformation is not yet computed, it will be stored in E.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
        Version 1       23.03.1998      S. Schmitt
   DATE ecqnfbtsnf     :  980323
H*/

# include <_ec2.h>

/*c
		    getdencoeff( a, i, f )

	"get denominator of coefficient"
	Quellbibliothek: srclib.ec2
	Include-Datei:   _ec2.h
	static int getdencoeff( a, i, f ) nfel a; single i, f;
	N = getdencoeff( a, i, f );
	a = ai ist der i-te Koeffizient einer elliptischen Kurve
	E ueber dem quadratischen Zahlkoerper Q(D^(1/2)).
	f = 1, falls D == 1 mod 4; 0 sonst.
	getdencoeff liefert eine naturliche Zahl N, fuer die gilt:
	    a * N^i in O_D, O_D = Ganzheitsring von Q(D^(1/2)),
	getdencoeff ist static zu ecqnftoeci. 
c*/

static int getdencoeff( a, i, f )
nfel a;
single i, f;
{
    int N;

    init( N );
    bind( a );

    N = lfirst( a );

    if( f )
    {
	if( lsecond( a ) )
	{
            if( mshom( 2, N ) == 0 )
	    {
		if( mshom( 2, lthird( a ) ) &&  mshom( 2, lfourth( a ) ) )
		{
		    N = iquot( N, 2 );
		}
	    }
	}
    }
    if( ( i != 1 ) && ( N != 1 ) )
    {
	list L;
	int p;
	single e;

	init( L, p );

	L = ifact( N );
	L = ifel ( L );
	N = 1;

	while( L != _0 )
	{
	    e = ( lsecond( L ) + i - 1 ) / i;
	    p = lfirst ( L );
           
            while( e )
	    {
		e--;
		N = iprod( N, p );
	    }

	    L = lred2( L );
	}
    }
    return( N );
}


list ecqnfbtsnf( E )
list E;
{
    if( ( lsixth( lfirst( E ) ) == _0 )
    || ( lsecond( lsixth( lfirst( E ) ) ) == _0 ) )
    {
	/*   Birationale Transformation BTrs noch nicht berechnet   */
    
        list BT,L;
	int d,u,n;
	nfel a1,a2,a3,a4,a6,r,s,t,h;
	nfel a4s,a6s;

        bind( E );
        init( BT,L );
	init(d,u,n);
	init(a1,a2,a3,a4,a6,r,s,t,h);
	init(a4s,a6s);

	BT = lfirst(lfirst(E));
	a1 = lfirst(BT);
	a2 = lsecond(BT);
	a3 = lthird(BT);
	a4 = lfourth(BT);
	a6 = lfifth(BT);

	d = ecqnfflddisc(E);

	/** Berechnung der s,r,t **/

	s = qnfneg(d,a1);
	s = qnfiquot(d,s,2);
	
	r = qnfsum(d,s,a1);
	r = qnfprod(d,r,s);
	r = qnfdif(d,r,a2);
	r = qnfiquot(d,r,3);

	t = qnfprod(d,r,a1);
	t = qnfsum(d,t,a3);
	t = qnfiquot(d,t,2);
	t = qnfneg(d,t);

	/** Berechnung von u^iai' mit i=4,6. a1'=a2'=a3'=0 **/

	h = qnfsum(d,r,r);
	h = qnfsum(d,h,r);
	h = qnfsum(d,h,a2);
	h = qnfsum(d,h,a2);
	a4s = qnfprod(d,h,r);	/** 2a_2r + 3r^2 **/
	h = qnfprod(d,r,a1);
	h = qnfsum(d,h,t);
	h = qnfsum(d,h,t);
	h = qnfsum(d,h,a3);
	h = qnfprod(d,h,s);	/** sa_3 + sra_1 + 2st **/
	a4s = qnfdif(d,a4s,h);
	h = qnfprod(d,t,a1);
	a4s = qnfdif(d,a4s,h);
	a4s = qnfsum(d,a4s,a4);
	
	a6s = qnfsum(d,a2,r);
	a6s = qnfprod(d,a6s,r);
	a6s = qnfsum(d,a6s,a4);
	a6s = qnfprod(d,a6s,r);
	a6s = qnfsum(d,a6s,a6);	/** a6 + ra4 + r^2a2 + r^3 **/
	h = qnfprod(d,r,a1);
	h = qnfsum(d,h,a3);
	h = qnfsum(d,h,t);	
	h = qnfprod(d,h,t);	/** a3t + ra1t + t^2 **/
	a6s = qnfdif(d,a6s,h);

	/** getdencoeff ist static zu ecqnftoeci. Wenn Sebp das 
	richtig programmiert hat, gibt es eine natuerliche Zahl n
	zurueck mit a*n^i ganz. **/

	n=1; u=1;

	if(m4hom(d)==1)
	{	
		if(!isqnfiel(d,a4s)) u = getdencoeff(a4s,4,1);
		if(!isqnfiel(d,a6s)) n = getdencoeff(a6s,6,1);
	}
	else
	{	
		if(!isqnfiel(d,a4s)) u = getdencoeff(a4s,4,0);
		if(!isqnfiel(d,a6s)) n = getdencoeff(a6s,6,0);
	}
	n = ilcm(n,u); /** also n^iais ist ganz. **/

	h = itonf(1);
	h = qnfiquot(d,h,n);

	/** Eintrag der ais **/

	n = iprod(n,n);
	u = iprod(n,n);
	a4s = qnfiprod(d,a4s,u);
	u = iprod(u,n);
	a6s = qnfiprod(d,a6s,u);

	BT = list2(a4s,a6s);
	L = lthird(E);
	if(L==_0) 
	{
		L = list6(_0,_0,_0,_0,_0,_0);
		L = lcomp(_0,L);
	}
	leset(L,1,BT);
	leset(E,3,L);

	/** Eintrag der Transformationen **/

	BT = list4(r,s,t,h);
	L = lfirst( E ); 
	leset( L, 6, list2( _0, BT ) );
	leset(  E, 1, L );
	
	return( BT );
    }
    
    return( lsecond( lsixth( lfirst( E ) ) ) );
}   
