/*M
.SH NAME
cdedeetas - complex Dedekind eta function special

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cdedeetas (q,ln_q)
complex q;
double ln_q;

.SH DESCRIPTION
cdedeetas() returns eta(q)*q^(-1/24), where eta() denotes the Dedekind eta-function.

.PP
.TP 8
.B q
is a complex number with 0 < |q| < 1.

.PP
.TP 8
.B ln_q
is an approximation of Re (ln(q)) = Re (2*pi*i*t) for q = e^(2*pi*i*t) with i*i = -1.

M*/

/*H
        Version 1       16.01.1993      Georg Lay
   DATE cdedeetas     : 931130
H*/

#include <_arith1.h>

static single glieder_eta(double);

complex cdedeetas  (q,ln_q)
complex 	    q;	
double		      ln_q;
 {
 single n,N;

 list  q_n,lexp,l;
 complex  _1,eta,qn,q1;
 bind(q); 
 init (q_n,lexp,l);
 init    (_1,eta,qn,q1);

 N = glieder_eta (ln_q);

 lexp = _0;							/* benoetigte Exponenten*/
 for (n = 1; n<=N; n++)						/* in q-Entwichlung	*/
   lexp = (n % 2 == 0) ? lcomp2 (n,2*n-1,lexp) : lcomp2 (-n,-2*n+1,lexp);

 q_n = _0;
 for (n = 1; n <= 2*N-1; n++)	q_n = lcomp (0,q_n);

 lsfirst (q_n,q);

 for (n = 2; n<=N; n++)						/* benoetigte q-Potenzen*/
 if (lelt (q_n,n) == 0)						/* vorberechnen		*/
   {
   q1 = lelt (q_n,n/2);

   if (n % 2 == 0)	qn = csqr  (q1);     
   else			qn = cprod (q1,lelt (q_n,n-n/2));     

   leset (q_n,n,qn); 
   }

 for (n = 3; n<=2*N-1; n+=2)
 if (lelt (q_n,n) == 0)
   {
   q1 = lelt (q_n,n/2);

   if (n % 2 == 0)	qn = csqr  (q1);     
   else			qn = cprod (q1,lelt (q_n,n-n/2));     

   leset (q_n,n,qn); 
   }

 _1  = ccri (itofl (1),0); 					/* Horner-Auswertung	*/
 eta = 0;							/* der q-Entwicklung	*/

 for ( ; lexp != _0; lexp = lred (lexp))
   {
   n = lfirst (lexp);

   eta = (n > 0) ? csum (eta,_1) : cdif (eta,_1);
   qn  = lelt (q_n,abs(n));
   eta = cprod (eta,qn);
   }

 eta = csum  (eta,_1);      

 return (eta);
 }


static
single glieder_eta (ln_q)					/* Wieviele Reihen-	*/
double		    ln_q;					/* glieder sind noetig?	*/
 {
 double N;

 N = -log (6.0) - 30.0*log(2.0)*((double) FL_EPS);
 N = N/ln_q;
 if (N < 1.0) N = 1.0;
 N = 1.0 + sqrt (N/1.5);

 return ((int) N);
 }
