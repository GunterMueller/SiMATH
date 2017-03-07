/*M
.SH NAME
ispmsunit - is polynomial over modular singles unit ?

.SH SYNOPSIS
.nf
#include<_pol1.h>

single ispmsunit(r, m, P)  
single r, m; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B m
is an integer number, 0 < m < BASIS.
.TP 4
.B P
is a polynomial in r variables over Z/mZ.
.PP
ispmsunit returns                                                               
.TP 4                                                                           
1,                                                                              
if P is an unit in the polynomial ring in r variables over Z/mZ.                
.TP 4                                                                           
0,                                                                              
else.
                                                                            
M*/

/*H                                                                         
	Version 1	19.07.90	Pascale Serf                        
   DATE ispmsunit     : 901120.9109__
H*/                                                                         
                                                                            
                                                                            
                                                                            
# include <_pol1.h>                                                         

static pbclist(pol,list*);

single ispmsunit(r,m,P)                                                     
single r,m;                                                                 
pol P;                                                                      
{                                                                           
    /*** Fuer f(x1,..,xr) aus (Z/mZ)[x1,...,xr] mit Koeffizienten     ***/
    /*** a(i1,...,ir) gilt folgende relativ leicht nachzurechnende    ***/
    /*** Aequivalenz:                                                 ***/
    /***    f ist Einheit in (Z/mZ)[x1,...,xr]  <==>                  ***/
    /***        1) a(0,...,0) ist Einheit in Z/mZ                     ***/
    /***        2) M | a(i1,...,ir) fuer alle (i1,...,ir)!=(0,...,0), ***/
    /***    wobei M der quadratfreie Kern von m, d.h. das Produkt     ***/
    /***    aller Primteiler von m, ist.                              ***/

                                                                            
    /***    Spezialfall: P=0    ***/                                        
    if ( !P ) return(0);                                                    

    /***    allgemeiner Fall: P!=0    ***/
    else {

	pol P1;
	list L;
	single n,a,M;

	bind(P);
	init(P1,L);

	/* Bestimmung des quadratfreien Kerns M von m */
	L = sfactors(m);
	M = 1;
	while ( L != _0 ) {
		M *= lfirst(L);
		L = lred(L);
	}

	/* ueberpruefen, ob absolutes Glied Einheit in Z/mZ ist */
	P1 = lcopy(P);
	do {
		P1 = linv(P1);
		if ( lsecond(P1) ) return(0);
		P1 = lfirst(P1);
	}
	while ( islist(P1) );
	if ( sgcd(P1,m) != 1 ) return(0);

	/* Liste aller Basiskoeffizienten !=0 berechnen */
	L = _0;
	pbclist(P,&L);    /* siehe unten */          
	
	/* alsolutes Glied (!=0 nach obigem) rauswerfen */
	L = lred(L);

	/* ueberpruefen, ob alle uebrigen Basis- */
	/* koeffizienten durch M teilbar sind    */

	    /* Spezialfall: M=m */
	    /* nur Basiskoeffizient 0 durch M=m teilbar */
	    if ( M==m ) {
		if ( L!=_0 ) return(0);
		else return(1);
	    }

	    /* allgemeiner Fall: M<m */
    	    while ( L != _0 ) {
		a = lfirst(L);
		if ( a%M ) return(0);
		L = lred(L);
	    }
	    return(1);
    }
}



/* Das Hilfsprogramm pbclist(P,pL) ("polynomial base coefficients    */
/* list") haengt alle Basiskoeffizienten (Atome, also vom Typ single */
/* oder modular single) ungleich 0 des Polynoms P!=0 an die Liste    */
/* *pL an. Falls das absolute Glied von P ungleich 0 ist, steht es   */
/* am Anfang von *pL.                                                */

static pbclist(P,pL)                   /* rekursiv */
pol P;
list *pL;
{
	obj a;

	bind(P,*pL);
	init(a);

	while ( P != _0 ) {
		a = lsecond(P);
		P = lred2(P);
		if ( isatom(a) ) *pL = lcomp(a,*pL);
		else pbclist(a,pL);
	}
}
