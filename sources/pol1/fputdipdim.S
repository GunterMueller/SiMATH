/*M
.SH NAME
fputdipdim - file put distributive polynomial dimension

.SH SYNOPSIS
.nf
#include<_pol1.h>

single fputdipdim(r, dim, S, M, VL, pf)  
single r, dim; 
list S, M, VL;
FILE *pf;
                                                  
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                  
.TP 4
.B dim, S, M
are the values, computed by dipdimpolid, i.e.
.IP
 dim := the dimension of the ideal spanned by G,                                
 S   := the maximal free set of variables,                                      
 M   := the set of all maximal free sets of variables 
        of VL.
.TP 4
.B VL
is the list of variables of the polynomial ideal with length r.
.TP 4                                                                           
.B pf                                                                           
is a pointer to an output file.         
.PP    
fputdipdim writes dim, S, M to the file pf.
.PP
fputdipdim returns
.PP
 0      by success,                                                             
 ERROR  else.            

.SH SEE ALSO
dipdimpolid

M*/

/*H
	Version 1	28.06.1993	Th. Weis
   DATE fputdipdim    : 931130
H*/

#include <_pol1.h>

static list ixsubs(single,list,list);

single fputdipdim(r,dim,S,M,VL,pf)
single r,dim;
list   S,M,VL;
FILE   *pf;
{
/*
 * Fall: dim == -1  - Anfang
 */
  if ( fprintf(pf,"\ndimension = %i\n",dim) != 0 )  return(ERROR);
  if ( dim == (-1) )  return(0);
/*
 * Fall: dim == -1  - Ende
 * Fall: dim != -1
 */
  {
    single err=0;
    list   VV,VA,VA2,ML;

    bind(S,M,VL);
    init(VV,VA,VA2,ML);
/*
 * Ausgabe - Anfang
 */
    VV = ixsubs(r,VL,S);
    if ( fprintf(pf,"maximal independent set = { ") != 0 )  return(ERROR);
    /* Variablen-Ausgabe - Anfang */
    if ( VV != _0 ) {
       VA = VV;
       do {
          VA2 = lfirst(VA);
          do {
             if ( fprintf(pf,"%c",lfirst(VA2)) != 0 ) { err = ERROR; break; }
             VA2 = lred(VA2);
          } while ( VA2 != _0 );
          if ( !err )  VA = lred(VA);
          else  break;
          if ( VA != _0 ) {
             if ( fprintf(pf,", ") != 0 ) { err = ERROR; break; }
          }
       } while ( VA != _0 );
    }
    /* Variablen-Ausgabe - Ende */
    if ( !err ) {
       if ( fprintf(pf," }\n") != 0 )  return(ERROR);
       if ( fprintf(pf,"all maximal independent sets = { { ") != 0 )  return(ERROR);
       while ( M != _0 ) {
             ML = lfirst(M);
             M  = lred(M);
             VV = ixsubs(r,VL,ML);
             /* Variablen-Ausgabe - Anfang */
             if ( VV != _0 ) {
                VA = VV;
                do {
                   VA2 = lfirst(VA);
                   do {
                      if ( fprintf(pf,"%c",lfirst(VA2)) != 0 ) { err = ERROR; break; }
                      VA2 = lred(VA2);
                   } while ( VA2 != _0 );
                   if ( !err )  VA = lred(VA);
                   else  break;
                   if ( VA != _0 ) {
                      if (  fprintf(pf,", ") != 0 ) { err = ERROR; break; }
                   }
                } while ( VA != _0 );
             }
             /* Variablen-Ausgabe - Ende */
             if ( !err && M != _0 ) {
                if ( fprintf(pf," }, { ") != 0 ) { err = ERROR; break; }
             }
       }
       if ( !err )  err = fprintf(pf," } }\n");
    }
/*
 * Ausgabe - Ende
 * Rueckgabe
 */
    return(err);
  }
}



/*c
			ixsubs( r, V, I )	(static)

        static list ixsubs(r,V,I)  single r; list V,I;
        VP = ixsubs(r,V,I);
c*/

static list ixsubs(r,V,I)
single r;
list   V,I;
{
  single i;
  list   IP,VL,VP;

  bind(V,I);
  init(IP,VL,VP);

  IP = I;
  VP = _0;
  while ( IP != _0 ) {
        i  = lfirst(IP);
        IP = lred(IP);
        VL = lelt(V,i);
        VP = lcomp(VL,VP);
  }
  VP = linv(VP);
  return(VP);
}
