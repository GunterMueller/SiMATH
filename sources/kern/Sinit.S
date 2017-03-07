/*M
.SH NAME
Sinit - initialize SIMATH-Variables with undefined value

.SH SYNOPSIS 
.nf 
#include <_list.h>

int Sinit(pA)
object *pA;

Sbind(pA); 

.SH DESCRIPTION 
Sinit(&A) makes the address of the variable A 
known to the SIMATH memory management. Use Sinit(&A)  
only for varibales, whose value is undefined, esp. if A is a 
local parameter. For values with defined value
use Sbind() instead. Every variable, which has been initialized
with Sinit() has to be freed with Sfree().

.SH REMARKS
A Sinit(&A) - Sfree(&A) combination is the same as init(A), 
if you are using the SIMATH - precompiler. 

.SH WARNING
You should not mix up initializations of SIMATH variables 
by init() and bind(), which are interpreted by the SIMATH preprocessor
with initializations via Sinit() or Sbind() which are functions, 
unless you don't know exactly, what you are doing. If in doubt, 
use only init()/bind() or Sinit()/Sbind().  

.SH SEE ALSO 
.BR Sbind(),
.BR Sfree()
M*/
/*H
        Version 1       10.10.1996      Marc Conrad
   DATE Sinit   : 961201
H*/

#include <_list.h>

int Sinit(pa) 
	int *pa; 
	{ 
	if( ST_SIZE <= ST_INDEX + 1 && !SIMATHinit()) { 
		setstack(ST_SIZE + 125); 
		} 
	*(STACK+ST_INDEX++) = pa; 
	*pa = 0; 
	} 
