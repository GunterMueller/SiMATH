/*M
	For a given monic irreducible polynomial F(x) in Z[x] the program
	computes an integral basis, i.e. a Z-basis of the ring of integers
        O of the number field Q[z] := Q(x) / (F(x) * Q(x)), and the
	index [O : Z[z]].
*M/
/*H
        Version 1       11.10.93        J. Schmitt
H*/
/*cS
        ORDMAXnf ruft auf: cdmarhermred, cdmarid, cdprlfcdmar, iexp
		iprod, isuspi, lcomp, lconc, linv, oupidedekmt
		ouspibasics, ouspibasicss, ouspibaslmoi, rdiscupifact
		settime, upireddiscc, uprfcdpr
        Macros: getpi, getsi, lcomp2, lfirst, list1, list3, lred
		lred2, lsecond, pdegree, printf, puti, putpi, putpr
Sc*/

#include<_simath.h>
main()
{
	single i,z,h,e1,e2,e3;
	list V,Vz,M,L,L2,HH,MM;            
	int I,Ind,t1,t;
	pol F;
	init(V,Vz,M,L,L2,HH,MM,I,Ind,t1,t,F);

	V  = list1(list1('x'));
	Vz = list1(list1('z'));
e3 = 1;
if ( e3 ) {
	printf("\n For given monic irreducible polynomial F(x) in Z[x] the program");
	printf("\n computes an integral basis, i.e. a Z-basis of the ring of integers");
        printf("\n O of the number field Q[z] := Q(x) / ( F(x) * Q(x) ), and the");
	printf("\n index [ O : Z[z] ].");
}
e1=0;
while (1) {
	printf("\n\n Examples :\n");
printf("\n x^4-2 x+8#                                   x^4+4 * x^3+108 # ");
printf("\n 72 x + x^9-64 #                              x*x*x    +43568x# ");
printf("\n x^20+x^10- 248502 #                                x**2 + 3  # ");
	        printf("\n\n !!! You must end input of polynomials with # and Return. !!!");
	printf("\n\n F(x) = ");
	F = getpi(1,V); 
	while (1) {
          while ( F == ERROR ) {
            printf("\n Input incorrect.");
   	    printf(" Please try again!");
            printf("\n F(x) = ");
	    F=getpi(1,V);
	  }
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
    if ( !e1 && e3 ) {
    }
    e1=1;
	t1 = 0;
printf("\n Computation in progress !                  !!! Please wait !!!\n");
	if (t1) M = ouspibasicss(F,&L);
	else    M = ouspibasics(F,&L);
		
	printf("\n F(x) = ");
	putpi(1,F,V);
	printf(" with related integral basis :\n");
	HH = M;
	while ( HH != _0 ) {
 		printf("\n ");
		putpr(1,lfirst(HH),Vz);
		HH = lred(HH);
	}


printf("\n\n [ O : Z[z] ] = ");
	HH = L;
	i  = 0; 
	if (HH == _0) printf(" 1, i.e. O = Z[z] !");
	Ind = 1;
	while ( HH != _0 ) {
		i  = 1 - i;      
		if ( i == 0 ) {
			I   = iexp(t,lfirst(HH));
			Ind = iprod(Ind,I);
		}
		t  = lfirst(HH);
		HH = lred(HH);
		puti(t);
		if ( i == 1 ) printf(" ^ ");
		else {
			if ( HH != _0 ) printf("\n              * ");
			else {
			        printf("\n              = ");
				puti(Ind);
			}
		}
	}                                            
printf("\n\n End of program  			( y/n = 1/0 )  : ");
e2 = getsi();
if (e2==1) {
	printf("\n\n	             Bye \n\n");
	break;                                 
}
}
}

static list ouspibasics(F,pL)
pol F;
list *pL;
{
	list L,Lk,B,M,HH;
	single n,i,k,e;
	int t,p,Q,rd,c,h1,h2,I,Ind;
	init(L,Lk,B,M,t,HH,p,Q,rd,c,h1,h2,I,Ind);
	bind(F);

	t = settime();
	rd = upireddiscc(F,&c);   
	L  = rdiscupifact(rd,c,&Lk);
	t = settime();
	printf("\n d_kl (F) = ");                                 
	HH = Lk;
	i  = 0; 
	Ind = 1;
	while ( HH != _0 ) {
		i  = 1 - i;      
		if ( i == 0 ) {
			I   = iexp(t,lfirst(HH));
			Ind = iprod(Ind,I);
		}
		t  = lfirst(HH);
		HH = lred(HH);
		puti(t);
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
	while ( HH != _0 ) {
		i  = 1 - i;      
		if ( i == 0 ) {
			I   = iexp(t,lfirst(HH));
			Ind = iprod(Ind,I);
		}
		t  = lfirst(HH);
		HH = lred(HH);
		puti(t);
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
	printf("\n %d / 100 seconds (computation and decomposition of d_kl and d_red).\n",t);

	B  = _0;
	while ( Lk != _0 ) {
		e = lsecond(Lk);
		if ( e != 1 ) {
			p = lfirst(Lk);      
			if (oupidedekmt(p,F)) {
				Q  = iexp(p,lsecond(L));
				B  = lcomp2(p,Q,B);
			}
			else {
				printf("\n Dedekind - Criterion : ");puti(p);
				printf(" do not divide [ O : Z[z] ].");
			}																									
		}
		L  = lred2(L);          
		Lk = lred2(Lk);
	}

	*pL = _0;
	n   = lfirst(F);

	if ( B == _0 ) {
		for (i=0;i<n;i++) {
			M = list3(1,i,1);
			B = lcomp(M,B);
		}                 
	}
	else {
		L=B;
		M = cdmarid(n);
                do {
			p = lfirst(L);
			L = lred(L);
                        Q = lfirst(L);
                        L = lred(L);
			printf("\n Computation for p = ");
		        puti(p);
			printf(".  ");	
                        printf("Please wait !! ");
			t = settime();
                        B = ouspibaslmoi(F,p,Q,&k);                              
			t = settime();
			printf("\n Time : ");
			printf(" %d / 100 sec.\n",t);
			*pL = lcomp2(k,p,*pL);
			M = lconc(B,M);
			M = cdmarhermred(M);
		} while ( L != _0 );         
		if (*pL!=_0) *pL = linv(*pL);
		B = cdprlfcdmar(M); 
	}
	M = _0;
	while ( B != _0 ) {
		L = lfirst(B);
		B = lred(B);
		L = uprfcdpr(L);
		M = lcomp(L,M);
	}	
	return(M);
}


static list ouspibasicss(F,pL)
pol F;
list *pL;
{
	list Vz,L,Lk,B,M,HH,H2;
	single n,i,k,e;
	int p,Q,rd,c,h1,t,h2,I,Ind;
	init(Vz,L,Lk,B,t,HH,H2,p,Q,rd,c,h1,h2,I,Ind);
	bind(F);

	Vz=list1(list1('z'));
	t = settime();
	rd = upireddiscc(F,&c);   
	L  = rdiscupifact(rd,c,&Lk);
	t = settime();
	printf(" %3d / 100 sec.",t);
	printf("\n for computation and decomposition of discriminant");
	printf("\n and reduced discriminant.");
	printf("\n\n d_kl (F) = ");                                 
	HH = Lk;
	i  = 0; 
	Ind = 1;
	while ( HH != _0 ) {
		i  = 1 - i;      
		if ( i == 0 ) {
			I   = iexp(t,lfirst(HH));
			Ind = iprod(Ind,I);
		}
		t  = lfirst(HH);
		HH = lred(HH);
		puti(t);
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
	printf("\n\n d_red(F) = ");                                 
	HH = L;
	i  = 0; 
	Ind = 1;
	while ( HH != _0 ) {
		i  = 1 - i;      
		if ( i == 0 ) {
			I   = iexp(t,lfirst(HH));
			Ind = iprod(Ind,I);
		}
		t  = lfirst(HH);
		HH = lred(HH);
		puti(t);
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

	B  = _0;
	while ( Lk != _0 ) {
		e = lsecond(Lk);
		if ( e != 1 ) {
			p = lfirst(Lk);      
			if (oupidedekmt(p,F)) {
				Q  = iexp(p,lsecond(L));
				B  = lcomp2(p,Q,B);
			}
			else {      
      		        	printf("\n p = ");
				puti(p);
				printf(" : Z[z] local maximal by");
				printf("\n Dedekind - Criterion");
			}																									
		}
		L  = lred2(L); 
		Lk = lred2(Lk);
	}

	*pL = _0;
	n   = lfirst(F);

	if ( B == _0 ) {
		for (i=0;i<n;i++) {
			M = list3(1,i,1);
			B = lcomp(M,B);
		}                 
	}
	else {
		L=B;
		M = cdmarid(n);
                do {
			p = lfirst(L);
			L = lred(L);
                        Q = lfirst(L);
                        L = lred(L);
			printf("\n Computation for p = ");
			puti(p);
                        printf(".         !!! Please wait !!!\n");
			t = settime();
                        B = ouspibaslmoi(F,p,Q,&k);                              
			t = settime();
			printf("\n Time: ");
			printf(" %d / 100 sec.\n",t);

			printf("\n\n Basis of local maximal order :\n");
			HH = cdprlfcdmar(B);
			HH = linv(HH);
			while ( HH != _0 ) {
 				printf("\n ");
				H2 = lfirst(HH);
				H2 = uprfcdpr(H2);
				putpr(1,H2,Vz);
				HH = lred(HH);
			}
			printf("\n\n");
			*pL = lcomp2(k,p,*pL);
			M = lconc(B,M);
			M = cdmarhermred(M);
		} while ( L != _0 );         
		if (*pL!=_0) *pL = linv(*pL);
		B = cdprlfcdmar(M); 
	}
	M = _0;
	while ( B != _0 ) {
		L = lfirst(B);
		B = lred(B);
		L = uprfcdpr(L);
		M = lcomp(L,M);
	}	
	return(M);
}
