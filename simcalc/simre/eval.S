/*C
			eval( keller, vprio )

	"evaluation".
	list eval(keller,vprio); list keller; single *vprio;
	kelleraus = eval( keller, vprio );

	Die erste Operation, in dem von der Kellerverwaltung ( basad )
	aufgebauten Keller, wird ausgefuehrt. Dabei werden die zu
	der Operation gehoerigen Objekte dem Keller entnommen und
	das Ergebnis der Operation in den Keller aufgenommen.
	Die Prioritaet der naechsten in keller stehenden Operation
	wird *vprio zugewiesen.
	Laeuft eval fehlerhaft ab, so ist kelleraus = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      01.06.1987      H.Stroeher/M.Mang
	Version  1.1    27.01.1992      U.Schneiders
H*/
 
#include <_calc.h>
list eval( keller, vprio )
list keller;
single *vprio;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj a1, a2, erg;
	single t1, t2;
	list kelleraus;
	char op;
	init( a1, a2, erg, kelleraus );
	bind( keller );

	/*** Erkennung des Operators, der zu verknuepfenden Elemente,
	     Entnahme aus dem Keller und Auswertung ***/

	a1 = lfirst( lfirst( keller ) );
	t1 = lsecond( lfirst( keller ) );
	keller = lred( keller );
	op = lfirst( lfirst( keller ) );
	keller = lred( keller );
	if ( op != '#' ) {
		if ( keller == _0 )
		{       mistake( 26 );
			return( -BASIS );
		}
		a2 = lfirst( lfirst( keller ) );
		t2 = lsecond( lfirst( keller ) );
		keller = lred( keller );
	}

	if( flerr() )
	{       FL_EPS = smax( flinit( DIGITS ), 5 );
		mistake( 28 );
		return( ERROR );
	}

	switch( op ) {
		case '+': erg = calc_sum( a1, a2, t1, t2 );
			  break;
		case '*': erg = calc_prod( a1, a2, t1, t2 );
			  break;
		case '-': erg = calc_dif( a1, a2, t1, t2 );
			  break;
		case ':': erg = calc_quot( a1, a2, t1, t2 );
			  break;
		case '/': erg = calc_cons( a1, a2, t1, t2 );
			  break;
		case '^': erg = calc_exp( a1, a2, t1, t2 );
			  break;
		case '#': erg = calc_neg( a1, t1 );
			  break;
		case 'm': erg = calc_mod( a1, a2, t1, t2 );
			  break;
		case '<': erg = calc_le(a1,a2,t1,t2);
			  break;
		case '$': erg = calc_leq(a1,a2,t1,t2);
			  break;
		case '>': erg = calc_ge(a1,a2,t1,t2);
			  break;
		case '%': erg = calc_geq(a1,a2,t1,t2);
			  break;
		case '~': erg = calc_equ(a1,a2,t1,t2);
			  break;
		case '_': erg = calc_nequ(a1,a2,t1,t2);
			  break;
		case '&': erg = calc_and(a1,a2,t1,t2);
			  break;
		case '|': erg = calc_or(a1,a2,t1,t2);
			  break; 
	}

	if( erg == -BASIS ) return( -BASIS );

	/*** Anpassung der Kennung ***/

	switch(lsecond(erg))
	{	case 15:erg = lfirst( erg );
			erg = fltofl( erg );
			erg = list2( erg, 15 );
			break;
		case 37:erg=lfirst(erg);
			erg=ctoc(erg);
			erg=list2(erg,37);
			break;
		case 38:erg=lfirst(erg);
			a1=lfirst(erg);
			t1=llength(a1);
			erg=lsecond(erg);
			erg=pfltopfl(t1,erg);
			erg=list2(a1,erg);
			erg=list2(erg,38);
			break;
		case 39:erg=lfirst(erg);
			a1=lfirst(erg);
			t1=llength(a1);
			erg=lsecond(erg);
			erg=pctopc(t1,erg);
			erg=list2(a1,erg);
			erg=list2(erg,39);
			break;
		default:break;
	}
	erg = kenntest( erg );

	/*** Neuaufbau des Kellerinhaltes und Berechnung von *vprio ***/

	if ( keller == _0 ) *vprio = -2;
	else *vprio = lsecond( lfirst( keller ) );
	kelleraus = lcomp( erg, keller );
	return( kelleraus );
}
