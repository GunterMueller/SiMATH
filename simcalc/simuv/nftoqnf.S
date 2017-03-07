/*C
			nftoqnf( a1, t1 )

	"number field to quadratic number field"
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	obj nftoqnf( a1, t1 );  obj a1; single t1;
	X = nftoqnf( a1, t1 );

	a1 is an object with reference number t1=24,-11,-12.
	a1 is an element over a quadratic number field given by
	a polynomial of the form Ax^2+Bx+C with A,B!=0.
	X is the representation of a1 as an object over the 
	quadratic number field given by the polynomial x^2-D
	with a^2-4b=Dk^2 where k is a natural number and a=B/A, 
	b=C/A.
	nftoqnf returns ERROR if an error occurs.
C*/
/*H
	Version  1      19.06.1996      S.Schmitt
	Version  1.1    03.03.1997      S.Schmitt (-11,-12)
H*/

#include <_calc.h>

obj nftoqnf( a1, t1 )
obj a1;
single t1;
{
	obj k, a, x;
	init(k, a, x);
	bind( a1 );

	if(!nfsch) return(ERROR);
	k=lfirst(varlist[nfsch].varwert);
	if(lfirst(k)!=2) return(ERROR);

	if(llength(ecqnfsch)!=3) return(a1);

	/** Die Uebergabeparameter fuer nfeltoqnfel:
	    Das Polynom ist AX^2+BX+C. **/

	a=lsecond(ecqnfsch);
	k=lthird(ecqnfsch);
	
	switch( t1 )
	{	case 24:a1=nfeltoqnfel(a1, a,k);
			break;
		case -11: 
		case -12: x=lfirst(a1);
			  a1=lsecond(a1);
			  x=nfeltoqnfel(x,a,k);
			  a1=nfeltoqnfel(a1,a,k);
			  a1=list2(x,a1);
			  break;
		default:
		        break;
	}
	
	return( a1 );
}
