/*M
.SH NAME
eqisnfpnp - elliptic curve over quadratic number field with integral coefficients, short normal form, number modulo prime ideal

.SH SYNOPSIS
.nf
#include<_ec2.h>

list  eqisnfpnp(E, P, pi, z)
list   E, P;
nfel pi;
single z;

.SH DESCRIPTION
eqisnfpnp() returns the number of points of an elliptic curve E over a quadratic
number field K = Q(D^(1/2)) modulo a prime ideal.
.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod'). The prime ideal P divides a prime number not equal to 2.
.TP 4
.B pi
is a prime element of the prime ideal P.
.TP 4
.B z
is = 0,1, or 2, if the prime ideal P divides an inert, ramified or split prime
number in Q.
M*/
/*H
        Version 1       31.07.1998      S. Schmitt
   DATE eqisnfpnp     : 980731
H*/


# include <_ec2.h>



/**************************************************************************/    
/***                 s t a t i c   f u n c t i o n s                    ***/
/***                      ( B e g i n n i n g )                         ***/
/**************************************************************************/
                                                                                
/*c
		qnfpitquad1(D,p,A) 
	
	"quadratic number field prime ideal table of quadrats"

	Berechnet die Tabelle der Quadrate modulo dem Ideal ueber p
	(muss traege sein!) fuer omega = sqrt{d}.
c*/
	
static single qnfpitquad1(D,p,A)
int D;
single p;
char **A;
{
    	single l,a,b,ps,u,v;	  
	single zd,zv;
	single c,d;

	bind(D);
    
        **A = ( char ) 1;   /** A[0][0] **/

    	l = p >> 1;         /*  l = [p/2]  */

	/** Quadrate u^2, 1<=u<=(p-1)/2 **/

    	u = 0; 
	a = 0;
    	while(u <= l)
    	{
		a += u;  /* Berechnung von ( u+1 )^2 aus u^2: */
		u++;     /* (u+1)^2 = u^2 + u + (u+1)         */
		a += u;  
		while( a >= p ) a -= p;
	
        	*(*(A +a)) = ( char ) 2;   /* A[a][0] */
    	}

	/****************************************************************/
	/** Es ist (u + v w)^2 = a[u,v] + b[u,v] w mit                 **/
	/**                                                            **/
	/** a[u,v] = u^2 + dv^2,   a[u+1,v] = a[u,v] + u + (u+1) und   **/
	/** b[u,v] = 2uv           b[u+1,v] = b[u,v] + 2v              **/
	/** Dabei ist                                                  **/
	/** a[0,v] = dv^2 = c[v] mit c[v+1] = c[v] + d[v] mit          **/
	/**        d[v] = d(2v+1), d[v+1] = d[v] + 2d    	       **/
	/** b[0,v] = 0                                                 **/
	/****************************************************************/

	ps = p-1;
   
	v = 0;    
	d = mshom(p,D);
	D = isum(D,D);
    	zd = mshom(p,D);	/** 2D **/
	zv = 0;
	c = 0;
	while(v<=l)
	{
		zv += 2;	/** 2v **/
		v++;

		/** c[v+1] **/
		c += d;
		while(c>=p) c-=p;

		/** d[v+1] **/
		d += zd;
		
		u = 0;
		a = c;
		b = 0;
       		*((*(A+a))+b) = (char) 2;  /** A[a][b] **/

		while(u<=ps)
    		{
			/** a[u+1,v] **/
			a += u;  	
			u++;     
			a += u;  
			while( a >= p ) a -= p;

			/** b[u+1,v] **/
			b += zv;	 
			while( b >= p ) b -= p;

        		*((*(A+a))+b) = (char) 2;  /** A[a][b] **/
		}
	}

    return(0);
}


/*****************************************************************************/
                                                                                
/*c
		qnfpitquad2(D,p,A) 
	
	"quadratic number field prime ideal table of quadrats"

	Berechnet die Tabelle der Quadrate modulo dem Ideal ueber p
	(muss traege sein!) fuer omega = (1+sqrt{d})/2.
c*/
	
static single qnfpitquad2(D,p,A)
int D;
single p;
char **A;
{
    	single l,a,b,ps,u,v;	  
	single ds,zv,zds;
	single c,d,e;

	bind(D);
    
        **A = ( char ) 1;   /** A[0][0] **/

    	l = p >> 1;         /*  l = [p/2]  */

	/** Quadrate u^2, 1<=u<=(p-1)/2 **/

    	u = 0; 
	a = 0;
    	while(u <= l)
    	{
		a += u;  /* Berechnung von ( u+1 )^2 aus u^2: */
		u++;     /* (u+1)^2 = u^2 + u + (u+1)         */
		a += u;  
		while( a >= p ) a -= p;
	
        	*(*(A +a)) = ( char ) 2;   /* A[a][0] */
    	}


	/****************************************************************/
	/** Es ist (u + v w)^2 = a[u,v] + b[u,v] w mit                 **/
	/**                                                            **/
	/** a[u,v] = u^2 + ds v^2, a[u+1,v] = a[u,v] + u + (u+1) und   **/
	/** b[u,v] = 2uv + v^2, b[u+1,v] = b[u,v] + 2v                 **/
	/** Dabei ist                                                  **/
	/** a[0,v] = ds v^2 = c[v] mit c[v+1] = c[v] + d[v] mit        **/
	/**        d[v] = ds (2v+1), d[v+1] = d[v] + 2ds	       **/
	/** b[0,v] = v^2 = e[v] mit e[v+1] = e[v] + v + (v+1)          **/
	/****************************************************************/
   
	ps = p-1;
	v = 0;    

    	D = idif(D,1);
    	D = iquot(D,4);
    	ds = mshom(p,D);   /** ds = (D-1)/4 mod p **/
	zv = 0;
	zds = ds + ds; while(zds >= p) zds -= p;
	c = 0;
	d = ds;
	e = 0;
	while(v<=l)
	{
		zv += 2;	/** 2v **/

		/** c[v+1] **/
		c += d;
		while(c>=p) c-=p;

		/** d[v+1] **/
		d += zds;

		/** e[v+1] **/
		e += v;
		v++;
		e += v;
		while(e>=p) e-=p;

		u = 0;
		a = c;
		b = e;
       		*((*(A+a))+b) = (char) 2;  /** A[a][b] **/

		while(u<=ps)
    		{
			/** a[u+1,v] **/
			a += u;  	
			u++;     
			a += u;  
			while( a >= p ) a -= p;

			/** b[u+1,v] **/
			b += zv;	 
			while( b >= p ) b -= p;

        		*((*(A+a))+b) = (char) 2;  /** A[a][b] **/
		}


	}

    return(0);
}

/***************************************************************************/

/*****************************************************************************/
                                                                                
/*c
		npquadsq(D,p,a1,a2,b1,b2,A)
	
	"number of points with use of table of quadrats"

	Berechnet die Anzahl der Punkte von E(k_P) fuer traege p's,
	fuer omega = sqrt{d}.
c*/
	

static single npquadsq(D,p,a1,a2,b1,b2,A)
int D;
single p,a1,a2,b1,b2;
char **A;
{
	single u,v, N;
	single a,b,c,d,e,f,g,h,i,j,k,l,m;
	single dd, da2, sd, n, sv;

	bind(D);


	/*****************************************************************/
	/** Berechne fuer A = a1 + a2w, B = b1 + b2w, x = u + vw        **/
	/** x^3+Ax+B = a[u,v] + b[u,v]w mit                             **/
        /** a[u,v] = u^3 + 3duv^2 + a1u + da2v + b1 und                 **/
        /** b[u,v] = 3u^2v + dv^3 + a1v + a2u + b2                      **/
	/** Dabei ist                                                   **/
	/** a[u,0] = c[u] mit c[u+1] = c[u] + d[u], d[u] = 3u^2+3u+1+a1 **/
	/**		mit d[u+1] = d[u] + e[u], e[u]=6(u+1), und      **/
	/**             e[u+1] = e[u] + 6                               **/
        /** b[u,0] = f[u] mit f[u+1] = f[u] + a2                        **/
	/** Weiter ist                                                  **/
	/** a[0,v] = g[v] mit g[v+1] = g[v] + da2                       **/
 	/** b[0,v] = h[v] mit h[v+1] = h[v] + i[v] mit                  **/
	/**             i[v] = 3dv^2+3dv+d+a1 und i[v+1] = i[v] + j[v], **/
	/**             j[v] = 6d(v+1) und j[v+1] = j[v] + 6d		**/
	/** Zuletzt ist                                                 **/
	/** a[u+1,v] = a[u,v] + d[u] + k[v] mit k[v] = 3dv^2 und        **/
	/**             k[v+1] = k[v] + l[v] + l[v+1], l[v]=3dv,        **/
	/**             l[v+1] = l[v]+3d                                **/
	/** b[u+1,v] = b[u,v] + m[u,v], mit m[u,v] = 6uv + 3v + a2,     **/
	/**             m[u+1,v] = m[u,v] + 6v                          **/
	/*****************************************************************/

    	/* unendlich ferner Punkt und x = 0 : b1+b2w <=> A[b1][b2]    */
    	N = 1 + ( single ) *((*(A+b1)) + b2); 

	c = b1;
	d = a1+1;
	e = 6;
	f = b2;

    	for(u=1;u<p;u++)
	{
		c += d;  while(c>=p) c -= p;
		d += e;  while(d>=p) d -= p;
		e += 6;  while(e>=p) e -= p;
		f += a2; while(f>=p) f -= p;

		/** A[c][f] **/
    		N += ( single ) *((*(A+c)) + f); 
	}

	dd = mshom(p,D);
	i = dd+a1;

	da2 = dd*a2;  while(da2>=p) da2 -= p;
	dd = 3*dd;    while(dd>=p) dd -= p;
	sd = dd + dd; while(sd>=p) sd -= p;

	g = b1;
	h = b2;
	j = sd;
	k = 0;
	l = 0;
	sv = 0;
	n = a2;

	for(v=1;v<p;v++)
	{
		g += da2; while(g>=p) g -= p;
		h += i;   while(h>=p) h -= p;
		i += j;   while(i>=p) i -= p;
		j += sd;  while(j>=p) j -= p;
		k += l;
		l += dd;  while(l>=p) l -= p;
		k += l;   while(k>=p) k -= p;
		sv += 6;  while(sv>=p) sv -= p;
		n += 3;   while(n>=p) n -= p;

		a = g;	
		b = h;

		/** A[a][b] **/
    		N += ( single ) *((*(A+a)) + b); 

		m = n;
		d = a1 + 1;
		e = 6;
		for(u=1;u<p;u++)
		{
			a += d;
			a += k;  while(a>=p) a -= p;
			b += m;  while(b>=p) b -= p;
			d += e;  while(d>=p) d -= p;
			e += 6;  while(e>=p) e -= p;	
			m += sv; while(m>=p) m -= p;


			/** A[a][b] **/
    			N += ( single ) *((*(A+a)) + b); 
		}
	}

	return(N);

}

/***************************************************************************/
                                                                                
/*c
		eqisnfpnp1(D,p,A4,A6)
	
	"number of points with use of table of quadrats"

	Berechnet die Anzahl der Punkte von E(k_P) fuer traege p's,
	fuer omega = sqrt{d}.
c*/
	
static single eqisnfpnp1(D,p,A4,A6)
int D;
single p;
nfel A4,A6;	/** A4,A4 sind schon mod \wp reduziert **/
{
    	char  **A;
	single pp,ps,a;
	single a1,a2,b1,b2;
	single n;
	list L;

	bind(D,A4,A6);
	init(L);
    
    	/*   Initialisieren des Arrays A gemaess            */
    	/*           / 0, falls (a+b omega) qNR 0 Loesungen */
    	/* A[a][b]= <  1, falls a=b=0 mod p     1 Loesung   */
    	/*           \ 2, falls (a+b omega) qR  2 Loesungen */
    	/* Dabei bedeutet q(N)R quadratischer (Nicht-) Rest */

	/*   Zuerst werden alle Array-Zellen auf 0 gesetzt          */
	/*   und anschliessend A[0][0] = 1 und A[j^2] = 2 gesetzt   */

	pp = p+1;

    	if((A = (char**) calloc(pp, sizeof(char*))) == NULL) return(ERROR);
	ps = p-1;
    	for(a=0;a<=ps;a++) 
	{
	     if((A[a] = (char*) calloc(pp,sizeof(char))) == NULL) return(ERROR);
	}

        qnfpitquad1(D,p,A);

    /*   Initialisieren des Arrays A ...           ( E N D E ) */

	if(!A4) 
	{
		a1 = 0;
		a2 = 0;
	}
	else
	{
		L = qnfielbasvec(D,A4);
		a1 = lfirst(L);
		a2 = lsecond(L);
	}

	if(!A6)
	{
		b1 = 0;
		b2 = 0;
	}
	else
	{
		L = qnfielbasvec(D,A6);
		b1 = lfirst(L);
		b2 = lsecond(L);
	}

	n = npquadsq(D,p,a1,a2,b1,b2,A);

    	for(a=0;a<=ps;a++) 
	{
	     free(A[a]);
	}

        free(A);
	return(n);
}

/***************************************************************************/
/*c
		npquadepsdh(D,p,a1,a2,b1,b2,A)
	
	"number of points with use of table of quadrats"

	Berechnet die Anzahl der Punkte von E(k_P) fuer traege p's,
	fuer omega = 1+sqrt{d})/2
c*/
	

static single npquadepsdh(D,p,a1,a2,b1,b2,A)
int D;
single p,a1,a2,b1,b2;
char **A;
{
	single N,u,v;
	single a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,r,s;
	single ds, sdse, da2,dd,sd;

	bind(D);


	/*****************************************************************/
	/** Berechne fuer A = a1 + a2w, B = b1 + b2w, x = u + vw        **/
	/** d' = (d-1)/4, w^2 = w+d',                                   **/
	/** x^3+Ax+B = a[u,v] + b[u,v]w mit                             **/
        /** a[u,v] = u^3 + 3d'uv^2 + d'v^3 + a1u + d'a2v + b1 und       **/
        /** b[u,v] = 3u^2v + 3uv^2 + d'v^3 + v^3 + a1v + a2u + a2v + b2 **/
	/** Dabei ist                                                   **/
	/** a[u,0] = c[u] mit c[u+1] = c[u] + d[u], d[u] = 3u^2+3u+1+a1 **/
	/**		mit d[u+1] = d[u] + e[u], e[u]=6(u+1), und      **/
	/**             e[u+1] = e[u] + 6                               **/
        /** b[u,0] = f[u] mit f[u+1] = f[u] + a2                        **/
	/** Weiter ist                                                  **/
	/** a[0,v] = g[v] mit g[v+1] = g[v] + h[v],                     **/
	/**             h[v] = 3d'v^2+3d'v+d'+d'a2,  h[v+1]=h[v] + i[v] **/
	/**             i[v] = 6d'(v+1), i[v+1] = i[v] + 6d'            **/
 	/** b[0,v] = j[v] mit j[v+1] = j[v] + k[v] mit                  **/
	/**             k[v] = 3(d'+1)v^2+3(d'+1)v+(d'+1)+a1+a2 und     **/
	/**             k[v+1] = k[v]+l[v], l[v] = 6(d'+1)(v+1) und     **/
	/**             l[v+1] = l[v] + 6(d'+1)                         **/
	/** Zuletzt ist                                                 **/
	/** a[u+1,v] = a[u,v] + d[u] + m[v] mit m[v] = 3d'v^2 und       **/
	/**             m[v+1] = m[v] + n[v] + n[v+1], n[v]=3d'v,       **/
	/**             n[v+1] = n[v]+3d'                               **/
	/** b[u+1,v] = b[u,v] + o[u,v], mit o[u,v] = 6uv+3v+3v^2+a2,    **/
	/**             o[u+1,v] = o[u,v] + 6v                          **/
	/*****************************************************************/

    	/* unendlich ferner Punkt und x = 0 : b1+b2w <=> A[b1][b2]    */
    	N = 1 + ( single ) *((*(A+b1)) + b2); 

	c = b1;
	d = a1+1;
	e = 6;
	f = b2;

    	for(u=1;u<p;u++)
	{
		c += d;  while(c>=p) c -= p;
		d += e;  while(d>=p) d -= p;
		e += 6;  while(e>=p) e -= p;
		f += a2; while(f>=p) f -= p;

		/** A[c][f] **/
    		N += ( single ) *((*(A+c)) + f); 
	}

	D = idif(D,1);
	D = iquot(D,4);
	ds = mshom(p,D);

	da2 = ds*a2;  while(da2>=p) da2 -= p;
	dd = 3*ds;    while(dd>=p) dd -= p;
	sd = dd + dd; while(sd>=p) sd -= p;
	sdse = sd+6;  while(sdse>=p) sdse -= p;

	g = b1;
	h = ds + da2; while(h>=p) h -= p;
	i = sd;
	j = b2;
	k = ds+1;
	k += a1;
	k += a2;      while(k>=p) k -= p;
	l = sdse;
	m = 0;
	n = 0;
	r = a2;
	s = 0;
	for(v=1;v<p;v++)
	{
		g += h;    while(g>=p) g -= p;
		h += i;    while(h>=p) h -= p;
		i += sd;   while(i>=p) i -= p;
		j += k;    while(j>=p) j -= p;
		k += l;    while(k>=p) k -= p;
		l += sdse; while(l>=p) l -= p;
		m += n;
		n += dd;   while(n>=p) n -= p;
		m += n;    while(m>=p) m -= p;
		s += 6;    while(s>=p) s -= p;
		r += s;    while(r>=p) r -= p;

		a = g;	
		b = j;

		/** A[a][b] **/
    		N += ( single ) *((*(A+a)) + b); 

		d = a1+1;
		e = 6;
		o = r;
		for(u=1;u<p;u++)
		{
			a += d;
			a += m;  while(a>=p) a -= p;
			b += o;  while(b>=p) b -= p;
			d += e;  while(d>=p) d -= p;
			e += 6;  while(e>=p) e -= p;	
			o += s;  while(o>=p) o -= p;

			/** A[a][b] **/
    			N += ( single ) *((*(A+a)) + b); 
		}
	}

	return(N);

}

/***************************************************************************/
/*c
		eqisnfpnp2(D,p,A4,A6)
	
	"number of points with use of table of quadrats"

	Berechnet die Anzahl der Punkte von E(k_P) fuer traege p's,
	fuer omega = 1+sqrt{d})/2
c*/
	
static int eqisnfpnp2(D,p,A4,A6)
int D;
single p;
nfel A4,A6;
{
    	char  **A;
	single u,ps,a;
	single n;
	single a1,a2,b1,b2;
	list L;

	bind(D,A4,A6);
	init(L);
    
    	/*   Initialisieren des Arrays A gemaess            */
    	/*           / 0, falls (a+b omega) qNR 0 Loesungen */
    	/* A[a][b]= <  1, falls a=b=0 mod p     1 Loesung   */
    	/*           \ 2, falls (a+b omega) qR  2 Loesungen */
    	/* Dabei bedeutet q(N)R quadratischer (Nicht-) Rest */

	/*   Zuerst werden alle Array-Zellen auf 0 gesetzt          */
	/*   und anschliessend A[0][0] = 1 und A[j^2] = 2 gesetzt   */

	u = p+1;

    	if((A = (char**) calloc(u, sizeof(char*))) == NULL) return(ERROR);
	ps = p-1;
    	for(a=0;a<=ps;a++) 
	{
	     if((A[a] = (char*) calloc(u,sizeof(char))) == NULL) return(ERROR);
	}

        qnfpitquad2(D,p,A);

    /*   Initialisieren des Arrays A ...           ( E N D E ) */

/*****
for(u=0;u<=p-1;u++)
{
	for(a=0;a<=p-1;a++) printf("A[%obj][%obj] = %obj ",a,u, *((*(A+a)) + u)); 
	printf("\n");
}
****/

	if(!A4)
	{
		a1 = 0;
		a2 = 0;
	}
	else
	{
		L = qnfielbasvec(D,A4);
		a1 = lfirst(L);
		a2 = lsecond(L);
	}

	if(!A6)
	{
		b1 = 0;
		b2 = 0;
	}
	else
	{
		L = qnfielbasvec(D,A6);
		b1 = lfirst(L);
		b2 = lsecond(L);
	}

	n = npquadepsdh(D,p,a1,a2,b1,b2,A);

    	for(a=0;a<=ps;a++) 
	{
	     free(A[a]);
	}
        free(A);
	return(n);
}

/**********************************************************************/
/***                                                                ***/
/***               s t a t i c   f u n c t i o n s                  ***/
/***                          ( E n d )                             ***/
/***                                                                ***/
/***                                                                ***/
/***     B e g i n n i n g   o f   t h e   m a i n   p a r t        ***/
/***                                                                ***/
/**********************************************************************/


int eqisnfpnp(E,P,pi,z)
list E,P;
nfel pi;
single z;
{
	list L;
	int n,d,p;
	nfel a4,a6;
	
	bind(E,P,pi);
	init(L,n,d,p);
	init(a4,a6);


	/** Gleichung minimieren **/

	d = ecqnfflddisc(E);
	L = eqisnfminnaav(d,E,P,pi,z);
	a4 = lfirst(L);
	a6 = lsecond(L);
	
	/** Koeffizienten reduzieren **/
	
	a4 = qnfpihom(d,P,pi,z,a4);
	a6 = qnfpihom(d,P,pi,z,a6);

	/** Primzahl **/
	
	p = qnfidprime(P,pi,z);

	if(z) /** verzweigt oder zerlegt **/
	{
		if(a4) a4 = lthird(a4);	/** a4 = 0 oder (1 0 a) **/
		if(a6) a6 = lthird(a6);
		n = ecmspsnfnp(p,a4,a6);
		return(n);
	}

	if(mshom(4,d)==1) n = eqisnfpnp2(d,p,a4,a6);
	else n = eqisnfpnp1(d,p,a4,a6);
	return(n);
}

	
