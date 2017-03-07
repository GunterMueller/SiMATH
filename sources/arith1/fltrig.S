/*M
.SH NAME
fltrig - floating point trigonometric functions (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h> or <_PAFarith.h>  - see below

floating fltrig(Ffunc, f)
void (*Ffunc)();
floating f;

.SH DESCRIPTION
fltrig() returns Ffunc(f).
.PP
.TP 4
.B Ffunc
is one of the following (trigonometric) functions:
Fsin, Fcos, Ftan, Fcot, Fsinh, Fcosh, Ftanh, Fcoth, Fasin,
Facos, Fatan, Facot, Fasinh, Facosh, Fatanh, Facoth, Fasin, 
Facos, Fatan, Facot, Fasinh, Facosh, Fatanh, Facoth   

.TP 4
.B f
must be a value from the domain of Ffunc (c.f. remark 2)

.SH REMARK 1
The function Ffunc must be declared as an external function
returning void.
If the header _PAFarith.h is used instead of _arith1.h,
then the function Ffunc must not be declared since this
is already done _PAFarith.h. I.e. you can either write
.nf

#include<_arith1.h>
void Fcosh();  
...
g = fltrig( Fcosh, f ); 
...

or

#include<_PAFarith.h>
...
g = fltrig( Fcosh, f ); 
...                            

.SH REMARK 2
The functions are implemented using the Papanikolaou
floating point package (PAF). As a consequence some things
such as overflow-handling using flerr() is not possible.
In addition occurring error messages do not conform the SIMATH
standard. The range of valid values f is also depending on
the implementation of Ffunc in the PAF. Calculations within
PAF are performed with a precision determined by FL_EPS (cf. flinit).
See also the documentation of flPAFfu, PAFtrans1, PAFtrans2 and PAFtrans3.

.SH REMARK 3
For "normal" values of f, remark 2 can be ignored.

M*/
/*H
	Version 1       27.08.1993      Marc Conrad
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fltrig        : 931130.941201
H*/
/*
	For the definition of fltrig please refer to the header file _arith1.h.
*/
