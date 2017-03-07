/*M
.SH NAME
flPAFfu - floating point using Papanikolaou floating point functions

.SH SYNOPSIS
.nf
#include<_PAFarith1.h>

floating flPAFfu(func, anzahlargs, arg1, arg2)
void (*func)();
single anzahlargs;
floating arg1, arg2;

.SH DESCRIPTION
flPAFfu() converts the input parameters arg1 and arg2 according to the conventions of the Papanikoloau floating point package and then applies the function func to them. The precision being used is given by the SIMATH variable FL_EPS, i.e. the precision of the PAF-arithmetic is adjusted to FL_EPS.


.PP
.TP 4
.B func
is one of the PAF-functions listed below. More detailed information and restrictions on the use of the functions can be found in the documentation in "file".

.TP 4
.B anzahlargs
is the number of arguments used by func.

.nf
  func       |    anzahlargs   |   file 
-------------+-----------------+--------------  
  Fsqrt      |        1        |   PAFtrans1
  Fexp       |        1        |   PAFtrans1
  Flog       |        1        |   PAFtrans1
  FsqrF      |        1        |   PAFtrans1
  FasFpowF   |        2        |   PAFtrans1   
  Fe         |        0        |   PAFtrans2   
  Fpi        |        0        |   PAFtrans2   
  Feuler     |        0        |   PAFtrans2   
  Fcatalan   |        0        |   PAFtrans2   
  Fsin       |        1        |   PAFtrans2   
  Fcos       |        1        |   PAFtrans2   
  Ftan       |        1        |   PAFtrans2   
  Fcot       |        1        |   PAFtrans2   
  Fsinh      |        1        |   PAFtrans2   
  Fcosh      |        1        |   PAFtrans2   
  Ftanh      |        1        |   PAFtrans2   
  Fcoth      |        1        |   PAFtrans2   
  Fasin      |        1        |   PAFtrans3
  Facos      |        1        |   PAFtrans3
  Fatan      |        1        |   PAFtrans3
  Facot      |        1        |   PAFtrans3
  Fasinh     |        1        |   PAFtrans3
  Facosh     |        1        |   PAFtrans3
  Fatanh     |        1        |   PAFtrans3
  Facoth     |        1        |   PAFtrans3
  Fasin      |        1        |   PAFtrans3
  Facos      |        1        |   PAFtrans3
  Fatan      |        1        |   PAFtrans3
  Facot      |        1        |   PAFtrans3
  Fasinh     |        1        |   PAFtrans3
  Facosh     |        1        |   PAFtrans3
  Fatanh     |        1        |   PAFtrans3
  Facoth     |        1        |   PAFtrans3

.SH EXAMPLE
.nf

g = asin( f )   has to be written as   g = flPAFfu( Fasin, 1, f, 0 ); 
g = Pi          has to be written as   g = flPAFfu( Fpi, 0, 0, 0 ); 
g = f^e         has to be written as   g = flPAFfu( FasFpowF, 2, f, e );

.SH SEE ALSO
PAFtofl, fltoPAF
M*/

/*H
	Version 1       02.09.1993      Marc Conrad
   DATE flPAFfu       : 931130
H*/

#include<_PAFarith.h>


int flPAFfu(func, anzahlargs, arg1, arg2)
	void (*func) ();
single anzahlargs;
obj arg1, arg2;

{
	single d;
	Float y;

	bind(arg1, arg2);
	d = (int) floor((FL_EPS - 1) * 9.0308998699194 + 2);
        
	Fsetprec(d);
	cF(&y);


	if (anzahlargs == 0) {
		(*func) (&y);
	} else if (anzahlargs == 1) {
		Float a;

		cF(&a);
		fltoPAF(arg1, &a);
		(*func) (&y, &a);
		dF(&a);
	} else if (anzahlargs == 2) {
		Float a, b;

		cF(&a);
		cF(&b);
		fltoPAF(arg1, &a);
		fltoPAF(arg2, &b);
		(*func) (&y, &a, &b);
		dF(&a);
		dF(&b);
	}
	arg1 = PAFtofl(&y);
	dF(&y);
	return (arg1);
}           









