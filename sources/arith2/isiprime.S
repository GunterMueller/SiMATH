/*M
.SH NAME 
isiprime - is integer prime? is integer pseudoprime?

.SH SYNOPSIS
.nf
#include <_arith2.h>

isiprime(n)
int n; 

erg = isiprime(n); 

.SH DESCRIPTION
.TP 4
.B n 
has to be greater than 0.
.PD 0
.TP
.B erg = 1: 
n is prime,
.TP
.B erg = 0: 
n is not prime,
.TP
.B erg = -1: 
it was not possible to decide, whether n is prime or not. With 
high probability n is prime.
.RE

.SH NOTE
The function call 
.B set_pseudoprimality_only(1); 
sets a flag, which invokes isiprime()
to check only for pseudo primality, no matter if isiprime() is called
directly or indirectly, for instance by ifact(). This is 
recommended, if a proof of primality is not necessary. Especially
without the smext-extension, 
strict primality testing can be rather slow.

You can of course unset the 
pseudoprimality-flag by calling 
.B set_pseudoprimality_only(0);, 
and query for this flag by with the function 
.B single query_pseudoprimality_only().
The default value for this flag is 0.

.SH SEE ALSO
.BR isispprime(),
.BR ifact(),
.BR ifactpp().
M*/

/*H
        Version 1       27.01.1991      Georg Lay
        Version 2       23.07.1992      cornaccia ausgebaut. GL
  	Version 3	16.01.1993	isiprime ruft nur igkapt auf. GL
	Version 4	31.01.1997	Umbau wg. smext. Marc Conrad.
   DATE isiprime      : 920331.921130.930531
H*/

#include <_arith2.h>

static pseudoprimality = 0;  

int set_pseudoprimality_only( a )  
	single a; 
	{ 
	pseudoprimality = a; 
	return( 0 ); 
	} 
int query_pseudoprimality_only()  { return(pseudoprimality); } 
	


single isiprime (n)
int	         n;
{
	bind(n); 
#ifdef HAVE_SM_EXT
  if( pseudoprimality ) { 
  	if (isispprime (n,11) == NOTPRIME) return NOTPRIME; 
	else return ISAPRIME;  
	} 
  return (igkapt (n,0));
#else
  if (isispprime (n,11) == NOTPRIME)       return NOTPRIME; 

  if( pseudoprimality ) return ISAPRIME; 

  if (ilog10 (n) <= 13) return (ISAPRIME);
  return(iftpt(n, ifact(idif(n, 1)), 1000)); 
#endif
}

