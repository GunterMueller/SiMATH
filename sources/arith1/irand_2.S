/*M
.SH NAME
irand_2 - integer randomise, alternative version
.SH SYNOPSIS
.nf
#include <_arith1.h>

int irand_2 (u)
single u;

.SH DESCRIPTION
For u>0
irand() returns a random integer Z with BASIS^(u-1) <= |Z| < BASIS^u.
To produce the random result, irand_2 only uses the C-function rand().
Therefore the C-function srand(a) may be used to initialise the
random generator with a seed value in order to achieve results
that may be reproduced deterministically.

.SH SEE ALSO
irand and the C-functions rand, srand
M*/

/*H
	Version 1	04.06.1992	Marc Conrad    
   DATE irand_2       : 921130.9305__
H*/

#include<_arith1.h>

irand_2(u)
	single u;
{
	single i, s, t, vz;
	list L;

	init(L);

	L = _0;
	s = 0;

	if ((rand() % 37) % 2)
		vz = 1;
	else
		vz = 0;

	if (u < 2) {
		L = (rand() % BASIS);
		if (vz)
			L = -L;
	} else {
		for (i = 0; i < u; i++) {
			t = (rand() % BASIS);
			if (!s && !t)
				u++;
			else {
				s = 1;
				if (vz)
					t = -t;
				L = lcomp(t, L);
			}
		}
	}
	return (L);
}
