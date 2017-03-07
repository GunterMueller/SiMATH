/*C
			subst( arg, P )

	"substitution".         ( rekursiv )
	list subst( arg, P );
	char * arg;
	list P;

	subst fuehrt die Substitution, die durch den Term arg angege-
	ben wird, im Polynom, rationaler Funktion, Matrix oder Vektor
	P durch und liefert die daraus resultierende Struktur zurueck.
	Wird keiner Polynomvariablen von P etwas zugewiesen,stimmen
	die Werte nicht ueberein, oder erfolgt Wertzuweisung, so wird
	-BASIS zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      25.01.88         C.Hollinger/U.Schneiders
	Version  2      30.10.89         C.Hollinger/U.Schneiders
					 ( Matrizen und Vektoren )
H*/
/*cS
	subst ist rekursiv
	und   ruft auf: isalnum, isalpha, isvarinvl, kenntest,
			mistake, peval, val, valcontrol

		Macros: lfirst, lsecond
Sc*/
 
#include<_calc.h>

list subst( arg, P )
char *arg;
list P;

{
	single h, i, j, ken, kl, klm, n, p, pos[101], wertsch;
	char hilf[21], aid[1000];
	list VL, wert, werthilf;
	bind( P );
	init( VL, wert, werthilf );

	ken = lsecond( P );
	P = lfirst( P );
	VL = lfirst( P );
	P = lsecond( P );
	while ( *arg == ' ' ) arg++;
	n = 0;
	while ( *arg != ' ' && *arg != '=' )
	{       hilf[n] = *arg;
		n++;
		arg++;
	}
	hilf[n] = '\0';

	/*** Ueberpruefung, ob hilf Polynomvariable von P ist. ***/

	pos[0] = isvarinvl( hilf,VL );
	p = 1;
	if ( !pos[0] )
	{       mistake1( 249, hilf );
		return( -BASIS );
	}
	while ( *arg != '=' ) arg++;
	arg++;

	/*** Beginn der Wertzuweisung an Polynomvariable. ***/

	wertsch = 0;
	while ( *arg != ',' && *arg != '\0' )
	{       n = 0;
		kl = 0; klm = 0;
		while ( kl != 0 || klm != 0 || (*arg != '=' && *arg != ',' && *arg != '\0' ) )
		{       aid[n] = *arg;
			switch( *arg )
			{       case '(': kl++;
					  break;
				case ')': kl--;
					  break;
				case '{': klm++;
					  break;
				case '}': klm--;
					  break;
			}
			n++;
			arg++;
		}
		if ( *arg == '=' ) arg++;
		aid[n] = '\0';
		if ( isalpha( aid[0] ) )
		{       n = 1;
			while ( isalnum( aid[n] ) ) n++;
			if ( aid[n] == '\0' )
			{       h = isvarinvl( aid,VL );
				if ( h )
				{       i = 0;
					while( i<p && pos[i] != h ) i++;
					if ( i == p )
					{       if ( p > 100 )
						{       
							mistake(314);
							return( -BASIS );
						}
						pos[p] = h;
						p++;
					}
				}
				else
				{       werthilf = val( aid );
					if( werthilf == -BASIS )    return( -BASIS );
					if( !wertsch )
					{       wert = werthilf;
						wertsch = 1;
					}
					else
					{       h = valcontrol( wert, werthilf );
						if( !h )        return( -BASIS );
					}
				}
			}
			else
			{       werthilf = val( aid );
				if( werthilf == -BASIS )    return( -BASIS );
				if( !wertsch )
				{       wert = werthilf;
					wertsch = 1;
				}
				else
				{       h = valcontrol( wert, werthilf );
					if( !h )    return( -BASIS );
				}
			}
		}
		else
		{       werthilf = val( aid );
			if( werthilf == -BASIS )   return( -BASIS );
			if( !wertsch )
			{       wert = werthilf;
				wertsch = 1;
			}
			else
			{       h = valcontrol( wert, werthilf );
				if( !h )        return( -BASIS );
			}
		}
	}

	/*** Werte Polynome P aus fuer Argumentvektor pos mit Wert wert
	     und aendere P entsprechend! ***/

	pos[ p ]= -1;
	if( !wertsch && p <= 1 )
	{       mistake( 32 );
		return( -BASIS );
	}
	if( !wertsch )   wert = _0;
	P = peval( VL, P, ken, wert, pos ); 
	if( P == -BASIS )   return( -BASIS );
	if( *arg != '\0' )      
	{       arg++;
		P = subst( arg, P );
	}
	else
	{
	       P = kenntest( P );
	}
	return( P );     
}
