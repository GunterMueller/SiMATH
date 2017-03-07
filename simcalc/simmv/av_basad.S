/*C
			av_basad( W )

	"auxiliary variable basis administration"
	av_basad( W ); list W;

	av_basad loescht das array AV und traegt die Werte aus W ein.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1	11.04.1995	S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

av_basad( W )
list W;
{
	single j;
	obj el;
	init(el);
	bind(W);

	/*** Loeschen in AV ***/

	j=0;
	while( AV[j] && j < AVLENGTH )
	{	AV[j] = 0;
		j++;
	}

	/*** Eintragen in AV ***/

	j=0;
	while( W!=_0 )
	{	el = lfirst(W);
		W = lred(W);
		AV[j] = el;
		j++;
		if( j>= AVLENGTH )
		{	printf(" Not enough memory in AV\n" );
			if(ps) fprintf( datei, "out: Not enough memory in AV\n" );
			break;
		}
	}
}
