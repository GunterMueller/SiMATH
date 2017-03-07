/*M
.SH NAME
ineg - integer negation

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ineg(A)
int A;

.SH DESCRIPTION
ineg() returns -A.
M*/
/*H
	Version  1 	23.06.1986  	R. Boeffgen
	Version  2	06.06.1992	diverse Verbesserungen.  MC
   DATE ineg          : 890501.921130
H*/


# include <_arith1.h>



#define lpmoc( A, a ) { A = AVAIL;  AVAIL = lred( AVAIL ); \
lsfirst( A, (a) ); if ( AVAIL == _0 ) {gc(); lsred( A, AVAIL );} }     
#define lpmoc_start( AA ) { if ( AVAIL == _0 ) gc();  AA = AVAIL; }  
/* Zu diesen Macros vgl. Doku von isum */

int ineg ( A )         
int A;
{
	if ( issingle(A) )  return( -A );
	{
		list B, BB; 
		bind( A ); 
		init( BB );   
   
		lpmoc_start( BB )
		
		do { 
		lpmoc( B, -lfirst( A ) )
		A = lred( A );    
		}
		while ( A != _0 );
		
		lsred( B, _0 );
		return(BB);
	}
}
