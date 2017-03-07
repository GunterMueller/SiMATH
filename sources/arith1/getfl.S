/*M
.SH NAME
getfl - get floating point (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating getfl()

.SH DESCRIPTION
getfl() returns the floating value f read from stdin,
or ERROR in case an error occurs.
The following representations of f are valid:
.nf

- integer
- fraction
- decimal formats:
  Let n and m two sequences of figures.
  Let b and d positive singles.

    [+-]m.n e [+-]d 
    [+-]m.n E [+-]d
    [+-]m.n * b ^ [+-]d 
    [+-]m.n * b ** [+-]d    
    b^[+-]d 
    b**[+-]d   
    [+-]m.n                      
    [+-]m.n * b

  Here 'e' respectively. 'E' represent the term "* 10 ^". 
  Instead of '.' the notation ',' may be used as well.
  Either m or .n may be omitted.

- SIMATH list in internal floating representation     


The character 'e' will be interpreted as the Euler constant e.
The string "Pi" will be interpreted as 3.141....

The relative rounding error of f representing the real value a is:
    | ( a - f ) / a | <  1/2 * (2^30)^( 1 - FL_EPS ).                                                          
M*/

/*H
	Version  1      19.03.1991      Marc Conrad
	Version  2	11.03.1992	Doku wegen Pi geaendert.  MC
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE getfl         : 910715.920331.941201
H*/
/*
	For the definition of getfl please refer to the header file _arith1.h.
*/
