/*M
.SH NAME
flcomp - floating point comparison

.SH SYNOPSIS
.nf
#include<_arith1.h>

single flcomp(f,g)
floating f,g;

.SH DESCRIPTION
flcomp() returns the sign of ( f - g ).
M*/
/*H
	Version  1      18.03.91	Marc Conrad
   DATE flcomp        : 910715
H*/

#include<_arith1.h>     
single flcomp(f,g)
floating f,g;     
{
	list fm,gm;
	single lf,lg, d,i ;      

	bind( f, g );         
/* f od. g == 0 */         
   
	if (!f) return(g ? -flsign(g) : 0);     
	fm = flmant(f);
	if (!g) return( isign(fm) );   
	gm = flmant(g);   
	                        
/* Verschiedene VZ.   */
	if ( (d=isign(fm)) * isign(gm) < 0) return(d);     

/* 'Expo' vgl.          */
	lf = (issingle( fm ) ? 1 : llength( fm ) );
	lg = (issingle( gm ) ? 1 : llength( gm ) );

	if ( lf+flexpo(f) > lg + flexpo(g) ) return(d);
	if ( lf+flexpo(f) < lg + flexpo(g) ) return(-d);    
/* gleicher 'Expo'(faux)   */
	if (lf>lg) {
		for (i=lg;i<lf;i++) fm = lred(fm);
		if (lred(fm) == _0) fm = lfirst(fm);
		i = icomp(fm,gm);             
		/* Hier haben fm und gm gleiche Laenge */
		if (!i) return(d);
		else return(i);
		}                        
	if (lf<lg) {
		for (i=lf;i<lg;i++) gm = lred(gm);
		if (lred(gm) == _0) gm = lfirst(gm);
		i = icomp(fm,gm);
		if (!i) return(-d);  
		/* denn d ist auch Signum von gm */ 
		else return(i);
		}
         /* if (lf == lg) <==> Expos gleich   */
	 return (icomp(fm,gm));
}
