/*C
			invsploc( name, sch )

	"is in vector special local".    (rekursiv)
	single invsploc(name,sch); char *name; single sch;
	i = invsploc( name, sch );

	Das Programm ueberprueft, ob der Variablenname name ein Funk-
	tionsname ist. In diesem Fall wird 0 zurueckgegeben, sonst 1.
	Ist sch=1, so wird ueberprueft, ob name VNF oder VGF ist, sonst
	nicht.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1    25.05.1994      S.Schmitt/U.Schneiders
	Version  1.1  20.06.1995      S.Schmitt/U.Schneiders
H*/

# include<_calc.h>

int invsploc(name,sch)
char *name;
single sch;

{       /*** Deklarationen und Vorbesetzungen ***/

	single i, n;
	list V;
	char hname[21];
	init( V );

		
	    /*** Ueberpruefen, ob name == curEllCurve, curModulus,
		 curNumberField, curGaloisField ist ***/

	if( !strcmp( name, "curEllCurve" ) || !strcmp( name, "curModulus" ) 
         || !strcmp( name, "curNumberField" ) || !strcmp( name, "curGaloisField" ) 
         || ( strlen(name)>=2 && name[0] == AVNAME[0] && name[1]==AVNAME[1]
            && ( strlen(name)==2 || name[2]=='[' ) ) ) 
	{	mistake1(227,name);
		return(0);
	}

	     /*** Ueberpruefen, ob name = Var. des curNumberField 
		  oder des curGaloisField ist ***/

	if( sch && VNF != _0 )
	{	V = lfirst( VNF );
		n = 0;
		while( V != _0 )
		{	hname[n] = lfirst( V );
			V = lred( V );
			n++;
		}
		hname[n] = '\0';
		if( !strcmp( name, hname ) )
		{ mistake(291);
		  return(0); 
		}
	}
        if( sch && VGF != _0 )
        {	V = lfirst( VGF );
		n = 0;
		while( V != _0 )
		{	hname[n] = lfirst( V );
			V = lred( V );
			n++;
		}
		hname[n] = '\0';
		if( !strcmp( name, hname ) )
		{  mistake(292);
		   return(0);
		}
	}

	/*** Ueberpruefung des eingegebenen Variablennamen, ob
	     dieser bereits als Funktions- oder Variablenname
	     benutzt wurde ***/

	for(i=1;i<MXNUM;i++)
	{	if(!strcmp(name, varlist[i].varname))
		{
	/*** Falls ein Funktionsname als Variablenname benutzt 
			werden soll ***/

			mistake1(228,name);
			return(0);
		}

	}
	return( 1 );
}
