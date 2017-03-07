/*C
			sortaus( L )

	"Sortierte Ausgabe".
	sortaus(L); list L;
	sortaus( L );

	Das Programm gibt die in der Variablenliste enthaltenen Variablen
	und zugehoerige Werte in lexikographisch sortierter Form aus.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      17.08.1987      M.Mang
	Version  2      10.01.1990      U.Schneiders
	Version  3      23.08.1991      U.Schneiders  ( L speichert Feld-
							nr. in varlist )
H*/
/*cS
	sortaus ruft auf:  ausgabe, strcmp
		  Macros:  fprintf, lfirst, lred, lsecond, lsfirst, printf
Sc*/

#include <_calc.h>
jmp_buf tes2;

void ausstop()
{
	printf(" \n **********   Output is interrupted.   **********\n\n");
	if (ps) fprintf(datei,"\nout: **********   Output is interrupted.   **********\n\n");
	longjmp(tes2,0);
}


single sortaus( L )
list L;
{
	list a,L1,L2,M,M1;
	single  l, k, sch=0, stai;
	init(a,L1,L2,M,M1);
	bind( L );

	if ( L==_0 ) return(0);
	M = _0; a = _0;
	do {
		L1 = L;
		l = lfirst( L1 );
		M1 = _0;
		while ( (L2 = lred(L1)) != M ) {
			k = lfirst( L2 );
			if ( strcmp(varlist[l].varname, varlist[k].varname ) > 0 ) {
				lsfirst( L1,k );
				lsfirst( L2,l );
				M1 = L2;
			}
			else l = k;
			L1 = L2;
		}
	}
	while ( (M=M1) != _0 );
	while ( L != _0 ) {
		stai = ST_INDEX;
		setjmp(tes2);
		signal(SIGINT,ausstop);
		ST_INDEX = stai;
		if ( L == _0 ) break;
		l = lfirst( L );
		L = lred( L );
		if(varlist[l].typ != 2 && varlist[l].typ!=(-3))
		{	a = varlist[l].varwert;
			k = lsecond( a );
			if( sch && ( ( k > 4 && k < 10 ) || ( k > 18 && k < 21 ) || ( k > 25 && k < 28 ) || ( k > 32 && k < 35 ) ) )
			{       printf("\n");
				if( ps ) fprintf( datei, "\n" );
			}
			ausgabe( "", varlist[l].varname, a, 0 );
			sch = 1;
		}
	}
	return(0);
}
