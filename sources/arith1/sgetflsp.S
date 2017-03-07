/*M
.SH NAME
sgetflsp - string get floating point special version

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating sgetflsp(ps)
char **ps;

.SH DESCRIPTION
sgetflsp()
returns the floating point value read from the string *ps,
or ERROR in case an error occurs.
On return, *ps points to the last character read.
The following representations of f are valid:
.nf

- integer
- fraction
- decimal formats:
  Let n and m two sequences of figures.
  Let b and d positive singles.

    [+-]m.ne[+-]d 
    [+-]m.n                      
  
  Here 'e' respectively. 'E' represent the term "* 10 ^". 
  Either m or .n may be omitted.

The relative rounding error of f representing the real value a is:
    | ( a - f ) / a | <  1/2 * (2^30)^( 1 - FL_EPS ).                                                        

The purpose of sgetflsp() is to prevent misunderstandings
when reading characters such as ',', 'e', 'E', '*', '^' 
in a matrix or a polynomial including floating point numbers.

.SH SEE ALSO
sgetfl

M*/

/*H
	Version 1       15.06.1993      Marc Conrad
   DATE sgetflsp      : 931130
H*/


# include <_arith1.h>

floating sgetflsp(fp)
	char **fp;
{
	single s = 1, nkst = 0, komflag = 0, c, expo, base;
	int mant, bpot;

	init(mant, bpot);

/*  nkst Anzahl Nachkommast. komflag: Flag ob Komma gesetzt   */

	c = sgetcs(fp);
/* Eingabe Liste (verboten) */
/* Eingabe Vorzeichen */
	while (c == '+' || c == '-') {
		s = (c == '+' ? s * 1 : s * (-1));
		c = sgetcs(fp);
	}

/* Eingabe Eulersche Zahl */
/* Eingabe i */
/* Eingabe Pi */

/* sonstige Eingaben */
	/***    Fehlermeldung    ***/
	if (!isdigit(c) && !(c == '.')) {
		errmsgio("sgetfl", "EA011");
		return (ERROR);
	}
	/***    Nullen am Anfang    ***/
	while (c == '0' || c == '.') {
		if (c == '.') {
			if (komflag) {
				errmsgio("sgetfl", "EA011");
				/* Nur ein Komma */
				return (ERROR);
			} else
				komflag = 1;
		} else if (komflag)
			nkst++;
		c = sgetc(fp);
	}
	if (!isdigit(c) && !(c == '.'))
		mant = 0;
	else {
		single a = 0, b, i = 0;
		list L = _0;
		bind(L);

		/***    Liste zur Basis DECBAS    ***/
		do {
			if (c == '.') {
				if (komflag) {
					errmsgio("sgetfl", "EA011");
					return (ERROR);
				} else
					komflag = 1;
			} else {
				if (komflag)
					nkst++;
				a = 10 * a + c - '0';
				if (++i == BLOG10)
					L = lcomp(a, L), a = i = 0;
			}
		}
		while (isdigit(c = sgetc(fp)) || c == '.');
		if (komflag && !nkst) {
			errmsgio("sgetfl", "EA011");
			return (ERROR);
		}
		/***    Basisumwandlung zu BASIS    ***/
		L = linv(L);

		mant = 0;
		while (L != _0) {
			mant = isprod(mant, DECBAS);
			b = lfirst(L), L = lred(L);
			mant = isum(mant, b);
		}
		if (mant != 0)
			mant = isprod(mant, sexp(10, i));
		mant = isum(mant, a);
		if (s < 0)
			mant = ineg(mant);
/***   mant ist jetzt Mantisse     ***/
	}
/*   --------------------------------base , expo---------------------*/
/* ------ Eingabe Bruch -------- */
/* ------ Eingabe dddde... -------	*/
	if (c == 'e') {
		if ((expo = sgetsi(fp)) == ERROR) {
			errmsgio("sgetfl", "EA011");
			return (ERROR);
		}
	} else {
		unsgetc(c, fp);
		expo = 0;
	}

/* ------------------- Berechnung des floats aus mant, base, exp --------------------*/
	FL_EPS++;
	expo = expo - nkst;
	bpot = flsexp(list2(0, 10), expo);
	mant = itofl(mant);
	FL_EPS--;
	bpot = flprod(mant, bpot);
	if (!isfloat(bpot)) {
		errmsgio("sgetfl", "EA011");
		return (ERROR);
	}
	return (bpot);
}
