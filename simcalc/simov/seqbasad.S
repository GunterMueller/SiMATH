/*C
			seqbasad ( arg, fkt, fktco, fsch ,hsch )

	"sequence basement-administration".   
	int seqbasad(arg, fkt, fktco, fsch,hsch); char *arg; int (*fkt)(), (*fktco)();
					 single fsch,hsch;
	erg = seqbasad( arg, fkt, fktco, fsch,hsch );

	seqbasad unterteilt eine Sequenz von Kommandos in die 
	einzelnen Kommandos und uebergibt sie an error und rechnung.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      10.11.1993      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

int seqbasad( arg, fkt, fktco, fsch,hsch )
char *arg;
void (*fkt)(), (*fktco)();
single fsch,hsch;

{       single sp = 0,pi, psch, kl=0, y,z,stel,prog,klam;
	single hk=0;
	list pos;
	char str[MAXL];
	init(pos);

	*str='\0';

	y=0; 

/*** pos: Position, an der Funktionen wie if,for,... beginnen ***/

	prog=inprog(arg,&pos);
	while ( *(arg+y) != '\0' ) {
       while ( *(arg+y)=='_' || *(arg+y)==' ' || *(arg+y)==';' ) ++y;
	  z=0;
	  if(prog)  
	  {	stel=lfirst(pos);
		pos=lred(pos);
		prog--;
	  }
	  else stel=MAXL+1;
	  while(*(arg+y)!='\0')
	  {	if(y<stel)
		{	if(*(arg+y) == '_' && kl==0 ) break;
			*(str+z)= *(arg+y);
			if(*(str+z) == ';'&& kl==0 )
			{  z++;y++;
			   break;
			}
			switch(*(str+z))
			{       case '(': if(seven(hk)) kl++;
					  break;
				case ')': if(seven(hk)) kl--;
					  break;
				case '"': if(*(str+z-1) !='\\') hk++;
					  break;
				default: break;
			}
			z++;
			y++;
		}
		else if(y==stel)
		{ 	klam=1;
			while(*(arg+y)!='(')
			{  *(str+z)= *(arg+y);
			   z++;y++;
			}
			*(str+z)= *(arg+y);
			z++;y++;
			while(*(arg+y)!='\0' && klam)
			{  switch(*(arg+y))
			   {      case '(': if(seven(hk)) klam++;
				 	      break;
			          case ')': if(seven(hk)) klam--;
					      break;
			          case '"': if(*(arg+y-1) !='\\') hk++;
					      break;
			   	  default: break;
			   }
			   *(str+z)= *(arg+y);
			   z++;y++;
			}
			if(klam) break;
			while(prog)
			{	stel=lfirst(pos	);
				pos=lred(pos);
				prog--;
				if(y<=stel) break;
			}
			if(y>stel) stel=MAXL+1;
		}
       }
		 *(str+z) = '\0';
       while ( *(arg+y)=='_' || *(arg+y)==' ' || *(arg+y)==';' ) ++y;
			  if ( *(arg+y) != '\0' || hsch == 1 ) hsch=1;
			  if ( fsch ) hsch = 1;
			  if (schleife==1) hsch = 1;
			  if(funktion) hsch=1;

	/** Einlesen von Datei **/

			 if ( !strncmp( str, "fopen", 5 ) ) {
				 if(ps ) fprintf( datei, "in : %s\n", str );
				 pi=calc_fopen( str );
				 if(!pi && schleife==1)
				 {	if(fosch!=2 ) fosch=1;
					return;
				 }
			 }
			 else if ( !strncmp( str, "fread", 5 ) ) {
				 pi=calc_fread( str, fkt, fktco );
				 if(!pi && schleife==1)
				 {	if(fosch!=2 ) fosch=1;
					return;
				 }	
			 }
			 else if ( !strncmp( str, "fclose", 6 ) ) {
				 if(ps ) fprintf( datei, "in : %s\n", str);
				 pi=calc_fclose( str);
				 if(!pi && schleife==1)
				 {	if(fosch!=2 ) fosch=1;
					return;
				 }
			 }		
			 else if ( !strncmp( str, "fload", 5 ) ) {
				 if(ps ) fprintf( datei, "in : %s\n", str);
				 pi=calc_fload( str, fkt, fktco );
				 if(!pi && schleife==1)
				 {	if(fosch!=2 ) fosch=1;
					return;
				 }
			 }		
			 else if ( !strncmp( str, "logon", 5 ) ) {
				 ps = proton( str );
				 if(!ps && schleife==1)
				 {	if(fosch!=2 ) fosch=1;
					return;
				 }
				 if( ps ) hps = 1;
			 }
			 else if ( !strncmp( str, "logoff", 6 ) )
			 {      stel = 6;
				pi = strlen(str);
				if(*(str+pi-1)==';') sp=1;
				psch = 1;
				while(str[stel] ==' ') stel++;
				if(*(str+stel)!= '\0' && *(str+stel) == '(')
				{	stel++;
					while(*(str+stel)==' ') stel++;
					if(*(str+stel) == '\0' || *(str+stel) != ')')
					{	mistake(1);
						psch = 0;
					}
					else
					{   stel++;
					    while(*(str+stel)==' ') stel++;
					}
				}
				if(psch && *(str+stel)!='\0' && *(str+stel)!=';' ) 
				{	mistake1(34,"logoff");
					psch=0;
				}
				if( psch )
				{       if ( ps )
					{ if(!sp) printf(" Log file %s closed.\n", datn );
					  fclose( datei );
					}
					else if(!sp)
					{ printf(" No log file to be closed.\n");
					}
					ps = 0;
					hps = 0;
				}
				else if(schleife==1)
				{	if(fosch!=2 ) fosch=1;
					return;
				}
			 }  

		/** Ueberschreibschutz **/

			 else if ( !strncmp( str, "owoff", 5 ) )
			 {      if(schleife==1)
				{	mistake(301);
					if(fosch!=2 ) fosch=1;
					return;
				}
				pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 5; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" Overwrite protection mechanism disabled until \"owon\".\n");
					if ( ps )
					{ fprintf( datei, "in : owoff\n");
				          fprintf( datei, "out: Overwrite protection mechanism disabled until \"owon\".\n");
					}
				       owsch = 0;
				       owalt=0;
				}
				else if(psch) 
				{	owsch=0;
					owalt=0;
				}
			 }
			 else if ( !strncmp( str, "owon", 4 ) )
			 {      if(schleife==1)
				{	mistake(301);
					if(fosch!=2 ) fosch=1;
					return;
				}
				pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 4; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" Overwrite protection mechanism enabled.\n");
					if ( ps )
					{ fprintf( datei, "in : owon\n");
				          fprintf( datei, "out: Overwrite protection mechanism enabled.\n");
					}
					owsch = 1;
					owalt=1;
				}
				else if(psch) 
				{	owsch=1;
					owalt=1;
				}
			 } 
			 else if ( !strncmp( str, "staton", 6 ) )
			 {      if(schleife)
				{	mistake(302);
					if(fosch!=2 ) fosch=1;
					return;
				}
				pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 6; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" Statistical messages until \"statoff\".\n");
					if ( ps )
					{ fprintf( datei, "in : staton\n" );
				          fprintf(datei,"out: Statistical messages until \"statoff\".\n");
					}
				}
				if(psch) statsch = 1;
			 }
			 else if ( !strncmp( str, "statoff", 7 ) )
			 {      if(schleife)
				{	mistake(302);
					if(fosch!=2 ) fosch=1;
					return;
				}
				pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 7; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" No more statistical messages.\n");
					if ( ps )
					{ fprintf( datei, "in : statoff\n");
				          fprintf( datei, "out: No more statistical messages.\n");
					}
				}
				if(psch) statsch = 0;
			 }
			 else if ( !strncmp( str, "nfon", 4 ) )
			 {      pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 4; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" Lifting to number fields until \"nfoff\".\n");
					if ( ps )
					{ fprintf( datei, "in : nfon\n" );
				          fprintf(datei,"out: Lifting to number fields until \"nfoff\".\n");
					}
				}
				if(psch) nfon = 1;
			 }
			 else if ( !strncmp( str, "nfoff", 5 ) )
			 {      pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 5; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" No more lifting to number fields.\n");
					if ( ps )
					{ fprintf( datei, "in : nfoff\n");
				          fprintf( datei, "out: No more lifting to number fields.\n");
					}
				}
				if(psch) nfon = 0;
			 }

			 else if ( !strncmp( str, "avon", 4 ) )
			 {      pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 4; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" Additional results are stored in AV until \"avoff\".\n");
					if ( ps )
					{ fprintf( datei, "in : avon\n" );
				          fprintf(datei,"out: Additional results are stored in AV until \"avoff\".\n");
					}
				}
				if(psch) avsch = 1;
			 }
			 else if ( !strncmp( str, "avoff", 5 ) )
			 {      pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 5; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" No more storage of additional results until \"avon\".\n");
					if ( ps )
					{ fprintf( datei, "in : avoff\n");
				          fprintf( datei, "out: No more storage of additional results until \"avon\".\n");
					}
				}
				if(psch) avsch = 0;
			 }

			 else if ( !strncmp( str, "ppon", 4 ) )
			 {      pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 4; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" Only pseudoprimality checking until \"ppoff\".\n");
					if ( ps )
					{ fprintf( datei, "in : ppon\n" );
				          fprintf(datei,"out: Only pseudoprimality checking until \"ppoff\".\n");
					}
				}
				if(psch) set_pseudoprimality_only(1);
			 }
			 else if ( !strncmp( str, "ppoff", 5 ) )
			 {      pi = strlen(str);
				if( *(str+pi-1)==';') sp=1;
				pi = 5; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( !sp && psch )
				{       printf(" No more pseudoprimality checking only until \"ppon\".\n");
					if ( ps )
					{ fprintf( datei, "in : ppoff\n");
				          fprintf( datei, "out: No more pseudoprimality checking only until \"ppon\".\n");
					}
				}
				if(psch) set_pseudoprimality_only(0);
			 }

			 else if ( !strncmp( str, "break", 5 ) )
			 {      pi = 5; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( psch && schleife==1 ) 
				{	breaksch=1;
					return;
				}
				if( !psch && schleife==1 )
				{	if(fosch!=2 ) fosch=1;
					return;
				}
			  }
			 else if ( !strncmp( str, "continue", 8 ) )
			 {      pi = 8; psch = 1;
				while( pi < strlen(str) && psch )
				{       if ( *(str+pi) != ' ' && *(str+pi) != ';')
					{ mistake( 253 );
					  psch = 0;
					}
					pi++;
				}
				if( psch && schleife==1 )
				{	breaksch = 2;
					return;
				}
				if( !psch && schleife==1 )
				{	if(fosch!=2 ) fosch=1;
					return;
				}
			  }
			  else
			  {	signal(SIGINT,fkt);
				signal(SIGQUIT,fktco);
				signal(SIGILL,fktco);
				signal(SIGTRAP,fktco);
				signal(SIGABRT,fktco);
#ifdef HAVE_SIGEMT
				signal(SIGEMT,fktco);
#endif
				signal(SIGFPE,fktco);
				signal(SIGBUS,fktco);
				signal(SIGSEGV,fktco);
#ifdef HAVE_SIGSYS
				signal(SIGSYS,fktco);
#endif
			  	if ( error( str ) ) 
			  	{	
					rechnung( str, fkt, fktco, hsch );
/**					if(prfehl && breaksch!=(-1)) prfehl = 0;**/
					if(!funktion || (prfehl==1 && breaksch!=(-1))) prfehl=0;
					if(schleife!=1) fosch=0;
					if(fosch==1 && errstop())
					{
						fosch=2;
						return;
					}
					else if(fosch==1) fosch=0;
					if(breaksch) 
					{
						return;
					}
			  	}
				else if( schleife==1 && errstop())
				{	fosch = 2;
					return;
				}
			  }
			  sp=0;
       }
}
