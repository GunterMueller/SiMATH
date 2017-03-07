/*C
			carrqnf1( D, E, g2d, verbose, bound )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	single carrqnf1( D, E, g2d, verbose, bound );  single D; list E; 
			            	    single g2d, verbose, bound;
	X = carrqnf1( D, E, g2d, verbose, bound );

	E ist eine elliptische Kurve ueber dem reellquadratischen Zahlkoerper
	Q(sqrt(D)). carrqnf1 versucht, mit Hilfe des 2-Abstiegs den
	Rang von E ueber Q(sqrt(D)) zu bestimmen. Bei mehreren Moeglichkeiten
	fuer den Rang wird die erste Moeglichkeit zurueckgegeben.
	Die Klassenzahl des reellquadratischen Zahlkoerpers soll 1 sein.
	g2d = 0,1 je nachdem, ob 2-Abstieg mit Isogenien zuerst versucht
	werden soll oder nicht. bound ist die obere Grenze zur Punktsuche
	auf den Quartiken. verbose gibt an, wie die Ausgabe aussehen
	soll.

        Warning: General 2-descent should currently only be used over
        "small" quadratic number fields of class number 1, e.g. Q(sqrt(5)), 
        Q(sqrt(2)), Q(sqrt(13)), and Q(sqrt(3)). Otherwise the cpu times may 
        be "arbitrarily large". 2-descent via 2-isogeny can be used over any 
	field Q(sqrt(D)) with sfp(D) 2^30 and class number 1. 

	Siehe auch Doku zu `ecrqnf1rank'.

	Laeuft carrqnf1 fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      28.04.1997      S.Schmitt
H*/

# include <_calc.h>
/**# include <_PAFarith.h> **/
# include <_qnf.h>
static nfel nfeltoqnfri(obj,single);
static single classno(single);
single carrqnf1(D, E, g2d, verbose, bound)
list E;
single D, g2d, verbose, bound;
{
	single h;
	rqnf K;
	obj a1,a2,a3,a4,a6;
	list L;
	single output;
	char command[100];

	bind(E);

	init(a1,a2,a3,a4,a6,L);
	init(K.fununit,K.pi,K.pib);
	cF(&K.w); cF(&K.w1); cF(&K.rD_2); cF(&K.d1); cF(&K.d1inv);

	/* correct D */
	
	if(D<100)
	{  h = classno(D);
	   if(!assch)
	   {  printf("class number of Q(sqrt(%d)) = %d\n",D,h);
	      if(ps) fprintf(datei, "class number of Q(sqrt(%d)) = %d\n",D,h);
	   }
	}
	else 
	{  if(!assch)
	   {  printf("\nWarning!\n");
	      printf("General 2-descent should currently only be used ");
	      printf("over \"small\" quadratic number\n");
	      printf("fields of class number 1, e.g. Q(sqrt(5)), Q(sqrt(2)), ");
	      printf("Q(sqrt(13)), and \n");
	      printf("Q(sqrt(3)). Otherwise the cpu times may be ");
	      printf("\"arbitrarily large\".\n");
	      printf("2-descent via 2-isogeny can be used over any ");
	      printf("field Q(sqrt(D)) with sfp(D) <\n");
	      printf("2^30 and class number 1. But if sfp(D) > 100, the ");
	      printf("program does not really\n");
	      printf("check whether the class number is 1. It only tests ");
	      printf("whether sfp(D) is a prime,\n");
	      printf("twice a prime congruent to 3 modulo 4, or the product ");
	      printf("of two primes congruent\n");
	      printf("to 3 modulo 4. If so, the program assumes that the ");
	      printf("class number is 1; if not,\n");
	      printf("the class number is definitely > 1.\n\n");
	      if(ps)
	      {  fprintf(datei, "\nWarning!\n");
		 fprintf(datei, "General 2-descent should currently only be used ");
		 fprintf(datei, "over \"small\" quadratic number\n");
		 fprintf(datei, "fields of class number 1, e.g. Q(sqrt(5)), Q(sqrt(2)), ");
		 fprintf(datei, "Q(sqrt(13)), and \n");
		 fprintf(datei, "Q(sqrt(3)). Otherwise the cpu times may be ");
		 fprintf(datei, "\"arbitrarily large\".\n");
		 fprintf(datei, "2-descent via 2-isogeny can be used over any ");
		 fprintf(datei, "field Q(sqrt(D)) with sfp(D) <\n");
		 fprintf(datei, "2^30 and class number 1. But if sfp(D) > 100, the ");
		 fprintf(datei, "program does not really\n");
		 fprintf(datei, "check whether the class number is 1. It only tests ");
		 fprintf(datei, "whether sfp(D) is a prime,\n");
		 fprintf(datei, "twice a prime congruent to 3 modulo 4, or the product ");
		 fprintf(datei, "of two primes congruent\n");
		 fprintf(datei, "to 3 modulo 4. If so, the program assumes that the ");
		 fprintf(datei, "class number is 1; if not,\n");
		 fprintf(datei, "the class number is definitely > 1.\n\n");
	      }
	   }
	   L = sfact(D);
	   h = llength(L);
	   if ( h==1 || (h==2 && lfirst(L)%4!=1 && lsecond(L)%4==3) ) 
	   {  h = 1;
	      if(!assch)
	      {    printf("The class number of Q(sqrt(%d)) is assumed to be 1.\n",D);
		   if(ps) fprintf(datei, "The class number of Q(sqrt(%d)) is assumed to be 1.\n",D);
	      }
	   }
	   else h = 2;
	}
        if ( h != 1 ) 
	{ 	dF(&K.w); dF(&K.w1); dF(&K.rD_2); dF(&K.d1); dF(&K.d1inv);
		return(ERROR);
        }
	rqnfinit(D,&K);

	if(!assch) output=1;
	else 
	{	output=0;
        	verbose = 0;
	}

	/* initialization of the global parameters */

	ecrqnf1pinit(g2d);

	if(mshom(4,D)==1) h=1;
	else h=0;

	L=lfirst(lfirst(E));
	L=ecqnftoeci(D,L);
	a1 = lfirst(L);
	a2 = lsecond(L);
	a3 = lthird(L);
	a4 = lfourth(L);
	a6 = lfifth(L);

	a1=nfeltoqnfri(a1,h);
	a2=nfeltoqnfri(a2,h);
	a3=nfeltoqnfri(a3,h);
	a4=nfeltoqnfri(a4,h);
	a6=nfeltoqnfri(a6,h);

	L = ecrqnf1rank(K,a1,a2,a3,a4,a6,bound,output,verbose,g2d);

	if(!assch)
	{	printf("list of possible ranks: %l\n\n",L);
		if(ps) fprintf(datei, "list of possible ranks: %l\n\n",L);
	}
		
	dF(&K.w); dF(&K.w1); dF(&K.rD_2); dF(&K.d1); dF(&K.d1inv);
	return(lfirst(L));
}

static single classno(D)	/* primitive */
single D;
{
	switch ( D ) {
                case  2: return(1);
                case  3: return(1);
                case  5: return(1);
                case  6: return(1);
                case  7: return(1);
                case 10: return(2);
                case 11: return(1);
                case 13: return(1);
                case 14: return(1);
                case 15: return(2);
                case 17: return(1);
                case 19: return(1);
                case 21: return(1);
                case 22: return(1);
                case 23: return(1);
                case 26: return(2);
                case 29: return(1);
                case 30: return(2);
                case 31: return(1);
                case 33: return(1);
                case 34: return(2);
                case 35: return(2);
                case 37: return(1);
                case 38: return(1);
                case 39: return(2);
                case 41: return(1);
                case 42: return(2);
                case 43: return(1);
                case 46: return(1);
                case 47: return(1);
                case 51: return(2);
                case 53: return(1);
                case 55: return(2);
                case 57: return(1);
                case 58: return(2);
                case 59: return(1);
                case 61: return(1);
                case 62: return(1);
                case 65: return(2);
                case 66: return(2);
                case 67: return(1);
                case 69: return(1);
                case 70: return(2);
                case 71: return(1);
                case 73: return(1);
                case 74: return(2);
                case 77: return(1);
                case 78: return(2);
                case 79: return(3);
                case 82: return(4);
                case 83: return(1);
                case 85: return(2);
                case 86: return(1);
                case 87: return(2);
                case 89: return(1);
                case 91: return(2);
                case 93: return(1);
                case 94: return(1);
                case 95: return(2);
                case 97: return(1);

		default: return(1);
	}
}

static nfel nfeltoqnfri(A, m)
single m;			/** m=1 if D==1(mod 4) -> {1, (1+sqrt(D))/2} **/
				/** m=0 if D==0(mod 4) -> {1, sqrt(D)} **/
obj A;
{
	obj al,be;
	single hn;

	init(al,be);
	bind(A);

	if(!A) return(list2(0,0));
	hn=lfirst(A);
	if(llength(A)==3)		/** (hn, 0, al), hn=1 **/
	{	al=lthird(A);
		return(list2(al,0));
	}
					/** (hn, 1, be, al), hn=1,2 **/
	if(!m)
	{	be=lthird(A);
		al=lfourth(A);
		return(list2(al,be));
	}

	/** m=1 **/

	be=lthird(A);
	al=lfourth(A);
	al=idif(al,be);
	if(hn==1) be=iprod(2,be);
	else if(hn==2) al=iquot(al,2);
	return(list2(al,be));
}
