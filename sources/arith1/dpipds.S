/*M
.SH NAME 
dpipds - double precision integer prime divisor search

.SH SYNOPSIS
.nf
#include<_arith1.h>

list dpipds(a, N)
single a;
int N;

.SH DESCRIPTION
dpipds() returns a descending sorted list (q1,...,qr)
of all prime factors of N, i.e. q1 >= ... >= qr > 0
and N=q1*...*qr.

.PP
.TP 4
.B N
the number to be factorised, 1 <= N < 2^60
.TP 4
.B a
lower bound of the prime factors of N, i.e. N must not
have any prime factor < a.
M*/

/*H
	Version 1       08.10.1990      M.Conrad     
	Version 2  	01.09.1992	Konstante beim Aufruf von rhopds
					geaendert.  MC
	Version 3	01.02.1994	Benutzt isiprime anstatt ispt.
					rand % 1000 durch irand (1000)
					resetzt.
						Georg J. Lay
   DATE dpipds        : 901120.921130.941201
H*/

#include <_arith1.h>

list dpipds(a,n) 
single a;
int n;
{
	unsigned u1, u2, u1s;
	single  e, d, w, ws, nu, s, *Dl, *Pl;
	int ns;
	list F, FS;

	bind(n);
	init(F,FS,ns);

/* (Re-)Initialisierung (997: groesste Primzahl < 1000) */        
	nu = 0;                      
        if (a < 997) {
		d = 1039;   /* wegen: (1039/30)*30-11 = 1009  */
		Pl = LIST_SP;   
	}
	else if ( a > 56449 ){
		d = (a/2310) * 2310 + 1009;
		while ( d > a ) d -= 2310;
		Pl = &nu;
	}        
	else   {                                      
		d = a;     
		Pl = &nu;
	}            
	F = _0;
	e = smax(7,a);
	Dl = DIFF;          
	goto r0;      

reinit: n = isquot(n,d);
	e = d;
	F = lcomp(d,F);     
   
r0:     if (n == 1) return(F);
	if (issingle(n)) {u1 = 0; u2 = n;}
	else {u1 = lsecond(n); u2 = lfirst(n);}

/* --------------------------- n < 2^32 -------------------------------- */

	if (u1 <= 3) {
		u2 += u1<<BLOG2;
		M1:     if (!(u2%2)) {u2 /= 2; F = lcomp(2,F); goto M1;}
			if (!(u2%3)) {u2 /= 3; F = lcomp(3,F); goto M1;}
			if (!(u2%5)) {u2 /= 5; F = lcomp(5,F); goto M1;}
			if (u2 < BASIS) w = ssqrt((int)u2);
			else w = isqrt(list2((int)(u2%BASIS),(int)(u2/BASIS)));
			goto M3;
		M2:     F = lcomp(e,F);
			u2 /= e;
			w = ssqrt((int)u2);
		M3:     e = ((e-2)/30)*30+7;
			while (e <= w) {
				if (!(u2%e)) goto M2; e += 4;
				if (!(u2%e)) goto M2; e += 2;
				if (!(u2%e)) goto M2; e += 4;
				if (!(u2%e)) goto M2; e += 2;
				if (!(u2%e)) goto M2; e += 4;
				if (!(u2%e)) goto M2; e += 6;
				if (!(u2%e)) goto M2; e += 2;
				if (!(u2%e)) goto M2; e += 6;
			}
		if (u2 != 1) {
		    n = (u2 < BASIS ? (int)u2 : list2((int)(u2%BASIS),(int)(u2/BASIS)));
		    F = lcomp(n,F);
		}
		return(F);
	}
/* ------------------------ 2^32 <= n < 2^60 --------------------------- */ 

        /* Suche Primteiler kleiner 1000 */              
	while ((s = *Pl)) {
		if (!(((u1%s)*(BASIS%s)+u2)%s)) {
			F = lcomp(s,F);
			n = isquot(n,s);
			goto r0;
		}
		Pl++;
	}

/* ---------------------- 2^32 <= n < 2130*BASIS ----------------------- */
                                                                    	
	if (u1 <= 2129) {
		d = (d/30)*30-11;   
		while (d <= 30000) {
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 4;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 6;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 2;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 6;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 4;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 2;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 4;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 2;
		}

		if (u1 > 100)
		if (isiprime (n) == 1)		return(lcomp(n,F));    

		w = isqrt(n);
		while (d <= w) {
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 4;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 6;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 2;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 6;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 4;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 2;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 4;
			if (!((u1*(BASIS%d)+u2)%d)) goto reinit; d += 2;
		}
		return(lcomp(n,F));
	}

/* ------------------- 2130*BASIS <= n < 2^60 -------------------------- */

	/*   Suche Teiler kleiner 56449 < 3^(1/2)*2^15   */
	if (d < 56449) d = (d/30)*30-11;
	while (d < 56449) {
		if (!(((u1%d)*(BASIS%d)+u2)%d)) goto reinit; d += 4;
		if (!(((u1%d)*(BASIS%d)+u2)%d)) goto reinit; d += 6;
		if (!(((u1%d)*(BASIS%d)+u2)%d)) goto reinit; d += 2;
		if (!(((u1%d)*(BASIS%d)+u2)%d)) goto reinit; d += 6;
		if (!(((u1%d)*(BASIS%d)+u2)%d)) goto reinit; d += 4;
		if (!(((u1%d)*(BASIS%d)+u2)%d)) goto reinit; d += 2;
		if (!(((u1%d)*(BASIS%d)+u2)%d)) goto reinit; d += 4;
		if (!(((u1%d)*(BASIS%d)+u2)%d)) goto reinit; d += 2;
	}

	if (isiprime (n) == 1)	return(lcomp(n,F)); 
	else			s = -1;   
  
	/* Suche Teiler kleiner 2500052 */  
	w = isqrt(n);    
	ws = smin(w,2500052);
	while (d <= ws) {
		if (!((((((((u1%d)<<10)%d)<<10)%d)<<10)+u2)%d)) goto reinit;
		d += *Dl;
		Dl++;
		if (!*Dl) Dl = DIFF;
		} 
        if (ws == w) return(lcomp(n,F));
                         
	/* Suche Teiler kleiner 2^30 */         
	if ((s == -1) && ( w > 3500053 )) {      
		d = irand(1000);
		d++;               
/* Alternativ:	while(((ns = elcfds( n, d, 5000000))==1) || (ns == n)) d++; */
		while(((ns = rhopds( n, d, 5000000))==1) || (ns == n)) d++;
                d = iquot(n,ns); 
                F = lcomp(imin(d,ns),F); 
                F = lcomp(imax(d,ns),F);
                return(F);       
                /* denn 2^21 < 2500052 =>  ns und d prim */
	}
	else {
	u1 <<= 2;
	while (d <= w) {
		u1s = ((((((((u1%d)<<2)%d)<<2)%d)<<2)%d)<<2)%d;
		u1s = (((((((((u1s<<2)%d)<<2)%d)<<2)%d)<<2)%d)<<2)%d;
		if (!(((((((((((u1s<<2)%d)<<2)%d)<<2)%d)<<2)%d)<<2)%d+u2)%d)) goto reinit;
		d += *Dl;
		Dl++;
		if (!*Dl) Dl = DIFF;
	}       
	return(lcomp(n,F));   
                 }
}                     
