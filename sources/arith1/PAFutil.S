/*C
			PAFutil( )

	"Papanikolaou floating point package: utilities"
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fabs
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = |x| = abs(x) in time O(1)
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fneg
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = -x in time O(1)
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ftrunc
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = integer part of x in time O(log(fractional
*                   part)
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Frndtoi
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = nearest integer of x in time O(log(t))
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fceil
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = round to ceil of x in time O(log(t))
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ffloor
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = round to floor x in time O(log(t))
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsign, Fsetsign, Fexpo, Fsetexpo, Ftype,
*                   Fsettype
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declarations
* return value    : see function declarations
* extern          :
* error messages  :
* side effects    : none
* algorithm       : time O(1)
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ferror
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : char *msg
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : print msg ane exit in time O(1)
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Flead0s, Fleadzeros, Flength
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declarations
* return value    : see function declarations
* extern          :
* error messages  :
* side effects    : none
* algorithm       : return the leading zeros of an int (of a Float)
*                   in time O(1), return the length of the mantisse
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fbinul, Fbinary
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see ...
* return value    : see ...
* extern          :
* error messages  :
* side effects    : none
* algorithm       : print the binary representation of x in time
*                   O(log(t)) where t ist the length of x
*
*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fnorm, Froundb, Fnormalize
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see ...
* return value    : see ...
* extern          :
* error messages  :
* side effects    : none
* algorithm       : normalisation of x in time O(log(t))
*
*****************************************************************
C*/
/*H
	Version  1      02.09.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2  	09.02.1994	Fehler in Frndtoi & Flfloor beseitigt.  MC
   DATE PAFutil       : 931130.940315
H*/                                                             

#include<_PAFarith.h>      
/*

*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fabs
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = |x| = abs(x) in time O(1)
*
*****************************************************************/

void
Fabs(x)
	Float          *x;
{
	x->m.sign = PLUS;
}

/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fneg
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = -x in time O(1)
*
*****************************************************************/

void
Fneg(x)
	Float          *x;
{
	x->m.sign = !x->m.sign;
}

/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ftrunc
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = integer part of x in time O(log(fractional
*                   part)
*
*****************************************************************/

void
Ftrunc(y, x)
	register Float *y;
	register const Float *x;
{
	FasF(y, x);
	Israsint(&(y->m), abs(x->e - Flength(x)));
	y->e = Flength(y);
	if (!(y->e)) {
		y->e = -BinPrec;
		y->m.sign = PLUS;
	}
}

/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Frndtoi
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = nearest integer of x in time O(log(t))
*
*****************************************************************/

void Frndtoi(y, x)
	register pFloat y;
	register const Float *x;
{
	long            e;
	long            fract;

	FasF(y, x);

	if (e = abs(y->e - Flength(y))) {     

		Israsint(&(y->m), e - 1);

		if ( Ieq0( &(y->m) ) ) { 
			Fasint( y, 0 ); 
			return; 
			}
 
		fract = y->m.vec[0] & 1;
		Isr1(&(y->m));
		if (fract)
			if (y->m.sign)
				Idec(&(y->m));
			else
				Iinc(&(y->m));
	}
	y->e = Flength(y);
	if (!(y->e)) {
		y->e = -BinPrec;
		y->m.sign = PLUS;
	}
}

/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fceil
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = round to ceil of x in time O(log(t))
*
*****************************************************************/

void
Fceil(y, x)
	register pFloat y;
	register const Float *x;
{       
	if ( Ieq0( &(x->m) ) ) { 
		Fasint( y, 0 ); 
		}
	else { 
		x->m.sign = !x->m.sign;
		Ffloor(y, x);
		if (x != y)
		    x->m.sign = !x->m.sign;
		if (y->m.length)
		    y->m.sign = !y->m.sign;
	}
}

/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ffloor
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = round to floor x in time O(log(t))
*
*****************************************************************/
/* 
Wegen eines (noch) nicht naeher identifizierten BUGS in 
Ffloor (original) hier eine andere Version: 
(die originale Version befindet sich auskommentiert weiter unten)
*/       

     
void Ffloor(y, x)
	Float *y, *x;   
	{              


	if ( x->e  >= Flength( x ) ) FasF( y, x ); 
	else { 
 	    int s; 

            s = x->m.sign; 
	    Ftrunc( y, x ); 
	     if ( s == MINUS )  
		    Fplasint( y, -1 );
	}      
}
	 
	









/*
void
Ffloor(y, x)
	register pFloat y;
	register const Float *x;
{
	long            e, fract = 0, w, b, wi, bi;
	
	FasF(y, x);
        Fnormalize(y);
	BinPrec -= 3 * BitsPerDigit;
        Fnormalize(y);         
   
	if ( Ieq0( &(y->m) ) ) { 
		Fasint( y, 0 ); 
		BinPrec += 3 * BitsPerDigit;
		return; 
		}

	if (e = abs(y->e - Flength(y)))
                if (y->m.sign) {
                        y->m.sign = !y->m.sign;
                        w = e >> LogDigit;
                        b = e % BitsPerDigit;
                        for (wi = 3; wi < w; wi++)
                                fract |= (y->m.vec[wi] != 0);
                        if (fract) {
                                Israsint(&(y->m), e); 
                                Iinc(&(y->m));
                        } else {
                                Israsint(&(y->m), w << LogDigit); 
				
                                w = y->m.vec[0];
                                bi = b;
                                while (bi--) {
                                        fract |= (w & 1);
                                        w >>= 1;
                                }
                                Israsint(&(y->m), b);
                                if (fract)
                                        Iinc(&(y->m));
                        }
                        y->m.sign = !y->m.sign;
		} else
                        Israsint(&(y->m), e);
	
	BinPrec += 3 * BitsPerDigit;
	y->e = Flength(y);
	if (!(y->e)) {
		y->e = -BinPrec;
		y->m.sign = PLUS;
	}
	
} 
*/



/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsign, Fsetsign, Fexpo, Fsetexpo, Ftype,
*                   Fsettype
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declarations
* return value    : see function declarations
* extern          :
* error messages  :
* side effects    : none
* algorithm       : time O(1)
*
*****************************************************************/

int
Fsign(x)
	Float          *x;
{
	return x->m.sign;
}

void
Fsetsign(x, s)
	Float          *x;
	int             s;
{
	x->m.sign = s;
}

long
Fexpo(x)
	Float          *x;
{
	return x->e;
}


void
Fsetexpo(x, ex)
	Float          *x;
	long            ex;
{
	x->e = ex;
}

/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ferror
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : char *msg
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : print msg ane exit in time O(1)
*
*****************************************************************/

long            ErrorHasOccured = 0;
long            ExitOnError = 1;

void
Ferror(msg)
	const char     *msg;
{
	fprintf(stderr, "\n libF error: %s\n", msg);
	ErrorHasOccured = 1;
	if (ExitOnError)
		exit(-1);
}

/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Flead0s, Fleadzeros, Flength
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declarations
* return value    : see function declarations
* extern          :
* error messages  :
* side effects    : none
* algorithm       : return the leading zeros of an int (of a Float)
*                   in time O(1), return the length of the mantisse
*
*****************************************************************/

int
Flead0s(ul)
	register unsigned long ul;
{
	register int    sc;
	static int      t[16] = {
	4, 3, 2, 2, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0};

	if (ul & (0xffff0000))
		sc = 0;
	else {
		sc = 16;
		ul <<= 16;
	}
	if (!(ul & (0xff000000))) {
		sc += 8;
		ul <<= 8;
	}
	if (ul & (0xf0000000))
		ul >>= 28;
	else {
		sc += 4;
		ul >>= 24;
	}
	sc += t[ul];
	return sc;
}

int
Fleadzeros(x)
	register pFloat x;
{
	return Flead0s(x->m.vec[x->m.length - 1]);
}

int
Flength(x)
	register const Float *x;
{
	int             l = x->m.length;
	if (!l)
		return 0;
	else
		return (l * BitsPerDigit - Flead0s((x->m.vec[l - 1])));
}

/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fbinul, Fbinary
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see ...
* return value    : see ...
* extern          :
* error messages  :
* side effects    : none
* algorithm       : print the binary representation of x in time
*                   O(log(t)) where t ist the length of x
*
*****************************************************************/

void
Fbinul(ul)
	unsigned long   ul;
{
	int             i, j = 1;
	char            out[38];
	out[0] = '[';
	out[36] = ']';
	out[37] = '\0';
	out[9] = out[18] = out[27] = ' ';
	for (i = 1; i <= BitsPerDigit; i++) {
		out[j] = (BigDigit1 & ul) ? '1' : '0';
		ul <<= 1;
		if (i % 8)
			j++;
		else
			j += 2;
	}
	printf("%s", out);
}

void
Fbinary(x)
	register pFloat x;
{
	long            e = x->e, l = x->m.length - 1;

	while (l >= 0) {
		printf("\n x[%-3ld] = ", l);
		Fbinul(x->m.vec[l]);
		l--;
	}
	printf("\n");
	printf("\n Exponent = %ld ", e);
	printf("\n");
}

/*****************************************************************
*
* filename        : util.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fnorm, Froundb, Fnormalize
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see ...
* return value    : see ...
* extern          :
* error messages  :
* side effects    : none
* algorithm       : normalisation of x in time O(log(t))
*
*****************************************************************/

void
Fnorm(x)
	register pFloat x;
{
	long            l, i;

	if (l = x->m.length) {
		i = Flead0s(x->m.vec[l - 1]);
		Islasint(&(x->m), i);
	}
}

int RoundMode = MP_RND;

void
Fnormalize(x)
	register pFloat x;
{
	int             l = Flength(x), dif;

	dif = l - BinPrec;
	if (dif > 0) {
		register int    addt;
		dif--;
		Israsint(&(x->m), dif);
		addt = (x->m.vec[0] & 1);
		Isr1(&(x->m));
		if (addt) {
			int lx = x->m.length; 
#ifdef WITH_ROUNDING_MODES
			switch (RoundMode) {
			case MP_RND:
					if (x->m.vec[0] & 1) {
						if (x->m.sign)
							Idec(&(x->m));
						else
							Iinc(&(x->m));
					}
					break;
			case MP_RND_UP:
					Iinc(&(x->m));
					break;
			case MP_RND_DOWN:
					Idec(&(x->m));
					break;
			}

#else
			
			if (x->m.sign)
				Idec(&(x->m));
			else
				Iinc(&(x->m));

#endif
			if (x->m.length > lx) {
				Isr1(&(x->m));
				x->e++;
			}
		}
	} else
		Islasint(&(x->m), -dif);
}
