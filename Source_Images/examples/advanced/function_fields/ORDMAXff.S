/*M
        Let Z/pZ (X) denote the rational congruence function field of
        characteristic p.
        For a given monic separable polynomial F(Y) in Z/pZ (X) [Y]
        the program computes an integral basis, i.e. a Z/pZ[X] -
	basis of the ring of integers O of the algebraic
	congruence function field Z/pZ(X) (Y) / (F(Y) * Z/pZ(X) (Y)).
*M/
/*H
        Version 1       11.10.93        J. Schmitt
H*/
/*cS
        ORDMAXff ruft auf: afmsp1expsp, afmsp1idpval, afmsp1pptf
		afmsp1prodsp, afmsp1regul, cdmarfmsp1hr, cdmarfmsp1id
		cdprfmsp1fup, cdprfmsp1inv, cdprfmsp1lfm, cdprfmsp1mh
		cdprfmsp1sum, cdprfmsp1upq, clfcdprfmsp1, coreal
		gfsalgen, iafmsp1mpmpp, icomp, iexp, intbas
		intbaslok, iprod, issprime, lcomp, lconc, lelt, linv
		llength, modprmsp1elt, oequal, oprmsp1basfg
		ouspprmsp1dm, ouspprmsp1su, pmsdif, pmsexp, pmsmonic
		pmsneg, pmsprod, pmsupmsprod, pmsupmsquot, prfmsp1sum
		rden, rfloor, rfmsp1prod, rfmsp1quot, rnum, rquot
		setocnt, settime, upgfscfact, upgfsgcd, upgfsgsd
		upgfsrelpfac, upmsaddval, upmscfacts, upmsgcd
		upprmsp1disc, upprmsp1hfa, upprmsp1redd, uprfmsp1egcd
		uprfmsp1fcdp
	Macros: geti, getpms, getsi, lcomp2, lfirst, list1, list2
		list3, list4, list5, lred, lred2, lsecond, lsred
		lthird, pdegree, pgfsquot, pmsquot, pmsrem, printf
		puti, putpms, putrfmsp1, putsi 
Sc*/

#include<_pol4.h>
main()
{                                                 
	list AL,V,Vgfs,V1,V2,V3,V33,V4,V5,HH;
	pol F,G,P,P1,P2,P3,P4,Q,Q2,a1,b1,Fh,mp,e1,e2,h1,h2,F2,ap;
	single m,n,p,l,ent,ent2,e,ph,t,i,neu,k;

	init(AL,V,Vgfs,V1,V2,V3,V33,V4,V5,HH,F,G,P,P1,P2,P3,P4,Q,Q2);
	init(a1,b1,Fh,mp,e1,e2,h1,h2,F2,ap);
                                              
	k    = 0;
	V    = list1(list1('Y'));    
	Vgfs = list1(list1('X')); 
	V33  = list2(list1('X'),list1('Y'));
	printf("\n flag 0 : integral basis;");
	printf("\n flag 1 : bases of the local maximal orders;");  
	printf("\n flag 2 : Hensel-factorization;");
	printf("\n flag 3 : complete factorization;");
	printf("\n flag 4 : orthogonal idempotents;");
	printf("\n flag 5 : all local bases;");
	printf("\n flag 6 : Eisenstein-elements;");
	printf("\n flag 7 : all elements computed in the core-algorithm;");

while (1) {
	if (k) {
		printf("\n\n\n 0 --> End of program ! ");
		printf("\n Characteristic of IF_p [X] = ");
	}
	else	printf("\n\n Characteristic of IF_p [X] = ");
    while(1) {
	p = geti();
	if (!p) break;
	t = issprime(p,&neu);
     setocnt(stdout,0);
	if ( t!=1 ) printf(" p incorrect ! \t      p = ");
	else break;
    }
	k = 1;
	if (!p) break;

	printf("\n F in ( IF_p [X] ) [Y] : F = ");
	P = getpms(2,p,V33);

	while (1) {
          while ( P == ERROR ) {
            printf("\n Input incorrect.");
   	    printf(" Please try again!");
            printf("\n F = ");
	    P = getpms(2,p,V33);
	  }
	  if ( pdegree(2,P) < 2 ) {
    if (!P) {
	printf("\n Examples : \n ");
	printf("\n p = 2 and F = Y^9 + X^2 Y^2 + X^3 Y + Y ;");
	printf("\n p = 2 and F = Y^11 + X^3 Y^10 + X^2 Y^10 + X Y^10 + X^3 Y^7 + X^2 Y^7 + Y^7 ");
        printf("\n + X^3 Y^6 + X Y^6 + Y^6 + X^3 Y^4 + X^2 Y^4 + X Y^4 + Y^4 + X^3 Y^3 + X^2 Y^3 ");
	printf("\n + X Y^3 + X^3 Y^2 + X^2 Y^2 + Y^2 + X^3 Y + X Y + Y + X^3 + X^2 + 1 ;");

	printf("\n p = 5 and F = Y^7 + 2 X^3 Y^6 + 4 X^2 Y^6 + 2 X Y^6 + 3 Y^6 + 2 X^3 Y^5 + 4 X^2");
	printf("\n Y^5 + Y^5 + 2 X^3 Y^4 + 3 X^2 Y^4 + 3 X Y^4 + 2 X^3 Y + 4 X^2 Y + 4 X Y + 3 Y ;");
	printf("\n p = 5 and F = Y^6 + 2 X^3 Y^5 + 4 X^2 Y^5 + 2 X Y^5 + 2 Y^5 + 2 X^3 Y^3 + ");
	printf("\n 4 X^2 Y^3 + Y^3 + 2 X^3 Y + 3 X^2 Y + 3 X Y ;");

	printf("\n p = 19 and F = Y^4 + 15 X Y^3 + 16 Y^3 + 4 X^2 Y^2 + 11 Y^2 + 10 X^2 Y + ");
	printf("\n 10 X Y + 10 Y ; ");
	printf("\n p = 19 and F = Y^4 + 15 X Y^3 + 16 Y^3 + 5 X^2 Y^2 + 18 X Y^2 + 8 Y^2 + 2 X^2 Y");
	printf("\n + 17 X Y + 10 Y .\n");
	printf("\n Characteristic of IF_p [X] = ");
    while(1) {
	p = geti();
	t = issprime(p,&neu);
     setocnt(stdout,0);
	if ( t!=1 ) printf(" p incorrect ! \t      p = ");
	else break;
    }

	  
	printf("\n F in ( IF_p [X] ) [Y] : F = ");
	P = getpms(2,p,V33);
	continue;

    }
    else {
	    printf("\n F trivial.");
   	    printf(" Please try again!");
	    printf("\n F = ");
	    P = getpms(2,p,V33);
    }
	  }	    
	  else {
 	    if ( !oequal(lsecond(P),list2(0,1)) ) {
	      printf("\n F not monic.");
   	      printf(" Please try again!");
 	      printf("\n F = ");
	      P = getpms(2,p,V33);
	    }
	    else {
              if( !upprmsp1disc(p,P) ) { 	
	        printf("\n F not separable.");
   	        printf(" Please try again!");
	        printf("\n F = ");
		P = getpms(2,p,V33);
	      }                                                  
	      else break;		
            }
          }
	}


	printf("\n Input of flag (0-7) : ");
	neu = getsi();
	if ((neu<0)||(7<neu)) neu=0;
	V4 = intbas(p,P,&V5,neu);

m = llength(V4);
	printf("\n Integral basis with z := Y modulo F : \n");
	for (n=1;n<=m;n++) {
                P3 = lfirst(V4);
		V4 = lred(V4);
		if (P3==0) printf(" 0 # \n");
		else {   
			t = 0;
			while ( P3 != _0 ) {
				l=lfirst(P3);
				P3=lred(P3);
				P1=lfirst(P3);
				P3=lred(P3);
				if ( !t ) printf("\n ");
				if ( !oequal(P1,rfmsp1prod(p,P1,P1)) ) {
					printf("( ");
					putrfmsp1(p,P1,Vgfs);
					printf(" ) ");
        				printf(" * ");
				}
				printf("z^");
				putsi(l);
				if ( P3 != _0 ) printf(" + ");
				else printf(" ; ");
				t = 1;
			}
		}
	}

	printf("\n\n Index of polynomial order in maximal order is \n");
	if ( V5 == _0 ) printf("1");
	while ( V5 != _0 ) {
		printf("\n ( ");	
		putpms(1,p,lfirst(V5),Vgfs);
		printf(") ^ ");	
                putsi(lsecond(V5));
		V5=lred2(V5);
		if ( V5!=_0) printf("    * ");
	}
} /* end while(1) */
}

static list intbas(p,F,pL,neu)
single p;
pol F;
list *pL;
single neu;
{
	list Va,Vax,Neu,Neun,A,L,Lk,B,M;
	single s,t,n,i,k,e,mn,nn,tn,ln,zz;
	pol P,Q,rd,c;
	init(Va,Vax,Neu,Neun,A,L,Lk,B,M,P,Q,rd,c);
	bind(F);
          
	c  = upprmsp1disc(p,F);
Va = list1(list1('X'));
Vax = list2(list1('X'),list1('Y'));
                             
M = _0;

if ( lfirst(c) ) {
	A = upmscfacts(p,c);
	printf("\n Decomposition of discriminant: d(F) = ");putpms(1,p,c,Va);
	printf(" = \n");
	while (A!=_0) {
		printf("\n ( ");
		putpms(1,p,lfirst(A),Va);
		printf(") ^ ");
		putsi(lsecond(A));
		A=lred2(A);
		if (A!=_0) printf("    * ");
		printf("");
	}
}
else {
	printf("\n Discriminant d(F) = ");
	putpms(1,p,c,Va);
}

	rd = upprmsp1redd(p,F);                 
	rd = pmsmonic(1,p,rd);
if ( pdegree(1,rd) ) {
	M  = upmscfacts(p,rd);   
	printf("\n\n Decomposition of reduced discriminant: d_r(F) = ");putpms(1,p,rd,Va);
	printf(" = \n");
	A = M;
	while (A!=_0) {
		printf("\n ( ");
		putpms(1,p,lfirst(A),Va);
		printf(") ^ ");
		putsi(lsecond(A));
		A=lred2(A);
		if (A!=_0) printf("    * ");
	}
}
else {
	printf("\n Reduced discriminant d_r(F) = ");
	putpms(1,p,rd,Va);
}
	L  = _0;
	while ( M != _0 ) {
		B = lfirst(M);
		M = lred(M);
		n = lfirst(M);
		M = lred(M);
		if ( n != 1 ) L = lcomp2(B,n,L);
	        else {
			Q = pmsquot(1,p,c,B);
                        if ( !pmsrem(1,p,Q,B) ) L = lcomp2(B,n,L);
		}     
	}


s = 0;
zz=1;
	while ( L != _0 ) {
		P = lfirst(L);
		L = lred(L); 
		e = lfirst(L);
		L = lred(L); 
		if ( ouspprmsp1dm(p,P,F) ) {
s++;
if (s ==1) 
   printf("\n\n Dedekind-Criterion: polynomial order is not local maximal for:\n");
printf("\n P_%d = ",zz);
zz++;
putpms(1,p,P,Va);
			Q = pmsexp(1,p,P,e);
			M = lcomp2(P,Q,M);
		}
	} 
printf("\n");                 
	Lk = _0;
	n  = lfirst(F);
	c  = list2(0,1);
	if ( M == _0 ) {
		for (i=0;i<n;i++) {
			B = list2(c,c);
			B = list2(i,B);
			M = lcomp(B,M);
		}                 
	}
	else {
		B = cdmarfmsp1id(n);
                do {
			P  = lfirst(M);
			M  = lred(M);
                        Q  = lfirst(M);
                        M  = lred(M);
printf("\n Computation of local maximal order for prime element P_i = ");
putpms(1,p,P,Va);
t = settime();
                        L  = intbaslok(p,F,P,Q,&k,neu);
t = settime();
printf("\n\n ( Time in 1/100 sec. : ");puti(t);printf(" )\n");
			Lk = lcomp2(k,P,Lk);

if (neu > 0 ) {
A = cdprfmsp1lfm(L,p); 
Neun = _0;
while ( A != _0 ) {  
Neu = uprfmsp1fcdp(p,lfirst(A));
A = lred(A);
Neun = lcomp(Neu,Neun);
}		
A = linv(Neun);

mn = llength(A);
printf("\n Basis of local maximal order with z := Y modulo F : \n");
for (nn=1;nn<=mn;nn++) {
Neu = lfirst(A);
A = lred(A);
if (Neu==0) printf(" 0 # \n");
else {   
tn = 0;
while ( Neu != _0 ) {
ln=lfirst(Neu);
Neu=lred(Neu);
Neun=lfirst(Neu);
Neu=lred(Neu);
if ( !tn ) printf("\n ");
if ( !oequal(Neun,rfmsp1prod(p,Neun,Neun)) ) {
printf("( ");
putrfmsp1(p,Neun,Va);
printf(" ) ");
printf(" * ");
}
printf("z^");
putsi(ln);
if ( Neu != _0 ) printf(" + ");
else printf(" ; ");
tn = 1;
}
}
}
}
printf("\n");
			B  = lconc(L,B);
			B  = cdmarfmsp1hr(p,B);
		} while ( M != _0 );         
		if ( Lk != _0 ) Lk = linv(Lk);
		B = cdprfmsp1lfm(B,p); 
		while ( B != _0 ) {  
			P = uprfmsp1fcdp(p,lfirst(B));
			B = lred(B);
			M = lcomp(P,M);
		}
	}
	L = linv(M);
	*pL = Lk;
	return(L);
}

static list intbaslok(p,F,P,Q,pk,neu)
single p;
pol F,P,Q;
single *pk;
single neu;
{
	single j,i,zaehl;       
	list Vax,H,H1,H2,L,Lb,Ls,Lo,Lf,AL;
	pol zw,zw2,Q2,g,fh,fs,fb;

	init(Vax,H,H1,H2,L,Lb,Ls,Lo,Lf,AL,zw,zw2,Q2,g,fh,fs,fb);
	bind(F,P,Q);

Vax = list2(list1('X'),list1('Y'));
	AL = gfsalgen(p,pdegree(1,P),P);
	Q2 = pmsprod(1,p,Q,Q);
  	fh = F;
	fs = _0;
	while ( fh != _0 ) {
		i  = lfirst(fh);
		fh = lred(fh);
		fb = pmsrem(1,p,lfirst(fh),P);
		fh = lred(fh);
		if (fb) fs  = lcomp2(fb,i,fs);
	}
	fh = linv(fs);

	g  = upgfsgsd(p,AL,fh);     
	if ( pdegree(1,g) <= 1 ) {
		Lb = list1(g);
	  	fh = F;
		fs = _0;
		while ( fh != _0 ) {
			i  = lfirst(fh);
			fh = lred(fh);
			fb = pmsrem(1,p,lfirst(fh),Q2);
			fh = lred(fh);
			if (fb) fs  = lcomp2(fb,i,fs);
		}
		g  = linv(fs);
		Ls = list1(g);
		j  = upmsaddval(p,P,Q);
		j  = j+j;
	}
	else {                      
		Lb = upgfscfact(p,AL,g);
		if ( lred(Lb) == _0 ) {
		  	fh = F;
			fs = _0;
			while ( fh != _0 ) {
				i   = lfirst(fh);
				fh  = lred(fh);
				fb  = pmsrem(1,p,lfirst(fh),Q2);
				fh  = lred(fh);
				if (fb) fs  = lcomp2(fb,i,fs);
			}
			g  = linv(fs);
			Ls = list1(g);
			j  = upmsaddval(p,P,Q);
			j  = j+j;
		}
		else {
			L  = _0;
			Ls = Lb;
			while ( Ls != _0 ) {
				g  = lfirst(Ls);
				Ls = lred(Ls);
				fh = upgfsrelpfac(p,AL,fh,g,&fs);
				L  = lcomp(fs,L);
			}
			L  = linv(L);
                	j  = upmsaddval(p,P,Q);
			j  = j+j;
			Ls = upprmsp1hfa(p,F,P,L,j);
		}
        }

if (neu > 1) {
printf("\n\n Factors determined by Hensel/Zassenhaus modulo (P_i)^%d : \n",j);
  H = Ls;
zaehl=1;
  while (H!=_0) {
    H1 = lfirst(H);H=lred(H);
printf("\n F_%d = ",zaehl);putpms(2,p,H1,Vax);
zaehl++;
  }
}

	L = _0;
	while (Ls != _0) {
	  	zw = lfirst(Ls);
		fs = _0;
		while ( zw != _0 ) {
			i   = lfirst(zw);
			zw  = lred(zw);
			fb  = pmsrem(1,p,lfirst(zw),Q2);
			zw  = lred(zw);
			if (fb) fs  = lcomp2(fb,i,fs);
		}
		if ( fs != _0 ) fs = linv(fs);
		else fs = 0;
		Ls = lred(Ls);
		L  = lcomp(fs,L);
	}
	Ls = linv(L);

	fs = lfirst(Ls);
	Ls = lred(Ls);
	fb = lfirst(Lb);
	Lb = lred(Lb);
	fh = fs;

	zaehl = 1;
	L  = coreal(p,fs,P,Q,fb,neu,zaehl);

	if ( llength(L) == 2 ) {	
		Lf = lfirst(L);
		Lo = lsecond(L);

		L  = _0;
		L  = ouspprmsp1su(p,fs,P,Q,fb,Lf,Lo,L,1,neu,zaehl);
        }
 	else 
	L = lfirst(L);
	while ( Lb != _0 ) {
		fb = lfirst(Lb);
		Lb = lred(Lb);
		fs = lfirst(Ls);
		Ls = lred(Ls);
		g  = lcomp(list2(0,1),fh);
		Lo = list1(g);
		g  = lcomp(list2(0,1),fs);
		Lo = lcomp(g,Lo);
		Lf = list2(fh,fs);  
		fh = pmsprod(2,p,fh,fs);
		zw = _0;
		while ( fh != _0 ) {
			i   = lfirst(fh);
			fh  = lred(fh);
			zw2 = pmsrem(1,p,lfirst(fh),Q2);
			fh  = lred(fh);
			if (zw2) zw  = lcomp2(zw2,i,zw);
		}
		if ( zw != _0 ) fh = linv(zw);
		else fh = 0;

		zaehl++;
		L = ouspprmsp1su(p,fh,P,Q,fb,Lf,Lo,L,2,neu,zaehl);
	}                                   
                      
	AL  = list2(0,1);
	zw2 = list2(AL,AL);
	Lb  = L;              
	j   = 1;
	while ( Lb != _0 ) {
		Ls  = lfirst(Lb);  
		Lb  = lred(Lb);
		zw  = lfirst(Ls);
		zw  = list2(zw,AL);
		for (i=0;i<j;i++) Ls = lred(Ls);
		j   = j+1;
		zw  = rfmsp1quot(p,list2(lfirst(Ls),AL),zw);
		zw2 = rfmsp1prod(p,zw2,zw);	
	}                        
	zw  = lsecond(zw2);
	*pk = upmsaddval(p,P,zw);

        return(L);
} 

/*c
	ouspprmsp1su is a static modul called by ouspprmsp1bl
c*/
/*h
	Version 1    	 20.02.90	 J.Schmitt
   DATE ouspprmsp1su   : 900501
h*/
/*cS
	ouspprmsp1su ist rekursiv
	und ruft auf: coreal, afmsp1prodsp, cdmarfmsp1hr
		cdmarfmsp1id, cdprfmsp1lfm, cdprfmsp1mh, clfcdprfmsp1
		lcomp, lelt, llength
	Macros: lfirst, list2, lred, lsecond, pdegree
Sc*/

static list ouspprmsp1su(p,A1,P,Q,A2,L1,L2,L,v,neu,zaehl)
single p;
pol A1,P,Q,A2;
list L1,L2,L;
single v,neu,zaehl;
{                                 
	single n1,j;   
	list G,Gl,M,Ml,H,LH;
	pol Fh,e1,h,z;

	bind(A1,P,Q,A2,L1,L2,L);   
	init(G,Gl,M,Ml,H,LH,Fh,e1,h,z);	

        n1 = pdegree(1,A1);                                          
	M  = cdmarfmsp1id(n1);
	for (j=1;j<3;j++) {  
		if ( j >= v ) {
			Fh = lelt(L1,j);                 

			L  = coreal(p,Fh,P,Q,A2,neu,zaehl);
			if ( llength(L) == 2 ) {
				LH = lfirst(L);
				H  = lsecond(L);
				L  = _0;
				L  = ouspprmsp1su(p,Fh,P,Q,A2,LH,H,L,1);
			}       
			else L = lfirst(L);    
		} 
		e1 = lfirst(L2);
		L2 = lred(L2);     
		z  = lfirst(L);
		z  = lfirst(z);
		e1 = cdprfmsp1mh(p,e1,z);
		if ( e1 != 0 ) {
			G = cdprfmsp1lfm(L,p);
			do {
				Gl = lfirst(G);
				G  = lred(G);
				h  = afmsp1prodsp(p,A1,e1,Gl,list2(0,1));
				if ( h != 0 ) {
					Ml = clfcdprfmsp1(h,n1);
					M  = lcomp(Ml,M);
				}
                	} while (G!=_0);
		}   
	}
	M = cdmarfmsp1hr(p,M);
	return(M);
} 

static list coreal(p,F,P,Q,mp,neu,zaehl)
single p;              
pol F,P,Q,mp;
single neu,zaehl;
{
	single n,na,wy,e4,r,i,e,k,l,d,t,ph,ph2;
	int  ph3;
	rat  va,vb,vc;
	list Vax,H1,H2,H3,H4,HH,M,B,B2,Bl,AL;
	pol  Fh,Pp,P2,Ph,MOD,R2,E,U,G,H,y;
	pol  a0,ma0,a1,a2,alb,b0,mb0,b1,b2,blb,c0,mc0,c1,c2,clb;
	bind(F,P,Q,mp);
	init(ph3,va,vb,vc,Vax,H1,H2,H3,H4,HH,M,B,B2,Bl,AL,Fh,Pp,P2,Ph,MOD,R2,E,U,G,H,y);
	init(a0,ma0,a1,a2,alb,b0,mb0,b1,b2,blb,c0,mc0,c1,c2,clb);

Vax=list2(list1('X'),list1('Y'));
	e4 = 1;           
	Fh = 0;	                   
	E  = list2(0,1);
	n  = lfirst(F);
	U  = list3(E,1,E);
	ph = pdegree(1,P);
	AL = gfsalgen(p,ph,P);

	a1 = F; 
	a2 = _0;
	while ( a1 != _0 ) {
		t  = lfirst(a1);
		a1 = lred(a1);
		b1 = pmsrem(1,p,lfirst(a1),P);
		a1 = lred(a1);
		if (b1) a2 = lcomp2(b1,t,a2);
	}
	a2 = linv(a2);
	a2 = pgfsquot(1,p,AL,a2,mp);
	a1 = pmsdif(2,p,F,pmsprod(2,p,a2,mp));
	a1 = pmsupmsquot(2,p,a1,P);
	b1 = _0;
	while ( (a1) && (a1 != _0) ) {
		t  = lfirst(a1);
		a1 = lred(a1);
		b2 = pmsrem(1,p,lfirst(a1),P);
		a1 = lred(a1);
		if (b2) b1 = lcomp2(b2,t,b1);
	}
	if ( b1 != _0 ) a1 = linv(b1);
	else a1 = 0;                
 	a1 = upgfsgcd(p,AL,a1,a2);
	if ( lfirst(a1) == 0 ) {
		U = list1(U);
if(neu>4) {
printf("\n\n Factor ");putpms(2,p,F,Vax);
printf(": polynomial order is local maximal by Dedekind-Criterion.");
}
		M = oprmsp1basfg(p,F,U);   
		M = list1(M);
		return(M);
	}                          

	wy = 1;
	y  = 0;
	if ( lred2(mp) == _0 ) {   
		a1  = list2(0,(p-1));
		a0  = list5(E,1,E,0,a1);
		ma0 = list4(1,E,0,E);
	}
	else {
		a0  = U;
		ma0 = mp;
	}

	for ( ; ; ) {
	    for ( ; ; ) {
		if ( e4 == 1 ) {
			na = lfirst(ma0);
			na = n / na;
			if ( na == 1 )  {
				y  = 0;
				wy = 1;
			}
			if ( na == wy ) {    
				if(y) M = list3(U,a0,y);
				else  
{
				M = list2(U,a0);
if(neu>5){
printf("\n\n Factor ");putpms(2,p,F,Vax);printf(": Eisenstein-element (1) :");
HH = a0;
 if (HH==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(HH);
  printf("\n ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(HH);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
}
printf("\n");
}
				M = oprmsp1basfg(p,F,M);
				M = list1(M);
if(neu>4){
printf("\n\n Factor ");putpms(2,p,F,Vax);printf(": basis for local maximal order:\n");
HH = lfirst(M);
HH = cdprfmsp1lfm(HH,p);
while (HH!=_0) {
 H1 = lfirst(HH);
 H1 = uprfmsp1fcdp(p,H1);
 HH = lred(HH);
 if (H1==0) printf(" 0 # \n");
 else {   
  H3 = 0;
  while ( H1 != _0 ) {
	H4=lfirst(H1);
	H1=lred(H1);
	H2=lfirst(H1);
	H1=lred(H1);
	if ( !H3 ) printf("\n ");
	if ( !oequal(H2,rfmsp1prod(p,H2,H2)) ) {
 	 printf("( ");
	 putrfmsp1(p,H2,list1(list1('X')));
	 printf(" ) ");
	 printf(" * ");
	}
	printf("z^");
	putsi(H4);
	if ( H1 != _0 ) printf(" + ");
	else printf(" ; ");
	H3 = 1;
  }
 }
}
printf("\n");
}		
				return(M);
			}



 			va = afmsp1regul(p,F,P,Q,a0,ma0,&a1,&a2);
			i  = rden(va);
			if ( i == na ) {
if(neu>5) {
H1 = cdprfmsp1sum(p,a0,a2);
H2 = iafmsp1mpmpp(p,F,H1,P,1,Q);
if ( pdegree(1,H2) == n ) {
printf("\n\n Factor ");putpms(2,p,F,Vax);printf(": Eisenstein-element (2) :");
 if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf("\n ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
printf("\n");
}
else {
H3 = lfirst(a0);
H4 = lred(a0);
if ( !pmsrem(1,p,H3,P) ) { H3 = pmsquot(1,p,H3,P); }
else H4 = pmsupmsprod(2,p,H4,P);
H4 = lcomp(H3,H4);

while (1) {
H1 = cdprfmsp1sum(p,H1,H4);
H2 = iafmsp1mpmpp(p,F,H1,P,1,Q);
if ( pdegree(1,H2) == n ) {
printf("\n\n Factor ");putpms(2,p,F,Vax);printf(": Eisenstein-element (3) :");
 if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf("\n ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
printf("\n");
break; }
} /* END while */
} /* END else  */
} /* END if(neu>5) */
				M = list3(U,a0,a2);
				M = oprmsp1basfg(p,F,M);
				M = list1(M);   
if(neu>4){
printf("\n\n Factor ");putpms(2,p,F,Vax);printf(": basis of local maximal order:\n");
HH = lfirst(M);
HH = cdprfmsp1lfm(HH,p);
while(HH!=_0) {
 H1 = lfirst(HH);
 H1 = uprfmsp1fcdp(p,H1);
 HH = lred(HH);
 if (H1==0) printf(" 0 # \n");
 else {   
  H3 = 0;
  while ( H1 != _0 ) {
	H4=lfirst(H1);
	H1=lred(H1);
	H2=lfirst(H1);
	H1=lred(H1);
	if ( !H3 ) printf("\n ");
	if ( !oequal(H2,rfmsp1prod(p,H2,H2)) ) {
 	 printf("( ");
	 putrfmsp1(p,H2,list1(list1('X')));
	 printf(" ) ");
	 printf(" * ");
	}
	printf("z^");
	putsi(H4);
	if ( H1 != _0 ) printf(" + ");
	else printf(" ; ");
	H3 = 1;
  }
 }
}
printf("\n");
}		
				return(M);
			}
			Pp = P;
			if ( i % wy ) {
			    alb = afmsp1idpval(p,F,P,a0,a2,i,y,wy,&y,&wy);
if(neu>6){
printf("\n v_P^* - value was reduced, y = 1 / %d",wy);
printf(" for \n c = ");
 H1 = y;
if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf(" ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
printf("\n was replaced by 1 / kgV(y,z) with z = %d for \n g = ",i);
 H1 = a0;
if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf(" ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
}

			}
			else {
				if ( i == 1 ) Pp = pmsprod(1,p,P,P);
				if ( rnum(va) == 1 ) break;     
				alb = cdprfmsp1sum(p,a0,a2);
				
			}
		}
		e4  = 1;                    
		ma0 = afmsp1pptf(p,F,P,Q,Pp,a0,alb);
		alb = lsecond(ma0);
                if (llength(ma0)==2) ma0=lfirst(ma0);
		else {
			M = lred(ma0);

if (neu>2) {
HH = lfirst(M);
printf("\n\n Core-algorithm: F_i = ");
putpms(2,p,F,Vax);
printf(" was factored in \n\n ");
putpms(2,p,lfirst(HH),Vax);
printf("   and \n ");
putpms(2,p,lsecond(HH),Vax);
printf("\n");
}
if (neu>3) {
HH = lsecond(M);
printf("\n Related orthogonal idempotents : \n");
while(HH!=_0) {
 H1 = lfirst(HH);
 HH = lred(HH);
 if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf("\n ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,Vax);printf(" ) ");
 }
printf("\n");
}
}		
			return(M);
		}
		a0  = alb;
	    }

	    y   = a2;
	    wy  = rden(va);
	    clb = list3(E,0,E);
	    B   = list2(U,a0);
	    B   = oprmsp1basfg(p,F,B);
	    B   = cdprfmsp1lfm(B,p);
	    Ph  = pmsprod(1,p,P,P);
	    b0  = afmsp1expsp(p,F,a2,wy,Ph);
	    b0  = cdprfmsp1upq(p,b0,P);
	    if ( modprmsp1elt(B,p,b0) == 0 ) { 
		a1  = a2;
		Pp  = P;
		MOD = E;
	    }
	    else {                
		B   = list1(a0);
		B   = oprmsp1basfg(p,F,B);
		B   = cdprfmsp1lfm(B,p);
		B2  = B;
		MOD = E;
		while ( B2 != _0 ) {
			Bl  = lfirst(B2);
			B2  = lred(B2);
			MOD = pmsprod(1,p,MOD,lthird(Bl));
		}                         

		Ph = pmsquot(1,p,Pp,upmsgcd(p,Pp,MOD));
		Ph = pmsprod(1,p,MOD,Ph);
		a1 = cdprfmsp1mh(p,a1,Ph);

                Pp = P;
		Ph = pmsquot(1,p,P,upmsgcd(p,P,MOD));
		Ph = pmsprod(1,p,MOD,Ph);
		Ph = pmsprod(1,p,Ph,P);
		b0 = afmsp1expsp(p,F,a1,wy,Ph);
		b0 = cdprfmsp1upq(p,b0,P);
	    }                            
               
	    if ( !Fh ) {
	        B2 = F;
	        Bl = _0;
	        while ( B2 != _0 ) {
			t  = lfirst(B2);
			B2 = lred(B2);
			R2 = list2(lfirst(B2),E);
			B2 = lred(B2);
			Bl = lcomp2(R2,t,Bl);
		}
	        Fh = linv(Bl);	
	    }

	    for ( ; ; ) {                         
		mb0 = afmsp1pptf(p,F,P,Q,P,a0,b0);
		b1  = lsecond(mb0);
                if (llength(mb0)==2) mb0 = lfirst(mb0);
		else {                     
			M = lred(mb0);

if (neu>2) {
HH = lfirst(M);
printf("\n\n Core-algorithm : F_i = ");
putpms(2,p,F,Vax);
printf(" factored in \n\n ");
putpms(2,p,lfirst(HH),Vax);
printf("   and \n ");
putpms(2,p,lsecond(HH),Vax);
printf("\n");
}
if (neu>3) {
HH = lsecond(M);
printf("\n Related orthogonal idempotents : \n");
while(HH!=_0) {
 H1 = lfirst(HH);
 HH = lred(HH);
 if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf("\n ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,Vax);printf(" ) ");
 }
printf("\n");
}
}

			return(M);
		}

		Ph  = pmsquot(1,p,P,upmsgcd(p,P,MOD));
		Ph  = pmsprod(1,p,MOD,Ph);
		b0  = cdprfmsp1mh(p,b0,Ph);
		alb = cdprfmsp1sum(p,a0,b0);
		i   = lfirst(ma0);
		r   = lfirst(mb0);
		if ( i % r ) {
			e4 = 0;
if(neu>6){
printf("\n\n Core-algorithm: a and b with f_a do not divide f_b.");
printf("\n Replace a by a+b.");
printf("\n a = ");
 H1 = a0;
if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf(" ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
printf("\n b = ");
 H1 = b0;
if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf(" ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
printf("\n f_a = %d, f_b = %d.",i,r);
}
			break;
		}
	 	vb = afmsp1regul(p,F,P,Q,b0,mb0,&b1,&b2);
		i  = rden(va);
		r  = rden(vb);
		if ( i % r ) {                             
			alb = afmsp1idpval(p,F,P,a0,a2,i,b2,r,&y,&wy);
if(neu>6){
printf("\n v_P^* - value was reduced, y = 1 / %d",r);
printf(" for \n c = ");
 H1 = b0;
if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf(" ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
printf("\n was replaced by 1 / kgV(y,z) with z = %d for \n g = ",i);
 H1 = a0;
if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf(" ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
}
			e4 = 0;
			break;
		}              
		B2 = afmsp1pptf(p,F,P,Q,P,a0,alb);
		Bl = lsecond(B2);
                if (llength(B2)==2) B2=lfirst(B2);
		else {
			M = lred(B2);

if (neu>2) {
HH = lfirst(M);
printf("\n\n Core-algorithm : F_i = ");
putpms(2,p,F,Vax);
printf(" factored in \n\n ");
putpms(2,p,lfirst(HH),Vax);
printf("   and \n ");
putpms(2,p,lsecond(HH),Vax);
printf("\n");
}
if (neu>3) {
HH = lsecond(M);
printf("\n Related orthogonal idempotents : \n");
while(HH!=_0) {
 H1 = lfirst(HH);
 HH = lred(HH);
 if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf("\n ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,Vax);printf(" ) ");
 }
printf("\n");
}
}		

			return(M);		
		}         
		R2  = pmsprod(1,p,Q,MOD);
   		e   = upmsaddval(p,P,R2);                      
                e   = iprod(e,n);
		ph2 = iprod(ph,lfirst(ma0));
		ph2 = iexp(p,ph2);
		ph3 = ph2;
		while ( icomp(e,ph3) == 1 ) ph3 = iprod(ph3,ph2);
		blb = afmsp1expsp(p,F,b0,ph3,R2);
		Ph  = pmsquot(1,p,P,upmsgcd(p,P,MOD));
		Ph  = pmsprod(1,p,MOD,Ph);
		blb = cdprfmsp1mh(p,blb,Ph);
		B2  = pmsneg(2,p,lred(b0));
		lsred(b0,B2);
		B2  = cdprfmsp1sum(p,blb,b0);
		c0  = afmsp1prodsp(p,F,B2,clb,0);
		mc0 = list2(1,E);
		vc  = afmsp1regul(p,F,P,Q,c0,mc0,&c1,&c2);
		t   = rfloor(vc);
		t   = t + 1;
		P2  = pmsexp(1,p,P,t);
		Ph  = pmsquot(1,p,P2,upmsgcd(p,P2,MOD));
		R2  = pmsprod(1,p,Ph,MOD);
		c0  = cdprfmsp1mh(p,c0,R2); 
		i   = rden(va);
		r   = rden(vc);
		if ( i % r ) {
			alb = afmsp1idpval(p,F,P,a0,a2,i,c2,r,&y,&wy);
if(neu>6){
printf("\n v_P^* - value was reduced, y = 1 / %d",r);
printf(" for\n c = ");
 H1 = c0;
if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf(" ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
printf("\n was replaced by 1 / kgV(y,z) with z = %d for \n g = ",i);
 H1 = a0;
if (H1==0) printf(" 0 # \n");
 else {   
  H2 = lfirst(H1);
  printf(" ( 1 / ");putpms(1,p,H2,list1(list1('X')));printf(")  *   ( ");
  H1 = lred(H1);
  putpms(2,p,H1,list2(list1('X'),list1('z')));printf(" ) ");
 }
}
			e4 = 0;
			break;
		}
		B2  = rquot(vc,va);
		k   = rnum(B2);
		clb = afmsp1expsp(p,F,a1,k,R2);
                Ph  = uprfmsp1fcdp(p,clb);
		b0  = list2(P2,E);
		b0  = list2(0,b0);
		do {
			B2 = uprfmsp1egcd(p,Fh,Ph,&Bl,&R2);
			if ( lfirst(B2) ) Ph = prfmsp1sum(1,p,Ph,b0);
		} while ( lfirst(B2) );                         
		clb = cdprfmsp1fup(p,Ph);         
		Bl  = cdprfmsp1inv(p,Fh,clb);
		ph2 = upmsaddval(p,P,MOD);
		R2  = pmsexp(1,p,P,ph2);
		R2  = pmsquot(1,p,MOD,R2);
		Ph  = lfirst(Bl);
		Bl  = lred(Bl);
		ph2 = upmsaddval(p,P,Ph);
		Ph  = pmsexp(1,p,P,ph2);
		Bl  = pmsupmsprod(2,p,Bl,R2);
		Bl  = lcomp(Ph,Bl);
		b0  = afmsp1prodsp(p,F,c0,Bl,0);
	    }
	}
}
