/*M
.SH NAME
lipairspmax - list of integer pairs power maximum

.SH SYNOPSIS
.nf
#include<_list.h>

int lipairspmax(L)  
list L; 

.SH DESCRIPTION
.TP 4
.B L
is a list, containing an even number of integers.
.PP
Let L = (P_1, E_1, ..., P_r, E_r). Then lipairspmax returns a number M, where
.IP
M = max{ Pi ^ Ei; i = 1, ... , r }. 

M*/
       
/*H
	Version 1	16.09.1992	A.Stein
   DATE lipairspmax   : 921130
H*/

#include <_list.h>

int lipairspmax(LF)
list LF;
{
	int P, M, M1;
	bind(LF);
	init(P,M,M1);

	P = lfirst(LF);
	M = iexp(P,lsecond(LF));
	for( LF=lred2(LF); LF != _0; LF=lred2(LF) ) {
		P = lfirst(LF);
		M1 = iexp(P,lsecond(LF));
		if( icomp(M1,M) > 0 ) M = M1;
	}
	return(M);
}	
