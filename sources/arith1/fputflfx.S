/*M
.SH NAME
fputflfx - file put floating point by fix point

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputflfx(f,vk,nk,pf)
floating f;
single vk,nk;
FILE *pf;

.SH DESCRIPTION
fputflfx()
writes the floating point number f in rounded
representation [-]zzz.zzz
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
Here 'z' stands for a figure from 0 to 9.
.PP
.TP 4
.B vk
must be positive and is the number of decimal digits to be written.
If less than vk digits are present, blanks will be inserted.
The optional sign does not account to vk.
.TP 4
.B nk
|nk| is the number of decimal places to write. If the value
of nk is negative, trailing zeroes of the mantissa will not
be written. For example
.nf

f = 4/99, vk = 3, nk =  3 gets "   0.040"  
f = 4/99, vk = 3, nk = -3 gets "   0.04"
f = e,    vk = 6, nk =  4 gets "      2.7183"
f = e,    vk = 6, nk =  0 gets "      3"  
f = -123  vk = 3, nk =  1 gets "-123.0"
f =  123  vk = 3, nk =  1 gets " 123.0"
f =  123  vk = 2, nk =  1 gets "123.0"
f = 2^30, vk = 3, nk =  4 gets "1073741824.0000"
f = 2^30, vk = 3, nk = -4 gets "1073741824"
M*/                                                        
/*H
	Version 1	11.04.91	Marc Conrad
   DATE fputflfx      : 910715
H*/

#include<_arith1.h>

single fputflfx(f,vk,nk,fp)
floating f;
single vk,nk;
FILE *fp;
	{
	int A, B, Z;
	list L;
	single i, fsgn, nst,q,r,a,nf ;      
	char s[20], *p;    
                         
	bind( f );
	init( A, B, L, Z);   
        
	if (nk < 0) nf = 1, nk = -nk; 
	else nf=0;
	L = _0;  
	fsgn = flsign(f);
	f = flabs(f);
	A = flfloor(f);   
  
	r = FL_EPS;
	FL_EPS = BASIS-1;          /* exakte Rechnung */
	f = fldif(f,itofl(A));  
	flinit( nk );    
	FL_EPS++;
	Z = iexp(10,nk);
	B = flround(flprod(itofl(Z),f));   
	FL_EPS = r;
   
	if ( icomp(B, Z) >= 0 ) B = idif(B,Z), A = isum(A,1);                 
/* Vorkommastellen */      
	Z = A;                  
	q =  vk / BLOG10 + 1;
	r = BLOG10 - ( vk % BLOG10 );       
	for(i=0;(i < q );i++) {
		isqrem ( A, DECBAS, &A,&a );
		L = lcomp( a,L );  
		}    
	/* Format kann nicht eingehalten werden */  
	if (A != 0 ) {
		do {
			isqrem ( A,DECBAS, &A,&a );
			L = lcomp( a,L );
		} while ( A != 0 );
		a = fsgn * lfirst( L ),  L = lred( L );
		if ( fputa(a,fp) != 0 )  {
			errmsgio( "fputflfx", "EA106" );
			return( ERROR );
			}
		while ( L != _0 )  {
			a = lfirst( L ),  L = lred( L );
			*(p = s+BLOG10) = '\0';
			while ( p-- >s )  *p = a%10+'0',  a /= 10;
			if ( fputs(s,fp) != 0 )  {
				errmsgio( "fputflfx", "EA105" );
				return( ERROR );
				}
                        }   
	  	}           
	/* Format kann ggf. eingehalten werden */
	else {	              
	    char *pp;
	    nst = 1; 
	    a = lfirst( L ),  L = lred( L );
	    *(p = s+BLOG10) = '\0';
	    while ( p-- >s )  *p = a%10+'0',  a /= 10;
	    pp = s;
	    while (*pp == '0') *pp = ' ', pp++; 
	    if (*pp != '\0') { 
		 nst = 0;
		 *(--pp) = (fsgn < 0 ?  '-' : ' ');     
		 }                        
	    else if (L == _0 ) { 
		if (vk) *(--pp) = '0';   
		*(--pp) = (fsgn < 0 ?  '-' : ' ');    
		}
  	    p = s + (r - 1);   
	    while (*p != ' ' && *p != '-') p--;
	    if ( fputs(p ,fp) != 0 )  {
			errmsgio( "fputflx", "EA105" );
			return( ERROR );     
			}

	    while ( L != _0 )  {
			a = lfirst( L ),  L = lred( L );
			*(p = s+BLOG10) = '\0';   
			while ( p-- >s )   
				*p = a%10+'0',  a /= 10;     
			if (nst) {
			     pp = s;
	    		     while (*pp == '0') *pp = ' ', pp++; 
	    		     if (*pp != '\0') { 
				nst = 0;  
     	 		        *(--pp) = (fsgn < 0 ?  '-' : ' '); 
                                }
			     else if (L == _0) { 
				*(--pp) = '0';   
			        *(--pp) = (fsgn < 0 ?  '-' : ' ');    
				}
			    }

			if ( fputs(s,fp) != 0 )  {
				errmsgio( "fputflx", "EA105" );
				return( ERROR );
				}
			}      
	    }
/* --------------------------------------------------------------------------------- */
	/* Nachkommastellen */
	q =  nk / BLOG10 + 1;
	r = BLOG10 - ( nk % BLOG10 );  
	if ( r == BLOG10 ) q--,r=0;
	L = _0; 
	nst = 1;
	for(i=0;i < q ;i++) {      
		isqrem ( B,DECBAS, &B,&a ); 
		if (!nf || !nst || a) 
			nst=0, L = lcomp( a,L );  
		}          
	/* Format kann immer eingehalten werden */
	if (L != _0) {   
		putc('.',fp);
		a = lfirst( L ),  L = lred( L );       
		*(p = s+BLOG10) = '\0';
		while ( p-- >s )  *p = a%10+'0',  a /= 10;        
		if (nf && L == _0) {   
			p = s + (BLOG10 - 1);
			while( *p == '0') p--;
		 	*(++p) = '\0';
			}
		if ( fputs(s + r ,fp) != 0 )  {
			errmsgio( "fputflx", "EA105" );
			return( ERROR );     
			}     
		}                 
	else if (!Z && !vk) putc('0',fp);    
	/* else do nothing ( kommt vor ) */
	while ( L != _0 )  {
		a = lfirst( L ),  L = lred( L );
		*(p = s+BLOG10) = '\0';   
		while ( p-- >s ) *p = a%10+'0',  a /= 10;    
		if (nf && L == _0) {   
			p = s + (BLOG10 - 1);
			while( *p == '0') p--;
		 	*(++p) = '\0';
			}
		if ( fputs(s,fp) != 0 )  {
			errmsgio( "fputflx", "EA105" );
			return( ERROR );
			}
		}   
/* --------------------------------------------------------------------------------- */
	return(0);
	}
