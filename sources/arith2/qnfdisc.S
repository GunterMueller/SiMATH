/*M
.SH NAME
qnfdisc - quadratic number field discriminant

.SH SYNOPSIS
.nf
#include<_arith2.h>

int qnfdisc( D )  
int D;
  
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.PP
qnfdisc returns the discriminant of K over Q, i.e.
.IP
4D,  for D = 2 or 3 modulo 4, 
 D,  for D = 1      modulo 4.
 
M*/
                                        
/*H
	Version 1       11.04.1989      Christine Hollinger
	Version 2       06.07.1990      C.H.   DISCQNF -> QNFDISC
	Version 3       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.
					Programm vereinfacht.  PS
   DATE qnfdisc       : 890801.901120.9107__.910915
H*/

#include<_arith2.h>

int qnfdisc( D )
int D;
{
	bind( D );

	if ( mshom( 4,D ) != 1 ) D = isprod(D,4);

	return(D);
}
