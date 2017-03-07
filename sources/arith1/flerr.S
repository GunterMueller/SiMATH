/*M
.SH NAME
flerr - floating point overflow error handling (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

single flerr()

.SH DESCRIPTION
flerr() offers the possibility to handle overflows
that occur during floating point computations.
If flerr() is never called in main(), the program
will terminate with an error message on an overflow.
The first call of flerr() will return 0.
If a overflow now occurs during a computation,
the program will be resumed at the last
statement that called flerr(). This new call
will now return a value greater than 0.
Except for FL_EPS, all variables will hold the
values present at the time when the overflow
occurred. To ensure a well-defined value of FL_EPS
for further computations see example 2.

.SH EXAMPLE 1
The following SIMATH program reads x and calculates e^x.
In case of an overflow during the calculation,
the error message "infinity" will be displayed.
.nf

  #include<_simath.h>
  main()
  {
    floating x, result;
    init( x, result );
    x = getfl();
    if ( flerr() == 0 )
    { result = flexp( x );
      printf(" e^%p = %p",x,result);
    }
    else printf("infinity");
  }

If an overflow occurs in flexp( x ) the program will
skip back to "if ( flerr() == ... )" and continue as if
the result of flerr() was non-zero, i.e. the if-condition
is false the the else statement will be executed next.

.SH EXAMPLE 2   
The following SIMATH program reads x and calculates e^x
until the user inputs 0 as the value of x.
The calculation shall be performed with at least 10 decimal places.
On an overflow, the program shall skip back to the input statement
without notifying the user of the exception.
.nf

    #include<_simath.h>
    main()
    {
      floating x, result;
      single save_eps;

      init( x, result );

      save_eps = flinit( 10 );
      if ( flerr() != 0 ) FL_EPS = save_eps;
      while ( (x = getfl()) != 0 )
      { result = flexp( x );
        printf(" e^%p = %p",x,result);
      }

Please note that the value of FL_EPS is saved in save_eps.
Here
      save_eps = flinit( 10 );

has the same effect as

      save_eps = FL_EPS;
      flinit( 10 );

.SH CAUTION
There a two things to be aware of.
First, the value of FL_EPS may have been changed before the overflow
and may be invalid when returning to flerr().
Second, flerr() performs absolute jumps an must therefore ONLY BE USED IN THE MAIN PROGRAM!

M*/

/*H    
	Version 1       05.05.1991      Marc Conrad
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE flerr         : 910715.9112__.941201
H*/
/*
	For the definition of flerr please refer to the header file _arith1.h.
*/
