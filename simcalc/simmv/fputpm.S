/*C
			fputpm(r,P,V,pf)

	"file put polynomial over modular integers".
	single fputpm(r,P,V,pf) single r; pol P; list V; FILE *pf;
	a = fputpm(r,P,V,pf);

	P ist ein Polynom in r (0<=r<BASIS) Variablen ueber Z/mZ.
	Ist r gleich 0, so muss V die leere Liste sein; sonst ist
	V eine Liste V = (V1,...,Vr), wobei die Elemente Vi von V
	die Variablennamen repraesentieren, und zwar in der Form:
	  Vi = ascii(Bu)   oder   Vi = ( ascii(Bu) )
		falls der Name der i-ten Variablen nur aus dem
		Buchstaben Bu besteht;
	  Vi = ( ascii(Bu) , ascii(BZ2) , ... , ascii(BZn) )
		falls der Name der i-ten Variablen aus den n
		alphanumerischen Zeichen Bu,BZ2,...,BZn besteht.
	Ein Variablenname muss immer mit einem Buchstaben beginnen.
	Das Objekt Vr repraesentiert den Namen der Hauptvariablen.
	pf ist ein Zeiger auf eine zum Schreiben geoeffnete Datei.
	fputpm schreibt ein Polynom in r Variablen ueber Z/mZ
	auf die Datei pf.
	fputpm liefert den Ergebniswert
		0       falls der Programmablauf fehlerfrei war;
		-BASIS  falls Fehler auftraten.
	Der include-file <_arith3.h> wird benoetigt.
C*/
/*H
	Version 1	31.05.1987      B. Weis
	Version 2	10.09.1992      U.Schneiders
H*/
/*cS
	fputpm ruft auf: errmsgio, free, ilog2, isatty, isign, isvarl,
			 lcinv, lelt, malloc, ptosdp, sputi, strcat,
			 strlen
	Macros: fileno, fputc, fputs, getocnt, iabs, isatom, lfirst,
			lred, lred2, return, smax
Sc*/

#include <_arith3.h>

single fputpm(r,A,V,pf)
single r;
pol A;
list V;
FILE *pf;
{
    single Sch=1, eA, err=0, i, j, namax, zv=0;
    char *e, *fn, *h, *k, vz;
    int kA, hilf;
    list eAV, eAVS, Vi;
    pol AS;
    bind(A,V);
    init(eAV, kA, eAVS, Vi, AS, hilf );

/* A gleich 0 */

    if (!A) {
	if (fputs("MOD(0)",pf) == EOF) {err = -BASIS; fn = "P201";}
	}

/* r gleich 0 */

    else if (!r) {
	i = (ilog2(A)/3)+3;
	if ((k = malloc(i)) == NULL) {i = -1; err = -BASIS;}
	sputi(A,k);
	if (!err  &&  getocnt(pf)  &&  getocnt(pf)+strlen(k) > LN_SIZE) {
	    if (fputc('\n',pf) == EOF) err = -BASIS;
	    }
	if (!err  &&  fprintf(pf, "MOD(%s)", k ) < 0 ) err = -BASIS;
	if (!err  &&  fputs(" ",pf) == EOF) err = -BASIS;
	if (i != -1) free(k);
	if (err) fn = "P201";
	}

/* allgemeiner Fall: A,r ungleich 0 */

    else {
	namax = isvarl(r,V);
	A = ptosdp(r,A);
	i = 3;
	AS = A;
	while (AS != _0) {
	    kA = lfirst(AS);
	    AS = lred2(AS);
	    hilf = ilog2( kA );
	    i = smax(i, hilf );
	    }
	i = (i / 3) + 3;
	j = r * (12 + namax) + 3;
	if ((k = malloc(i)) == NULL) {j = 1; err = -BASIS; fn = "P220";}
	if (!err  &&  (e = malloc(j)) == NULL) {j = 2; err = -BASIS; fn = "P220";}
	if (!err  &&  (h = malloc(12)) == NULL) {j = 3; err = -BASIS; fn = "P220";}
	while (!err  &&  A != _0) {
	    kA = lfirst(A);
	    A = lred(A);
	    eAV = lfirst(A);
	    A = lred(A);
	    if (isign(kA) == -1) vz = '-';
	    else vz = '+';
	    kA = iabs(kA);
	    sputi(kA,k);
	    eAV = lcinv(eAV);
	    eAVS = eAV;
	    *e = '\0';
	    while (eAVS != _0) {
		strcat(e,"*");
		eA = lfirst(eAVS);
		eAVS = lred(eAVS);
		i = lfirst(eAVS);
		eAVS = lred(eAVS);
		Vi = lelt(V,i);
		i = strlen(e);
	/***	if (isatom(Vi)) {
		    *(e+i) = Vi;
		    i++;
		    }
		else {
		    while (Vi != _0) {
			Vib = lfirst(Vi);
			Vi = lred(Vi);
			*(e+i) = Vib;
			i++;
			}
		    }***/
 		while (Vi != _0) *(e+i++) = (char)lfirst(Vi), Vi = lred(Vi);
		*(e+i) = '\0';
		if (eA > 1) {
		    strcat(e,"^");
		    sputi(eA,h);
		    strcat(e,h);
		    }
		}
	    if (err) break;
	    i = strlen(e) + strlen(k) + 5;
	    if (i > LN_SIZE) zv = 1;
	    if (i+getocnt(pf)+3 > LN_SIZE  &&  getocnt(pf))  {
		if (!(getocnt(pf) == 80  &&  LN_SIZE == 80  &&  isatty(fileno(pf)))) {
		    if (fputc('\n',pf) == EOF) {err = -BASIS; fn = "P201"; break;}
		    }
		}
	    if (Sch  &&  vz == '-') {
		if (fputc(vz,pf) == EOF) {err = -BASIS; fn = "P201"; break;}
		if (fputc(' ',pf) == EOF) {err = -BASIS; fn = "P201"; break;}
		}
	    if (!Sch) {
		if (fputc(' ',pf) == EOF) {err = -BASIS; fn = "P201"; break;}
		if (fputc(vz,pf) == EOF) {err = -BASIS; fn = "P201"; break;}
		if (fputc(' ',pf) == EOF) {err = -BASIS; fn = "P201"; break;}
		}
	    Sch = 0;
	    
		if (fprintf(pf,"MOD(%s)",k ) < 0 ) {err = -BASIS; fn = "P201"; break;}
	
	    eAVS = eAV;
	    while (eAVS != _0) {
		*e = '\0';
		strcat(e,"*");
		eA = lfirst(eAVS);
		eAVS = lred(eAVS);
		i = lfirst(eAVS);
		eAVS = lred(eAVS);
		Vi = lelt(V,i);
		i = strlen(e);
/***		if (isatom(Vi)) {
		    *(e+i) = Vi;
		    i++;
		    }
		else {
		    while (Vi != _0) {
			Vib = lfirst(Vi);
			Vi = lred(Vi);
			*(e+i) = Vib;
			i++;
			}
		    }***/
		 while (Vi != _0) *(e+i++) = (char)lfirst(Vi), Vi = lred(Vi);
		*(e+i) = '\0';
		if (eA > 1) {
		    strcat(e,"^");
		    sputi(eA,h);
		    strcat(e,h);
		    }
		if (strlen(e)+getocnt(pf) > LN_SIZE  &&  getocnt(pf)) {
		    if (!(getocnt(pf) == 80  &&  LN_SIZE == 80  &&  isatty(fileno(pf)))) {
			if (fputc('\n',pf) == EOF) {err = -BASIS; fn = "P201"; break;}
			}
		    }
		if (fputs(e,pf) == EOF) {err = -BASIS; fn = "P201"; break;}
		if (zv  &&  A != _0) {
		    if (fputc('\n',pf) == EOF) {err = -BASIS; fn = "P201"; break;}
		    zv = 0;
		    }
		}
	    }
	switch (j) {
	    case 1: break;
	    case 2: free(k); break;
	    case 3: free(k); free(e); break;
	    default: free(k); free(e); free(h); break;
	    }
	}

/* Ende */

    if (err) errmsgio("fputpi",fn);
    return(err);
}
