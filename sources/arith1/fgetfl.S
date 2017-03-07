/*M
.SH NAME
fgetfl - file get floating point

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating fgetfl( pf )
FILE *pf;

.SH DESCRIPTION
fgetfl() returns the floating value read from the file *pf,
or ERROR in case an error occurs.
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
	Version 1       06.05.1991      Marc Conrad
	Version 2       21.08.1991      Fehler beseitigt.  MC
	Version 3	11.03.1992	Pi (=3.14...) eingebaut.  MC.
   DATE fgetfl        : 910715.910915.920331
H*/


# include <_arith1.h>

floating fgetfl(fp)
	FILE *fp;
{
	single s = 1, nkst = 0, komflag = 0, c, expo, base;
	int mant, bpot;

	init(mant, bpot);
	/*
	 * nkst Anzahl Nachkommast. komflag: Flag ob Komma gesetzt  
	 */
	c = fgetcs(fp);
/* Eingabe Liste */
	if (c == '(') {
		ungetc(c, fp);
		mant = fgetl(fp);
		if (!isfloat(mant)) {
			errmsgio("fgetfl", "EA011");
			return (ERROR);
		}
		return (mant);
	}
/* Eingabe Vorzeichen */
	while (c == '+' || c == '-') {
		s = (c == '+' ? s * 1 : s * (-1));
		c = fgetcs(fp);
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
		errmsgio("fgetfl", "EA012");
		return (ERROR);
	}
/* Eingabe Pi */
	if (c == 'P') {
		if ((c = fgetcs(fp)) == 'i') {
			bpot = flPi();
			if (s < 0)
				bpot = flneg(bpot);
			return (bpot);
		}
		ungetc(c, fp);
		c = 'P';
	}
/* sonstige Eingaben */
	/***    Fehlermeldung    ***/
	if (!isdigit(c) && !(c == ',') && !(c == '.')) {
		errmsgio("fgetfl", "EA011");
		return (ERROR);
	}
	/***    Nullen am Anfang    ***/
	while (c == '0' || c == ',' || c == '.') {
		if (c == '.' || c == ',') {
			if (komflag) {
				errmsgio("fgetfl", "EA011");
				/* Nur ein Komma */
				return (ERROR);
			} else
				komflag = 1;
		} else if (komflag)
			nkst++;
		c = getc(fp);
	}
	if (!isdigit(c) && !(c == ',') && !(c == '.'))
		mant = 0;
	else {
		single a = 0, b, i = 0;
		list L = _0;

		/***    Liste zur Basis DECBAS    ***/
		do {
			if (c == '.' || c == ',') {
				if (komflag) {
					errmsgio("fgetfl", "EA011");
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
		while (isdigit(c = getc(fp)) || c == ',' || c == '.');
		if (komflag && !nkst) {
			errmsgio("fgetfl", "EA011");
			return (ERROR);
		}
		/***    Basisumwandlung zu BASIS    ***/
		L = linv(L);
		bind(L);
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
	ungetc(c, fp);
/*   --------------------------------base , expo---------------------*/
	c = fgetcb(fp);
	s = '*';
/* ------ Eingabe Bruch -------- */
	if ((c == '/') && !komflag) {
		if ((bpot = fgeti(fp)) == ERROR) {
			errmsgio("fgetfl", "EA006");
			return (ERROR);
		}
		if (bpot)
			return (rtofl(rcons(mant, bpot)));
		else {
			errmsgio("fgetfl", "EA010");
			return (ERROR);
		}
	}
/* ------ Eingabe dddde...  bzw ddddE....-------	*/
	if (c == 'e' || c == 'E') {
		base = 10;
		if ((expo = fgetsi(fp)) == ERROR) {
			errmsgio("fgetfl", "EA011");
			return (ERROR);
		}
	}
/* --------Eingabe ...*.... ---- aber nicht ...**...---- */
	else if (c == '*' && (s = getc(fp)) != '*') {
		ungetc(s, fp);
		if ((base = fgetsi(fp)) == ERROR) {
			errmsgio("fgetfl", "EA011");
			return (ERROR);
		}
		c = fgetcb(fp);
		if (c == '^' || (c == '*' && (s = getc(fp)) == '*')) {
			if ((expo = fgetsi(fp)) == ERROR) {
				errmsgio("fgetfl", "EA011");
				return (ERROR);
			}
		} else {
			if (s != '*')
				ungetc(s, fp);
			expo = 1;
			ungetc(c, fp);
		}
		if (!base)
			mant = 0, base = 10;
	} else if (c == '^' || c == '*') {
		base = mant;
		if (!issingle(base) || komflag) {
			errmsgio("fgetfl", "EA011");
			return (ERROR);
		}
		mant = 1;
		if ((expo = fgetsi(fp)) == ERROR) {
			errmsgio("fgetfl", "EA011");
			return (ERROR);
		}
		if (!base)
			mant = 0, base = 10;

	} else {
		if (s != '*')
			ungetc(s, fp);
		ungetc(c, fp);
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
		errmsgio("fgetfl", "EA011");
		return (ERROR);
	}
	return (bpot);
}
