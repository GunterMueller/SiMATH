/*C
			invectsp( name )

	"is in vector special".    (rekursiv)
	single invectsp(name); char *name;
	i = invectsp( name );

	Das Programm ueberprueft, ob der Variablenname name ein Funk-
	tionsname oder eine Unbestimmte eines Polynoms ist. In diesem
	Fall wird ERROR zurueckgegeben.
	Falls die Variable schon existiert, gibt der Wert i die Stelle 
	im aktuellen Variablenspeicher an, an der die Variable steht.
	Falls die Variable noch nicht existiert, wird der Wert MX
	zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1    01.12.1993      S.Schmitt/U.Schneiders
H*/

# include<_calc.h>

int invectsp(name)
char *name;

{       /*** Deklarationen und Vorbesetzungen ***/

	single i=0, n, sch;
	list V;
	char hname[21];
	init( V );

		
	    /*** Ueberpruefen, ob name == curEllCurve, curModulus,
		 curNumberField, curGaloisField, AV([...) ist ***/

	if( !strcmp( name, "curEllCurve" ) || !strcmp( name, "curModulus" ) 
         || !strcmp( name, "curNumberField" ) || !strcmp( name, "curGaloisField" )
         || ( strlen(name)>=2 && name[0] == AVNAME[0] && name[1]==AVNAME[1]
            && ( strlen(name)==2 || name[2]=='[' ) ) ) 
	{	mistake1(227,name);
		return(ERROR);
	}

	     /*** Ueberpruefen, ob name = Var. des curNumberField 
		  oder des curGaloisField ist ***/

	if( VNF != _0 )
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
		  return(ERROR); 
		}
	}
        if( VGF != _0 )
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
		   return(ERROR);
		}
	}

	/*** Ueberpruefung des eingegebenen Variablennamen, ob
	     dieser bereits als Funktions- oder Variablenname
	     benutzt wurde ***/

	while( ( i < MX && strlen(varlist[i].varname) ) || !i )
        {    if( strcmp(name,varlist[i].varname) )
	     {   if ( varlist[i].typ!=2 && varlist[i].typ!=(-3) && varlist[i].varwert && varlist[i].varwert != ERROR &&
			 ( ( lsecond(varlist[i].varwert)>1 && lsecond(varlist[i].varwert)<5 )
			 || ( lsecond(varlist[i].varwert)>6 && lsecond(varlist[i].varwert)<10 )
			 || ( lsecond(varlist[i].varwert)>11 && lsecond(varlist[i].varwert)<15 ) 
                         || lsecond(varlist[i].varwert)==18  || lsecond(varlist[i].varwert)==20 || lsecond(varlist[i].varwert)==22
                         || lsecond(varlist[i].varwert)==25 || lsecond(varlist[i].varwert)==27 || lsecond(varlist[i].varwert)==29 
                         || lsecond(varlist[i].varwert)==32 || lsecond(varlist[i].varwert)==34 || lsecond(varlist[i].varwert)==36 
			 || lsecond(varlist[i].varwert)==38 || lsecond(varlist[i].varwert)==39 ) )
		    {   sch = ispolvar( name, i );

	/*** Meldungsblock, falls ein Variablenname bereits eine Unbe-
	     stimmte eines Polynoms, dann muss ein neuer Variablenname
	     angegeben werden.   ***/

			if ( sch ) {
			if( lsecond( varlist[i].varwert ) < 5 || lsecond( varlist[i].varwert ) == 18 
		        || lsecond( varlist[i].varwert ) == 25 || lsecond( varlist[i].varwert ) == 32 
			|| lsecond(varlist[i].varwert)==38 || lsecond(varlist[i].varwert)==39 )
			mistake1(293,name);
			else if( lsecond( varlist[i].varwert ) < 10 || lsecond( varlist[i].varwert ) == 20 
			|| lsecond( varlist[i].varwert ) == 27 || lsecond( varlist[i].varwert ) == 34 )
			mistake1(294,name);	
			else  mistake1(295,name);
			return(ERROR);
			}
		}
	    }
	    else {

	/*** Falls ein Funktionsname als Variablenname benutzt 
			werden soll ***/

		       if ( varlist[i].typ == 1 || varlist[i].typ == 3 ) {
				mistake1(228,name);
				return(ERROR);
			}

	/*** Falls Variable schon benutzt wurde ***/
		   else  return(i);
	     }
	     i++;
	}
	return( MX );
}
