/*C
			decl_error( string, laenge )

	"declaration error examination".
	single decl_error(string); char *string; single *laenge;

	Der Eingabestring wird auf syntaktische Fehler und unzulaessige
	Zeichen untersucht.
	Falls der Eingabestring fehlerfrei ist, so wird die Anzahl
	der Gleichheitszeichen, sonst -1 an das aufrufende Programm 
	zurueckgeliefert.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      26.04.1994      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

single decl_error( s, laenge )
char *s;
single *laenge;

{
	single i, l=1, z=1, z1=0, z2 = 0, klam, kl, m;
	single fe=0,gz=0, prog, hk;
	single stel;
	list pos;
	init(pos);

	*laenge = 0;

	/*** Ueberpruefen der Klammerstruktur ***/

	while ( *(s+l) != '\0' && z )
	{      while(*(s+l)==' ') l++;

	/** Funktionsname **/
				
	       if(!isalpha(*(s+l))) fe=1;
	       else
	       {	l++;
			while(isalnum(*(s+l))) l++;
			while(*(s+l)==' ') l++;
			if(*(s+l)=='[') 
			{ 	kl=1;
				l++;
				while(kl && *(s+l)!='\0')
				{	if(*(s+l)=='[') kl++;
					else if(*(s+l)==']') kl--;
					l++;
				}
				if(kl) fe=1;
				else while(*(s+l)==' ') l++;
			}
			if(*(s+l)!='(') fe=1;
		}
		if(fe)
		{	mistake(312);
			return(-1);
		}
		kl=0;

	/** Parameter **/

		l++;
		fe=0;
		while(*(s+l)==' ') l++;
		while(*(s+l)!=')')
		{	if(!isalpha(*(s+l))) fe=1;
	       		else
	       		{	l++;
				while(isalnum(*(s+l))) l++;
				while(*(s+l)==' ') l++;
				if(*(s+l)=='[') 
				{ 	kl=1;
					l++;
					while(kl && *(s+l)!='\0')
					{	if(*(s+l)=='[') kl++;
						else if(*(s+l)==']') kl--;
						l++;
					}
					if(kl) fe=1;
					else while(*(s+l)==' ') l++;
				}
				if(*(s+l)!=')' && *(s+l)!=',')  fe=1;
			}
			if(fe)
			{	mistake(313);
				return(-1);
			}
			if(*(s+l)==',')
			{	l++;
				while(*(s+l)==' ') l++;
				if(*(s+l)==')')
				{	mistake(313);
					return(-1);
				}
			}
		}

	/** Gleichheitszeichen **/

		l++;
		while(*(s+l)==' ') l++;
		if(*(s+l)!='=') 
		{	mistake(313);
			return(-1);
		}
		l++;
		gz++;
		while(*(s+l)==' ') l++;

	/** Sequenz **/

	if(1){
	char seq[MAXL],hilf[MAXLV];
	*hilf='\0';
	*seq='\0';

	m=0;
	while(z && ( z1 || z!=1 || *(s+l)!=','))		
	{	switch( *( s+l ) )
		{       case '(': if(seven(z2)) ++z;
				  break;
			case ')': if(seven(z2)) --z;
				  break;
			case '{': if(seven(z2)) ++z1;
				  break;
			case '}': if(seven(z2)) --z1;
				  break;
			case '"': if(*(s+l-1) !='\\') z2++;
				  break;
			case '=': if(seven(z2)) 
				  {	i=prechar(s,l); 
				  	if(i == '=') gz--;
				  	else if(i!= '>' && i != '<' && i != '!') gz++;
				  }
				  break;
			default: break;
		}
		if(z)
		{ 	*(seq+m)= *(s+l);
			m++;
		}
		l++;
	}
	if(!m)
	{	mistake(313);
		return(-1);
	}
	*(seq+m)='\0';
	m=0;	

/*** pos: Position, an der Funktionen wie if,for,... beginnen ***/
 /** Aufloesen der Sequenz **/

	pos = _0;
	prog=inprog(seq,&pos);
	while ( *(seq+m) != '\0' ) {
        while ( *(seq+m)=='_' || *(seq+m)==' ' || *(seq+m)==';' ) ++m;
	  i=0;
	  if(prog)  
	  {	stel=lfirst(pos);
		pos=lred(pos);
		prog--;
	  }
	  else stel=MAXL+1;
	  hk=0;
	  while(*(seq+m)!='\0')
	  {	if(m<stel)
		{	if((*(seq+m) == '_' || *(seq+m) == ';' ) && kl==0 ) break;
			*(hilf+i)= *(seq+m);
			switch( *( hilf+i ) )
			{       case '(': if(seven(hk)) ++kl;
				  		break;
				case ')': if(seven(hk)) --kl;
				  		break;
				case '"': if(*(hilf+i-1) !='\\') hk++;
				  		break;
				default: break;
			}
			i++;
			m++;
		}
		else if(m==stel)
		{ 	klam=1;
			while(*(seq+m)!='(')
			{  *(hilf+i)= *(seq+m);
			   i++;m++;
			}
			*(hilf+i)= *(seq+m);
			i++;m++;
			while(*(seq+m)!='\0' && klam)
			{  switch( *( seq+m ) )
			   {       case '(': if(seven(hk)) ++klam;
				  		break;
			           case ')': if(seven(hk)) --klam;
				  		break;
				   case '"': if(*(seq+m-1) !='\\') hk++;
				  		break;
				   default: break;
			   }
			   *(hilf+i)= *(seq+m);
			   i++;m++;
			}
			if(klam) break;
			while(prog)
			{	stel=lfirst(pos	);
				pos=lred(pos);
				prog--;
				if(m<=stel) break;
			}
			if(m>stel) stel=MAXL+1;
		}
       }
       if(i)
       {	*(hilf+i) = '\0';
       		if(!error(hilf)) return(-1);	
       }
       }
       }

	if(*(s+l)==',')	l++;
     }
	if ( z > 0 ) {
		mistake( 2 );
		return( -1 );
	}
	
	*laenge = l;
	return(gz);
}
