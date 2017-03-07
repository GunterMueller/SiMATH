/*M
	Groebner basis algorithm over polynomials over the integers
	input: a list of polynomials over polynomials over the integers
M*/

#include <_pol2.h>

main()
{
  single anz,met,r,r1,r2;
  pol    P;
  list   VL,VL1,VL2,PL,PL1;

  init(P,VL,VL1,VL2,PL,PL1);

  PL   = _0;
  GBRHO = 0;

/* list of variables occuring in the coefficients */
  printf("\n Enter the variable list for the coefficients\n");
  printf(" (e.g. in the form \"a b c #\") : ");
  VL2 = getvl();
  r2  = llength(VL2);

/* list of variables occuring in the polynomials */
  printf("\n Enter the variable list for the polynomials\n");
  printf(" (e.g. in the form \"x y z #\") : ");
  VL1 = getvl();
  r1  = llength(VL1);

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

/* list of polynomials over polynomials over Z */
  printf("\n Enter a list of polynomials over polynomials over Z in the form\n");
  printf("         { p1 ... pm }\n");
  printf(" where each polynomial pi ends with a '#'.\n ");
  PL = getdippil(r1,r2,VL1,VL2);

/* computation of the Groebner basis */
  printf("\n normal / recursive method ?  1 / 0 : ");
  met = getsi();
  if ( met == 1 )  PL1 = dippigb(r1,r2,PL);  /*  <---- normal Groebner basis algorithm ---- */
  else  PL1 = dippigbr(r1,r2,PL);            /*  <---- recursive Groebner basis algorithm ---- */

/* output */
  printf("\n Groebner basis:");
  putdippil(r1,r2,PL1,VL1,VL2);
}
