/*M
.SH NAME
fputrd - file put rational number decimal

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputrd(R,n,pf)
rat R;
single n;
FILE *pf;

.SH DESCRIPTION
fputrd()
writes the rational number R using decimal notation rounded to n places
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
The rounding error is at most (1/2) * 10^-n.
If the absolute value of R is rounded upwards, a trailing "+" will be added.
If the absolute value of R is rounded downwards, a trailing "-" will be added.
M*/
/*H
	Version 1       23.02.1987      R.Boeffgen
   DATE fputrd        : 890501
H*/


# include <_arith1.h>

single fputrd ( R, n, pf )
rat R;
single n;
FILE *pf;
{
	int  A,B, N, Q,S;
	single  s, t=0;
	init( N );
	bind2( A, B );
   /***    aufblaehen    ***/
	if ( R==0 )  A=0, B=1;
	else  A = lfirst(R),  B = lsecond(R);
	if ( (s=isign(A)) <0 )  A = ineg( A );
	N = iexp( 10,n );
	A = iprod( A,N );
	iqrem( A,B, &Q,&S );
	bind( Q );
	S = isprod( S,2 );
	if (S)  if ( (t=icomp(B,S)) ==0 ) t=1;
		else  if ( t<0 ) Q = isum( Q,1 );
   /***    Vorzeichen    ***/
	if ( s<0  &&  fputc('-',pf) == EOF )  goto ERR;
   /***    ganzzahliger Anteil    ***/
	iqrem( Q,N, &Q,&S);
	bind( S );
	if ( fputi(Q,pf) )  {
		errmsgio( "fputrd", "EA107" );
		return( ERROR );
	}
   /***    Nachkommastellen    ***/
	if ( (n || t)  &&  fputc('.',pf) == EOF )  goto ERR;
	while ( n-- > 0 )  {
		S = isprod( S,10 );
		iqrem( S,N, &Q,&S );
		if ( fputc(Q+'0',pf) == EOF )  goto ERR;
	}
   /***    Rundung anzeigen    ***/
	if ( ( t <= 0  ||  fputc('+',pf) != EOF )
	  && ( t >= 0  ||  fputc('-',pf) != EOF ) )  return( 0 );
   /***    Fehlermeldung    ***/
  ERR:  errmsgio( "fputrd", "EA104" );
	return( ERROR );
}
