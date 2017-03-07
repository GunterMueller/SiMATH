/*C
			nfeltoqnfel( A, a, k )

	"number field element to quadratic number field element"
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	nfel nfeltoqnfel( A, a, k );  nfel A; rat a,k;
	X = nfeltoqnfel( A, a, k );

	A ist ein Element eines quadratischen Zahlkoerpers, d.h.
	A ist dargestellt in der Form 0, (HN,0,s) oder (HN,1,s,t)
	(vgl. isnfel). a,k sind rationale Zahlen.

	Der quadratische Zahlkoerper K ist gegeben durch das
	irreduzible Polynom AX^2+BX+C, A,B,C ganze Zahlen, A!=0. Dann
	berechnen sich a= B/A, b=C/A, mk^2=a^2-4b,
	wobei k eine rationale Zahl ungleich 0 sein soll und m eine
	quadratfreie ganze Zahl. Dann ist K=Q(m^(1/2)).

	X ist A, gegeben durch eine Darstellung bezueglich der
	Basis 1,m^(1/2) ueber Q. 
C*/
/*H
	Version  1      19.06.1996      S.Schmitt
H*/

#include <_calc.h>

nfel nfeltoqnfel( A, a, k )
nfel A;
rat a,k;
{	obj H,B;
	init(H, B);
	bind( A, a, k );

	/** A = 0 oder A aus Q **/

	if(!A || llength(A)==3) return(A);

	H=lfirst(A);
	B=lthird(A);
	A=lfourth(A);

	A=rcons(A,H);
	B=rcons(B,H);		/** die Koeffizienten der Basisdarstellung
				    bzgl. 1,x0, dabei ist x0 Loesung der
				    Gleichung AX^2+BX+C=0  **/ 

	B=rquot(B,itor(2));
	H=rprod(a,B);
	A=rdif(A,H);

	B=rprod(B,k);		/** Koeffizienten der Basisdarstellung 
				    bzgl. 1,m^(1/2). **/

	H=rden(A);
	a=rden(B);
	H=ilcm(H,a);
	
	A=rprod(A,itor(H));
	A=rnum(A);
	B=rprod(B,itor(H));
	B=rnum(B);

	A=list4(H,1,B,A);	/** Interne Darstellung **/
	
	return( A );
}
