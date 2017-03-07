/*C
			qnfeltonfel( A, a, k )

	"quadratic number field element to number field element"
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	nfel qnfeltonfel( A, a, k );  nfel A; rat a,k;
	X = qnfeltonfel( A, a, k );

	A ist ein Element eines quadratischen Zahlkoerpers, der
	durch das irreduzible Polynom X^2-m gegeben ist, m eine
	quadratfreie ganze Zahl, d.h. A ist dargestellt in der 
	Form 0, (HN,0,s) oder (HN,1,s,t) (vgl. isnfel). 
	a,k sind rationale Zahlen, k ungleich 0.

	Der quadratische Zahlkoerper K kann auch durch das
	irreduzible Polynom AX^2+BX+C, A,B,C ganze Zahlen, A!=0
	gegeben werden. Dabei ist dann a= B/A, C=A*b = A*(a^2-mk^2)/4.

	X ist A, gegeben durch eine Darstellung bezueglich der
	Basis 1,x0 ueber Q, wobei x0 eine Loesung von AX^2+BX+C=0 in K ist. 
C*/
/*H
	Version  1      19.06.1996      S.Schmitt
H*/

#include <_calc.h>

nfel qnfeltonfel( A, a, k )
nfel A;
rat a,k;
{	obj H,B;
	init(H, B);
	bind( A, a, k );

	if(!A || llength(A)==3) return(A);

	H=lfirst(A);
	B=lthird(A);
	A=lfourth(A);

	A=rcons(A,H);
	B=rcons(B,H);		/** Koeffizienten der Basisdarstellung
				    bzgl. 1,m^(1/2) **/

	B=rquot(B,k);
	H=rprod(a,B);
	A=rsum(A,H);

	B=rprod(B,itor(2)); 	/** Koeffizienten der Basisdarstellung
				    bzgl. 1,x0, x0 ist Loesung der Gleichung
				    AX^2+BX+C=0 **/

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
