/*M
.SH NAME
KstrtoS - Kant string to SIMATH

.SH SYNOPSIS
.nf
#include<_arith2.h>

obj KstrtoS( a )  
char *a;
       
.SH DESCRIPTION
.TP 4
.B a
is a string.
.PP
KstrtoS decodes the string a according to the SIMATH-Kant converting rules (SDSD) and returns them as a SIMATH object (say A).

.SH NOTES
About SDSD (string data storage definition):
.PP
A SDSD string has the form
.IP
[x]y[nn]#data, where
.PP
x = p, m; y = I, R, Q; nn is the Kant precision for y = R.
.PP
Let T(y) be the type, coded in y.
For x =
.TP 4
p
, data is of the form a_n*x^e_n+...a_0*x^e_0,
a_i is of type T(y), e_i is an integer number, so A is an polynomial over T(y).
.TP 4
m
, data is of form m n a11 a12 ... amn.
A is a m x n matrix over T(y).
.PP
For y =
.TP 4
I
, data is an integer number.
.TP 4
R 
, data is of the form nnn.nnn. A is a floating point. Only the value of the SIMATH constant FL_EPS (s. flinit) determines the precision of A, and not the Kant precision.
.TP 4
Q
, data is of the form nnn/nnn. A is an rational number.

.SH SEE ALSO
 KtoS
 StoK
 StoKstr
 flinit

M*/
                                                                           
/*H
	Version  1      14.06.1993	Marc Conrad
   DATE KstrtoS       : 931130
H*/

#define   POLYNOMIAL            16	/* Bit 5 */
#define   MATRIX                32	/* Bit 6 */

#include<_pol1.h>

obj KstrtoS(a)
	char *a;
{
	char c;
	obj A;
	single et;


	init(A);

	c = *a;

	if (c == 'm') {
		a++;
		et = MATRIX;
	} else if (c == 'p') {
		a++;
		et = POLYNOMIAL;
	} else
		et = 0;

	c = *a;


	while (*a++ != '#');

	if (et == 0) {
		if (c == 'I')
			A = sgeti(&a);
		else if (c == 'R')
			A = sgetfl(&a);
		else if (c == 'Q')
			A = sgetr(&a);
	} else if (et == MATRIX) {
		single m, n, i, j;
		obj M, Z;

		init(M, Z);
		M = _0;
		m = sgetsi(&a);
		n = sgetsi(&a);
		for (i = 1; i <= m; i++) {
			Z = _0;
			for (j = 1; j <= n; j++) {
				if (c == 'I')
					A = sgeti(&a);
				else if (c == 'R')
					A = sgetfl(&a);
				else if (c == 'Q')
					A = sgetr(&a);
				Z = lcomp(A, Z);
			}
			Z = linv(Z);
			M = lcomp(Z, M);
		}
		A = linv(M);
	} else if (et == POLYNOMIAL) {

		obj M;
		pol P;
		obj E;
		single exp;

		init(M, P, E);

		P = 0;

		while (*a != '\0') {
			if (c == 'I')
				A = sgeti(&a);
			else if (c == 'R')
				A = sgetflsp(&a);
			else if (c == 'Q')
				A = sgetr(&a);

			while (!isdigit(*a))
				a++;
			exp = sgetsi(&a);
			E = list2(exp, A);
			if (c == 'I')
				P = pisum(1, P, E);
			else if (c == 'R')
				P = pflsum(1, P, E);
			else if (c == 'Q')
				P = prsum(1, P, E);
			A = P;
		}
	}
	return (A);
}
