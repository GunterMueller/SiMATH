/*M
.SH NAME
fputpms - file put polynomial over modular singles

.SH SYNOPSIS
.nf
#include<_pol1.h>

single fputpms(r, m, P, V, pf)  
single r, m; 
pol P;  
list V; 
FILE *pf;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.
.TP 4
.B m
is an integer number.                                           
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/mZ.                        
.TP 4                                                                           
.B V                                                                            
is a list, containing the variables names of P (s. pmakevl).                    
For r = 0, V is the empty list.                                                 
.TP 4                                                                           
.B pf                                                                           
is a pointer to an output file.                                                 
.PP                                                                             
fputpms writes the polynomial P to the file *pf. The end of the polynomial will be marked with '#'.   
.PP                                                                             
fputpms returns                                                                  
 0      by success,                                                             
 ERROR  else.                                                                   
                             
.SH SEE ALSO
pmakevl

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       23.10.1987      B. Weis
			malloc fuer h, k entfernt
	Version 3       10.03.1988      B. Weis
			Sonderfall einbuchstabige Variablennamen verboten
	Version 4       14.08.1991      P. Serf
			unsinnige Abfragen "sputi(.,.) == EOF" ausgeblendet
   DATE fputpms       : 890501.910915.9301__
H*/


#include <_pol1.h>

single fputpms(r,m,A,V,pf)
single r;
single m;
pol A;
list V;
FILE *pf;
{
    single Sch=1, eA, err=0, i, j, namax, zv=0;
    char *e, *fn, h[12], k[20];
    char *malloc();
    single kA;
    list eAV, eAVS, Vi;
    bind2(A,V);
    init(eAV);

/* A gleich 0 */

    if (!A) {
	if (fputs("0 #",pf) == EOF) {err = ERROR; fn = "P201";}
	}

/* r gleich 0 */

    else if (!r) {
      /*if (!err  &&  sputi(A,k) == EOF) err = ERROR;*/   sputi(A,k);
	if (!err  &&  getocnt(pf)  &&  getocnt(pf)+strlen(k) > LN_SIZE) {
	    if (fputc('\n',pf) == EOF) err = ERROR;
	    }
	if (!err  &&  fputs(k,pf) == EOF) err = ERROR;
	if (!err  &&  fputs(" #",pf) == EOF) err = ERROR;
	if (err) fn = "P201";
	}

/* allgemeiner Fall: A,r ungleich 0 */

    else {
	namax = isvarl(r,V);
	A = ptosdp(r,A);
	j = r * (12 + namax) + 3;
	if (!err  &&  (e = malloc(j)) == NULL) {j = 0; err = ERROR; fn = "P220";}
	while (!err  &&  A != _0) {
	    kA = lfirst(A);
	    A = lred(A);
	    eAV = lfirst(A);
	    A = lred(A);
	  /*if (sputi(kA,k)==EOF) {err=ERROR; fn="P221"; break;}*/  sputi(kA,k);
	    eAV = lcinv(eAV);
	    eAVS = eAV;
	    *e = '\0';
	    while (eAVS != _0) {
		if (kA != 1  ||  eAVS != eAV) strcat(e," ");
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
	    if (!Sch) {
		if (fputc(' ',pf) == EOF) {err = ERROR; fn = "P201"; break;}
		if (fputc('+',pf) == EOF) {err = ERROR; fn = "P201"; break;}
		if (fputc(' ',pf) == EOF) {err = ERROR; fn = "P201"; break;}
		}
	    Sch = 0;
	    if (kA != 1  ||  strlen(e) == 0) {
		if (fputs(k,pf) == EOF) {err = ERROR; fn = "P201"; break;}
		}
	    eAVS = eAV;
	    while (eAVS != _0) {
		*e = '\0';
		if (kA != 1  ||  eAVS != eAV) strcat(e," ");
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
	if (j) free(e);
	}

/* Ende */

    if (err) errmsgio("fputpi",fn);
    return(err);
}
