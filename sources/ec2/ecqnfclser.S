/*M
.SH NAME
ecqnfclser - elliptic curve over quadratic number field coefficients of
L-series 

.SH SYNOPSIS
.nf
# include <_ec2.h>

list ecqnfclser(E,n)
list E;
single n;

.SH DESCRIPTION
ecqnfclser() determines the first n coefficients of the L-series of E over the 
quadratic number field K=Q(sqrt(d)). The return value is a list L=(A,C) with
arrays A and C. The value A[m] is a list containing the coefficients of the
L-series at ideals with norm m. The value C[m] is the sum over all
values in A[m].
.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
.TP 4
.B n
is a single precision number.
M*/
/*H
        Version 1       27.08.1998      S. Schmitt
   DATE ecqnfclser     :   980830
H*/



#include <_ec2.h>

#define SoL    sizeof( list )
#define SoS    sizeof( single )

single *add;

/*****************************************************************************/
/***                                                                       ***/
/***   B e g i n n i n g   o f   t h e   s t a t i c   f u n c t i o n s   ***/
/***                                                                       ***/
/*****************************************************************************/
/*c 
	         shortfact( n, p, e, f, q ) 

        static shortfact( n ) single n;
        s = shortfact( n );
	Es muss gelten: n > 1.
	shortfact( n ) folgende Faktorisierung fuer n:
	     n = (*q) * (*f), *q = (*p)^(*e),
	wobei *p die kleinste Primahl ist, die n teilt, und (*p, *f) = 1.
	Rueckgabe: s = 0.
c*/
/*H     
	Version 1	12.11.1992	Josef Gebel.
H*/     


static shortfact( n, p, e, f, q )
single n, *p, *e, *f, *q;
{
    *e = 0;
    *f = n;
    *q = 1;
    *p = 2;
  
    while( !( (*f) & 01 ) )
    {
	(*f) >>= 1;
	(*q) <<= 1;
        (*e)++;
    }
    if( *e )
    {
        return( 0 );
    }
    else
    { 
        single r;

        *p = 3;

        while( 1 )
        {
            while( 1 )
            {
                iqrem( n, *p, f, &r );
                if( r )
                {
                    *f = n;
                    if( *e )
	            {
                        return( 0 );
                    }
                    break;
                }
                n = *f;
                *q *= *p;
                (*e)++;
            }
            if( *p == 3 )
            {
                *p = 5;
            }
            else
            {
                *p = 7;
                break;
            }
        }
        {
            single i, s;
            extern single *add;

            s = 1;
            while( *f )
            {
	        (*f) >>= 2;
	        s <<= 1;
            }
	    /*   s = 2^(log_2(n)/2) s ~ sqrt( n ),    */
        
            i = 0;
        
            while( 1 )
            {
                while( 1 )
                {
                    iqrem( n, *p, f, &r );
                    if( r )
                    {
                        *f = n;
                        if( *e )
	                {
                            return( 0 );
                        }
                        break;
                    }
                    n = *f;
                    *q *= *p;
                    (*e)++;
                }
            
                *p += add[i++];
	        i &= 0111;  /* i := i mod 8 */
        
                if( s < *p )
                {
		    /*   Keine Primteiler p von n gefunden    */
		    /*   mit p <= sqrt(n)  ==>  n prim        */
                    *p = *q = n;
                    *e = *f = 1;
                    return( 0 );
                }
            }
        }
    }
}

/**************   Ende von  s h o r t f a c t   ***************/


/*c
		ecqnflrt(d,E)

	"elliptic curve over quadratic number field, list of reduction
	 types"
c*/

static list ecqnflrt(d,E)
int d;
list E;
{
	list L,FD,P;
	nfel pi;
	int p;
	single z,r;

	init(L,FD,P,pi,p);
	bind(d,E);

	pi = ecqnfacdisc(E);
	FD = qnfpifact(d,pi);
	
	L = _0;
	while(FD!=_0)
	{
		P = lfirst(FD);
		pi = lthird(FD);
		z = lfourth(FD);
		FD = lred4(FD);

		p = qnfidprime(P,pi,z);
		r = ecqnfrt(E,p,P,pi,z);
		L = lcomp3(p,P,r,L);

	}
	return(L);
}

/*****************************************************************************/
/***                                                                       ***/
/***         E n d   o f   t h e   s t a t i c   f u n c t i o n s         ***/
/***                                                                       ***/
/*****************************************************************************/

extern list A[5500];
extern single C[5500];

single ecqnfclser( E, n )
list E;                                    
single n;
{
        single j,m,e,p,q,f;
	list L,H,P,RT;
	int d;
    
        extern single *add;

        bind( E );
	bind(A[0..n]);
	bind(C[0..n]);
	init(L,H,P,RT,d);

        if( ( add = ( single * ) malloc( 8 * SoS ) ) == NULL )
        {
	    /*   Fehler beim Allokieren   */
            return( 0 );
        }
        add[0] = 4;
        add[1] = 2;
        add[2] = 4;
        add[3] = 2;
        add[4] = 4;
        add[5] = 6;
        add[6] = 2;
        add[7] = 6;

/** sind die nicht schon berechnet? **/

	A[0] = n;
	A[1] = list1(1);
	C[0] = n;

	d = ecqnfflddisc(E);
	RT = ecqnflrt(d,E);

	/** A[j] = (c(a1),..., c(an)) mit C[j] =c(a1)+...+c(an) 
		enthaelt die c(\a) fuer alle \a mit Norm j **/

	for(j=2;j<=n;j++)	/** j ist die Norm der Ideale. **/
	{	
		L = _0;
		shortfact(j,&p,&e,&f,&q);	/** j = p^e*f **/

		if(f==1)			/** j = p^e **/
		{
			m = qnfnoidgn(d,p,e);
			if(m)
			{	
				P = qnfpifact(d,itonf(p));
				f = ecqnfreddec(E,P,p,RT);
				L = ecqnfclpp(E,P,p,e,q,m,f,n);
			}
		}
		else				/** j = q*f **/
		{
			L = lcopy(A[q]);
			if(L!=_0)
			{
				H = lcopy(A[f]);
				if(H!=_0)
				{
					L = liprod(L,H);
					L = linv(L);
				}
				else L=_0;		

			} /** falls es keine gibt, kann es auch keine mit
				Norm j geben. **/
		}	

		A[j] = lcopy(L);
	}
	for(j=1;j<=n;j++)
	{
		L = lcopy(A[j]);
		if(L!=_0) C[j] = lisumoe(L);
		else 	  C[j] = 0;
	}
		

    return( 1 );
}

/***************   Ende von  e c q n f c l s e r   ****************/
