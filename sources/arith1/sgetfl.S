/*M
.SH NAME
sgetfl - string get floating point

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating sgetfl(ps)
char **ps;

.SH DESCRIPTION
sgetfl()
returns the floating point value f read from the string *ps,
or ERROR in case an error occurs.
On return, *ps points to the last character read.
The following representations of f are valid:
.nf

- integer
- fraction
- decimal formats:
  Let n and m two sequences of figures.
  Let b and d positive singles.

    [+-]m.n e [+-]d 
    [+-]m.n E [+-]d
    [+-]m.n * b ^ [+-]d 
    [+-]m.n * b ** [+-]d    
    b^[+-]d 
    b**[+-]d   
    [+-]m.n                      
    [+-]m.n * b

  Here 'e' respectively. 'E' represent the term "* 10 ^". 
  Instead of '.' the notation ',' may be used as well.
  Either m or .n may be omitted.

- SIMATH list in internal floating representation     


The character 'e' will be interpreted as the Euler constant e.
The string "Pi" will be interpreted as 3.141....

The relative rounding error of f representing the real value a is:
    | ( a - f ) / a | <  1/2 * (2^30)^( 1 - FL_EPS ).                                                          
M*/
/*H
	Version 1       15.06.1993      Marc Conrad
   DATE sgetfl        : 931130
H*/


# include <_arith1.h>

floating sgetfl(fp)
	char **fp;
{
	single s = 1, nkst = 0, komflag = 0, c, expo, base;
	int mant, bpot;

	init(mant, bpot);
/*  nkst Anzahl Nachkommast. komflag: Flag ob Komma gesetzt   */
	c = sgetcs(fp);
/* Eingabe Liste */
	if (c == '(') {
		unsgetc(c, fp);
		mant = sgetl(fp);
		if (!isfloat(mant)) {
			errmsgio("sgetfl", "EA011");
			return (ERROR);
		}
		return (mant);
	}
/* Eingabe Vorzeichen */
	while (c == '+' || c == '-') {
		s = (c == '+' ? s * 1 : s * (-1));
		c = sgetcs(fp);
	}

/* Eingabe Eulersche Zahl */

	if (c == 'e') {
		bpot = flexp(list2(0, 1));
		if (s < 0)
			bpot = flneg(bpot);
		return (bpot);
	}
/* Eingabe i */
	if (c == 'i') {
		errmsgio("sgetfl", "EA012");
		return (ERROR);
	}
/* Eingabe Pi */
	if (c == 'P') {
		if ((c = sgetcs(fp)) == 'i') {
			bpot = flPi();
			if (s < 0)
				bpot = flneg(bpot);
			return (bpot);
		}
		unsgetc(c, fp);
		c = 'P';
	}
/* sonstige Eingaben */
	/***    Fehlermeldung    ***/
	if (!isdigit(c) && !(c == ',') && !(c == '.')) {
		errmsgio("sgetfl", "EA011");
		return (ERROR);
	}
	/***    Nullen am Anfang    ***/
	while (c == '0' || c == ',' || c == '.') {
		if (c == '.' || c == ',') {
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
	if (!isdigit(c) && !(c == ',') && !(c == '.'))
		mant = 0;
	else {
		single a = 0, b, i = 0;
		list L = _0;
		bind(L);

		/***    Liste zur Basis DECBAS    ***/
		do {
			if (c == '.' || c == ',') {
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
		while (isdigit(c = sgetc(fp)) || c == ',' || c == '.');
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
	unsgetc(c, fp);
/*   --------------------------------base , expo---------------------*/
	c = sgetcb(fp);
	s = '*';
/* ------ Eingabe Bruch -------- */
	if ((c == '/') && !komflag) {
		if ((bpot = sgeti(fp)) == ERROR) {
			errmsgio("sgetfl", "EA006");
			return (ERROR);
		}
		if (bpot)
			return (rtofl(rcons(mant, bpot)));
		else {
			errmsgio("sgetfl", "EA010");
			return (ERROR);
		}
	}
/* ------ Eingabe dddde...  bzw ddddE....-------	*/
	if (c == 'e' || c == 'E') {
		base = 10;
		if ((expo = sgetsi(fp)) == ERROR) {
			errmsgio("sgetfl", "EA011");
			return (ERROR);
		}
	}
/* --------Eingabe ...*.... ---- aber nicht ...**...---- */
	else if (c == '*' && (s = sgetc(fp)) != '*') {
		unsgetc(s, fp);
		if ((base = sgetsi(fp)) == ERROR) {
			errmsgio("sgetfl", "EA011");
			return (ERROR);
		}
		c = sgetcb(fp);
		if (c == '^' || (c == '*' && (s = sgetc(fp)) == '*')) {
			if ((expo = sgetsi(fp)) == ERROR) {
				errmsgio("sgetfl", "EA011");
				return (ERROR);
			}
		} else {
			if (s != '*')
				unsgetc(s, fp);
			expo = 1;
			unsgetc(c, fp);
		}
		if (!base)
			mant = 0, base = 10;
	} else if (c == '^' || c == '*') {
		base = mant;
		if (!issingle(base) || komflag) {
			errmsgio("sgetfl", "EA011");
			return (ERROR);
		}
		mant = 1;
		if ((expo = sgetsi(fp)) == ERROR) {
			errmsgio("sgetfl", "EA011");
			return (ERROR);
		}
		if (!base)
			mant = 0, base = 10;

	} else {
		if (s != '*')
			unsgetc(s, fp);
		unsgetc(c, fp);
		base = 10;
		expo = 0;
	}

/* ------------------- Berechnung des floats aus mant, base, exp --------------------*/
	FL_EPS++;
	if (base == 10) {
		expo = expo - nkst;
		bpot = flsexp(list2(0, 10), expo);
		mant = itofl(mant);
	} else {
		mant = itofl(mant);
		mant = flprod(flsexp(list2(0, 10), -nkst), mant);
		bpot = flsexp(list2(0, base), expo);
	}
	FL_EPS--;
	bpot = flprod(mant, bpot);
	if (!isfloat(bpot)) {
		errmsgio("sgetfl", "EA011");
		return (ERROR);
	}
	return (bpot);
}
