/*M
.SH NAME
issprime - is single prime ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single issprime(a,pc)
obj a,*pc;

.SH DESCRIPTION
issprime() returns 
.nf
-1 : if a is not a single in [2, BASIS-1].
     Here *pc equals a.
 0 : if a is a single in [2, BASIS-1], but a is not prime
     Here *pc equals the smallest prime factor of a.
 1 : if a is a prime in [2, BASIS-1]
     Here *pc equals a.
M*/
/*H
	Version 1       10.12.1986              Bosco Weis
	Version 2       09.03.1987              geringfuegige Aenderungen. PS
	Version 3       18.03.1988                    "            "       PS
   DATE issprime      : 890501
H*/


# include <_arith1.h>

single issprime(a,pc)
obj a,*pc;
{
	single b, c;

	*pc = a;
	if ( !issingle(a) || a<=1 ) return(-1);
	if (a==2 || a==3 || a==5 || a==7 || a==11 || a==13) return(1);
	if (a%2==0) { *pc = 2; return(0); }
	if (a%3==0) { *pc = 3; return(0); }
	if (a%5==0) { *pc = 5; return(0); }
	if (a%7==0) { *pc = 7; return(0); }
	if (a%11==0) { *pc = 11; return(0); }
	if (a%13==0) { *pc = 13; return(0); }
	if (a < 289) return(1);
	b = ssqrt(a)+2;
	c = 17; *pc = c;
	while (c < b) {
		if (a%c == 0) { *pc=c; return(0); }
		c +=2;
		if (a%c == 0) { *pc=c; return(0); }
		c +=4;
		if (a%c == 0) { *pc=c; return(0); }
		c +=6;
		if (a%c == 0) { *pc=c; return(0); }
		c +=2;
		if (a%c == 0) { *pc=c; return(0); }
		c +=6;
		if (a%c == 0) { *pc=c; return(0); }
		c +=4;
		if (a%c == 0) { *pc=c; return(0); }
		c +=2;
		if (a%c == 0) { *pc=c; return(0); }
		c +=4;
		}
	*pc = a; return(1);
}
