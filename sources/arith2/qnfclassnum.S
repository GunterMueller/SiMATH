/*M
.SH NAME
qnfclassnum - class number of quadratic field

.SH SYNOPSIS
.nf
#include<_arith2.h>

int qnfclassnum(D)  int D;   

.SH DESCRIPTION
.TP 4
.B D
is an integer number, D must be 0 or 1 mod 4.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).   
.PP
qnfclassnum returns the class number of K.

M*/
                   
/*H

        Version 2       19.08.1997      S.Kessler
H*/

#include <_arith2.h>

double fltoCfl();


int igcdSim(r1,r2,P2)
	int r1;
	int r2;
	int P2[2];

{
	int P1[2],P[2],r,q,hilf;
	single Marke;

	bind(r1,r2,P2[0],P2[1]);
	init(P1[0],P1[1],P[0],P[1],r,q,hilf);

	if (icomp(r1,0)==0) {
		P2[0]=0;
		P2[1]=1;
		return(r2);
	}

	if (icomp(r2,0)==0) {
		P2[0]=1;
		P2[1]=0;
		return(r1);
         }
		
	Marke=0;
	if (icomp(r1,r2) < 0) {
		Marke=1;
		hilf=r1;r1=r2;r2=hilf;
         }
	
	r=mihom(r2,r1);
	q=idif(r1,r); q=iquot(q,r2);
         
	P1[0]=1;P1[1]=0;
	P2[0]=0;P2[1]=1;

	if (r == 0) {
		P2[0]=1;P2[1]=ineg(idif(q,1));
		if (Marke==1) { hilf=P2[0];P2[0]=P2[1];P2[1]=hilf;} 
		return(r2);
	}
	
   
	while (icomp(r,0)!=0) {
		r1=r2;
		r2=r;

		P[0]=idif(P1[0],iprod(q,P2[0]));
		P[1]=idif(P1[1],iprod(q,P2[1]));

		P1[0]=P2[0];P1[1]=P2[1];
		P2[0]=P[0];P2[1]=P[1];


                r=mihom(r2,r1);
	 	q=idif(r1,r);q=iquot(q,r2);
	}

	if (Marke==1) {
		hilf=P2[0];P2[0]=P2[1];P2[1]=hilf;
	}
	return(r2);
}
		
single redmakeSim(e,g)
	int e[3];
	int g[3];


{
	int r,q,hilf;
	single NU;

	bind(e[0],e[1],e[2],g[0],g[1],g[2]);
	
	init(r,q,hilf);

	NU=1;

	g[0]=e[0];g[1]=e[1];g[2]=e[2];

	while ( (icomp(ineg(g[0]),g[1])>=0) || (icomp(g[1],g[0])>0) || ( icomp(g[0],g[2])>0 )) {

	        if ( (icomp(ineg(g[0]),g[1])>=0) || (icomp(g[1],g[0])>0) ) {
		        r=mihom(iprod(2,g[0]),g[1]);
			if ( icomp(r,g[0])>0) {
			        r=idif(r,iprod(2,g[0]));
			}
			q=idif(g[1],r);q=iquot(q,iprod(2,g[0]));
			g[2]=idif(g[2],iprod(q,g[1]));g[2]=isum(g[2],iprod(iprod(q,q),g[0]));
			g[1]=idif(g[1],iprod(iprod(2,q),g[0]));
/*
			(a,b,c) -> (a,b-2qa,c-qb+q*q*a) mit b=2aq+r -a<r<=a
*/
		}

		if ( icomp(g[0],g[2])>0 ) {
			g[1]=ineg(g[1]);
			hilf=g[0];
			g[0]=g[2];
			g[2]=hilf;
		}
	}

	if (( icomp(g[0],g[2])==0) && (icomp(g[1],0)<0) ) {
		g[1]=ineg(g[1]);
	}
	
	return(NU);	
	
}


single coandredSim(e1,e2,D,g)
	int e1[3];
	int e2[3];
	int D;
	int g[3];
       
{
	int u,v,w,d,dstrich,s,n,k;
	int strich[2],f[2],hilf[3],e1s[3],e2s[3];
	single NU;

	bind(e1[0],e1[1],e1[2],e2[0],e2[1],e2[2],D,g[0],g[1],g[2]);
	init(u,v,w,d,dstrich,s,n,strich[0],strich[1],f[0],f[1],hilf[0],hilf[1],hilf[2],e1s[0],e1s[1],e1s[2],e2s[0],e2s[1],e2s[2],k);

	if (icomp(e1[0],e2[0])>0) {
		e1s[0]=e2[0];
		e1s[1]=e2[1];
		e1s[2]=e2[2];
		e2s[0]=e1[0];
		e2s[1]=e1[1];
		e2s[2]=e1[2];
	}
	else {
		e1s[0]=e1[0];
		e1s[1]=e1[1];
		e1s[2]=e1[2];
		e2s[0]=e2[0];
		e2s[1]=e2[1];
		e2s[2]=e2[2];
	}

	s=isum(e1s[1],e2s[1]);s=iquot(s,2);
	n=idif(e1s[1],e2s[1]);n=iquot(n,2);	

	dstrich=igcdSim(e1s[0],e2s[0],strich);
	d=igcdSim(dstrich,s,f);

	v=iprod(f[0],strich[1]);
	u=iprod(f[0],strich[0]);
	w=f[1];
	g[0]=iprod(e1s[0],e2s[0]);g[0]=iquot(g[0],iprod(d,d));

	g[1]=idif(iprod(v,idif(s,e2s[1])),iprod(w,e2s[2]));
	g[1]=iprod(g[1],e2s[0]);g[1]=iprod(g[1],2);g[1]=iquot(g[1],d);
	g[1]=isum(g[1],e2s[1]);
 
	g[2]=iprod(g[1],g[1]); 
	g[2]=idif(g[2],D);
	k=iprod(4,g[0]); 
	g[2]=iquot(g[2],k);  
	
	redmakeSim(g,hilf);
	 
	g[0]=hilf[0];g[1]=hilf[1];g[2]=hilf[2];
       
	return(NU);
}
	
/* Berechnung der Klassenzahl eines i.q. ZK. durch abzaehlen der reduzierten Formen */	
int CRF(D)
     int D;
{

	int a,a2,B,b,h,q;
	bind(D);
	init(a,a2,B,b,h,q);
	h=1;
	/*B=isqrt(iquot(iabs(D),3));*/
	B=iabs(D);
	B=iquot(B,3);
	B=isqrt(B);
	b=iabs(mihom(2,D));
	for (b=iabs(mihom(2,D)); icomp(b,B)<1; b=isum(b,2)) {
	    /*q=iquot(idif(iprod(b,b),D),4);*/
	    q=iprod(b,b);
	    q=idif(q,4);
	    q=iquot(q,4); 
	    a=b;
	    a2=iprod(a,a); 
	    for (a; icomp(a2,q)<1 ; a=isum(a,1)) {
	        if ((icomp(a,0)==0) || (icomp(a,1)==0))
		    a=1;
		else {
		    if ((mihom(a,q)==0) && (igcd( igcd(a,b),iquot(q,a) ) ==1)) {
		        if (icomp(a,b)==0 || icomp(iprod(a,a),q)==0 || icomp(b,0)==0)  
			    h=isum(h,1);  
			else
			    h=isum(h,2);
		    }
		}
		a2=iprod(a,a);
	    } 
	}
	return h;
}

/* Integer Power a,b beides ganze Zahlen */
int ipow(a,b)
	int a;
	int b;
{
	int p,i;
	init(p,i);
	bind(a,b);
	p=1;
	for (i=0; icomp(i,b)<0; i=isum(i,1)) p=iprod(p,a);
	return p;
}

/* GetKronecker berechnet das Kronecker Delta von a,b */
/* nach Cohen */

/* hier muessen a und b single Integer sein */
single sGetKronecker(a,b)
	single a,b;
{
	single v,k,r;
	single t[8];
	t[0]=0; t[1]=1; t[2]=0; t[3]=-1; t[4]=0; t[5]=-1; t[6]=0; t[7]=1;
	
	if (b==0)
		if (abs(a)==1) return 1;
		else   return 0;
	
	if ((a%2==0) && (b%2==0)) return 0;

	for (v=0; b%2==0; v++, b=b/2);

	if (v%2==0) 	k=1;
	else 
			/*k=(-1)^((a*a-1)/8);*/
			k=t[a&7];
	if (b<0) {
		b=-b;
		if (a<0) k=-k;
	}

	while (a!=0) {
		for (v=0; a%2==0; v++, a=a/2);
		if ((v%2==1) && (t[b&7]==-1)) k=-k; /*if ((v%2==1) && (((b*b-1)/8)%2==1)) k=-k; */
		if ((a&b&2)) 		      k=-k; /*if ((((a-1)*(b-1))/4)%2!=0)	  k=-k; */
		r=abs(a);
		a=b%r;
		b=r;
		if (a>r/2) a=a-r;
	}

	if (b==1) return k;
	else return 0;
}

/* hier koennen a und b lange Integer sein */

single iGetKronecker(a,b)
  int a,b;
{
        int v;
	int r;
	int h;
	single k;
	single t[8];
	bind(a,b);
	init(v,r,h);
	t[0]=0; t[1]=1; t[2]=0; t[3]=-1; t[4]=0; t[5]=-1; t[6]=0; t[7]=1;

	if (b==0)
	  if (iabs(a)==1) return 1;
	  else	          return 0;

	if ((ieven(a)==1) && (ieven(b)==1)) return 0;

	for (v=0; ieven(b)==1; v=isum(v,1), b=iquot(b,2));

	if (ieven(v)==1) k=1;
	else             k=t[mihom(8,iabs(a))];
/*
	if (v!=0) printf("v: %i, k: %i, a: %i",v,k,(mihom(8,iabs(a))));
*/

	if (icomp(b,0)<0)
	{
		b=ineg(b);
		if (icomp(a,0)<0) k=-k;
	}
	if ((icomp(a,0)==0) && (icomp(b,0)>0)) return 0;
	if (icomp(b,1)==0) return k;
	return (k*ijacsym(a,b)); 
}
  
/* hier werden die beiden Funktionen sGetKronecker bzw. iGetKronecker ausgewaehlt */
single GetKronecker(a,b)
	int a,b;
{
	bind(a,b); 
        if (isatom(a) && isatom(b)) 
		return sGetKronecker(a,b); 
	else
		return iGetKronecker(a,b);
}

/* GetClassNumberAnalytic : berechnet die Klassenzahl eines i.q. ZK. ueber L-Reihen */

/* singleGetCNrA benutzt reine C Arithmetik */	
single sGetCNrA(D)
	single D;
{
	single schranke,n,Kronecker;
	float s,k1;
	/*float PI=3.1415927;*/
	float h=0;
	D=-D;
	k1=PI/D;
	schranke=(single)sqrt(log((float)D)*D/(2*PI));
	for (n=1; n<=schranke; n++) 
	{
		Kronecker=GetKronecker(-D,n);
		if (Kronecker) 
		{
			s=erfc(n*sqrt(k1));
			s=s+sqrt((float)D)/(PI*n)*exp(-k1*n*n);
			s=s*Kronecker;
			h=h+s;
		}
	}
	if ((h-(single)h)>0.5) h=h+1;
	return (single)h;
}

/* intGetCNrA benutzt lange Simath Integer und Simath Fliesskommaarithmetik */	
int iGetCNrA(D)
	int D;
{
	floating flerfc(floating,int);
	int schranke,genau;
	int n;
	single Kronecker;
	floating k1,flD,fln,s,h,s1,s2,s3,flPI,fl2;

	init (schranke,k1,flD,fln,s,h,s1,s2,s3,flPI,genau,n,fl2);
	bind(D);
	fl2=itofl(2); 
	h=0;
	D=ineg(D);
	flD=itofl(D);
	flPI=flPi();
	k1=flquot(flPI,flD);

	s=fllog(flD);
	s=flprod(s,flD);
	s1=flprod(flPI,fl2);
	s=flquot(s,s1);
	s=flsqrt(s);
	schranke=flround(s);
	s=fllog(itofl(schranke));
	s=flquot(s,fllog(fl2));
	genau=flround(s);
	genau=genau; 
	flsetprec(genau+4,4);
	
	printf("Schranke: %i Genauigkeit : %i\n",schranke,iprod(4,ipow(2,genau)));

	for (n=1; icomp(schranke,n)==1; n=isum(n,1)) 
	{
		Kronecker=GetKronecker(ineg(D),n);
		if (Kronecker) 
		{
			fln=itofl(n);
			s=flsqrt(k1);
			s=flprod(fln,s);
			s=flerfc(s,iprod(4,ipow(2,genau)));
			s2=flneg(k1);
			s1=flprod(s2,fln);
			s1=flprod(s1,fln); 
			s1=flexp(s1);
			s2=flprod(flPI,fln);
			s3=flsqrt(flD); 
			s2=flquot(s3,s2);
			s1=flprod(s1,s2);
			s=flsum(s,s1);
			if (Kronecker==-1) s=flneg(s);
			h=flsum(h,s);
		}
	}
	putfl(h,10);
	printf("  ");
	return flround(h);
}

/* mGetCNrA benutzt lange Simath Integer aber C Fliesskommaarithmetik */	
int mGetCNrA(D)
	int D;
{
	int schranke;
	int n;
	single Kronecker;
	double k1,flD,fln,s,h,flPI;

	init(schranke,n);
	bind(D);
	h=0;
	D=ineg(D);
	flD=fltoCfl(itofl(D));
	flPI=fltoCfl(flPi());
	k1=flPI/flD;
	schranke=flround(Cfltofl(sqrt(log(flD)*flD/(2*flPI))));
	for (n=1; icomp(schranke,n)==1; n=isum(n,1)) 
	{
		Kronecker=GetKronecker(ineg(D),n);
		if (Kronecker) 
		{
			fln=fltoCfl(itofl(n));
			s=erfc(n*sqrt(k1));
			s=s+sqrt(flD)/(flPI*fln)*exp(-k1*fln*fln);
			s=s*Kronecker;
			h=h+s;
		}
	}
	return flround(Cfltofl(h));
}

/* berechnet den Regulator des quad. ZK. mit Diskriminante D */	
floating GetRegulator(D)
  int D;
{

  int a,b,a2,bstart,Dsqrt,s,t,found;
  floating f,R,Rh,grenze;
  int d,e,p,q,q1,pd,A,r,p1,L;
  
  bind(D);
  init (a,a2,b,bstart,Dsqrt,s,t,found);
  init (d,e,p,q,q1,pd,A,r,p1,f,R,Rh,grenze,L); 

/* imaginaer quad. Zk. Regulator = 1; */
  if (icomp(D,0)==-1) return itofl(1); 
  
  /* Berechnung einer reduzierten Form mit a>0 und 4a | (D-b^2) */
  Dsqrt=isqrt(D);
  found=0;
  for (a=Dsqrt; ( (found==0) && (a>0) ); a=idif(a,1)) {
    bstart=iprod(2,a);
    bstart=idif(Dsqrt,bstart);
    bstart=iabs(bstart);
    bstart=isum(bstart,1)	; 
    if (mihom(2,bstart)!=mihom(2,D)) isum(bstart,1);
    for(b=bstart; (found==0) && (icomp(Dsqrt,b)>=0); b=isum(b,1)) {
       t=iprod(b,b); 
       t=idif(D,t);
       s=iprod(4,a); 
       if ( (mihom(s,t)==0) && (icomp(a,0)==1)) 
	 { p=a; q=b; found=1;}
     }
  }
  
  a=p; b=q;
  /*if (found==0) printf("nichts gefunden !\n"); */
  /*printf("a: %i, b: %i\n",a,b); */
  /* Regulatorberechnung */
  f=flsqrt(itofl(D));
  d=flfloor(f);
  e=0;
  R=itofl(1);
  p=b;
  q=iprod(2,a);
  a2=q;
  q1=iprod(p,p);
  q1=idif(D,q1);
  q1=iquot(q1,q);
  
  /* fl Overflow vermeiden*/
  L=ilog2(d);
  L=idif(30,L);
  grenze=itofl(L);
  grenze=flpow(itofl(2),grenze);
		 
  do 
  {
    pd=isum(p,d);
    A=iquot(pd,q);
    r=mihom(q,pd); 
    p1=p;
    p=idif(d,r);
    t=q;
    s=idif(p,p1);
    s=iprod(A,s);
    q=idif(q1,s);
    q1=t; 
    
    Rh=itofl(p);
    Rh=flsum(f,Rh);
    R=flprod(R,Rh);
    Rh=itofl(q);
    R=flquot(R,Rh);
    if (flcomp(R,grenze)>-1) 
    { 
	R=flquot(R,grenze);
	e=isum(e,1);
    } 
     
    /*printf("q:%i, a2:%i",q,a2);*/
    /*printf("p:%i, p1:%i, q1:%i\n",p,p1,q1);*/
    pd=idif(p,b);
     
  }
  while( (icomp(q,a2)!=0) || (mihom(a2,pd)!=0));
  
  /* R= ln(R)+ e * L * ln(2)*/
  Rh=itofl(L);
  f=itofl(e);
  Rh=flprod(Rh,f);
  f=fllog(itofl(2));
  Rh=flprod(Rh,f);
  f=fllog(R);
  R=flsum(f,Rh);
  
  return R;
}

/* Berchnet eine Naeherung fuer das Eulerprodukt */
/* D ist die Diskiminante, multipliziert wird von Primzahl ps bis Primzahl pe */
floating flEuler(D,ps,pe)
  int D;
  int ps;
  int pe;
{
  int pi,i,laenge,k;
  list L;
  floating flpi,f,euler;  
  bind(D,ps,pe);
  init(pi,i,laenge,k,flpi,f,euler,L);
  euler=itofl(1);
  L=ipgen(ps,pe);
  laenge=llength(L);
  for (i=1; icomp(i,laenge)<0; i=isum(i,1)) 
    {
      pi=lfirst(L);
      L=lred(L); 
      k=GetKronecker(D, pi);
      flpi=itofl(pi);
      k=idif(pi,k);
      f=itofl(k);  
      f=flquot(flpi,f);
      euler=flprod(euler,f);
    }
  return euler;
}

/* heuristischer Algorithmus zur Klassenzahlberechnung bei reell quad. ZK. */
int Cnheuristic(D)
	int D;
{
  floating h1,flD,f,R,fl1,euler,g;
  int c,ret,h,m,pi,k;
  list L;
  single i;  
  unsigned p[37];
	
  bind(D);  
  init( h1,k,flD,f,pi,R,euler,g); 
  init( c,ret,h,m,L)	; 
  init( fl1)		;
	
  p[0]=2; p[1]=3571; p[2]=7919; p[3]=12553; p[4]=17389; p[5]=22307; p[6]=27449; 
  p[7]=32609; p[8]=37813; p[9]=43051; p[10]=48611; p[11]=53993; p[12]=59359;
  p[13]=65063; p[14]=70657; p[15]=76207; p[16]=81799; p[17]=87553; p[18]=93179;
  p[19]=98947; p[20]=104729; p[21]=110597; p[22]=116447; p[23]=122251; p[24]=128189;
  p[25]=134053; p[26]=139901; p[27]=145931; p[28]=151703; p[29]=157739; p[30]=163841;
  p[31]=170029; p[32]=176081; p[33]=182059; p[34]=187963; p[35]=194003;
  flD=itofl(D); 
  h1=flsqrt(flD); /*printf("Regulator...");*/
  R=GetRegulator(D); /*printf("Regulator :	"); putfl(R,2);  printf("  ");*/
  /*f=Cfltofl(0.16);*/
  /*f=flpow(flD,f);  */
  /*if (flcomp(R,f)==-1) { printf("Regulator zu klein !"); return 0; }*/
  /*putfl(f,2); printf(" ");*/
  f=flprod(itofl(2),R); 
  h1=flquot(h1,f); 
  h=0;
  c=0;
  k=0;
  ret=1; 
  fl1=itofl(1);
  do
  {
    if (k==35)   { printf("Regulator zu klein !"); return 0; }
    euler= flEuler(D,p[k],p[k+1]);
    h1=flprod(h1,euler);
    m=flround(h1);
    k++;
    f=fldif(itofl(m),h1);
    f=flabs(f);
    ret=0; 
    g=Cfltofl(0.1);

    if (flcomp(f,g)==1) { c=0; ret=1; }
    if (ret==0 && m!=h)   { h=m; c=1; ret=1; }
    else if (ret==0) { 
      c++;
      if (c<=5) ret=1 ; 
    }
  }
  while (ret==1);
  return h;
}


int qfprod(a,b,D,c)
  int a[3];
  int b[3];
  int D;
  int c[3];
{ 
  bind(a[0],a[1],a[2],b[0],b[1],b[2],D,c[0],c[1],c[2]);
  coandredSim(a,b,D,c);
  return 0; 
}

int qfpow(g,n,D,y)
  int g[3];
  int n;
  int D;
  int y[3];

{
  int N;
  int z[3];
  init(N,z[0],z[1],z[2]);
  bind(g[0],g[1],g[2],n,D,y[0],y[1],y[2]);
  y[0]=1;
  if (ieven(D)==1) 
    { y[1]=0; y[2]=iquot(D,4); y[2]=ineg(y[2]);}
  else
    { y[1]=1; y[2]=idif(1,D); y[2]=iquot(y[2],4); }
  if (n==0) return 0;
  z[0]=g[0]; z[1]=g[1]; z[2]=g[2];
  for (N=n; N!=0; coandredSim(z,z,D,z))
    {
      if (iodd(N)==1) coandredSim(z,y,D,y);
      N=iquot(N,2);
      if (N==0) return 0;
    }
  return 0;
}
	
/*int qfpow(a,b,D,c)
  int a[3];
  int b;
  int D;
  int c[3];

{
  int i;
  init(i);
  bind(a[0],a[1],a[2],b,D,c[0],c[1],c[2]);
  c[0]=1;
  if (mihom(2,D)==0) 
    { c[1]=0; c[2]=iquot(D,4); c[2]=ineg(c[2]); }
  else
    { c[1]=1; c[2]=idif(1,D); c[2]=iquot(c[2],4); }
  for (i=1; icomp(i,b)<=0; i=isum(i,1)) qfprod(a,c,D,c); 
  return 0;
}
*/


/* gibt die naechstgroessere int Zahl zureuck */
int fltop(x)
  floating x;
{
 int ix;
 floating y;
 init(ix,y);
 bind(x);
 ix=flfloor(x);
 y=itofl(ix);
 if (flcomp(x,y)==0)  return ix;
 return isum(ix,1);
}
 
int isqrmp(p,a)
  int p;
  int a;
{
  int n,z,y,r,e,q,p1,h,x,m,b,t;
  floating f,f1;
  single flag;
  init(n,z,y,r,e,q,p1,h,f,f1,x,m,b,t);
  bind(p,a);
  q=1;
  p1=idif(p,1);
  f=fllog(itofl(p1));
  f1=fllog(itofl(2));
  e=fltop(flquot(f,f1));
  printf("e: %i\n",e);
  flag=0;
  while (flag==0)
  {
    h=ipow(2,e);
    if (mihom(h,p1)==0 && iodd(iquot(p1,h))==1)
      flag=1;
    else 
      e=idif(e,1);
  }
  q=iquot(p1,h);
  printf("p-1:%i e:%i q:%i", p1,e,q);
  n=2;
  while (GetKronecker(n,p)!=-1) n=isum(n,1);
  /*n=irand(1000000);*/
  /*while (GetKronecker(n,p)!=-1) n=irand(1000000);*/
  printf("n: %i",n);
  z=ipow(n,q);
  z=mihom(p,z);
  printf(" z: %i \n",z);
  y=z;
  r=e;
  x=idif(q,1);
  x=iquot(x,2);
  x=ipow(a,x);
  x=mihom(p,x);
  printf(" x: %i \n",x);
  b=iprod(x,x);
  b=iprod(a,b);
  printf(" b: %i \n",b);
  b=mihom(p,b);
  x=iprod(a,x);
  x=mihom(p,x);
  
  while (icomp(mihom(p,b),1)!=0) {
      m=0;
      do
	{
	  m=isum(m,1);
	  h=ipow(2,m);
	  h=ipow(b,h);
	  h=mihom(p,h);
	  printf("b: %i, m: %i, h:%i ",b,m,h);
	}
      while(icomp(h,1)!=0);
      if (icomp(m,r)==0) {
	  printf("%i ist not a quadratic residue mod %i !",a,p);
	  return 0;
      }
      
      h=idif(r,m);
      h=idif(h,1);
      h=ipow(2,h);
      t=ipow(y,h);
      t=mihom(p,t);
      
      y=ipow(t,2);
      y=mihom(p,y);

      r=mihom(p,m);

      x=iprod(x,t);
      x=mihom(p,x);

      b=iprod(b,y);
      b=mihom(p,b);
    }
  return x;
}
  
/* heuristischer Algorithmus complex */
int CnheuricCom(D)
  int D;
{
  int P,Q,Q1,B,B1,C,C1,bp,j,p,k,e,q,n,h;
  unsigned i,c,step7,r;
  const single b=10;
  floating euler,f,fl1,z,flD,h1;
  list L,Lh;
  int fp[b][3];
  int g[3];
  int y[3];
  int v[3];
  int x[2000][3];
  
  for(i=0; i<b; i++) init(fp[i][0],fp[i][1],fp[i][2]);
  init(g[0],g[1],g[2]);
  init(y[0],y[1],y[2]);
  init(v[0],v[1],v[2]);
  
  init(P,Q,Q1,B,B1,C,C1,bp,j,p,k,e,q,euler,f,fl1,z,L,Lh,flD,n,h,h1);
  for(r=0; r<2000; r++) {init(x[r][0]); init(x[r][1]); init(x[r][2]);}
  bind(D);
  
  fl1=itofl(1);
  flD=itofl(D);

  if (icomp(D,-163)==0) return 1;
  /* compute Euler product */
  /*ifdef DEBUG printf("Ipgen 3,10000\n"); #endif*/
  /*Achtung Laenge von L muß angepasst werden !!!!*/
  L=ipgen(3,10000);
  Lh=lcopy(L);
  P=iabs(D);
  if (icomp(P,100000)<0) 
     { 
      P=isqrt(P);
      P=isqrt(P);
      P=imax(100,P);
     }
    else 
     { 
      P=isqrt(P);
      P=isqrt(P);
      P=imax(262144,P);
     }
  /*printf("Euler Produkt\n"); */
  euler=flEuler(D,2,P);
  /*printf("Fertig\n");*/
  f=flabs(flD);
  f=flsqrt(f);
  f=flquot(f,flPi());
  f=flprod(f,euler);
  /*printf("\n h: "); putfl(f,10); */
  h1=f;
  Q=flfloor(f);
  
  f=itofl(P);
  f=flsqrt(f);
  f=flprod(itofl(2),f);
  f=flquot(fl1,f);
  z=f;
  f=flsum(fl1,f);
  f=flprod(h1,f);
  B=flfloor(f);
  /*printf(" B: %i",B);*/
  
  f=fldif(fl1,z);
  f=flprod(h1,f);
  C=fltop(f);
  if (B==0) B=1;
  /*printf(" C: %i  ",C);*/
  if (idif(B,C)==0) return B;
  if (icomp(C,B)>0) { j=B; B=C; C=j;}
  
  for(i=0; i<b; i++)
    {
      do
	{
	  p=lfirst(L);
	  L=lred(L);
	}
      while (GetKronecker(D,p)!=1);
      
      /* Bestimmung der bp */
      bp=ineg(p);
      do
	{
	  bp=isum(bp,1);
	  j=iprod(bp,bp);
	  j=idif(j,D);
	  /*printf(" bp: %i, ",bp);*/
	}
      while ((mihom(p,j)!=0 || mihom(4,j)!=0) && (icomp(p,iabs(bp))>=0));
      if (icomp(p,iabs(bp))<0) {i--; /*printf("nichts gefunden");*/ }
      else
	{
	  fp[i][0]=p; 
	  fp[i][1]=bp;
	  j=iprod(bp,bp);
	  j=idif(j,D);
	  k=iprod(p,4);
	  j=iquot(j,k);
	  fp[i][2]=j;
	}
    }

  /*Initialize*/
  e=1;
  c=0;
  B1=B;
  C1=C;
  Q1=Q;

  do
  {
    /*ifdef DEBUG printf(" Take a new g\n");*/
    /*Take a new g*/
    g[0]=fp[c][0];
    g[1]=fp[c][1];
    g[2]=fp[c][2];
    c++;
    j=idif(B1,C1);
    f=itofl(j);
    f=flquot(f,itofl(2));
    f=flsqrt(f);
    q=fltop(f);
    /*printf(" q=%i ",q);*/

    /*printf("Compute small steps\n");*/
    if (mihom(2,D)!=0) 
      {
	x[0][0]=1;
	x[0][1]=1;
	x[0][2]=idif(1,D);
	x[0][2]=iquot(idif(1,D),4);
      }
    else
      {
	x[0][0]=1;
	x[0][1]=0;
	x[0][2]=iquot(D,4);
	x[0][2]=ineg(x[0][2]);
      }
    qfpow(g,e,D,x[1]);
    step7=0;
    if (icomp(x[1][0],1)==0) 
	  if (((mihom(2,D)!=0) && (icomp(x[1][1],1)==0) && (icomp(x[1][2],iquot(idif(1,D),4)==0))) ||
	      ((mihom(2,D)==0) && (icomp(x[1][1],0)==0) && (icomp(x[1][2],ineg(iquot(D,4)))==0)))
	       { n=e; step7=1; /*printf(" Treffer n: %i\n",e);*/}
    for (r=2; r<=q; r++)
      {
	qfprod(x[1],x[r-1],D,x[r]);
	if (icomp(x[r][0],1)==0) 
	  if (((mihom(2,D)!=0) && (icomp(x[r][1],1)==0) && (icomp(x[r][2],iquot(idif(1,D),4)==0))) ||
	      ((mihom(2,D)==0) && (icomp(x[r][1],0)==0) && (icomp(x[r][2],ineg(iquot(D,4)))==0)))
	       { n=r; step7=1; /*printf("Treffer n: %i",n); */ break; }
      }
    
    if (!step7) 
      {
	/*sortiere die x*/
	qfprod(x[1],x[q-1],D,y);
	qfprod(y,y,D,y);
	n=isum(C1,q);
	qfpow(x[1],n,D,v);
	/*printf(" n: %i \n",n);*/
	/*for (r=0; r<=q; r++) 
	  {
	    puti(x[r][0]); printf(",");
	    puti(x[r][1]); printf(",");
	    puti(x[r][2]); printf("\n");
	  }*/
	/*printf("Compute giant Steps \n");*/
	do 
	  {
	    /*printf(" n: %i\n",n);
            printf(" q: %i\n",q);
	    printf("z: ");
	    puti(v[0]); printf(",");
	    puti(v[1]); printf(",");
	    puti(v[2]); printf("\n");*/
	    for(r=0; (r<=q) && (step7==0); r++)
	      {
		/*printf("e=%i, e=%i, ",n-r,n+r);*/
	      if ( (icomp(v[0],x[r][0])==0) && (icomp(v[2],x[r][2])==0) )
		{
		  if (icomp(v[1],x[r][1])==0)
		  {
		    n=idif(n,r);
		    /*printf("Treffer1: n=%i r=%i",n,r);*/
		    step7=1;  
		  }
		  if (icomp(v[1],ineg(x[r][1]))==0)		   
		  {
		    n=isum(n,r);  
		    /*printf("Treffer2: n=%i r=%i",n,r);*/
		    step7=1;
		  }
		}
	      }
	    if (step7==0)
	      {
		qfprod(y,v,D,v);
		j=iprod(2,q);
		n=isum(n,j);
	      }
	  }
	  while( (step7==0) && (icomp(n,B1)<=0));
	/*if (step7==0) { printf("Grenzen zu klein!  (n: %i, B: %i, C: %i)",n,B1,C1);}*/
      }
     /*printf("\n n: %i",n);*/
    if (step7==1)
      {
	j=isqrt(n);
	/*j=isum(j,10); */
	/* abbruchkriterium*/
	L=lcopy(Lh);
	/*printf(" Primzahlgrenze : %i\n",j);*/
	for (p=2; icomp(p,j)<=0;  p=lfirst(L)) 
	  { /*printf("p: %i, j: %i\n",p,j);*/
	    if (mihom(p,n)==0)
	    {
	      k=iquot(n,p);
	      qfpow(x[1],k,D,v);
	      /*printf("\n h: %i\n",n);*/
	      /*puti(v[0]); printf(",");
	      puti(v[1]); printf(",");
	      puti(v[2]); printf("\n");*/
	      if ((icomp(v[0],1)==0) 
		&&  (((mihom(2,D)!=0) && (icomp(v[1],1)==0) && (icomp(v[2],iquot(idif(1,D),4)==0))) ||
		     ((mihom(2,D)==0) && (icomp(v[1],0)==0) && (icomp(v[2],ineg(iquot(D,4)))==0))))
		  n=k;
	      else L=lred(L);
	      j=isqrt(n);
	       /*ifdef DEBUG printf("p: %i, n: %i\n",p,n); #endif*/
	    }
	    else L=lred(L);
	  }
	e=iprod(e,n);
	j=idif(B,C);
	/*printf("e :%i, j: %i, n: %i\n",e,j,n);*/
        
	if (icomp(e,j)>0) 
	  {
	    j=iquot(B,e);
	    j=imax(1,j);
	    h=iprod(e,j);
	    return h;
	  }
        C1=iquot(C1,n);
	
	f=itofl(B1);
	z=itofl(n);
	f=flquot(f,z);
	B1=fltop(f);
	
        /*printf("B1: %i, C1: %i, %i \n",B1,C1,n);*/
        
      }
  
   else
    {
	j=idif(B,C);
	j=iabs(j);
	j=iquot(j,2);
	j=imax(1,j);
	C=idif(C,j);
	C=imax(C,1);
	B=isum(B,j);
	C1=C;
	B1=B;
	c=0;
    }
  }
  while(c<b);
  /*printf("Algorithmus funktioniert nicht !");*/
  return 0;
}
    


	
/* Berechnung der Klassenzahl quadratischer Zahlkoerper        */
/* D ist die Diskrminante des ZK., D muss 0 oder 1 mod 4  sein */
/* aus dieser Funktion werden die entsprechenden Funktionen    */
/* zur tatsaechlichen Berechnung aufgerufen                    */
int qnfclassnum(D)
	int D;
{
	int h;
        single m;
	init(h);
	bind(D);

        m=m4hom(D); 
	if ((m!=0) && (m!=1)) return 0;
	if ((icomp(0,D)==1) && (icomp(D,-12)==1))
	    h=1;
	if ((icomp(0,D)==1) && (icomp(D,-12)<=0))
	    h=CnheuricCom(D);
	/*if ((icomp(0,D)==1) && (icomp(D,-32000)==1) && (icomp(D,-12)<=0))         h=sGetCNrA(D);*/
	/*if ((icomp(0,D)==1) && (icomp(D,-32000)<=0) && (icomp(D,-1000000000)==1)) h=mGetCNrA(D);*/
	/*if (icomp(D,-1000000000)<=0)                                              h=iGetCNrA(D);*/
	if (icomp(0,D)==-1)
	    h=Cnheuristic(D); 
	return h;
}
