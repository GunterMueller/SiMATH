/*M
.SH NAME
Sbind - initialize SIMATH-Variables with defined value

.SH SYNOPSIS 
.nf 
#include <_list.h>

int Sbind(pA)
object *pA;

Sbind(pA); 

.SH DESCRIPTION 
Sbind(&A) makes the address of the variable A 
known to the SIMATH memory management. Use Sbind(&A)  
only for varibales, whose value is defined, esp. if A is a 
parameter of a function call. For values with undefined value
use Sinit() instead. Every variable, which has been initialized
with Sbind() has to be freed with Sfree().

.SH REMARKS
A Sbind(&A) - Sfree(&A) combination is the same as bind(A), 
if you are using the SIMATH - precompiler. 

.SH WARNING
You should not mix up initializations of SIMATH variables 
by init() and bind(), which are interpreted by the SIMATH preprocessor
with initializations via Sinit() or Sbind() which are functions, 
unless you don't know exactly, what you are doing. If in doubt,  
use only init()/bind() or Sinit()/Sbind().  

.SH SEE ALSO 
.BR Sinit(),
.BR Sfree()
M*/
/*H
        Version 1       10.10.1996      Marc Conrad
   DATE Sbind   : 961201
H*/






#include <_list.h>

int Sbind(pa) 
	int *pa; 
	{        
	if( ST_SIZE <= ST_INDEX + 1 && !SIMATHinit()) {
                setstack(ST_SIZE + 125);
                }
	*(STACK+ST_INDEX++) = pa; 
	} 
