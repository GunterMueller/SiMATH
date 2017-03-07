/*C
			PAFio ( )

	"Papanikolaou floating point package: I/O-functions"
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Flog2
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : int
* extern          : Ilog()
* error messages  : none
* side effects    : none
* algorithm       : return log2(x) in time O(log(t)) where t the
*                   precision of x
*
*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): atoF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : char s[], Float *n
* return value    : int
* extern          : Fnormalize(), Flength(), Israsint(), IdiasI(),
*                   Islasint(), ImuasD(), atoI(), cIasint(), dI(),
*                   isdigit(), malloc(), free(), atol(), strlen().
*                   abs()
* error messages  : none
* side effects    : none
* algorithm       : convert a string to Float in time O(t^2) where
*                   t the precision
*
*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ftoa
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : char s[], Float *n
* return value    : int
* extern          : Fnormalize(), Fmuas10(), cFasF(), dF(),
*                   Israsint(), atoI(), Islasint(), Iinc(), Itoa(),
*                   cIasint(), dI(), strlen(), strcat(), abs()
* error messages  : none
* side effects    : none
* algorithm       : convert a Float to a string in time O(t) where
*                   t the precision
*
*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): fprintF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : FILE *fp, Float *a
* return value    : int
* extern          : Ftoa(), Ilog(), Ifree(), putc(), malloc(),
*                   free(), sizeof()
* error messages  : fprintF: no memory available
* side effects    : none
* algorithm       : writes a Float into a file in time O(t) where
*                   t the precision
*
*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): fscanF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : FILE *fp, Float *a
* return value    : int
* extern          : atoF(), getc(), malloc(), free(), sizeof(),
*                   fseek()
* error messages  : fprintF: no memory available
* side effects    : none
* algorithm       : writes a Float into a file in time O(t) where
*                   t the precision
*
*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): printF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : char *msg, Float *a
* return value    : int
* extern          : Flog2(), Ftoa(), malloc(), free(), sizeof(),
*                   printf()
* error messages  : fprintF: no memory available
* side effects    : none
* algorithm       : writes a Float into a file in time O(t) where
*                   t the precision
*
C*/
/*H
	Version  1      17.07.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFio         : 931130
H*/                                                             

#include<_PAFarith.h>      


/*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Flog2
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : int
* extern          : Ilog()
* error messages  : none
* side effects    : none
* algorithm       : return log2(x) in time O(log(t)) where t the
*                   precision of x
*
*****************************************************************/

int
Flog2(x)
	register const Float *x;
{
	return Ilog(&(x->m));
}

/*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): atoF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : char s[], Float *n
* return value    : int
* extern          : Fnormalize(), Flength(), Israsint(), IdiasI(),
*                   Islasint(), ImuasP(), atoI(), cIasint(), dI(),
*                   isdigit(), malloc(), free(), atol(), strlen().
*                   abs()
* error messages  : none
* side effects    : none
* algorithm       : convert a string to Float in time O(t^2) where
*                   t the precision
*
*****************************************************************/

int
atoF(s, n)
	char            s[];
	register Float *n;
{
	register int    mi, ei, eii, count;
	int             l = (int)strlen(s); 
	int	        expo;
	char           *mant, *exs, c, *prec;

	mant = (char *) malloc(l + 1);
	exs = (char *) malloc(10);
	prec = (char *) malloc(10);

	for (mi = 0; mi < l+1; mi++)
		mant[mi] = '\0';
	for (ei = 0; ei < 10; ei++) {
		exs[ei] = '\0';
		prec[ei] = '\0';
	}

	mi = 0;
	ei = 0;
	eii = 0;
	count = 0;

	c = s[count];

	while (isspace(c)) {
		count++;
		c = s[count];
	}
	/*** Mantisse Sign ***/
	if (c == '-') {
		mant[mi] = c;
		count++;
		mi++;
	} else if (c == '+')
		count++;

	c = s[count];
	/*** Part x ***/
	while (isdigit(c)) {
		mant[mi] = c;
		count++;
		mi++;
		c = s[count];
	}
	/*** Radixpoint ***/
	if (c == '.') {
		count++;
		c = s[count];
	}
	/*** Part y ***/
	while (isdigit(c)) {
		mant[mi] = c;
		count++;
		mi++;
		eii--;
		c = s[count];
	}


	/*** Exponent ***/
	if (c == 'E' || c == 'e') {
		count++;
		c = s[count];
		/*** Sign ***/
		if (c == '-') {
			exs[ei] = c;
			count++;
			ei++;
		} else if (c == '+')
			count++;

		c = s[count];
		/*** Digits ***/
		while (isdigit(c)) {
			exs[ei] = c;
			count++;
			ei++;
			c = s[count];
		}
	}
	atoI(mant, &(n->m));
	expo = atol(exs) + eii;
	n->e = expo;

	if (expo == 0) {
			n->e = Flength(n);
			while ((n->m.vec[0]) == 0 && ((n->m.length) > 1))
                        Israsint(&(n->m), BitsPerDigit);
	} else if (expo > 0) {
		n->e = 0;
		Fmuas10(n, expo);
		n->e = Flength(n);
		Fnormalize(n);
		/*n->e += BinPrec; */
		while ((n->m.vec[0]) == 0 && ((n->m.length) > 1))
			Israsint(&(n->m), BitsPerDigit);
	} else {
		Integer         h1;
		long            h, j, q, r;

		cIasint(&h1, 1);
		h = (long) (abs(strlen(mant) + expo) / L2B10);
		q = -expo;

		/** 
		** for (count = 1; count <= expo; count++)
		** ImuasD(&h1, 10); 
		**/

                r = q % 9;
                for (j = 0; j < r; j++)
                        ImuasD(&h1, 10);
                q -= r;
                while (q > 0) {
                        ImuasD(&h1, BigPow10);
                        q -= LogPow10;
                }

		if (h < BinPrec)
			h = BinPrec;
		h *= 2;
		Islasint(&(n->m), h);
		IdiasI(&(n->m), &h1);
		n->e = -h + Flength(n);
		Fnormalize(n);
		/* n->e += BinPrec; */
		while ((n->m.vec[0]) == 0 && ((n->m.length) > 1))
			Israsint(&(n->m), BitsPerDigit);

		
		dI(&h1);
	}

	free(mant);
	free(exs);
	free(prec);
	return l;
}

/*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ftoa
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : char s[], Float *n
* return value    : int
* extern          : Fnormalize(), Fmuas10(), cFasF(), dF(),
*                   Israsint(), atoI(), Islasint(), Iinc(), Itoa(),
*                   cIasint(), dI(), strlen(), strcat(), abs()
* error messages  : none
* side effects    : none
* algorithm       : convert a Float to a string in time O(t) where
*                   t the precision
*
*****************************************************************/

int
Ftoa(n, s)
	register const Float *n;
	register char   s[];
{
	Float           h;
	long            e1, e2, ms = 0, cut, sl;
	int             i;
	char            ch, E[10];

	cFasF(&h, n);
	h.e = n->e - Flength(n);

	/*
	 * while (*(n->m.vec + i) == 0) i++; Israsint(&(n->m), i *
	 * BitsPerDigit); n->e += i * BitsPerDigit;
	 */


	e1 = abs(h.e);

	if (h.e > 0) {
		Islasint(&h.m, e1);
		h.e = 0;
		Itoa(&h.m, s);
		i = strlen(s);
		s[i] = '~';
		s[i + 1] = '\0';
		dF(&h);
		return (i + 1);
	} else {
		e2 = (long) (e1 * L2B10);
		Fmuas10(&h, e2);

		Israsint(&(h.m), e1);
		h.e = -e2;

		if (n->m.sign) {
			ms = 1;
			h.m.sign = !h.m.sign;
		}
		Itoa(&(h.m), s);
		sl = strlen(s);
		e1 = sl - e2;
		if (sl > DecPrec) {
			cut = DecPrec;
			ch = s[cut + 1];
			if (ch > '5')
				s[cut] += (s[cut] > '5');
			ch = s[cut];
			if (ch >= '5')
				i = 1;
			else
				i = 0;
			s[cut] = '\0';
			if (i) {
				cut--;
				while (cut >= 0 && i) {
					if (s[cut] == '9') {
						s[cut] = '0';
						cut--;
						i = 1;
					} else {
						s[cut] += 1;
						i = 0;
					}
				}
				if (cut == -1 && i) {
					int             m, l = strlen(s) + 1;
					for (m = l; m > 0; m--);
					s[m] = s[m - 1];
					s[0] = '1';
				}
			}
			sl = strlen(s) + i;
			e1 += (sl > DecPrec);
		}
		i = sl - 1;
		while (s[i] == '0' && i > (e1 - 1)) {
			s[i] = '\0';
			i--;
		}
		if ((i + 1) == e1) {
			s[i + 1] = '\0';
			sl = i + 1;
			if (ms) {
				for (i = sl; i >= 0; i--)
					s[i + 1] = s[i];
				s[0] = '-';
			}
			dF(&h);
			return (i + 1);
		}
		sl = strlen(s);
		if (e1 > 0 && e1 < sl) {
			for (i = sl + e1; i >= e1; i--) {
				s[i + 1] = s[i];
			}
			s[e1] = '.';
			sl++;
			if (ms) {
				for (i = sl; i >= 0; i--)
					s[i + 1] = s[i];
				s[0] = '-';
			}
			dF(&h);
			return (int) strlen(s);
		} else {
			for (i = sl + 3 - (!ms); i >= 3 - (!ms); i--)
				s[i] = s[i - 3 + (!ms)];
			if (ms) {
				s[0] = '-';
				s[1] = '0';
				s[2] = '.';
				sl += 3;
			} else {
				s[0] = '0';
				s[1] = '.';
				sl += 2;
			}
			if (e1 != 0) {
				s[sl] = 'e';
				s[++sl] = '\0';
				sprintf(E, "%d", e1);
				strcat(s, E);
			}
			dF(&h);
		}
	}
	/* return (int) strlen(s); */
}

/*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): fprintF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : FILE *fp, Float *a
* return value    : int
* extern          : Ftoa(), Ilog(), Ifree(), putc(), malloc(),
*                   free(), sizeof()
* error messages  : fprintF: no memory available
* side effects    : none
* algorithm       : writes a Float into a file in time O(t) where
*                   t the precision
*
*****************************************************************/

int
fprintF(fp, a)
	FILE           *fp;
	const Float    *a;
{
	char           *s;
	int             i, sl, count;
	int		l = a->e - Flength(a);
	sl = Ilog(&(a->m)) + (l > 0) * l;
	sl = sl / 3 + 20;
	s = (char *) Imalloc(sl * sizeof(char));
	if (!s)
		Ferror("fprintF: no memory available\n");
	count = Ftoa(a, s);
	for (i = 0; i <= count; i++)
		putc(s[i], fp);
	free(s);
	return count;
}

/*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): fscanF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : FILE *fp, Float *a
* return value    : int
* extern          : atoF(), getc(), malloc(), free(), sizeof(),
*                   fseek()
* error messages  : fprintF: no memory available
* side effects    : none
* algorithm       : writes a Float into a file in time O(t) where
*                   t the precision
*
*****************************************************************/

int
fscanF(fp, a)
	FILE           *fp;
	Float          *a;
{
	static char     s[100000];
	int             count = 0;
	char           *p = s;
	char            c;
	
	do {
		c = getc(fp);
		count++;
	} while (isspace(c) && c != '\n');
	if ((c == '+') || (c == '-')) {
		*p++ = c;
		c = getc(fp);
		count++;
	}
	while (isspace(c) && c != '\n') {
		c = getc(fp);
		count++;
	}
	if (!isdigit(c) && c != '.')
		Ferror("digit/point expected");
	while (isdigit(c)) {
		*p++ = c;
		c = getc(fp);
		count++;
	}
	if (c == '.') {
		*p++ = c;
		c = getc(fp);
		count++;
		while (isdigit(c)) {
			*p++ = c;
			c = getc(fp);
			count++;
		}
	}
	while (isspace(c) && c != '\n') {
		c = getc(fp);
		count++;
	}
	if (c == 'E' || c == 'e') {
		*p++ = c;
		c = getc(fp);
		count++;
		while (isspace(c) && c != '\n') {
			c = getc(fp);
			count++;
		}
		if ((c == '+') || (c == '-')) {
			*p++ = c;
			c = getc(fp);
			count++;
		}
		while (isspace(c) && c != '\n') {
			c = getc(fp);
			count++;
		}
		if (!isdigit(c))
			Ferror("digit expected");
		while (isdigit(c)) {
			*p++ = c;
			c = getc(fp);
			count++;
		}
	}
	ungetc(c, fp);
	count--;
	*p = '\0';
	atoF(s, a);
	return count;
}

/*****************************************************************
*
* filename        : io.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): fscanF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : FILE *fp, Float *a
* return value    : int
* extern          : Flog2(), Ftoa(), malloc(), free(), sizeof(),
*                   printf()
* error messages  : fprintF: no memory available
* side effects    : none
* algorithm       : writes a Float into a file in time O(t) where
*                   t the precision
*
*****************************************************************/

void
printF(msg, x)
	char            msg[];
	register const Float *x;
{
	char           *s;
	int		l = x->e - Flength(x);
	int             i = Flog2(x) +  (l > 0) * l;
	i = i / 3 + 10;
	s = (char *) malloc(i * sizeof(char));
	Ftoa(x, s);
	printf("%s%s", msg, s);
	fflush(stdout);
	free(s);
}
