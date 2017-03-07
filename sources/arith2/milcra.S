/*M
.SH NAME
milcra - modular integer list chinese remainder algorithm

.SH SYNOPSIS
.nf
#include<_arith2.h>

list milcra(m1, m2, L1, L2)  
int m1, m2; 
list L1, L2;

.SH DESCRIPTION
.TP 4
.B m1, m2
are positive coprime numbers.
.TP 4
.B L1
= (a_1 ... a_m) is a list, containing elements of Z/m1*Z.
.TP 4
.B L2
= (b_1 ... b_n) is a list, containing elements of Z/m2*Z.
.PP
milcra returns a list 
.PP
L = (c_1,1 ... c_1,n ... c_m,1 ... c_m,n), 
.PP
where for 1 <= k <= n, 1 <= l <= m, c_k,l is the unique element in Z/(m1*m2)*Z, for which
.IP
c_k,l = a_k modulo m1, and
.IP
c_k,l = b_l modulo m2 
.PP
holds.

M*/
                
/*H
	Version 1	13.08.91	J.Schmitt
   DATE milcra        : 910915
H*/

# include <_arith2.h>

list milcra(m1,m2,L1,L2)
int m1,m2;
list L1,L2;
{
	int n1,a1,a2,a;
	list L,M2;

	bind(m1,m2,L1,L2);
	init(n1,a1,a2,a,L,M2);

	n1 = miinv(m2,mihom(m2,m1));
	L = _0;
	while ( L1 != _0 ) {
		a1 = lfirst(L1);
		L1 = lred(L1);
		M2 = linv(lcinv(L2));   /*    Kopie von L2      */
		while ( L2 != _0 ) {
			a2 = lfirst(L2);
			L2 = lred(L2);
			a  = micra(m1,m2,n1,a1,a2);
			L  = lcomp(a,L);
		}
		L2 = M2;                /*  urspruengliches L2  */
	}
	L = linv(L);
	return(L);
}
