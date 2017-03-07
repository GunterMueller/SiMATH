/*M
.SH NAME
upireddiscc - univariate polynomial over the integers reduced discriminant and content of resultant equation

.SH SYNOPSIS
.nf
#include<_pol2.h>

int upireddiscc(P, pc) 
pol P; 
int *pc;

.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the integers,    deg(P) > 2.
.PP
Let a be the reduced discriminant of P, and rd the content of the resultant equation, ( so rd is the quotint of the discriminant and the reduced discriminant of P ). 
.PP
upireddiscc returns a and writes rd to *pc.
 
M*/

/*H
	Version 1       05.05.89        J.Schmitt
	Version 2	30.12.89	J.Schmitt
					Sicherung von *pc;
   DATE upireddiscc   : 891101.900101
H*/


#include <_pol2.h>

int upireddiscc(P,pc)
pol P;
int *pc;
{
	pol dP, B;
	int d;
	bind(P);
	init(dP,B,d);

	dP=pideriv(1,P);
	d=upiresulc(P,dP,&B);
	if ( mods(lfirst(P),4) >=2 ) d=ineg(d);
	B=lcomp2(1,d,B);
	dP=piicont(1,B);
	d=iquot(d,dP);
	*pc=dP;
	return(d);
}
