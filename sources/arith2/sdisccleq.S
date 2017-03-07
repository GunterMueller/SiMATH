/*M
.SH NAME
sdisccleq - single discriminant, class equation

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol sdisccleq(D, L)  
single D; 
list L;
     
.SH DESCRIPTION
.TP 4
.B D
is a single, D < 0.
.TP 4
.B L
is a list, containing primitive, reduced and binary quadratic forms of discriminant D, such as the forms created by iprpdbqf.   
.PP
sdisccleq returns the class equation of the discriminant D as monic polynomial over Z.
 
.SH SEE ALSO
 sdiscrcleq1
 iprpdbqf

M*/
                      
/*H
	Version 1	01.07.1993	Georg J. Lay
	Version 2	15.01.1994	sdisccleq ist ein Spezialfall
					von sdiscrcleq	GJL
   DATE sdisccleq     : 931130.941201
H*/

#include<_arith2.h>

pol sdisccleq (D,L)
single	       D;
list		 L;
 {
 single s;
 pol	H,f,g;
 init  (H,f,g);

 s = 1;

 H = sdiscrcleq1(D,L,&s,&f,&g,0);

 return (H);
 }
