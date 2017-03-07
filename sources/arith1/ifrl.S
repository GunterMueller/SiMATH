/*M
.SH NAME
ifrl - integer Fermat residue list

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ifrl(N,pm)
int N;
single *pm;

.SH DESCRIPTION
ifrl() calculates a positive single precision number *pm and returns
a list L of elements from Z/(*pm)Z with the following property:
If x*x-N is a square in Z for some x in Z, 
then there is an element y in L which is congruent to x modulo *pm.
.PP
.TP 4
.B N
>0, must not have any prime factors <17.
M*/

/*H
	Version 1       6.3.1987                Pascale Serf
   DATE ifrl          : 890501.9203__
H*/


# include <_arith1.h>

list ifrl(N,pm)
int N;
single *pm;
{
	single a1,a2,a3,a4,b1,h,k,k1,m,m1;
	list L,L1,M,H;

	bind(N);
	init4(L,L1,M,H);

	/***    Modul 2^5    ***/
	a1 = isrem(N,32);
	a2 = a1%16;
	a3 = a2%8;
	a4 = a3%4;
	if ( a4 == 3 ) {
		m = 4;
		if ( a3 == 3 ) b1 = 2;
		else b1 = 0;
	}
	else if ( a3 == 1 ) {
		     m = 8;
		     if ( a2 == 1 ) b1 = 1;
		     else b1 = 3;
	     }
	     else {
		     m = 16;
		     switch(a1/8) {
			     case 0 : b1 = 3;
				      break;
			     case 1 : b1 = 7;
				      break;
			     case 2 : b1 = 5;
				      break;
			     case 3 : b1 = 1;
				      break;
		     }
	     }
	if ( m == 4 ) L = list1(b1);
	else L = list2(b1,m-b1);
	k = llength(L);

	/***    Modul 3^3    ***/
	a1 = isrem(N,27);
	a2 = a1%3;
	if ( a2 == 2 ) {
		m1 = 3;
		k1 = 1;
		L1 = list1(0);
	}
	else {
		m1 = 27;
		k1 = 4;
		L1 = msfrl(m1,a1);
	}
 
	/***    Kombination    ***/
	L = mslcra(m,m1,L,L1);
	m = m*m1;
	k = k*k1;

	/***    Modul 5^2    ***/
	a1 = isrem(N,25);
	a2 = a1%5;
	if ( a2 == 2 || a2 == 3 ) {
		m1 = 5;
		L1 = list2(a2-1,6-a2);
		k1 = 2;
	}
	else {
		m1 = 25;
		L1 = msfrl(m1,a1);
		k1 = 7;
	}

	/***    Kombination    ***/
	if ( m1 >= BASIS/m ) {
		*pm = m;
		return(L);
	}
	k = k*k1;
	L = mslcra(m,m1,L,L1);
	m = m*m1;

	/***    Module 7,11,13    ***/
	M = list3(7,11,13);
	H = list3(64,48,0);
	for ( ; ; ) {
		m1 = lfirst(M);
		M = lred(M);
		if ( m1 >= BASIS/m ) {
			*pm = m;
			return(L);
		}
		a1 = isrem(N,m1);
		L1 = msfrl(m1,a1);
		k1 = llength(L1);
		L = mslcra(m,m1,L,L1);
		m = m*m1;
		k = k*k1;
		h = lfirst(H);
		H = lred(H);
		if ( k > h ) {
			*pm = m;
			return(L);
		}
	}
}
