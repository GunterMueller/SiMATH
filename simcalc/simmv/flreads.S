/*C
			flreads( str )

	"floating point read from string".
	floating flreads( str ); char *str;
	A = flreads( str );

	Der Zahlenstring str wird zu der floating point-Zahl A
	umgewandelt.
	Der include-file <_calc.h> wird benoetigt.
	Es werden folgende Darstellungen von A beruecksichtigt:
	- in folgenden Formaten ( n und m seien beliebige 
	  Ziffernfolgen, d positive single ) :
	    m.n e [+-]d
	    m.n E [+-]d
	    m.n
	  Dabei entspricht 'e' bzw. 'E' dem Ausdruck "* 10 ^". 
	  Entweder m oder .n koennen fehlen.
	Ist a der genaue Wert, der einzulesen ist, so gilt :
	| ( a - A ) / a | <  1/2 * (2^30)^( 1 - FL_EPS ).
C*/
/*H
	Version 1       07.01.1992      U. Schneiders
H*/
/*cS
	flreads ruft auf: flprod, flsexp, ireads, isprod, isum,
			  lcomp, linv, mistake
	Macros: isatom, isdigit, itofl, lfirst, list2, lred, sexp
Sc*/

# include <_calc.h>

floating flreads( str )
char *str;
{
	single  nkst=0, komflag = 0, vz=0;
	int expo, mant, bpot;
	init( expo, mant, bpot );
	/* nkst Anzahl Nachkommastellen
	   komflag: Flag ob Komma gesetzt  */

	/***    Nullen am Anfang    ***/
	while( *str == '0' || *str == '.' )
	{       if( *str == '.' )  komflag = 1;
		else if( komflag ) nkst++;
		str++;
	}

	if( !isdigit(*str) &&  *str != '.' )  mant = 0;
	else {
		single  a=0, b, i=0;
		list  L;
		init( L );
		L = _0;

		/***    Liste zur Basis DECBAS    ***/
		do
		{       if( *str == '.' )  komflag = 1;
			else
			{       if( komflag ) nkst++;
				a = 10*a + *str - '0';
				if ( ++i == BLOG10 )
				{       L = lcomp( a,L );
					a=i=0;
				}
			}
			str++;
		} while ( isdigit( *str ) || *str == '.' );


		/***    Basisumwandlung zu BASIS    ***/
		L = linv( L );
		mant = 0;
		while( L!=_0 )
		{       mant = isprod( mant, DECBAS );
			b = lfirst( L );  L = lred( L );
			mant = isum( mant,b );
		}
		if ( mant != 0 )  mant = isprod( mant, sexp(10,i) );
		mant = isum( mant, a );
		/***   mant ist jetzt Mantisse     ***/
	}                                           

/* ------ Eingabe dddde...  bzw ddddE....-------	*/

	if( *str == 'e' || *str == 'E' )
	{       str++;
		if( *str == '+' ) str++;
		else if( *str == '-' )
		{       str++;  vz = 1;   }
		expo = ireads( str );
		if( !isatom( expo ) )
		{       mistake( 28 );
			return( ERROR );
		}
		if( vz ) expo = -expo;
	}

/* ------------------- Berechnung des floats aus mant, expo --------------------*/

	FL_EPS++;
	expo = expo-nkst;
	bpot = flsexp(list2(0,10),expo);
	mant = itofl(mant);
	FL_EPS--;                  
	bpot = flprod(mant,bpot);      
	return( bpot);
}      
