/*C

			eggtaus( G, LK, L )

	"Erweiterter ggT Ausgabe".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	eggtaus( G, LK, L ); obj G; list LK,L; 
	X = eggtaus( G, LK, L );

	eggtaus ist ein spezielles Ausgabeprogramm, das nur bei egcd 
	aufgerufen wird. 
	Dabei ist L eine Liste von Objekten mit Kennung, 
	L=((l1,t1),...,(ln,tn)) und G=(g,ken) wobei g der ggT(l1,...,ln) ist. 
	LK ist die Liste der Kofaktoren mit Kennungen LK=((k1,s1),...,(kn,sn)),
	wobei gilt: g = k1*l1 + ... + kn*ln.

C*/
/*H

	Version  1      22.07.1994      S.Schmitt
	Version  1.1    27.07.1995      U.Schneiders (nf)

H*/

#include<_calc.h>

eggtaus( G, LK, L )
obj G;
list LK,L;
{	
	single kx,ka,k;
	obj M,VL,A,X;
	init(M,VL,A,X);
	bind(G,LK,L);

	if(!assch){
	
	/** Ausgabe ggT **/

	k=lsecond(G);
	G=lfirst(G);
	switch(k)
	{	case 0: printf(" %i = ",G);
			if(ps) fprintf(datei,"out: %i = ",G);		
			break;
		case 1: printf(" %r = ",G);
			if(ps) fprintf(datei,"out: %r = ",G);		
			break;
		case 2: VL=lfirst(G);
			G=lsecond(G);
			printf(" ");
			putpi(1,G,VL);
			printf(" = ");
			if(ps)
			{	fprintf(datei,"out: ");
				fputpi(1,G,VL,datei);
				fprintf(datei," = ");
			}
			break;
		case 3: VL=lfirst(G);
			G=lsecond(G);
			printf(" ");
			putpr(1,G,VL);
			printf(" = ");
			if(ps)
			{	fprintf(datei,"out: ");
				fputpr(1,G,VL,datei);
				fprintf(datei," = ");
			}
			break;
		case 17:printf(" MOD(%i) = ",G);
			if(ps) fprintf(datei,"out: MOD(%i) = ",G);
			break;
		case 18:VL=lfirst(G);
			G=lsecond(G);
			printf(" ");
			putpm(1,G,VL);
			printf(" = ");
			if(ps)
			{	fprintf(datei,"out: ");
				fputpm(1,G,VL,datei);
				fprintf(datei," = ");
			}
			break;
		case 24:M=lfirst(varlist[nfsch].varwert);
			printf(" ");
			putnfel( M, G, VNF ); 
			printf(" = ");
			if( ps  ) 
			{	fprintf(datei,"out: ");
				fputnfel( M, G, VNF, datei );
				fprintf(datei, " = ");
			}
			break;
		case 25:M=lfirst(varlist[nfsch].varwert);
			VL=lfirst(G);
			G=lsecond(G);
			printf(" ");
			putpnf(1,M,G,VL,VNF);
			printf(" = ");
			if(ps)
			{	fprintf(datei,"out: ");
				fputpnf(1,M,G,VL,VNF,datei);
				fprintf(datei," = ");
			}
			break;
			break;
		case 31:M=lfirst(varlist[gfsch].varwert);
			printf(" ");
			if(gfchar==2) putgf2el(M,G,VGF);
			else putgfsel(G,VGF);
			printf(" = ");
			if(ps)
			{	fprintf(datei,"out: ");
				if(gfchar==2) fputgf2el(M,G,VGF,datei);
				else fputgfsel(G,VGF,datei);
				fprintf(datei," = ");
			}
			break;
		case 32:M=lfirst(varlist[gfsch].varwert);
			VL=lfirst(G);
			G=lsecond(G);
			printf(" ");
			if(gfchar==2) putpgf2(1,M,G,VL,VGF);
			else putpgfs(1,G,VL,VGF);
			printf(" = ");
			if(ps)
			{	fprintf(datei,"out: ");
				if(gfchar==2) fputpgf2(1,M,G,VL,VGF,datei);
				else fputpgfs(1,G,VL,VGF,datei);
				fprintf(datei," = ");
			}
			break;
	}

	/** Ausgabe von LK und L **/

	if(LK!=_0)
	{ 	X=lfirst(LK);
		kx=lsecond(X);
		X=lfirst(X);
		LK=lred(LK);
	}
	while(L!=_0)
	{	A=lfirst(L);
		A=kenntest(A);
		L=lred(L);
		ka=lsecond(A);
		A=lfirst(A);
		switch(kx)
	        {	case 0: printf("%i * ",X);
				if(ps) fprintf(datei,"%i * ",X);
				break;
	        	case 1: printf("%r * ",X);
				if(ps) fprintf(datei,"%r * ",X);
				break;
			case 2: VL=lfirst(X);
				X=lsecond(X);
				k=0;
				if(llength(X)>2)
				{	k=1;
					printf("(");
				}
				putpi(1,X,VL);
				if(k) printf(")");
				printf(" * ");
				if(ps)
				{	if(k) fprintf(datei,"(");
					fputpi(1,X,VL,datei);
					if(k) fprintf(datei,")");
					fprintf(datei," * ");
				}
				break;
			case 3: VL=lfirst(X);
				X=lsecond(X);
				k=0;
				if(llength(X)>2)
				{	k=1;
					printf("(");
				}
				putpr(1,X,VL);
				if(k) printf(")");
				printf(" * ");
				if(ps)
				{	if(k) fprintf(datei,"(");
					fputpr(1,X,VL,datei);
					if(k) fprintf(datei,")");
					fprintf(datei," * ");
				}
				break;
			case 17:printf("MOD(%i) * ",X);
				if(ps) fprintf(datei,"MOD(%i) * ",X);
				break;
			case 18:VL=lfirst(X);
				X=lsecond(X);
				k=0;
				if(llength(X)>2)
				{	k=1;
					printf("(");
				}
				putpm(1,X,VL);
				if(k) printf(")");
				printf(" * ");
				if(ps)
				{	if(k) fprintf(datei,"(");
					fputpm(1,X,VL,datei);
					if(k) fprintf(datei,")");
					fprintf(datei," * ");
				}
				break;
			case 24:M=lfirst(varlist[nfsch].varwert);
			        putnfel( M, X, VNF ); 
				printf(" * ");
				if(ps)
				{       fputnfel( M, X, VNF, datei );
					fprintf(datei," * ");
				}
				break;
			case 25:M=lfirst(varlist[nfsch].varwert);
				VL=lfirst(X);
				X=lsecond(X);
				k=0;
				if(llength(X)>2)
				{	k=1;
					printf("(");
				}
			        putpnf(1,M,X,VL,VNF);
				if(k) printf(")");
				printf(" * ");
				if(ps)
				{	if(k) fprintf(datei,"(");
				        fputpnf(1,M,X,VL,VNF,datei);
					if(k) fprintf(datei,")");
					fprintf(datei," * ");
				}
				break;
			case 31:M=lfirst(varlist[gfsch].varwert);
				if(gfchar==2) putgf2el(M,X,VGF);
				else putgfsel(X,VGF);
				printf(" * ");
				if(ps)
				{	if(gfchar==2) fputgf2el(M,X,VGF,datei);
					else fputgfsel(X,VGF,datei);
					fprintf(datei," * ");
				}
				break;
			case 32:M=lfirst(varlist[gfsch].varwert);
				VL=lfirst(X);
				X=lsecond(X);
				k=0;
				if(llength(X)>2)
				{	k=1;
					printf("(");
				}
				if(gfchar==2) putpgf2(1,M,X,VL,VGF);
				else putpgfs(1,X,VL,VGF);
				if(k) printf(")");
				printf(" * ");
				if(ps)
				{	if(k) fprintf(datei,"(");
					if(gfchar==2) fputpgf2(1,M,X,VL,VGF,datei);
					else fputpgfs(1,X,VL,VGF,datei);
					if(k) fprintf(datei,")");
					fprintf(datei," * ");
				}
				break;
		}
		switch(ka)
	        {	case 0: printf("%i",A);
				if(ps) fprintf(datei,"%i",A);
				break;
	        	case 1: printf("%r",A);
				if(ps) fprintf(datei,"%r",A);
				break;
			case 2: VL=lfirst(A);
				A=lsecond(A);
				printf("(");
				putpi(1,A,VL);
				printf(")");
				if(ps)	
				{	fprintf(datei,"(");
					fputpi(1,A,VL,datei);
					fprintf(datei,")");
				}
				break;
			case 3: VL=lfirst(A);
				A=lsecond(A);
				printf("(");
				putpr(1,A,VL);
				printf(")");
				if(ps)	
				{	fprintf(datei,"(");
					fputpr(1,A,VL,datei);
					fprintf(datei,")");
				}
				break;
			case 17:printf("MOD(%i)",A);
				if(ps) fprintf(datei,"MOD(%i)",A);
				break;
			case 18:VL=lfirst(A);
				A=lsecond(A);
				printf("(");
				putpm(1,A,VL);
				printf(")");
				if(ps)	
				{	fprintf(datei,"(");
					fputpm(1,A,VL,datei);
					fprintf(datei,")");
				}
				break;
			case 24:M=lfirst(varlist[nfsch].varwert);
				putnfel( M, A, VNF ); 
				if(ps) fputnfel( M, A, VNF, datei );
				break;
			case 25:M=lfirst(varlist[nfsch].varwert);
				VL=lfirst(A);
				A=lsecond(A);
				printf("(");
			        putpnf(1,M,A,VL,VNF);
				printf(")");
				if(ps)
				{	fprintf(datei,"(");
				        fputpnf(1,M,A,VL,VNF,datei);
					fprintf(datei,")");
				}
				break;
			case 31:M=lfirst(varlist[gfsch].varwert);
				if(gfchar==2) putgf2el(M,A,VGF);
				else putgfsel(A,VGF);
				if(ps)
				{	if(gfchar==2) fputgf2el(M,A,VGF,datei);
					else fputgfsel(A,VGF,datei);
				}
				break;
			case 32:M=lfirst(varlist[gfsch].varwert);
				VL=lfirst(A);
				A=lsecond(A);
				printf("(");
				if(gfchar==2) putpgf2(1,M,A,VL,VGF);
				else putpgfs(1,A,VL,VGF);
				printf(")");
				if(ps)
				{	fprintf(datei,"(");
					if(gfchar==2) fputpgf2(1,M,A,VL,VGF,datei);
					else fputpgfs(1,A,VL,VGF,datei);
					fprintf(datei,")");
				}
				break;
		}
		if(L!=_0)
		{	X=lfirst(LK);
			kx=lsecond(X);
			X=lfirst(X);
			LK=lred(LK);
			if( (!kx && isign(X)<0) || (kx==1 && rsign(X)<0))
			{	printf(" - ");
				if(ps) fprintf(datei," - ");
				if(!kx) X=ineg(X);
				else    X=rneg(X);
			}
			else
			{	printf(" + ");
				if(ps) fprintf(datei," + ");
			}
		}
	}
	printf("\n");
	if(ps) fprintf(datei,"\n");
	}
	return(1);
}
