/*M
.SH NAME
ifact60 - integer factorization, N < 2^60

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ifact60(N)
int N;

.SH DESCRIPTION
For 1<= N <2^60 ifact60() returns the list L = (p1 , ... , pr)
of all prime factors of N with p1 <= ... <= pr.
M*/
/*H
	Version 1       30.06.1987      B. Weis
	Version 2       08.09.1987      B. Weis
			letzte while-Schleife berichtigt
	Version 3       02.10.1987      B. Weis
			umfangreiche Aenderungen   
	Version 4       19.11.1990      M.Conrad
			2^30<=N<2^60 --> 1<=N<2^60 in der Dokumentation
	Version 5	01.02.1994	ispt -> isiprime
					G.J.Lay
   DATE ifact60       : 890501.901120.941201
H*/

# include <_arith1.h>

list ifact60(n)
int n;
{
	unsigned u1, u2, u1s;
	single d=1039, e=7, h, p, r, w, ws, *Dl, *Pl;
	int ns;
	list F=_0, FS;
	bind2(F,n);
	init2(FS,ns);

/* (Re-)Initialisierung */

	Pl = LIST_SP;
	Dl = DIFF;
	goto r0;
reinit: n = isquot(n,d);
	e = d;
	F = lcomp(d,F);
r0:     if (n == 1) return(linv(F));
	if (issingle(n)) {u1 = 0; u2 = n;}
	else {u1 = lsecond(n); u2 = lfirst(n);}

/* n < 2^32 */

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
		return(linv(F));
		}

/* 2^32 <= n < 2^60 */
/* Suche Primteiler kleiner 1000 */

	while ((p = *Pl)) {
		if (!(((u1%p)*(BASIS%p)+u2)%p)) {
			F = lcomp(p,F);
			n = isquot(n,p);
			goto r0;
			}
		Pl++;
		}

/* 2^32 <= n < 2130*BASIS */

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

/* Primzahltest */

		if (u1 > 100) 	if (isiprime (n) == 1) {
			F = lcomp (n,F);
			return (linv (F));
			}

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
		F = lcomp(n,F);
		return(linv(F));
		}

/* 2130*BASIS <= n < 2^60 */
/* Suche Teiler kleiner 56449 < 3^(1/2)*2^15 */

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

/* Primzahltest */

	if (isiprime (n) == 1) {
		F = lcomp(n,F);
		return(linv(F));
		}

	w = isqrt(n);

/* Suche Teiler kleiner 3*2^20 */

	ws = smin(w,3*(1<<20));
	while (d <= ws) {
		if (!((((((((u1%d)<<10)%d)<<10)%d)<<10)+u2)%d)) goto reinit;
		d += *Dl;
		Dl++;
		if (!*Dl) Dl = DIFF;
		}

/* Suche Teiler kleiner 3*2^24 */

	ws = smin(w,3*(1<<24));
	while (d <= ws) {
		if (!((((((((((((u1%d)<<6)%d)<<6)%d)<<6)%d)<<6)%d)<<6)+u2)%d)) goto reinit;
		d += *Dl;
		Dl++;
		if (!*Dl) Dl = DIFF;
		}

/* Suche Teiler kleiner 3*2^27 */

	ws = smin(w,3*(1<<27));
	while (d <= ws) {
		u1s = ((((((((((u1%d)<<3)%d)<<3)%d)<<3)%d)<<3)%d)<<3)%d;
		if (!(((((((((((u1s<<3)%d)<<3)%d)<<3)%d)<<3)%d)<<3)+u2)%d)) goto reinit;
		d += *Dl;
		Dl++;
		if (!*Dl) Dl = DIFF;
		}

/* Suche Teiler kleiner 2^30 */

	u1 <<= 2;
	while (d <= w) {
		u1s = ((((((((u1%d)<<2)%d)<<2)%d)<<2)%d)<<2)%d;
		u1s = (((((((((u1s<<2)%d)<<2)%d)<<2)%d)<<2)%d)<<2)%d;
		if (!(((((((((((u1s<<2)%d)<<2)%d)<<2)%d)<<2)%d)<<2)%d+u2)%d)) goto reinit;
		d += *Dl;
		Dl++;
		if (!*Dl) Dl = DIFF;
		}
	F = lcomp(n,F);
	return(linv(F));
}
