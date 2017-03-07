/*M
.SH NAME
flsum - floating point sum

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flsum(f,g)
floating f,g;

.SH DESCRIPTION
flsum() returns f+g.
M*/
/*H	   
	Version 1       18.03.91        Marc Conrad
   DATE flsum         : 910715
H*/

#include <_arith1.h>                  

floating flsum(f,g)
floating f,g;
{       
    /* ganz triviale Faelle  */
    if (!f) return (g);
    else if (!g) return (f);    
    else {
	single fe,ge,fl,gl,edf, ergex, ergl; 
	single  a, b, c, u, fs, gs, k, k0, nz, ep, t;
	list  RA, A, E, Eva;

 	bind(f,g);    
	init(RA, Eva, A, E);   

	fe = flexpo(f);
	ge = flexpo(g);                              

/* ggf. g und f vertauschen */        
	if (ge > fe ) { 
		A = f; f = g; g = A;
		fe = ge; ge = flexpo(g);
		}
	
	f = lred(f);    
	g = lred(g); 

	/* Listenlaenge: */ 
        fl = llength(f);
	gl = llength(g);
  
        /* triviale Faelle: eine Zahl riesig */       
	k = fe - ge;
	edf = fl - gl + k ;  
	
	if ( (edf > FL_EPS +1) && ( k > gl ) ) 
		Eva = flcons (f,fe,fl) ;      

/*    
        Erlaeuterung der benutzten Konstanten :       
	Man stelle sich f und g als integer vor, jeder Punkt
	bedeutet eine single - Stelle

                   . . . . . .(. . . . .)                 = f 
       ge                k         fl
                  (. . . . . . .). . . .                  = g   
       "                gl         edf
                   . . . . .(. . . . . . .)                = f+g
       "		k0     FL_EPS + 2    
Bem.: Es gilt immer k >= 0. ( Sonst f und g vertauscht )
      Ist k0 < 0 wird k0 = 0 gesetzt.  
      Ist | edf | < 2 und verschiedene Vz. gibt k0 keinen Sinn wg. Ausloeschung.
      Es wird dann mit Pseudo-Ringliste gearbeitet.  Dabei ist RA Anfang, 
      Eva Ende der Psuedoringliste, A und E virtueller Anfang bzw. Ende. 
      Eva  = Ergebnivariable. Die Variablen werden auch sonst als 
      Hilfsvariablen benutzt.      
 */
	else {               
		ergex = ge;            
		/* Man beachte, dass wg. Normierung 
		das erste Listenelement != 0 ist  */

		fs = ssign(lfirst(f));
		gs = ssign(lfirst(g));      

		A = _0;
		ergl = 0;        
		k0 = smax(fl + k, gl ) - 1 - FL_EPS;  
		k0 = smax(k0,0);
	    /***    gleiche Vorzeichen    ***/
		if ( fs==gs ) {                 
		    a = 0; u=0;    
		    do  {   
			if ( k > 0 ) k--;
			else if ( f!=_0 ) a=lfirst(f), f=lred(f), fl--;
			else  a = 0;
			if ( g!=_0 ) b=lfirst(g), g=lred(g), gl--;
			else  b = 0;
			c = a+b+u;
			if      (c >= BASIS) c -= BASIS, u =  1;
			else if (c <=-BASIS) c += BASIS, u = -1;      
			else u = 0;
			if ( k0 ) k0--, ergex++;
			else if (!ergl && !c ) ergex++;
			else A = lcomp( c,A ), ergl++;
		    }
		    while ( !ergl || k || u || ( f!=_0 && g!=_0 ) );  
		    E = linv( A );

 		    /***    Ergebnis durch Concatenation    ***/
			if ( f == _0 )  {
				if (g == _0) { 
					Eva = flcut(E,ergex,ergl);      
					}
				else {                  
  					lsred( A , g);
					Eva = flcons(E,ergex,ergl+gl);
					}     
				}
			else { 
				lsred( A, f);                      
				Eva = flcons(E,ergex,ergl+fl);
				}
		    }                                       
/* ........... verschiedene Vorzeichen .......................  */
		else {                 
		/* Vorzeichen von erg: */     
		    if (!edf) {              
			A = g; E= f; RA = 0;
			for(u=0;u<k;u++) A = lred(A);
			while(A != _0) {
				a=lfirst(A); b= lfirst(E);
				if (a+b) RA=A,Eva=E; 
				A=lred(A), E=lred(E);
				}            
			if (!RA ) ep = gs * k;
			else 
			 ep=(gs * lfirst(RA) >  fs * lfirst(Eva) ? gs : fs); 
			}
 		    else ep = edf * fs; 
		/* Ergebnis Null */            
		    if (!ep) return(0);      
		    if ( sabs( edf ) < 2 ) {    
			b = smax ( k + fl, gl ); 
			t = smin( FL_EPS + 1, b );            
			k0 = 0;
			RA = list1(0);  
			Eva = RA;
			for(u=1;u<t;u++) RA = lcomp(0,RA);     
			E = Eva;
			}      
		    else E = _0, t=0, k0 = smax( k0 - 1, 0 );  
		    ergl=0; u=0; nz=0; a=0;         

		    do  {               
			if ( k ) k--;
			else if ( f!=_0) a = lfirst(f),  f = lred(f), fl--;    
			else a=0;
			if (g != _0) b = lfirst(g),  g = lred(g) , gl--;   
			else b=0;   
			c = a+b+u;                              
			if (ep>0 && c<0 ) c += BASIS, u = -1;
			else if (ep<0 && c>0 ) 	c -= BASIS, u=1;
			else u=0;      

			if ( c && t) { 
				while(nz>0) { 
					E = ( E == Eva ? RA : lred(E) ); 
					nz--; ergl++; lsfirst(E,0);
					} 
				E = ( E == Eva ? RA : lred(E) ); 
				ergl++; lsfirst(E,c); 
				}
			else if (!t) {
				if ( k0 ) k0--, ergex++;
				else if (!ergl && !c ) ergex++;
				else E = lcomp(c,E), ergl++;    
				}
			else nz++;      
			} 
		    while ( !ergl || u || k || (f!=_0 && g !=_0) ); 
		
		    if ( f==_0 )  f = g,  fl=gl;
			
		    /***    uebriger Teil von f    ***/     
		    if (!t) {                             
		/*	ggf. fuehrende Null!    */   
			if ( (f == _0) && !lfirst( E )) ergl--,E=lred( E );
			A = linv(E); 
			lsred(E,f); 
			gl=ergl;    
			}
   
		    else {
			if ( f != _0)
			while(nz>0) { 
				E = ( E == Eva ? RA : lred(E) );  
				nz--,ergl++,lsfirst(E,0); 
				}      

			if ( ergl < t ) A = RA, lsred(E,f), gl=ergl;
			else { 
			        A = ( E == Eva ? RA : lred(E) );
				lsred(E,f);            
				if ( E != Eva ) lsred( Eva, RA );
				gl = t;
			        }                               
			ergex = ergex + ergl - gl;
			}

		    if ( f == _0 ) Eva = flcut(A,ergex,gl);
		    else Eva = flcons(A,ergex,gl+fl);
                    }
                }
	return( Eva );	
	}		
} 
