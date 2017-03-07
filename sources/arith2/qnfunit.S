/*M
.SH NAME
qnfunit - quadratic number field unit group

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfunit(D)  
int D;
  
.SH DESCRIPTION
.TP 4
.B D
is an integer number, D != 0 or 1 and D is square free.
.PP
qnfunit returns a list, say L, containing the generators of the unit group, say U, of Q(D^(1/2)) (elements of type nfel), more exact,
.PP
L = (ew)     and U = <ew>, for D > 0, or
.PP
L = (ew, fe) and U = <ew>x<fe> for D < 0, 
.PP
where ew is a root of unity (i.e. of finite order) and fe is a fundamental unit (i.e. of infinite order).

.SH NOTES
In order to compute the fundamental unit, qnfunit uses the continued fraction algorithm with maximal period length |D|^(1/2). If the origin period length is greater than |D|^(1/2), then fe = _0 (s. rqnffu).
  
.SH SEE ALSO
rqnffu

M*/
                                     
/*H
	Version 1       17.04.1989      Christine Hollinger
	Version 2       04.01.1991      IFURQNF -> RQNFIFU.  AS
	Version 3       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.
					fehlende Initial. L=_0 ergaenzt.
					fehlenden Parameter pl im Aufruf von
					rqnffu auf |D|^(1/2) gesetzt.
					"if( D>0 )" -> "if (icomp(D,0)>0)".  PS
	Version 4	08.10.1992	"icomp(D,0)>0" -> "isign(D)>0".
				        "isqrt(ineg(D))" -> "isqrt(D)".  US
   DATE qnfunit       : 890801.910715.910915.921130
H*/

#include<_arith2.h>

list qnfunit( D )
int D;
{
	list L;
	nfel e;
	init( L, e );
	bind( D );

	/*** D > 0 -> Berechnung der Fundamentaleinheit. ***/
	/*** (maximale Periodenlaenge D^(1/2))           ***/

	L = _0;
	if( isign(D) > 0 )
	{       e = rqnffu( D,isqrt(D) );
		L = list1( e );
	}

	/*** Bestimme Einheitswurzel. ***/

	switch( D )
	{       case -1: e = list4( 1,1,1,0 );
			 break;
		case -3: e = list4( 2,1,1,-1 );
			 break;
		default: e = list3( 1,0,-1 );
			 break;
	}
	L = lcomp( e,L );
	return( L );
}
