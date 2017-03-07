/*C
			av_loesche( k )

	"auxiliary variable loeschen"
	av_loesche( k ); single k;

	k ist eine der Kennungen 16, 23, 30.
	av_loesche loescht das array AV, falls in AV eine entsprechende
	Kennung vorkommt.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1	25.04.1995	S.Schmitt
H*/

#include <_calc.h>

av_loesche( k )
single k;
{
	single j,ken,l;
	obj el;
	init(el);

	j=0; l=0;
	while( AV[j] && j<AVLENGTH )
	{	el = AV[j];
		j++;
		ken=lsecond(el);
		switch(k)
		{	case 16: if( (ken>=16 && ken<=22) 
				  || (ken>=(-8) && ken<=(-5)) ) l=1;
				 break;
			case 23: if( (ken>=23 && ken<=29) 
				  || (ken>=(-12) && ken<=(-9)) ) l=1;
				 break;
			case 30: if( (ken>=30 && ken<=36) 
     				  || (ken>=(-16) && ken<=(-13)) ) l=1;
				 break;
			default: break;
		}
		if(l) 
		{	el=_0;
			av_basad(el);
		        printf(" The variables in %s are deleted.\n",AVNAME );
		        if(ps) fprintf(datei, "out: The variables in %s are deleted.\n",AVNAME );
			break;
		}
	}
}
