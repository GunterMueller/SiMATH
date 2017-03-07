/*M
.SH NAME
ecracsaip - curve over the rational numbers, actual model, search for all integral points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecracsaip(E)
list E;

.SH DESCRIPTION
ecracsaip() returns the list L = ( P1  L1  ...  Pk  Lk ); list P1, L1, ..., Pk, Lk;
of all integral points P1, ..., Pk on the actual model of E/Q
together with their linear combination with respect to the torsion 
group and the basis contained in the list E. If an error condition
occurs, the result will be L = ( 0 ).
.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.


.SH EXAMPLE
.nf
Let (T0 = O, T1, ..., Tt) be the torsion subgroup, 
let rank(E/Q)=2 and let (B1, B2) be the basis of
the actual model contained in the list E.
Then L1 = ( 0 1  2 ), P1 =  O + 1 * B1 + 2 * B2,
     L2 = ( 1 0 -1 ), P2 = T1 - 1 * B2.

.SH NOTE
ecracsaip() uses the global double variable _H_BOUND, which equals 0.0 by default.
If _H_BOUND is positive then the height in the search for points
in ecisnfpbwh() will be limited by _H_BOUND.
For _H_BOUND = 0.0 the search is not limited but
for most applications _H_BOUND = 11.0 is sufficient.

.SH REFERENCES
J. Gebel, A. Pethoe and H. G. Zimmer, "Computing Integral Points on Elliptic Curves",
Acta arithmetica 68 (1994) 171-192.

.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1       22.02.1994      Josef Gebel
	Version 2	21.11.1994	ECIMINMWGBASE -> ECIMINBMWG. MP
	Version 3	17.10.1995	ECRACTOECIMIN -> ECRACTOIMIN JG
	Version 4	07.12.1996	Replacemant of the constant ETA by 
                                        a smaller value;
                                        Contruction of the list F in
                                        the `new model' case changed. JG

   DATE ecracsaip     : 941201.951201
H*/

#include <_ec2.h> 

#define EPSILON 0.000000001
#define ETA Cfltofl( EPSILON )
#define EPS Cfltofl( 0.1 )

/**************************************************************/
/***              S T A T I C   F U N C T I O N S           ***/
/**************************************************************/

/*c
      static single get_u_p( A4, A6, p ) int A4, A6; single p;
      e = get_u_p( A4, A6, p );
      e = 1, if p^4 | A4 and p^6 | A6
          0  otherwise.
c*/

static get_u_p( A4, A6, p )
int A4, A6;
single p;
{
    single e4, e6;
    int a4, a6;

    init( a4, a6 );
    bind( A4, A6 );

    a4 = A4;
    a6 = A6;

    e4 = 0;
    e6 = 0;
        
    if( a4 )
    {
        while( !mihom( p, a4 ) )
        {
            a4 = isquot( a4, p );
            e4++;
        }
    }
    else
    {
        e4 = 4;
    }
    if( e4 > 3 )
    {
        if( a6 )
        {
            while( !mihom( p, a6 ) )
            {
                a6 = isquot( a6, p );
                e6++;
            }
        }
        else
        {
            e6 = 6;
        }
    }

    if( e6 < 6 )
    {
        return( 0 );
    }
    return( 1 );
}
/***** End of get_u_p ***************************************************/

/***** Begin of get_icoef ***********************************************/
/** Makes model integral  SS Trafo **/

list get_icoef(a1,a2,a3,a4,a6)
rat a1,a2,a3,a4,a6;
{	
	single e;
	int u,v,h;
	int a1i,a2i,a3i,a4i,a6i;
	list L;

	init(u,v,h);
	init(a1i,a2i,a3i,a4i,a6i);
	init(L);
	
	bind(a1,a2,a3,a4,a6);

	u=rden(a1);
	if(u!=1)			/** Trafo mit u=rden(a1) **/
	{	a1i=rnum(a1);	
		h=iprod(u,u);
		a2=rprod(a2,itor(h));
		h=iprod(h,u);
		a3=rprod(a3,itor(h));
		h=iprod(h,u);
		a4=rprod(a4,itor(h));	
		h=iprod(h,u);
		h=iprod(h,u);
		a6=rprod(a6,itor(h));	
	}
	else a1i = rnum(a1);
	v=rden(a2);
	if(v!=1)			/** Trafo mit h*sqrt(v), hv=rden(a2) **/
	{	h=isfp(v);	
		v=iquot(v,u);
		v=isqrt(v);
		v=iprod(v,h);

		a1i=iprod(a1i,v);
		h=iprod(v,v);
		a2=rprod(a2,itor(h));
		a2i=rnum(a2);
		h=iprod(h,v);
		a3=rprod(a3,itor(h));
		h=iprod(h,v);
		a4=rprod(a4,itor(h));	
		h=iprod(h,v);
		h=iprod(h,v);
		a6=rprod(a6,itor(h));	

		u=iprod(u,v);
	}
	else a2i = rnum(a2);
	v=rden(a3);
	if(v!=1)
	{	L=ifact(v);
		L=ifel(L);
		v=1;
		while(L!=_0)
		{	h=lfirst(L);
			e=lsecond(L);
			L=lred2(L);
			if(mshom(3,e)) v=iprod(v,h);
			e=iquot(e,3);
			while(e--) v=iprod(v,h);
		}

		a1i=iprod(a1i,v);
		h=iprod(v,v);
		a2i=iprod(a2i,h);
		h=iprod(h,v);
		a3=rprod(a3,itor(h));
		a3i=rnum(a3);
		h=iprod(h,v);
		a4=rprod(a4,itor(h));	
		h=iprod(h,v);
		h=iprod(h,v);
		a6=rprod(a6,itor(h));	

		u=iprod(u,v);
	}
	else a3i = rnum(a3);
	v=rden(a4);
	if(v!=1)
	{	L=ifact(v);
		L=ifel(L);
		v=1;
		while(L!=_0)
		{	h=lfirst(L);
			e=lsecond(L);
			L=lred2(L);
			if(mshom(4,e)) v=iprod(v,h);
			e=iquot(e,4);
			while(e--) v=iprod(v,h);
		}

		a1i=iprod(a1i,v);
		h=iprod(v,v);
		a2i=iprod(a2i,h);
		h=iprod(h,v);
		a3i=iprod(a3i,h);
		h=iprod(h,v);
		a4=rprod(a4,itor(h));	
		a4i=rnum(a4);
		h=iprod(h,v);
		h=iprod(h,v);
		a6=rprod(a6,itor(h));	

		u=iprod(u,v);
	}
	else a4i = rnum(a4);
	v=rden(a6);
	if(v!=1)
	{	L=ifact(v);
		L=ifel(L);
		v=1;
		while(L!=_0)
		{	h=lfirst(L);
			e=lsecond(L);
			L=lred2(L);
			if(mshom(6,e)) v=iprod(v,h);
			e=iquot(e,6);
			while(e--) v=iprod(v,h);
		}

		a1i=iprod(a1i,v);
		h=iprod(v,v);
		a2i=iprod(a2i,h);
		h=iprod(h,v);
		a3i=iprod(a3i,h);
		h=iprod(h,v);
		a4i=iprod(a4i,h);
		h=iprod(h,v);
		h=iprod(h,v);
		a6=rprod(a6,itor(h));	
		a6i=rnum(a6);

		u=iprod(u,v);
	}
	else a6i = rnum(a6);
	return(list6(a1i,a2i,a3i,a4i,a6i,u));
}
	


/***** End of get_icoef *************************************************/

list ecracsaip( E )
list E;
{
    rat  v;
    single gt;   /** SS Trafo **/
    list B, F, L, M, P;
     
    bind( E );

    init( v );
    init( B, F, L, M, P );

    L = ecractoimin( E );
    B = lsecond( L );

    /** SS Trafo Anfang **/  /** Man koennte das hier noch verbessern,
			         indem man die Gleichung nur dann ganz 
				 macht, wenn gewisse ggT's > 1 sind.
				 Wie z.B. ggT(rnum(u),rden(r)) usw. **/

    gt=0;
    v = lfirst( B );    /** r **/
    if(rden(v)==1)
    {	v = lsecond( B );   /** s **/
    	if(rden(v)==1)
	{   v = lthird( B );   /** t **/
    	    if(rden(v)==1)
    	    {    v = lfourth( B );  /** u **/
		 if(rnum(v)==1) gt=1;
	    }
	}
    }

    /**  if( rnum( v ) == 1 ) Das stand vorher da **/

    if(gt) 	/** SS Trafo erst mal Ende **/
    {
        /***   `current model case'                                     ***/
        /***   In this case, the transformation from the actual to the  ***/
        /***   short model of E/Q, contained in the list E, is of the   ***/
        /***   form ( r  s  t  u ) with u = 1/u2, u2 in Z.              ***/
        /***   Let ( x, y ) be an integral point on the actual model.   ***/
        /***   Then the corresponding point ( X, Y ) on the short model ***/
        /***   (contained in the list E) will also be integral and thus ***/
        /***   the set of all integral points on the short model in E   ***/
        /***   contains the (corresponding) set of all integral points  ***/
        /***   on the actual model. The integral points on the short    ***/
        /***   model only have to be transformed to the actual model    ***/
        /***   and there be tested for intgrality.                      ***/

	/***   SS Trafo: we only get to this case, if r,s,t are  	***/
	/***   integral and u=1/u2, u2 in Z.                            ***/

        M = ecisnfsaip( E );
        B = ecisnfbtac( E );
    }
    else
    {
        /***   `new model case'                                         ***/
        /***   The coefficient u of the  birational transformation      ***/
        /***   ( r  s  t  u ) from the actual model to the minimal      ***/
        /***   is  u = u1 / u2 with u1, u2 in Z and u1 > 1.             ***/
        /***   Thus we cannot use the short WNF-model contained in      ***/
        /***   the list E since we could lose some integral points      ***/
        /***   by working on this model because the transformation      ***/
        /***   to the sWNF model transforms points of the form (x, y)   ***/
        /***   on the actual model with gcd(x, u1) = 1 to points        ***/
        /***   ( x'/u1^2, y'/u1^3 ) which will not be recognized as     ***/
        /***   integral points on the sWNF model and thus neither on    ***/
        /***   the actual model.                                        ***/
        /***   That's why we have to find another short model for E     ***/
        /***   First we transform E such that all coefficients become   ***/
        /***   integral:
        /***   ( a1  a2  a3  a4  a6 ) --> ( a1i  a2i  a3i  a4i  a6i )   ***/
        /***   Then we use a quasiminimal model for these coefficients  ***/
        /***   to compute all integral points on this (integral) model  ***/
        /***   As above, we transform these points to back to the       ***/
        /***   actual model and test whether they are integral or not.  ***/

   	/***   SS Trafo: We get to this case, if r,s,t are not 		***/
	/***   integral or if u=u1/u2, u1>1. The model must be made 	***/
	/***   integral by multiplication with the denominators of the	***/
	/***   ai's. Then we can go on.					***/

        int A4, A6, a1, a2, a3, a4, a6, h;
        rat r, s, t, u;

        init( A4, A6, a1, a2, a3, a4, a6, h );
        init( r, s, t, u );

        /***    Make model integral  ***/
        /**t  = itor( rden( u ) ); ORIG SS **/

	/**** Das stand da: SS Trafo 
        t  = itor( rden( v ) );
        r  = ecraca1( E );
        r  = rprod( r, t );
        a1 = rnum( r );
        r  = ecraca2( E );
        s  = rprod( t, t );
        r  = rprod( r, s );
        a2 = rnum( r );
        r  = ecraca3( E );
        s  = rprod( s, t );
        r  = rprod( r, s );
        a3 = rnum( r );
        r  = ecraca4( E );
        s  = rprod( s, t );
        r  = rprod( r, s );
        a4 = rnum( r );
        r  = ecraca6( E );
        s  = rprod( s, t );
        s  = rprod( s, t );
        r  = rprod( r, s );
        a6 = rnum( r );

 	so, Kommentar zu Ende  SS Trafo ***/

	/***  SS Trafo: Das ist neu: ***/

	v = ecraca1( E );
	r = ecraca2( E );
	s = ecraca3( E );
	t = ecraca4( E );
	u = ecraca6( E );

	B=get_icoef(v,r,s,t,u);
	a1=lfirst(B);
	a2=lsecond(B);
	a3=lthird(B);
	a4=lfourth(B);
	a6=lfifth(B);
	h=lsixth(B);

	v = rcons( 1, h );	/** braucht man spaeter wieder **/

	/*** SS Trafo: Jetzt ist das Neue auch zu Ende ***/

        M = ecitavalc( a1, a2, a3, a4, a6 );

        A4 = lfirst( M );
        A4 = isprod( A4, -27 );
        /***   A4 = -27 * c4   ***/

        A6 = lsecond( M );
        A6 = isprod( A6, -54 );
        /***   A6 = -54 * c6   ***/

        u = rcons( 1, 6 ); 

        /***   Make A4 and A6 as small as possible ('quasiminimal')      ***/
        if( get_u_p( A4, A6, 2 ) )
        {
            if( A4 )
            {
                A4 = isquot( A4, 16 );
            }
            if( A6 )
            {
                A6 = isquot( A6, 64 );
            }
            u = rprod( u, itor( 2 ) );
        }

        if( get_u_p( A4, A6, 3 ) )
        {
            if( A4 )
            {
                A4 = isquot( A4, 81 );
            }
            if( A6 )
            {
                A6 = isquot( A6, 729 );
            }
            u = rprod( u, itor( 3 ) );
        }

        /***   Find birational transformation between    ***/
        /***   quasiminmal model and actual model        ***/
    /**    a6 = iprod( a2, a2 ); entfernt SS **/
    /**    a4 = isprod( a6, 4 ); ORIG SS **/
	a4 = isprod( a2, 4);
        h  = iprod( a1, a1 );
        h  = isum (  h, a4 ); /***   h = b2   ***/

        r = itor( ineg( h ) );
        r = rquot( r, itor( 12 ) );

        s = itor( ineg( a1 ) );
        s = rquot( s, itor( 2 ) );

        t = itor( iprod( a1, h ) );
        t = rquot( t, itor( 12 ) );
        t = rdif ( t, itor( a3 ) );
        t = rquot( t, itor(  2 ) );

        M = list4( r, s, t, u );	/** TRAFO ICOEF -> QM **/
	L = list4( 0, 0, 0, v );	/** SS Trafo: TRAFO AC_E -> ICOEF **/
	M = ecrbtconc( L, M );	  /** SS Trafo: TRAFO AC_E -> ICOEF -> QM **/

        P = eciminbmwg( E );
        F = lcopy( E );

        L = lfirst( F );
        P = lsixth( L );
      
        if( P == _0 )
        {
            P = list2( _0, M );
        }
        else
        {
            leset( P, 2, M );
        }
        leset( L, 6, P );
        leset( F, 1, L ); 		/** TRAFO AC->QM eingebaut **/

        P = eciminbtac( F );		/** TRAFO MIN->AC **/
        M = ecrbtconc( P, M );		/** TRAFO MIN->AC->QM **/
        L = lsecond( F ); 
        P = lsixth( L );
      
        leset( P, 2, M );
        leset( L, 6, P );
        leset( F, 2, L );

        M = ecracbtsnf( F );
        M = ecrbtinv( M );
        L = eciminbtsnf( F );
        L = ecrbtinv( L );
        P = list2( M, L );
        M = list2( A4, A6 );
        L = list6( _0, _0, _0, P, _0, _0 );
        L = lcomp2( M, _0, L );
     
        leset( F, 3, L );
    
        M = ecisnfsaip( F );
        B = ecisnfbtac( F );		/** TRAFO QM -> AC **/
    }
        
    /***   F:  Y^2 = X^3 + A4 * X + A6    is a short Weierstrass model  ***/
    /***   for E and we have: P is an integral point on E   ==>         ***/
    /***   the correspondingpoint P' on F is also integral.             ***/
    /***   Thus we only have to find all integral points on the model F ***/
    /***   and check if their transformations to E are still integral.  ***/

    L = _0;

    while( M != _0 )
    {
        P = lfirst( M );
        P = ecrbtp( P, B );
        if( lthird( P ) == 1 )
        {
            L = lcomp( P, L );
            P = lsecond( M );
            L = lcomp( P, L );
        }
        M = lred2( M );
    }

    /** if( rnum( v ) != 1 )  SS Trafo: habe diese Zeile geaendert in: **/
    if( !gt )
    {
        /***   All the computations have been done on the list F and    ***/
        /***   not on E. Transform all the results in the list F that   ***/
        /***   were gained during the computation (as rank, basis,      ***/
        /***   torsion group, periods, j-invariant) into the list E     ***/
        /***   in order to avoid multiple computations if one wants     ***/
        /***   to keep on working with E after this computation.        ***/

	/** SS Trafo: ab hier bis zum bitteren Ende: alles durchgearbeitet,
	    ob die Trafo's richtig sind. Eigentlich nicht all zu viel
	    geaendert. Nur einige Kommentare. Bei min. model auch die
	    Torsionsgruppe dazu gemacht. 				***/

	/** transform the torsiongroup of F to E **/
	/** Tors(QM) -> Tors(AC) **/

  	M = ecisnftorgr( F );
  	P = ecisnfgentor( F );
  	M=ecrbtlistp(M,B,0);
  	P=ecrbtlistp(P,B,0);
  	B=lfirst(E);		
  	leset(B,5,list2(M,P));
  	leset(E,1,B);


	/** Tors(AC) -> Tors(SNF) **/	

	B=ecracbtsnf( E );
	M=ecrbtlistp(M,B,0);
	P=ecrbtlistp(P,B,0);
        B = lthird( E );
        leset( B, 5, list2( M, P ) );
        leset( E, 3, B );

	/** new min. model **/
	/** Tors(SNF) -> Tors(MIN) **/

	B=ecisnfbtmin(E);
	M=ecrbtlistp(M,B,0);
	P=ecrbtlistp(P,B,0);
	P=list2(M,P);
        M = lsecond( F );
        leset( M, 5, P );		/** Tors **/

        P = lsixth( M );
        B = eciminbtsnf( E );
        leset( P, 2, B );
       /** leset( M, 5, _0 ); **/
        leset( M, 6, P );		/** right transformation **/
        leset( E, 2, M );

	/** invariants **/
        
        M = lfourth( F );
        leset( E, 4, M );
    }

    return( linv( L ) );
}
