/*M	
	For a given monic irreducible polynomial F(x) in Z[x] and a given
	prime number p in Z, the program computes ramification indices
	and related residue class degrees of p in the ring of integers
	O of the number field Q[z] := Q(x) / (F(x) * Q(x)).
*M/
/*H	
	Version 1	11.10.93	J. Schmitt	
H*/
/*cS
	ZLGnf ruft auf: iexp, iprod, isqrem, issprime, isuspi, llength
		oupidedekmt, ouspiapfgmic, pitopms, rdiscupifact,
		upireddiscc, upmscfacts
	Macros: getpi, getsi, iquot, lfirst, list1, lred, lred2
		lsecond, lthird, pdegree, printf, puti, putsi
Sc*/

#include<_simath.h>
main()
{
	single i,k,j,t,z,h,e1,e2,e3,e,p;
	list V,Vz,M,L,L1,HH;            
	int I,Ind,t1,c,rd;
	pol F,P1;
	init(V,Vz,M,L,L1,HH,I,Ind,t1,c,rd,F,P1);

	V  = list1(list1('x'));
	Vz = list1(list1('z'));
e3 = 1;
if ( e3 ) {
	printf("\n For given monic irreducible polynomial F(x) in Z[x] and given");
	printf("\n prime number p in Z the program computes ramification indices");
	printf("\n and related residue class degrees of p in the ring of integers");
	printf("\n O of the number field Q[z] := Q(x) / ( F(x) * Q(x) ).");
}
h =0; 
while (1) {
	printf("\n\n Examples:\n");
printf("\n x^4-2 x+8#                                    x^4+4 * x^3+108 # ");
printf("\n x^9-64+72 x #                                 x*x*x    +43568x# ");
printf("\n x^10+x^20- 248502 #                                 x**2 +  3 # ");
	printf("\n\n !!! You must end input of polynomials with # and Return. !!!");

	if (!h) printf("\n\n F(x) = ");
	else {
printf("\n\n New polynomial : ( F(x) = 0# --> End of program ) F(x) = ");
	}
	h = 1;
	F = getpi(1,V); 
	while (1) {
          while ( F == ERROR ) {
            printf("\n Input incorrect.");
   	    printf(" Please try again!");
	    printf("\n F(x) = ");
	    F=getpi(1,V);
	  }                                                        
	  if ( h && !F ) break;
	  if ( pdegree(1,F) < 2 ) {
	    printf("\n Polynomial F trivial.");
   	    printf(" Please try again!");
	    printf("\n F(x) = ");
	    F=getpi(1,V);
	  }	    
	  else {
 	    if ( (lsecond(F)) != 1 ) {
	      printf("\n Polynomial F not monic.");
   	      printf(" Please try again!");
 	      printf("\n F(x) = ");
	      F=getpi(1,V);
	    }
	    else {
              if( !isuspi(F) ) { 	
	        printf("\n Polynomial F not squarefree.");
   	        printf(" Please try again!");
	        printf("\n F(x) = ");
	        F=getpi(1,V);
	      }                                                  
	      else break;		
            }
          }
	}
	t1 = 1;
        if ( !F ) break;

	rd = upireddiscc(F,&c);   
printf("\n Decomposition of d_kl(F) and d_red(F)    ( y/n = 1/0 ) : ");
	e = getsi();
	if ( e == 1 ) {  
		L  = rdiscupifact(rd,c,&L1);
 		printf("\n d_kl (F) = ");                                 
		HH = L1;
		i  = 0; 
		Ind = 1;
		if ( HH == _0 ) putsi(1);
		while ( HH != _0 ) {
			i  = 1 - i;      
			if ( i == 0 ) {
				I   = iexp(t,lfirst(HH));
				Ind = iprod(Ind,I);
			}
			t  = lfirst(HH);
			HH = lred(HH);
			putsi(t);
			if ( i == 1 ) printf(" ^ ");
			else {
				if ( HH != _0 )
	 			  printf("\n          * ");
				else {
				  printf("\n          = ");
				  puti(Ind);
				}
			}
		} 
		printf("\n d_red(F) = ");                                 
		HH = L;
		i  = 0; 
		Ind = 1;
		if ( HH == _0 ) putsi(1);
		while ( HH != _0 ) {
			i  = 1 - i;      
			if ( i == 0 ) {
				I   = iexp(t,lfirst(HH));
				Ind = iprod(Ind,I);
			}
			t  = lfirst(HH);
			HH = lred(HH);
			putsi(t);
			if ( i == 1 ) printf(" ^ ");
			else {
				if ( HH != _0 )
 				  printf("\n          * ");
				else {
				  printf("\n          = ");
				  puti(Ind);
				}
			}
		} 
		printf("\n");
	}	
				
	
while (1) {
	while (1) {
printf("\n Prime number p ( p = 0 --> input of new polynomial F(x) ) p = ");
		p = getsi();
		if ( !p ) break;
		t = issprime(p,&i);
		if ( !t ) printf ("\n p not prime !!\n");	
		if ( t == (-1) ) 
			printf("\n p not in correct range !!\n");
		if ( t == 1 ) break;
	}
	if ( !p ) break;
	if ( !oupidedekmt(p,F) ) {
	 printf("\n p do not divide the index [ O:Z[z] ] and the decomposition of p");
	 printf("\n will be given by the factorization of F(x) modulo p * Z[x].\n");
		e = 1;
		if ( e == 1 ) {          
			P1 = pitopms(1,F,p);		
                        L  = upmscfacts(p,P1);
			M  = L;
			i  = llength(L) / 2;
			printf("\n (p) = ");				
			for ( j=1; j<=i; j++ ) {
				printf(" (P_%d) ",j);
				z = lsecond(L);
				printf("^ %d ",z);
				if ( j != i ) printf(" * ");
				L = lred2(L);
			}	
			L = M;							
			printf("\n Related residue class degrees: \n");
			printf("\n       ");				
			for ( j=1; j<=i; j++ ) {
				z = pdegree(1,lfirst(L));
				printf("  f_%d  = ",j);
				putsi(z);
				if ( j != i ) printf("  , ");
				L = lred2(L);           
			}
		}
	}
	else {
	 printf("\n The decomposition of p will be computed.   Please wait  !!!!\n ");
	
		e = 1; /* e = getsi(); */
		if ( e == 1 ) {
			k = 0;           
			I = rd;
			while (1) {
                		isqrem(I,p,&Ind,&z);
				if (!z) k = k + 1;
				I = Ind;
				if (z) break;
			}
			k++;
			L1 = ouspiapfgmic(p,F,k);
			i  = llength(L1);
			HH = L1;
			printf("\n (p) = ");				
			for ( j=1; j<=i; j++ ) {
				L  = lfirst(L1);
				L1 = lred(L1);      
				z  = pdegree(1,lfirst(L));
				z  = iquot(z,pdegree(1,lthird(L)));
				printf(" (P_%d) ",j);
				printf("^ %d ",z);
				if ( j != i ) printf(" * ");
				L = lred2(L);
			}	
			L1 = HH;							
			printf("\n Related residue class degrees: \n");
			printf("\n       ");				
			for ( j=1; j<=i; j++ ) {
				L  = lfirst(L1);
				L1 = lred(L1);
				z = pdegree(1,lthird(L));
				printf("  f_%d  = ",j);
				putsi(z);
				if ( j != i ) printf("  , ");
				L = lred2(L);           
			}								
		}
	}	
}	/* End while : new p */
} 	/* End while : new F */		
}

