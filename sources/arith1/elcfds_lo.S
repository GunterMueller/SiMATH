/*M
.SH NAME
elcfds_lo - elliptic curve fast divisor search (list only)

.SH SYNOPSIS
.nf
#include<_arith1.h>

int elcfds_lo(N, b, e)
int N;
single b, e;

.SH DESCRIPTION
elcfds_lo() returns a factor of N.
If the factorization failed, elcfds() returns 1 or N.
In this case, elcfds() may be called again with another
value b and/or a greater value e.
40 curves are being tested simultaneously.
For each point P on one of these curves the Point E*P is calculated,
where E is a product of prime numbers < e.
In particular, the maximum runtime of elcfds is determined by e.

.PP
.TP 4
.B N
> 1, should not be prime
.TP 4
.B b
should be chosen as random as possible
.TP 4
.B e
>= 0, as mentioned above, recommended value e = 50000

.SH NOTE
elcfds has NOTHING to do with the ec.. functions!
For special applications, the constants for the
number of curves used and the limitation
of N can be set by modifying the source.

.SH SEE ALSO
elcpds, elcpdssum and for more details on the algorithm, please refer to
"Some integer factorization algorithms using elliptic curves"
of Richard P. Brent, September 1985.
M*/

#include<_arith1.h>
                                           
/* NUM_CURVES = number of elliptic curves to be tested  */
#define NUM_CURVES 40

/* P1 = (X1, Y1), P2 = (X2, Y2) */

static single randsingle(void);

/*                P2 := P1 + P2                   */
static list subelcadd(int N, list X1, list X2, list Y1, list Y2) {

    single i;
    int g, r, t, waste=0;
    int v,lambda, x02, y02;
    list M, W, Q, R;

    bind(N, X1, X2, Y1, Y2);
    init(g, r, t, M, W);

    M = _0; W = list1(1);
    for (i = 1; i <= NUM_CURVES; i++ ) {
	t = mihom(N, idif(lelt(X1,i), lelt(X2,i)));
	if (t)
	    M = lcomp(t, M);
	else
	    M = lcomp(1, M);
	iqrem(iprod(lfirst(M), lfirst(W)), N, &waste, &t);
	W = lcomp(t, W);
    }

    if ((r = iegcd(lfirst(W), N, &g, &waste)) != 1) {
	return list3(r,X2,Y2);
    }

    init( v,lambda, x02, y02);
    bind(Q,R);
    Q = R = _0;
    W = lred(W);
    for (i = NUM_CURVES; i > 0; i-- ) {
	iqrem(iprod(g, lfirst(W)), N, &waste, &v);
	iqrem(iprod(g, lfirst(M)), N, &waste, &g);
	M = lred(M); W = lred(W);

	lambda = mihom(N, iprod(v, idif(lelt(Y1,i), lelt(Y2,i))));

	x02 = mihom(N, idif(isquare(lambda),isum(lelt(X1,i),lelt(X2,i))));
	Q = lcomp(x02, Q);

	y02 = mihom(N, idif(iprod(lambda,idif(lelt(X1,i),x02)),lelt(Y1,i)));
	R = lcomp(y02, R);
    }
    return list3(0,Q,R);
}

/* tt = times two: P2 := 2 P2  */
static list subelctt(int N, list X2, list Y2) {

    single i;
    int r, g, t, waste=0;
    int u,v,lambda,x,y;

    list W, M, Q, R;

    bind(N, X2, Y2);
    init(r, g, t, W, M);

    M = _0;
    W = list1(1);
    for (i = 1; i <= NUM_CURVES; i++ ) {
	M = lcomp(isprod(lelt(Y2,i),2), M);
	iqrem(iprod(lfirst(M), lfirst(W)), N, &waste, &t);
	W = lcomp(t, W);
    } 
    if ((r = iegcd(lfirst(W),N,&g,&waste)) != 1) {
	return list3(r,X2,Y2);
    }

    init( u,v,lambda,x,y);

    bind(Q,R);
    Q = R = _0;
    W = lred(W);
    /* g tracks inverse of lfirst(W) */
    for (i = NUM_CURVES; i > 0; i-- ) {
	v = mihom(N, iprod(g, lfirst(W)));
	iqrem(iprod(g, lfirst(M)), N, &waste, &g);
	M = lred(M);
	W = lred(W);

	u = lelt(X2,i);
	iqrem(iprod(isum(isprod(isquare(u),3),1),v), N, &waste, &lambda);

	/* x = lambda^2 -2*u */
	x = mihom(N, idif(isquare(lambda),isum(u,u)));
	Q = lcomp(x,Q);

	/* y = lambda * (u - x) - y */
	y = mihom(N, idif(iprod(lambda,idif(u,x)), lelt(Y2,i)));
	R = lcomp(y, R);
    }
    return list3(0,Q,R);
}


/*   k * P   */
static list subelcsprod(int N, single k, list X1, list X2, list Y1, list Y2) {

    int ggt;
    list R;

    if (k == 1) return list3(0,X2,Y2);

    bind(N,X1,X2,Y1,Y2);
    init(ggt,R);

    R = subelcsprod(N, k/2, X1, X2, Y1, Y2);
    if (lfirst(R)) {
	return R;
    }
    X2 = lsecond(R);
    Y2 = lthird(R);
    
    R = subelctt(N,X2,Y2);
    if (lfirst(R)) {
	return R;
    }
    X2 = lsecond(R);
    Y2 = lthird(R);

    if (k & 1)
	R = subelcadd(N,X1,X2,Y1,Y2);

    return R;
}


int elcfds_lo(int N, single b, single elcmax) {

    single i, m, k, u;
    unsigned z;
    int ggt;
    list X1,X2,Y1,Y2,R;

    srand ( b );
    bind(N);
    init(ggt, X1, Y1, X2, Y2);

    X2 = Y2 = _0;
    for (i = 0; i < NUM_CURVES; i++ ) {
	X2 = lcomp(randsingle(), X2);
	Y2 = lcomp(randsingle(), Y2);
    }
    u = 1;
    for (m = 2; m <= elcmax; m++) {
	if (isspprime(m, &k)) {
	    if ( u > BASIS / k ) {
		X1 = lcopy(X2);
		Y1 = lcopy(Y2);
		R = subelcsprod(N,u,X1,X2,Y1,Y2);
		if (ggt = lfirst(R))  {
		    return (ggt);
		}
		X2 = lsecond(R);
		Y2 = lthird(R);
		u = 1;
	    }
	    else u = k * u;
	}
    }
    return( 1 );
}

static single randsingle() {
    single t;
    for(t=0; !t || t>=BASIS; t = rand());
    return(t);
}
