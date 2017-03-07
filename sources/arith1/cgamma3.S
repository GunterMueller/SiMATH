/*M
.SH NAME
cgamma3 - complex gamma 3

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cgamma3(z)
complex z;

.SH DESCRIPTION
Provided that Im(z) > 0,
cgamma2() returns an approximation of the function gamma_3(z)
The relation between gamma_3(z) and the module invariants
j -> cmodinvj is j = gamma_3^2+1728
M*/

/*H
        Version 1       15.01.1994	Georg J. Lay
   DATE cgamma3	      : 941201
H*/

#include <_arith1.h>

complex cgamma3 (z)
complex z;
 {
 complex  F,f_8,f1_8,f2_8,g3;
 bind    (z);
 init    (F,f_8,f1_8,f2_8,g3);

 F = cweberfs (z);

 f_8  = csexp (lelt (F,1),8);
 f1_8 = csexp (lelt (F,2),8);
 f2_8 = csexp (lelt (F,3),8);

 g3 = cdif (f1_8, f2_8);
 g3 = cquot(g3, f_8);

 f_8 = csexp (f_8,3);
 f_8 = cisum (f_8,8);

 return (cprod (f_8,g3));
 }
