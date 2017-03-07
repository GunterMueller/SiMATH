/*C
			caifact(S,Z,y)
	"calculator integer factorization" (rekursiv)
	caifact( S, Z, y ); int S; obj Z; single y;
	caifact produziert die Primteiler p1,...pr von S in der Form
		S = p1^n1 * ... * pr^nr,
	wobei die ni die Haeufigkeit des Vorkommens von pi in S angeben.
	y ist ein Schalter zur Unterscheidung ganzen Zahlen und Zahlen
	aus Q\Z und dem ersten Aufruf von caifact.
	Z ist die komplette Zahl, die faktorisiert werden soll, waehrend
	S der Zaehler oder Nenner bei rationalen Zahlen Z, und gleich Z
	bei ganzen Zahlen Z ist.
	Die Ausgabe eines Primteilers erfolgt sobald ein Primteiler
	gefunden wird.
	Benoetigt wird die Include-Datei <_calc.h>.
	Nach neuester Version von ifact von Marc Conrad ( 13.12.1990 ).
	Alte Versio unter ifakt.S vorhanden.
C*/
/*H
	Version 1       19.03.1987      Pascale Serf
	Version 2       22.05.1987      Beschleunigung fuer
					  2^30 <= |S| < 2^40
					  B.Weis (P.Serf)
	Version 3       28.07.1987      schnellerer Alg. fuer
					  2^30 <= |S| < 2^60
					  B.Weis (P.Serf)
	Version 4       29.09.1987      icomp(N,list3(0,0,1)) < 0
					durch
					ilog2( N ) <= 60
					ersetzt.
						MAR.
	Version 5       05.09.1990      komplett neu geschrieben.
					Marc Conrad
	Version 6       20.10.1990      varargs eingebaut wegen SUN4.
					Marc Conrad
	Version 7 	02.07.1992	Beschleunigung durch elcfds, 
					Aenderung der Voreinstellungen.
					Marc Conrad.
	Version 8       01.02.1994      Beschleunigung durch isiprime,
                                        Abbruch (err = -2) entfaellt.
                                        srand() entfernt und
                                        rand() % 1000 durch irand (1000)
                                        ersetzt, um Randomisierung ueber
                                        irand() kontrollieren zu koennen.
                                        if else if else if else if ...
                                        Ketten durch switch aufgeloest.
                                                Georg J. Lay

	Version 9       27.10.1994      S.Schmitt/U.Schneiders ( Calculatorversion )
H*/

# include <_calc.h>


list caifact(S,Z,y)

/*** # define pl { printf("%i ",lfirst(T));T=lred(T);}
# define ausgliste(H) {T = H; printf( " (L) "); while(T != _0) pl  printf("\n");}  
# define ausgzahl(P)  printf(" (Z) %i\n",P);    ***/

int S;
obj Z;
single y;    
{          
        
	list F,G;     /* F: Liste der gefundenen Primfaktoren, G: Hilfsliste */ 
	list L;
	int M,P,Q,W,A,T;                       /*   Q,W: Hilfsvariablen    */   
	                   /*   A: alle Primfaktoren < A sind schon getestet */
	int N, X;
	single s,c,imp,rho,elc;             /*   c : Cufallsvariable     */
	single i, j, m, t, z;
	bind(S,Z);
	init(F,G,M,P,Q,W,A,T); 
	init( L, N, X );

/* ------------   Vorbesetzung   -----------*/    
	F = _0;                         
	imp  = 5000;
	rho = 2500;
	elc = (1<<25);     

	/*** Calculator ***/

	L = _0; j = 1; z=0; t=0;
	N = iabs(S); m=isign(S);

/* - Einlesen der optionalen Parameter entfaellt-----------*/    
	     /* Q  = zu faktorisierende Zahl                   */      
	Q = N;       

/* ---------------    Q < 2^30       --------------------------------- */
	if (issingle(Q)) { 
		F = sfact(Q);

		/*** Calculator ***/
		if ( !assch && y ) factmsg( Z, F, y, m );

		return(F);
		}		
/* ---------------    Q  < 2^60      --------------------------------- */
        if (ilog2(Q) <= 60) {	   
		F = linv(dpipds(1,Q));           

		/*** Calculator ***/
/* 0--> */      if ( y && !assch ) factmsg( Z, F, y, m );

		return(F);
	}      

	/*** Ausgabe des Kopfes ***/
	/*** Calculator ***/

	if ( y && !assch ){
	   switch(y){
	   case 1 :  printf( " factorization of %i: ", Z );
		     if ( m == -1 ) printf("-");
		     if ( ps ) {
		       fprintf( datei, "out: factorization of %i: ", Z );
		       if ( m == -1 ) fprintf( datei, "-" );
		     }
		     break;
	   case 2 :  printf(" factorization of %r:\n", Z );
		     printf(" numerator: ");
		     if ( m ==  -1 ) printf("-");
		     if ( ps ) {
		       fprintf( datei, "out: factorization of %r:\n", Z ); 
		       fprintf( datei, "out: numerator: ");
		       if ( m == -1 ) fprintf( datei, "-" );
		     }
		     break;
	   case 3 :  printf(" denominator: ");
		     if ( ps ) fprintf( datei, "out: denominator: ");
		     break;
	   }
	}

/* ---------------   Suche nach ganz kleinen Primfaktoren    --------- */
	F = ispd(Q,&M);  
	A = 1000;  
                                          
	/*** Calculator ***/
/* 1-->  */  if ( M == 1 && y && !assch ) listaus(F);
	else if ( y && !assch ) {
	   L = lcopy( F );
	   while( L != _0 ) {
		   t=1;
		   X = lfirst( L );
		   L = lred( L );
		   i = 1;
		   while ( L != _0 && icomp( lfirst( L ) , X ) == 0 ) {
			   L = lred( L );
			   ++i;
		   }
		   if ( j == 1 ) {
			   if ( i == 1 ) {
				printf(" %i", X );
				if ( ps ) fprintf(datei," %i",X);
			   }
			   else {
				printf(" %i^%d", X, i );
				if ( ps ) fprintf(datei," %i^%d", X, i );
			   }
		   }
		   else {
			   if ( i == 1 ) {
				printf(" * %i", X );
				if ( ps ) fprintf(datei," * %i",X);
			   }
			   else {
				printf(" * %i^%d", X, i );
				if ( ps ) fprintf(datei," * %i^%d", X, i );
			   }
		   }
		   ++j;
	   }
	}

/* Suche nach restlichen Primfaktoren ( M ist jetzt zu faktorisieren ) */   
     
	while (M != 1) {        
		if ( ilog2(M) <= 60  ) {  
			G = linv(dpipds(A,M));  

			/*** Calculator ***/
/* 2-->  */
			if ( y && !assch ) {
				if ( t ) {
				       printf(" *");
				       if ( ps ) fprintf(datei," *");
				}
				listaus(G);
			}

			F = lconc(F,G);  
			libsort(F); 

			/*** Calculator ***/
			/*** zweite, jetzt sortierte Ausgabe der Primfaktoren ***/
			/*** fast nie ein Unterschied zur ersten Ausgabe      ***/

		/*      if( y && !assch )
			{       if( y == 1 ) t = 1;
				else         t = 10;
				printf( "%t =", t );
				if( ps ) fprintf( datei, "%t =", t );
				listaus( F );
			}       */

			return(F);
		}

	        switch (isiprime (M)) {

        	case ISAPRIME:
			if( y && !assch )
			{
			   if ( t ) 
			   {   printf(" * %i", M );
			       if ( ps ) fprintf(datei," * %i",M );
			   }
			   else 
			   {   printf(" %i", M );
			       if ( ps ) fprintf(datei," %i",M );
			   }
			   printf("\n");
			   if ( ps ) fprintf(datei,"\n");
			}
			F = lcomp( M,F );
			libsort(F);
			return(F);
                	break;
		case UNKNOWN:        
                	impds (M, A, W, &P, &M);
		        /*impds(M,A,W,&P,&Q);*/
                	if (P == 1) {
				if( y && !assch )
				{
			   	if ( t ) 
			   	{   printf(" * %i", M );
			       	    if ( ps ) fprintf(datei," * %i",M );
			   	}
			   	else 
			   	{   printf(" %i", M );
			            if ( ps ) fprintf(datei," %i",M );
			   	}
			        printf("\n");
			        if ( ps ) fprintf(datei,"\n");
				}
				F = lcomp( M,F );
				libsort(F);
				return(F);
                       	 }
                	 else    {
                       	 	G = list1 (P);
                       	 	A = P;
                        }
                	break;

 		case NOTPRIME:
			/* ....  Suche durch Probedivision  .... */
			if (A < imp) {      
				P=imspds(M,A,imp);  
				if (P == 1) A = imp; 
				else {
			        /*	M = isquot(M,P);  */
					A = P;
					G = list1(P); 
				/*	F = lcomp(P,F);  */
				}
			}                       
			else  P = 1;                
			/* ...  Suche durch rhopds und elcpds ...*/
			if ( P == 1) {         
			    c = 1+ irand(1000);
            
			    do {
				single elcmax=500000, i=32;
				P = rhopds(M,c,rho );
				while( ( P==1 ) && ( i<= elc ) )
				{	i += 32;
					P = elcfds( M, c, elcmax );
					c = c+irand (1000);
					elcmax += elcmax;
				}
				if( P == 0 )  P = elcpds( M, c, elc );
			    } while( oequal( P, M ) );
				  	
			    if (isqrt(P) > A)
					G = caifact(P,Z,0);
   			    else if (P == 1) G = _0;
			    else G = list1(P);    
			/* Abbruch falls brk = 1 und Fehlversuch */ 
			}     	    /* if ( P == 1)...  */
			break;
		} /* switch */

		/*- Herausdividieren der gefundenen Primfaktoren -*/  
			while (G != _0 ) {
				P = lfirst(G);   
				G = lred(G);
				iqrem(M,P,&Q,&W);
				while (W == 0) {
					M = Q;
					F = lcomp(P,F);         
/* 4--> */                              if( y ) z = z+1;
					iqrem(M,P,&Q,&W);
				}

				/*** Calculator ***/

				if( y && !assch )
				{
				   if ( t ) {
				     if ( z > 1) {
				       printf(" * %i^%d", P,z );
				       if ( ps ) fprintf(datei," * %i^%d",P,z );
				     }
				     else if(z){
				       printf(" * %i", P );
				       if ( ps ) fprintf(datei," * %i",P );
				     }
				   }
				   else {
				     if ( z > 1) {
				       printf(" %i^%d", P,z );
				       if ( ps ) fprintf(datei," %i^%d",P,z );
				     }
				     else if(z){
				       printf(" %i", P );
				       if ( ps ) fprintf(datei," %i",P );
				     }
				   }
				   z=0; t=1;
				}
			}

			/*** Calculator ***/

			if( M == 1 && y && !assch )
			{       printf("\n");
				if ( ps ) fprintf(datei,"\n");
			}

	}            /*  while( M != 1 )...                         */

	libsort(F);  

	/*** Calculator ***/
	/*** zweite, jetzt sortierte Ausgabe der Primfaktoren ***/
	/*** fast nie ein Unterschied zur ersten Ausgabe      ***/

/*      if( y && !assch )
	{       if( y == 1 ) t = 1;
		else         t = 10;
		printf( "%t =", t );
		if( ps ) fprintf( datei, "%t =", t );
		if( m == (-1) )
		{       printf( " -" );
			if( ps )  fprintf( datei, " -" );
		}
		listaus( F );
	}       */

        return(F);
}		   
