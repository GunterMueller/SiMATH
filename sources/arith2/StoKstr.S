/*M
.SH NAME
StoKstr - SIMATH to Kant string

.SH SYNOPSIS
.nf
#include<_arith2.h>

single StoKstr( str, D, typ, digits )  
char *str; 
obj D;
single typ, digits;
                 
.SH DESCRIPTION
.TP 4
.B str 
is a string.
.TP 4
.B D
is a SIMATH object.
.TP 4
.B type
determines the type of D (s. table below).
.TP 4
.B digits 
is the Kant precision, if type represents a floating-point and arbitrary else.  
.PP
type    |  D will be converted to a ..
        |
 1      |  integer
 2      |  floating point with
        |  Kant precision digits
 3      |  rational number
 16 + x |  polynomial over x
        |  (x = 1, 2 or 3)
 32 + x |  matrix over x
.PP  
StoKstr writes D to the string str, according to the SIMATH-Kant converting rules (SDSD). (s. also KstrtoS). Alternatively, you can use the header str_to_kant.h, included in the Kant system.  

.SH SEE ALSO
 KstrtoS
 StoK

M*/
                                         
/*H
	Version  1      14.06.1993	Marc Conrad
   DATE StoKstr       : 931130 
H*/

/* this is the header str_to_kant.h                    */
/*******************************************************/
/*        Header File for Data Exchange between        */
/*                    K A N T                          */
/*                      and                            */
/*                   S I M A T H                       */
/*******************************************************/


/* Basic types : */

#define   INTEGER               1	/* Bit 1 */
#define   REAL                  2	/* Bit 2 */
#define   RATIONAL              3	/* Bit 1 and Bit 2 */


/* Higher types : */

#define   POLYNOMIAL            16	/* Bit 5 */
#define   MATRIX                32	/* Bit 6 */




#include<_arith1.h>
char *xsgenput();

StoKstr(str, L, t, digits)
	char *str;
	list L;
	single t;
	obj digits;

{

	single et, gt;

	bind(L, digits);

	gt = t & 3;

	if (t & 16)
		*(str++) = 'p';
	else if (t & 32)
		*(str++) = 'm';


	if (gt == 1)
		*(str++) = 'I';
	else if (gt == 2) {
		*(str++) = 'R';
		sputi(digits, str);
		str += strlen(str);
	} else if (gt == 3)
		*(str++) = 'Q';

	*(str++) = '#';

	if (t & 16) {
		obj A;
		single e, sgn, vz, flag = 0;

		init(A);

		while (L != _0) {
			e = lfirst(L);
			A = lsecond(L);
			L = lred2(L);
			vz = xgensign(A, gt);

			if (!flag)
				flag = 1;
			else if (flag && (vz == 1))
				*(str++) = '+';

			str = xsgenput(A, gt, digits, str);

			*(str++) = '*';
			*(str++) = 'x';
			*(str++) = '^';

			str = xsgenput(e, 1, 0, str);
		}
	} else if (t & 32) {
		obj Z, A;

		init(Z, A);
		str = xsgenput(llength(L), 1, 0, str);
		*(str++) = ' ';
		str = xsgenput(llength(lfirst(L)), 1, 0, str);
		while (L != _0) {
			Z = lfirst(L);
			L = lred(L);
			{
				while (Z != _0) {
					*(str++) = ' ';
					str = xsgenput(lfirst(Z), gt, digits, str);
					Z = lred(Z);
				}
			}
		}
	} else
		xsgenput(L, gt, digits, str);

	return (1);
}
single xgensign(L, gt)
	obj L;
	single gt;

{
	if (gt == 1)
		return (isign(L));
	else if (gt == 2)
		return (flsign(L));
	else if (gt == 3)
		return (rsign(L));
}


char *xsgenput(L, gt, digits, str)
	list L;
	single digits, gt;
	char *str;

{
	bind(L);

	if (gt == 1)
		sputi(L, str);
	else if (gt == 2)
		sputflsp(digits, L, str);
	else if (gt == 3)
		sputr(L, str);

	return (str + strlen(str));
}
