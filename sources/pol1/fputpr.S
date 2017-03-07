/*M
.SH NAME
fputpr - file put polynomial over rationals

.SH SYNOPSIS
.nf
#include<_pol1.h>

single fputpr(r, P, V, pf)  
single r; 
pol P; 
list V; 
FILE *pf;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over the rational numbers.                        
.TP 4                                                                           
.B V                                                                            
is a list, containing the variables names of P (s. pmakevl).                    
For r = 0, V is the empty list.                                                 
.TP 4                                                                           
.B pf                                                                           
is a pointer to an output file.                                                 
.PP                                                                             
fputpr writes the polynomial P to the file *pf. The end of the polynomial will be marked with '#'.  
.PP                                                                             
fputpr returns                                                                  
 0      by success,                                                             
 ERROR  else.                       

.SH SEE ALSO
pmakevl

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       23.10.1987      B. Weis
			malloc fuer h entfernt
	Version 3       24.11.1987      B. Weis
			Ausgabe von Koeffizient 1 unterdrueckt
	Version 4       10.03.1988      B. Weis
			Sonderfall einbuchstabige Variablennamen verboten
	Version 5       14.08.1991      P. Serf
			unsinnige Abfragen "sput[i,r](.,.) == EOF" ausgeblendet
   DATE fputpr        : 890501.910915.9301__
H*/


#include <_pol1.h>

single fputpr(r,A,V,pf)
single r;
pol A;
list V;
FILE *pf;
{
    single Sch=1, eA, err=0, i, j, namax, zv=0;
    char *e, *fn, h[12], *k, vz;
    char *malloc();
    rat Eins, kA;
    list eAV, eAVS, Vi;
    pol AS;
    bind2(A,V);
    init3(Eins,eAV,kA);

/* A gleich 0 */

    if (!A) {
	if (fputs("0 #",pf) == EOF) {err = ERROR; fn = "P201";}
	}

/* r gleich 0 */

    else if (!r) {
	i = (ilog2(lfirst(A))/3) + (ilog2(lsecond(A))/3) + 9;
	if ((k = malloc(i)) == NULL) {i = -1; err = ERROR;}
      /*if (!err  &&  sputr(A,k) == EOF) err = ERROR;*/   sputr(A,k);
	if (!err  &&  getocnt(pf)  &&  getocnt(pf)+strlen(k) > LN_SIZE) {
	    if (fputc('\n',pf) == EOF) err = ERROR;
	    }
	if (!err  &&  fputs(k,pf) == EOF) err = ERROR;
	if (!err  &&  fputs(" #",pf) == EOF) err = ERROR;
	if (i != -1) free(k);
	if (err) fn = "P201";
	}

/* allgemeiner Fall: A,r ungleich 0 */

    else {
	Eins = list2(1,1);
	namax = isvarl(r,V);
	A = ptosdp(r,A);
	i = 3;
	AS = A;
	while (AS != _0) {
	    kA = lfirst(AS);
	    AS = lred2(AS);
	    j = ilog2(lfirst(kA)) + ilog2(lsecond(kA));
	    i = smax(i,j);
	    }
	i = (i / 3) + 9;
	j = r * (12 + namax) + 3;
	if ((k = malloc(i)) == NULL) {j = 1; err = ERROR; fn = "P220";}
	if (!err  &&  (e = malloc(j)) == NULL) {j = 2; err = ERROR; fn = "P220";}
	while (!err  &&  A != _0) {
	    kA = lfirst(A);
	    A = lred(A);
	    eAV = lfirst(A);
	    A = lred(A);
	    if (rsign(kA) == -1) vz = '-';
	    else vz = '+';
	    kA = rabs(kA);
	  /*if (sputr(kA,k)==EOF) {err=ERROR;fn="P221";break;}*/   sputr(kA,k);
	    eAV = lcinv(eAV);
	    eAVS = eAV;
	    *e = '\0';
	    while (eAVS != _0) {
		if (!oequal(kA,Eins)  ||  eAVS != eAV) strcat(e," ");
		eA = lfirst(eAVS);
		eAVS = lred(eAVS);
		i = lfirst(eAVS);
		eAVS = lred(eAVS);
		Vi = lelt(V,i);
		i = strlen(e);
		while (Vi != _0) *(e+i++) = (char)lfirst(Vi), Vi = lred(Vi);
		*(e+i) = '\0';
		if (eA > 1) {
		    strcat(e,"^");
		  /*if (sputi(eA,h)==EOF) {err=ERROR;fn="P221";break;}*/ sputi(eA,h);
		    strcat(e,h);
		    }
		}
	    if (err) break;
	    i = strlen(e) + strlen(k);
	    if (i > LN_SIZE) zv = 1;
	    if (i+getocnt(pf)+3 > LN_SIZE  &&  getocnt(pf))  {
		if (!(getocnt(pf) == 80  &&  LN_SIZE == 80  &&  isatty(fileno(pf)))) {
		    if (fputc('\n',pf) == EOF) {err = ERROR; fn = "P201"; break;}
		    }
		}
	    if (Sch  &&  vz == '-') {
		if (fputc(vz,pf) == EOF) {err = ERROR; fn = "P201"; break;}
		if (fputc(' ',pf) == EOF) {err = ERROR; fn = "P201"; break;}
		}
	    if (!Sch) {
		if (fputc(' ',pf) == EOF) {err = ERROR; fn = "P201"; break;}
		if (fputc(vz,pf) == EOF) {err = ERROR; fn = "P201"; break;}
		if (fputc(' ',pf) == EOF) {err = ERROR; fn = "P201"; break;}
		}
	    Sch = 0;
	    if (!oequal(kA,Eins)  ||  strlen(e) == 0) {
		if (fputs(k,pf) == EOF) {err = ERROR; fn = "P201"; break;}
		}
	    eAVS = eAV;
	    while (eAVS != _0) {
		*e = '\0';
		if (!oequal(kA,Eins)  ||  eAVS != eAV) strcat(e," ");
		eA = lfirst(eAVS);
		eAVS = lred(eAVS);
		i = lfirst(eAVS);
		eAVS = lred(eAVS);
		Vi = lelt(V,i);
		i = strlen(e);
		while (Vi != _0) *(e+i++) = (char)lfirst(Vi), Vi = lred(Vi);
		*(e+i) = '\0';
		if (eA > 1) {
		    strcat(e,"^");
		  /*if (sputi(eA,h)==EOF) {err=ERROR;fn="P221";break;}*/ sputi(eA,h);
		    strcat(e,h);
		    }
		if (strlen(e)+getocnt(pf) > LN_SIZE  &&  getocnt(pf)) {
		    if (!(getocnt(pf) == 80  &&  LN_SIZE == 80  &&  isatty(fileno(pf)))) {
			if (fputc('\n',pf) == EOF) {err = ERROR; fn = "P201"; break;}
			}
		    }
		if (fputs(e,pf) == EOF) {err = ERROR; fn = "P201"; break;}
		if (zv  &&  A != _0) {
		    if (fputc('\n',pf) == EOF) {err = ERROR; fn = "P201"; break;}
		    zv = 0;
		    }
		}
	    }
	if (!err  &&  fputs(" #",pf) == EOF) {err = ERROR; fn = "P201";}
	switch (j) {
	    case 1: break;
	    case 2: free(k); break;
	    default: free(k); free(e); break;
	    }
	}

/* Ende */

    if (err) errmsgio("fputpi",fn);
    return(err);
}
