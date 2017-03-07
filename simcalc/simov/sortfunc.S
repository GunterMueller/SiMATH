/*C
			sortfunc( L,aus )

	"Sortierte Ausgabe von Funktionen".
	sortfunc(L,aus); list L;single aus;
	sortfunc( L ,aus);

	Das Programm gibt die in der Funktionenliste enthaltenen 
	Funktionsnamen und zugehoerige Funktionen in lexikographisch 
	sortierter Form aus. Ist aus=0, dann wird "user defined 
	functions" nicht ausgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      10.05.1994      S.Schmitt/U.Schneiders
H*/

#include <_calc.h>
jmp_buf tes3;

void funcstop()
{
	printf(" \n **********   Output is interrupted.   **********\n\n");
	if (ps) fprintf(datei,"\nout: **********   Output is interrupted.   **********\n\n");
	longjmp(tes3,0);
}


single sortfunc( L,aus )
list L;
single aus;
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

	if(L!=_0 && aus) 
	{       printf(" user defined functions:\n" );
		if( ps ) 
		    fprintf( datei, "out: user defined functions:\n" );
	}
	while ( L != _0 ) {
		stai = ST_INDEX;
		setjmp(tes3);
		signal(SIGINT,funcstop);
		ST_INDEX = stai;
		if ( L == _0 ) break;
		l = lfirst( L );
		L = lred( L );
		ausgfunc(varlist[l].varname, varlist[l].varwert);
	}
	return(0);
}
