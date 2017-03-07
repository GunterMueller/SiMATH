/*M
	Groebner basis algorithm over the integers
	input: a list of polynomials over the integers
M*/

#include <_pol1.h>

main()
{
  single anz,met,r;
  pol    P;
  list   VL,PL,PL1;

  init(P,VL,PL,PL1);

  PL    = _0;
  GBRHO = 0;

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
  printf("\n Enter a list of polynomials over Z in the form\n");
  printf("         { p1 ... pm }\n");
  printf(" where each polynomial pi ends with a '#'.\n ");
  PL = getdipil(r,VL);

/* computation of the Groebner basis */
  printf("\n normal / recursive method ?  1 / 0 : ");
  met = getsi();
  if ( met == 1 )  PL1 = dipigb(r,PL);  /*  <---- normal Groebner basis algorithm ---- */
  else  PL1 = dipigbr(r,PL);            /*  <---- recursive Groebner basis algorithm ---- */

/* output */
  printf("\n Groebner basis:");
  putdipil(r,PL1,VL);
}
