/*M
.SH NAME
fputlstruct - file put list structure (rekursiv)

.SH SYNOPSIS
.nf
#include<_list.h>

single fputlstruct(L, pf)  
list L; 
FILE *pf;
  
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf. 
.PP
fputlstruct writes the structure of the list L, i.e. the adresses and values of the several list cells, to *pf.

M*/
            
/*H
	Version 1       07.04.1987      Pascale Serf
	Version 2       14.07.1988      Korrektur.   PS
	Version 3       04.07.1991      ueberfl. Zuweisung t=... beseitigt.  PS
	Version 4	01.12.1993	geaendert wegen HP.  MC
   DATE fputlstruct   : 890501.910715.940315
H*/


# include <_list.h>

single fputlstruct(L,pf)
list(L);
FILE *pf;
{
	static single i = 0;

	obj a;
	single t;

	bind(L);
	init(a);

	t = 0;
	i = i + 3;

	while ( (L != _0) && (t == 0) ) {
		a = lfirst( L );
		fprintf(pf,"%t%d",i, lred( L ) );
		if ( a == _0 ) t = fprintf(pf,"%tl e e r e   L i s t e\n",i+20);
		else           t = fprintf(pf,"%t%d\n",i+20,a);
		if ( t ) { errmsgio("fputlstruct","EA110"); break; }
		if ( !isatom(a) ) {
			t = fputlstruct(a,pf);
			if ( t ) break;
		}
		L = lred( L );
	}

	i = i - 3;

	if ( t ) return(ERROR);
	else return(t);
}
