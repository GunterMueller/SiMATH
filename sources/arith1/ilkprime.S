/*M
.SH NAME
ilkprime - integer largest known prime

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ilkprime()

.SH DESCRIPTION
ilkprime() returns the largest currently known prime number.
This refers to the end of 1999. 

.SH SEE ALSO
http://www.utm.edu/research/primes/largest.html

M*/
/*H
	Version  1      07.10.1992      Marc Conrad
	Version  2      13.01.1994      Marc Conrad
   DATE ilkprime      : 921130.941201
H*/

#include<_arith1.h>
int ilkprime()
{
	int P;
	single i;

	init(P);

/*  
(Version 1)
P = 2^756839  - 1   

	P = list1(536870911);
	for (i = 1; i < 25228; i++)
		P = lcomp(1073741823, P);
*/       
                                       
/* P = 2^859433 - 1  found by Paul Cage & David Slowinski 
	P = list1( 8388607 );
	for (i = 1; i < 28648 ; i++)
		P = lcomp(1073741823, P);
*/
/* P = 2^6972593 - 1 found by Hajrawala et. al. */ 
	P = list1( 8388607 );
	for (i = 0; i < 232419 ; i++)
		P = lcomp(1073741823, P);
	return (P);
}

/* 
 xxxxxxxxmain() { 
   floating f; 
   init(f);  
   f = ilkprime(); 
   printf("lf = %d\n", llength(f));  
   f = itofl(f); 
   printf("f = %p\n", f); 
   } 
*/
