/*M
.SH NAME
madel1rc - matrix delete 1 row and 1 column

.SH SYNOPSIS
.nf
#include<_matr1.h>

obj madel1rc(pM, i, j)
matrix *pM;
single i, j;

.SH DESCRIPTION
madel1rc() deletes the row i and the column j
from the matrix *pM and returns 0.

.PP
.TP 4
.B M
is an mxn matrix.
.TP 4
.B i
is a row index 1 <= i <= m.
.TP 4
.B j
is a column index 1 <= j <= n.
M*/
/*H
	Version 1	25.02.1992	Th. Weis
	Version	2	18.03.1992	neu.  Georg Lay
   DATE madel1rc      : 920331
H*/

#include <_matr1.h>

obj madel1rc (pM,i,j)
matrix 		*pM;
single 		    i,j;
  {
  obj	m_ij;
  list  h,l;

  bind (*pM);
  init (m_ij);

  m_ij = ledel( pM  ,i);
  m_ij = ledel(&m_ij,j);

  madelsc (pM,list1 (j));

  return (m_ij);
  }
