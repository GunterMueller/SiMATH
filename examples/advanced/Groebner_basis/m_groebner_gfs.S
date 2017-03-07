/*M
	Groebner basis algorithm over a Galois-field
	input: a list of polynomials over a Galois-field
M*/

#include <_pol3.h>

main()
{
  single anz,met,r,p,n;
  pol    P,G;
  list   AL,VL,Vgfs,PL,PL1;

  init(P,G,AL,VL,Vgfs,PL,PL1);

  PL    = _0;
  GBRHO = 0;

/* Galois-field */
  printf("\n characteristic p of the Galois-field GF(p^n): p = ");
  p = getsi();
  printf(" degree n of the Galois-field GF(p^n): n = ");
  n = getsi();
  printf(" polynomial generating the Galois-field: G(a) = ");
  Vgfs = list1(list1('a'));  /* <-- variable list belonging to
				    the Galois-field elements */
  G    = getpms(1,p,Vgfs);
  AL   = gfsalgen(p,n,G);

/* list of variables occuring in the polynomials */
  printf("\n Enter the variable list for the polynomials");
  printf(" (e.g. in the form \"x y z #\").\n");
  printf(" Please do NOT use the variable 'a'!  ");
  VL = getvl();
  r  = llength(VL);

/* term order */
  printf("\n The following term orders are possible:\n");
  printf("          - lexicographical                      ( EVORD = 1 ),\n");
  printf("          - graduated lexicographical            ( EVORD = 2 ),\n");
  printf("          - total degree ordering\n");
  printf("            (Buchberger's total degree ordering) ( EVORD = 3 ),\n");
  printf("          - lexicographical with inverse\n");
  printf("            exponent vector                      ( EVORD = 4 ).\n");
  printf(" EVORD = ");
  EVORD = getsi();

/* list of polynomials over the specified Galois-field */
  printf("\n Enter a list of polynomials over the");
  printf(" specified Galois-field in the form\n");
  printf("         { p1 ... pm }\n");
  printf(" where each polynomial pi ends with a '#'.\n ");
  PL = getdipgfsl(r,p,AL,VL,Vgfs);

/* computation of the Groebner basis */
  printf("\n normal / recursive method ?  1 / 0 : ");
  met = getsi();
  if ( met == 1 )  PL1 = dipgfsgb(r,p,AL,PL);  /*  <---- normale Groebner basis algorithm ---- */
  else  PL1 = dipgfsgbr(r,p,AL,PL);            /*  <---- recursive Groebner basis algorithm ---- */

/* output */
  printf("\n Groebner basis:");
  putdipgfsl(r,p,AL,PL1,VL,Vgfs);
}
