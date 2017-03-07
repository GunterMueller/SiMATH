/*M
.SH NAME
floverflow - floating point overflow error

.SH SYNOPSIS
.nf
#include<_arith1.h>

void floverflow(a)
single a;
floverflow( a);

.SH DESCRIPTION
If flerr() has not been called before in the main program
floverflow() will write "floating point overflow (a)"
to stderr and terminate the program with exit(1).
If flerr() has been called before in the main program,
the program will resume at the statement that
called flerr() as if flerr() has returned a.
For further detail see the documentation of flerr().

.SH SEE ALSO
flerr()
M*/
/*H    
					
	Version 1       02.05.91        Marc Conrad
	Version 2       21.03.1996      Fehler behoben. Marc Conrad
   DATE floverflow    : 910715.960501
H*/

#include<_arith1.h>
void floverflow( a )
single a;
{      
if( FL_STZ == 0 ) { 
	printf(" *** Overflow error, No. %d *** \n (See the documentation of flerr() for SIMATH-handling of overflow errors.\n Bye!\n", a); 
	lend(); 
	exit(1); 
	} 
ST_INDEX = FL_STZ;
longjmp( FL_JMP, a );
}
