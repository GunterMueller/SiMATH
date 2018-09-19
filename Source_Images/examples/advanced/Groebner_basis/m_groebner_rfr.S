/*M
	Groebner basis over rational functions over the rationals
	input: a list of polymials over rational functions over
	       the rationals
M*/

#include <_pol4.h>

main()
{
  single anz,met,r,r1,r2;
  rfunc  F;
  pol    P;
  list   VL,VL1,VL2,PL,PL1;

  init(F,P,VL,VL1,VL2,PL,PL1);

  PL    = _0;
  GBRHO = 0;

/* list of variables for the rational function field */
  printf("\n Enter the variable list for the rational function field\n");
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

/* list of polynomials over rational functions over the rationals */
  printf("\n Enter a list of polynomials over rational functions over the rationals\n in the form\n");
  printf("         { p1 ... pm }\n");
  printf(" where each polynomial pi ends with a '#'.\n ");
  PL = getdiprfrl(r1,r2,VL1,VL2);

/* computation of the Groebner basis */
  printf("\n normal / recursive method ?  1 / 0 : ");
  met = getsi();
  if ( met == 1 )  PL1 = diprfrgb(r1,r2,PL);  /*  <---- normal Groebner basis algorithm ---- */
  else  PL1 = diprfrgbr(r1,r2,PL);            /*  <---- recursive Groebner basis algorithm ---- */

/* output */
  printf("\n Groebner basis :");
  putdiprfrl(r1,r2,PL1,VL1,VL2);
}
