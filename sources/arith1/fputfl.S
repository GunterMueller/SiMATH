/*M
.SH NAME
fputfl - file put floating point

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputfl(f,n,pf)
floating f;
single n;
FILE *pf;

.SH DESCRIPTION
fputfl() 
writes the floating point number f in rounded
representation [-]0.z...ze[-]z...z
to the output file *pf and returns 0.
Here 'e' stands for "10^..." and z for a figure from 0 to 9.
In case of a failure, the return code is ERROR.
.PP
.TP 4
.B n
|n| is the number of decimal places to write. If the value
of n is negative, trailing zeroes of the mantissa will not
be written. For example
.nf

f = 4/99, n =  6  gets "0.404040e-1"
f = 4/99, n = -6  gets "0.40404e-1"
f = e,    n = -14 gets "0.2718281828459e1"
f = e,    n = 14  gets "0.27182818284590e1"
f = e,    n = 11  gets "0.27182818285e1"
M*/
/*H
	Version 1	17.05.91	Marc Conrad
   DATE fputfl        : 910715
H*/

#include<_arith1.h>     

single fputfl( f, k, fp)
FILE *fp;
single k;
floating f;            

/* k = Anzahl der auszugebenen Stellen  */    
{                
	char *fn, x='x';
	single epsbak,fsg,i,c, null;
	obj g,h,zehn,zpot,izpot,decexp;  
	bind(f);
	init(g,h,zehn,zpot,izpot,decexp);    

/* fn initialisieren */	
	fn = &x;         
/* FL_EPS  retten */
	epsbak = FL_EPS;   

 
	if (!f) { if(fputc('0',fp) == EOF) fn="EA104"; }

	else {      
		if ( k < 0 )  null = 1, k = -k;        
		else null = 0;
		
		flinit( k + 1);
		FL_EPS += 2;

		zehn = list2(0,10);
		fsg = flsign(f);
		f = flabs(f);    
                k = smax(k,1);
		decexp = idif(isprod(flexpo(f),30),1);      
		g = list2( 279366043 , 30937866 );
                h = list2( 801177600 , 9313225 );
                  			/*  g/h = log10/log2  */                             
  	    decexp = idif(iquot(iprod(isum(ilog2(flmant(f)),decexp),h),g),k);  
		izpot = idif(iexp(10,k),1);
		do { 
		    decexp = idif( decexp, 1);
		    if (!issingle(decexp)) {              
			FL_EPS += 2;
			isqrem(decexp,128,&h,&g);
			zpot = flsexp(zehn,g);        
			f = flquot( f, zpot );
			zpot = flsexp( flsexp(zehn,h),128);
			FL_EPS -= 2;
		        }
                    else zpot = flsexp(zehn,decexp);   
		  
		    g = flfloor(flquot(f,zpot));    
		} while(icomp(g,izpot) <= 0);
				 
		if ( fsg == -1 ) 
			if ( fputc('-',fp) == EOF) fn="EA104";     
                if ( fputc('0',fp) == EOF) fn="EA104"; 
		if ( fputc('.',fp) == EOF) fn="EA104"; 
		 
		while ( (c=icomp(g,izpot)) > 0 ) {
			isqrem(g,10,&g,&h);
			decexp = isum(decexp,1); 
			}     
		if (h<5) {     
                    if (null) {                 
			h = g; 
			do g = h, isqrem(g,10,&h,&i); while(!i);       
			}
		    if ( fputi(g,fp) == ERROR ) fn="EA107";    
		    }
/* c == 0  <=>     g == 999999999999.....     */
		else if (!c) {
		    if ( fputc('1',fp) == EOF) fn="EA104"; 
		    if (!null) for(i=1;i<k;i++) {  
			if ( fputc('0',fp) == EOF) fn="EA104";   
			}
		    decexp = isum(decexp,1);    
		    }
		else { 
		    g = isum(g,1);    
                    if (null) {                 
			h = g; 
			do g = h, isqrem(g,10,&h,&i); while(!i);       
			}
		    if ( fputi(g,fp) == ERROR ) fn="EA107";  
 		    }            
		if ( fputc('e',fp) == EOF) fn="EA104"; 
		if ( fputi(isum(decexp,k),fp) == ERROR ) fn="EA107";   		               

		}                         
	FL_EPS = epsbak;
	if ( fn != &x) { 
		errmsgio("fputfl",fn);
    		return(ERROR);    
		}
	else return( 0 );
	}	
