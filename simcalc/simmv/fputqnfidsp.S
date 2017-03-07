/*C
		    fputqnfidsp( D, A, pf )

	"file put quadratic number field ideal, special version"
	Quellbibliothek: srclib.arith2
	Include-Datei:   _arith2.h
	single fputqnfidsp( D, A, pf )  list D,A; FILE *pf; 
	s = fputqnfidsp( D, A, pf );
	Es muss gelten:
	 - D ist eine Liste. Entweder besteht D aus nur einem quadratfreien
	   Element m aus Z\{0,1}, oder D besteht aus zwei Elementen aus Q.
	   Dann ist der quadratische Zahlkoerper gegeben durch das
  	   Polynom AX^2+BX+C und D=(aa,k) mit aa=B/A, bb=C/A
	   und aa^2-4bb = mk^2, wobei m aus Z quadratfrei ist.
	 - A ist ein Ideal des Ganzheitsrings O_m von Q(m^(1/2)).
	fputqnfidsp gibt das durch A repraesentierte Ideal auf die Datei
	*pf aus. Zur Darstellung von Idealen siehe qnfidprod. Dort wird 
	ein Ideal bzgl. der Basis 1,m^(1/2) dargestellt. Waehlt man
	als Basis 1,x0, wobei x0 eine Loesung von AX^2+BX+C ist, so 
	erhaelt man eine andere Darstellung.Ein Ideal 
		A = ( a b c s )  int a,b,c; single s; 
	wird folgendermassen ausgegeben: 

	1.Fall: D=(m)
		(0), falls A das Nullideal darstellt,
                [b/s, (c+D^(1/2))/s], falls a == 1,
	    ((a)[b/s, (c+D^(1/2))/s]) sonst.

	2.Fall: D=(aa,k)
		(0), falls A das Nullideal darstellt,
                [b/s, (c'+2x0)/ks], falls a == 1,
	    ((a)[b/s, (c'+2x0)/ks]) sonst.
		Dabei ist c'=kc+aa.

	Rueckgabe: 0 bei Erfolg, ERROR sonst.
C*/
/*H
	Version 1       10.10.1993	Josef Gebel
	Version 2       03.07.1996	S.Schmitt
H*/

#include <_calc.h>

fputqnfidsp( D, A, pf ) 
list D,A; 
FILE *pf; 
{
    int a;

    bind( D, A );
    init( a );

    if( !( a = lfirst( A ) ) )
    {
	/***   A stellt das Nullideal dar   ***/
	if( ( fputc( '(', pf ) == ERROR )
	 || ( fputc( '0', pf ) == ERROR )
	 || ( fputc( ')', pf ) == ERROR ) )
	{
	    return( ERROR );
	}
    }
    else
    {
        single s;
        int    b, c,h,k;
    
        init( b, c, h,k );
        
        b = lsecond( A );
        c = lthird ( A );
        s = lfourth( A );
        b = isquot( b, s );

	if(llength(D)==2)
	{	c=itor(c);
		c=rprod(c,lsecond(D));
		c=rsum(c,lfirst(D));	/** c'=kc+aa **/
		h=itor(s);
		h=rprod(h,lsecond(D));
		c=rquot(c,h);		/** c'/ks **/
		h=rquot(itor(2),h);	/** 2/ks **/
		A=rden(c);
		k=rden(h);
		A=ilcm(A,k);		/** Hauptnenner **/
		c=rprod(c,itor(A));
		c=rnum(c);
		h=rprod(h,itor(A));
		h=rnum(h);
	}
	else h=0;
	
	if( fputc( '(', pf ) == ERROR )  return(ERROR);
    
        if( icomp(a,1) )
                    {
	    if( ( fputc( '(', pf ) == ERROR )
	     || ( fputi(   a, pf ) == ERROR )
	     || ( fputc( ')', pf ) == ERROR ) )
	    {
	        return( ERROR );
	    }
        }
        if( ( fputc( '[', pf ) == ERROR )
         || ( fputi(   b, pf ) == ERROR )
         || ( fputc( ',', pf ) == ERROR ) 
         || ( ((!h && ( s == 2 )) || (h && icomp(A,1))) && c && ( fputc( '(', pf ) == ERROR ) )
         || ( c && ( fputi(   c, pf ) == ERROR ) ) )
	{
		return(ERROR);
	}
	if(h && icomp(h,0)==(-1) )
	{	h=ineg(h);
		if(fputc( '-',pf) == ERROR) return(ERROR);
	}
	else if(c && ( fputc( '+', pf ) == ERROR ) )
	{	
		return(ERROR);
	}
	
	if( ( h && icomp(h,1) && (fputi(h,pf)==ERROR) )
	  || ( h && icomp(h,1) && (fputc('*',pf)==ERROR) )
	 || ( fputc( lfirst(lfirst(VNF)) , pf ) == ERROR )
         || ( (( !h && ( s == 2 )) || (h && icomp(A,1))) && c && ( fputc( ')', pf ) == ERROR ) )
         || ( (( !h && ( s == 2 )) || (h && icomp(A,1))) && ( fputc( '/', pf ) == ERROR ) )
         || ( !h && ( s == 2 ) && ( fputc( '2', pf ) == ERROR ) )
	 || ( h && icomp(A,1) && (fputi(A,pf)==ERROR) )
         || ( fputc( ']', pf ) == ERROR ) )
        {
	    return( ERROR );
        }
    	
        if( fputc( ')', pf ) == ERROR ) 
        {
	    return( ERROR );
        }
    }
    return( 0 );
}
