/*M
.SH NAME
ouspibaslmo - order of an univariate separable polynomial over the integers basis of a local maximal over-order

.SH SYNOPSIS
.nf
#include<_arith2.h>

list ouspibaslmo(F, p, Q, pk)  
pol F; 
single p, *pk; 
int Q; 
  
.SH DESCRIPTION
.TP 4
.B F 
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic, separable and univariate polynomial over the integer numbers.
.TP 4
.B p 
is a single prime number, so that the polynomial order of F is not p-maximal.
.TP 4
.B Q
is a power of p, the product of Q with an arbitrary element of a p-maximal over-order of the polynomial order of F is in the polynomial order.
.TP 4
.B pk
points on a single, say *pk.
.PP
ouspibaslmo returns a CD-matrix, say M. The rows of M (as coefficient lists of CD-polynomials over the rationals) represent elements of A (s. cdprfcl and cdmarid).These elements form a Z-basis of the p-maximal over-order of the polynomial order of F in A. The index of the polynomial order in the p-maximal over-order is equal to p^(*pk).
 
.SH NOTES
ouspibaslmo uses the FORD / ZASSENHAUS algorithem ROUND 4

.SH SEE ALSO
cdprfcl, cdmarid, ouspibaslmoi
.PP  
R. Boeffgen, Diplomarbeit, Universitaet des Saarlandes, Germany.

M*/
                           
/*H
	Version 1       19.09.89        J.Schmitt
	Version 2	11.02.91	J.Schmitt: Ls1 und Ls2 eingefuehrt;
						   Fehler korrigiert.
   DATE ouspibaslmo   : 891101.9001__.910915
H*/
#include<_arith2.h>

static list ouspiblmosub(pol,single,int,pol,list,list,list,single);

list ouspibaslmo(F,p,Q,pk)
pol F;                    
single p;
int Q;
single *pk;
{
	list L,Lb,Ls,Lort,Lfac;
	list Ls1,Ls2;
	single j,i;       
	rat zw,zw2;
	int Q2;
	pol g,fh,fs,fb;
	init(L,Lb,Ls,Lort,Lfac,zw,zw2,Q2,g,fh,fs,fb);
	init(Ls1,Ls2);
	bind(F,Q);    

	Q2=iprod(Q,Q);
	fh=pitopms(1,F,p);
	g = upmsgsd(p,fh);
	if (pdegree(1,g) <= 1) {
		Lb=list1(g);
		g=pitopmi(1,F,Q2);
		Ls=list1(g);
	}
	else {                      
		Lb=upmscfact(p,g);
		if (llength(Lb)==1) {
			Ls=list1(pitopmi(1,F,Q2));
		}
		else {
			L=_0;
			Ls=Lb;
			while (Ls!=_0) {
				g=lfirst(Ls);
				Ls=lred(Ls);
				fh=upmsrelpfact(p,fh,g,&fs);
				L=lcomp(fs,L);
			}
			L=linv(L);
                	j=iaval(p,Q);
			j=j+j;
			Ls=upihlfa(p,F,L,j);
		}
        }

	L = _0;
	while (Ls != _0) {
		fs = pitopmi(1,lfirst(Ls),Q2);
		Ls = lred(Ls);
		L  = lcomp(fs,L);
	}
	Ls=linv(L);

	fs=lfirst(Ls);
	Ls=lred(Ls);
	fb=lfirst(Lb);
	Lb=lred(Lb);
	fh=fs;

	L=ippnfecoreal(fs,p,Q,fb);
	if (llength(L)==2) {	
				Lfac=lfirst(L);
				Lort=lsecond(L);
				L=_0;
				L = ouspiblmosub(fs,p,Q,fb,Lfac,Lort,L,1);
        }
 	else L=lfirst(L);
        while (Lb!=_0) {
		fb=lfirst(Lb);
		Lb=lred(Lb);
		fs=lfirst(Ls);
		Ls=lred(Ls);
		g =lcomp(1,fh);
		Lort=list1(g);
		g =lcomp(1,fs);
		Lort=lcomp(g,Lort);
		Lfac=list2(fh,fs);  
		fh=piprod(1,fh,fs);
		fh=pitopmi(1,fh,Q2);
		L = ouspiblmosub(fh,p,Q,fb,Lfac,Lort,L,2);
	}
	zw2=itor(1);
	Lb=L;              
	j=1;
	while (Lb!=_0) {
		Ls=lfirst(Lb);
		Lb=lred(Lb);
		zw = lfirst(Ls);
		zw = itor(zw);
		for (i=0;i<j;i++) Ls=lred(Ls);
		j=j+1;
		Ls1 = lfirst(Ls);
		Ls2 = itor(Ls1);
		zw = rquot(Ls2,zw);
		zw2= rprod(zw2,zw);
	}
	zw = lsecond(zw2);
	*pk = iaval(p,zw);
        return(L);
} 

/*c
	ouspiblmosub ist ein static modul zu ouspibaslmo
c*/
/*H
	Version 1   	19.09.89	J.Schmitt
   DATE ouspiblmosub  : 891101
H*/

static list ouspiblmosub(A1,p,Q,A2,L1,L2,L,v)
pol A1,A2;
list L1,L2,L;
single p,v;
int Q;
{                                 
	single n1,j;   
	int z;                                   
	list G,Gl,M,Ml,H,LH;
	pol Fh,e1,h;
	bind(A1,A2,L1,L2,L,Q);   
	init(G,Gl,M,Ml,H,LH,Fh,e1,h,z);	
        n1 = pdegree(1,A1);                                          
	M  = cdmarid(n1);
	for (j=1;j<3;j++) {  
		if (j>=v) {
			Fh=lelt(L1,j);                 
			L=ippnfecoreal(Fh,p,Q,A2);
			if (llength(L)==2) {
				LH=lfirst(L);
				H=lsecond(L);
				L=_0;
				L=ouspiblmosub(Fh,p,Q,A2,LH,H,L,1);
			}       
			else L = lfirst(L);    
		} 
		e1=lfirst(L2);
		L2=lred(L2);     
		z=lfirst(lfirst(L));
		e1=cdprzmodhom(e1,z);
		if (e1!=0) {
			G=cdprlfcdmar(L);
			do {
				Gl=lfirst(G);
				G=lred(G);
				h=nfeprodspec(A1,e1,Gl,1);
				if (h!=0) {
					Ml=clfcdpr(h,n1);
					M=lcomp(Ml,M);
				}
                	} while (G!=_0);
		}   
	}
	M=cdmarhermred(M);
	return(M);
} 
