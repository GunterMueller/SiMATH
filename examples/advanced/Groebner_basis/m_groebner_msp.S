/*M
	Groebner basis algorithm over Z/pZ
	(where p is a prime < BASIS, BASIS = 2^30 = 1073741824)
	input: a list of polynomials over Z/pZ
M*/

#include <_pol1.h>

main()
{
  single anz,met,r,p;
  pol    P;
  list   VL,PL,PL1;

  init(P,VL,PL,PL1);

  PL    = _0;
  GBRHO = 0;

/* prime p < BASIS */
  printf("\n Enter a prime p < BASIS : ");
  p = getsi();

/* list of variables occuring in the polynomials */
  printf("\n Enter the variable list for the polynomials\n");
  printf(" (e.g. in the form \"x y z #\") : ");
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

/* list of polynomials over Z */
  printf("\n Enter a list of polynomials over Z/pZ in the form\n");
  printf("         { p1 ... pm }\n");
  printf(" where each polynomial pi ends with a '#'.\n ");
  PL = getdipmspl(r,p,VL);

/* computation of the Groebner basis */
  printf("\n normal / recursive method ?  1 / 0 : ");
  met = getsi();
  if ( met == 1 )  PL1 = dipmspgb(r,p,PL);  /*  <---- normal Groebner basis algorithm ---- */
  else  PL1 = dipmspgbr(r,p,PL);            /*  <---- recursive Groebner basis algorithm ---- */

/* output */
  printf("\n Groebner basis:");
  putdipmspl(r,p,PL1,VL);
}
