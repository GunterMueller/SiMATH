/*M
.SH NAME
ouspprmsp1bl - order of an univariate separable polynomial over polynomial ring over modular single prime, transcen-dence degree 1, basis of a local maximal over-order

.SH SYNOPSIS
.nf
#include<_arith4.h>

list ouspprmsp1bl(p, F, P, Q, pk)  
single p, *pk; 
pol F, P, Q; 

.SH DESCRIPTION
.TP 4
.B p 
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, separable and univariate polynomial over the polynomial ring (Z/pZ) [x]. 
.TP 4
.B P
is a monic and irreducible polynomial in (Z/pZ) [x]. The polynomial order of F is not P-maximal.
.TP 4
.B Q 
is a power of P. The product of Q with an arbitrary element in the P-maximal over-order of the polynomial order of F does not lie in the polynomial order.
.PP
ouspprmsp1bl returns a CD-matrix, say M. The rows of M represent CD-polynomials, these polynomials again repre-sent elements in A (s. cdprfmsp1fcl and cdmarfmsp1id). These elements form a (Z/pZ) [x]-basis of the P-maximal over-order of the polynomial order of F.
ouspprmsp1bl writes a single, say k, to *pk. The index of the polyno-mial order in the P-maximal over-order is equal to P^k.

.SH NOTES
ouspprmsp1bl uses the FORD / ZASSENHAUS-algorithm ROUND4.
 
.SH SEE ALSO
.nf
cdprfmsp1fcl
cdmarfmsp1id

M*/
           
/*H
	Version 1       19.02.90	J.Schmitt
   DATE ouspprmsp1bl  : 901120.9109__
H*/

#include<_arith4.h>

static list ouspprmsp1su(single,pol,pol,pol,pol,list,list,list,single);

list ouspprmsp1bl(p,F,P,Q,pk)
single p;
pol F,P,Q;
single *pk;
{
	single j,i;       
	list L,Lb,Ls,Lo,Lf,AL;
	pol zw,zw2,Q2,g,fh,fs,fb;

	init(L,Lb,Ls,Lo,Lf,AL,zw,zw2,Q2,g,fh,fs,fb);
	bind(F,P,Q);

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

	L  = afmsp1coreal(p,fs,P,Q,fb);
	if ( llength(L) == 2 ) {	
		Lf = lfirst(L);
		Lo = lsecond(L);
		L  = _0;
		L  = ouspprmsp1su(p,fs,P,Q,fb,Lf,Lo,L,1);
        }
 	else L = lfirst(L);
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
		L = ouspprmsp1su(p,fh,P,Q,fb,Lf,Lo,L,2);
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
	ouspprmsp1su ist ein static modul zu ouspprmsp1bl
c*/
/*H
	Version 1    	 20.02.90	 J.Schmitt
   DATE ouspprmsp1su   : 900501
H*/

static list ouspprmsp1su(p,A1,P,Q,A2,L1,L2,L,v)
single p;
pol A1,P,Q,A2;
list L1,L2,L;
single v;
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
			L  = afmsp1coreal(p,Fh,P,Q,A2);
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
