/*M
	Groebner basis algorithm over a number field
	input: a list of polynomials over a number field
M*/

#include <_pol3.h>

main()
{
  single anz,met,r;
  pol    F,P;
  list   VL,Vnf,PL,PL1;

  init(P,VL,Vnf,PL,PL1);

  PL    = _0;
  GBRHO = 0;

/* number field */
  Vnf = list1(list1('a'));  /* <-- variable list belonging to 
				   the number field elements */
  printf("\n Enter an irreducible polynomial over");
  printf(" Z generating the number field.\n F(a) = ");
  F = getpi(1,Vnf);
  F = ptodp(1,F);

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

/* list of polynomials over the specified number field */
  printf("\n Enter a list of polynomials over the");
  printf(" specified number field in the form\n");
  printf("         { p1 ... pm }\n");
  printf(" where each polynomial pi ends with a '#'.\n ");
  PL = getdipnfl(r,F,VL,Vnf);

/* computation of the Groebner basis */
  printf("\n normal / recursive method ?  1 / 0 : ");
  met = getsi();
  if ( met == 1 )  PL1 = dipnfgb(r,F,PL);  /*  <---- normal Groebner basis algorithm ---- */
  else  PL1 = dipnfgbr(r,F,PL);            /*  <---- recursive Groebner basis algorithm ---- */

/* output */
  printf("\n Groebner basis:");
  putdipnfl(r,F,PL1,VL,Vnf);
}
