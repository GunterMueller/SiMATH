/*M
.SH NAME
ecqnfrank - elliptic curve over quadratic number field, rank

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecqnfrank(E)
list (E);

.SH DESCRIPTION
ecqnfrank() returns the rank of the free part of the Mordell-Weil
group of the elliptic curve E/K. The rank is computed via the
Birch, Swinnerton-Dyer and Tate conjecture.
.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/K.
M*/
/*H
	Version 1	14.09.1998	S.Schmitt
   DATE ecqnfrank       :  980915.
H*/

#include<_ec2.h>

list A[5500];
list C[5500];
single numcoef = 5000;


list ecqnfrank( E )
list E;
{
    bind( E );
    if( ( lfourth( lfourth( E ) ) == _0 )
    ||  ( lsecond( lfourth( lfourth( E ) ) ) == -1 ) )
    {
      	single r,sig;
	floating l;
	list L4,L44;
int t;

	init(l,L4,L44);
init(t);
settime();

	ecqnfclser(E,numcoef);

	sig = ecqnfsigns(E,numcoef);

	if(sig==1)	/** Rang ist gerade **/
	{
		r = 0;
		l = ecqnflsers(E,numcoef);
		while(!flcomp(l,0))
		{
			r = r+2;
			l = ecqnflserhd(E,r,numcoef);
		}
	}
	else		/** Rang ist ungerade **/
	{
		r = 1;
		l = ecqnflserfd(E,numcoef);
		while(!flcomp(l,0))
		{
			r = r+2;
			l = ecqnflserhd(E,r,numcoef);
		}
	}
t = settime();


sigtest(E,numcoef);
	L4 = lfourth(E);
	L44= lfourth(L4);
	leset(L44,2,r);
	leset(L44,3,l);
	leset(L4,4,L44);
	leset(E,4,L4);

	return(list2(r,t));

    }

    return( lsecond( lfourth( lfourth( E ) ) ) );
}   
