/*M
.SH NAME
printf - print formated (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>
 
single printf( format [,arg]... )  
char *format;
 
.SH DESCRIPTION
At most, 26 arguments (without the format-string) are allowed. 
printf writes the arguments to stdout (according to the directions given in format). printf returns 0 by success and a negative number else.
For the format string, see CES book 2, pp 2-123. The following changes are made:

.TP 4
l 
(as prefix of d, o, u, x) is not allowed.
.TP 4
d, o, u, x
refer only to numbers of type singles.
.PP
New formats:
.TP 4
%a
decimal notation of an atom.
.TP 4
%b
binary pattern of a number of type single.
.TP 4
%i
decimal notation of an integral number.
.TP 4
%l
list.
.TP 4
%obj 
object.
.TP 4
%r
representation of a rational number as fraction.
.TP 4
%.[m]r
decimal notation of a rational number. m denotes the number of decimal digits
(%.r is equal to %.10r).
.TP 4
%[m]p
exponent-representation of a number of type real. m denotes the number of the mantissa digits (default m = 8).
.TP 4
%[n].[m]p
representation of a number of type real with n digits in front of the decimal point and m digits after. Less than n digits in front of the decimal point will be filled with blanks, more than n digits will be printed anyhow. (default n = 1, m = 8).
.TP 4
%t
(to the argument single n, n < LN-SIZE) 
The beginning of the actual line will be idented by n characters (if possible).

M*/

/*H
	Version 1       04.03.1987      R. Boeffgen
	Version 2       28.03.1991      Doku wegen floats geaendert.  MC
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE printf        : 890501.910715.941201
H*/
/*
	For the definition of printf please refer to the header file _list.h.
*/
