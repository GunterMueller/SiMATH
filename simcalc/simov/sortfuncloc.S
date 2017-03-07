/*C
			sortfuncloc( L )

	"Sortierte Ausgabe von Funktionen lokal".
	sortfuncloc(L); list L;
	sortfuncloc( L );

	Das Programm gibt die in der lokalen Funktionenliste 
	enthaltenen Funktionsnamen und zugehoerige Funktionen in 
	lexikographisch sortierter Form aus. 
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      26.05.1994      S.Schmitt/U.Schneiders
H*/

#include <_calc.h>
jmp_buf tes5;

void funcstoploc()
{
	printf(" \n **********   Output is interrupted.   **********\n\n");
	if (ps) fprintf(datei,"\nout: **********   Output is interrupted.   **********\n\n");
	longjmp(tes5,0);
}


single sortfuncloc( L )
list L;
{
	list a,L1,L2,M,M1;
	single  l, k, stai;
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
			if ( strcmp(localvar[l].varname, localvar[k].varname ) > 0 ) {
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
		setjmp(tes5);
		signal(SIGINT,funcstoploc);
		ST_INDEX = stai;
		if ( L == _0 ) break;
		l = lfirst( L );
		L = lred( L );
		ausgfunc(localvar[l].varname, localvar[l].varwert);
	}
	return(0);
}
