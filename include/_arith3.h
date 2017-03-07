# ifndef __POL3__
# include <_list.h>
# include <_arith1.h>
# include <_ec1.h>
# include <_pol1.h>
# include <_matr1.h>
# include <_pol2.h>
# include <_arith2.h>
# include <_ec2.h>
# include <_matr2.h>
# include <_pol3.h>
# endif
# define __ARITH3__

# define                   rfunc  int
# define                   afunc  int

# define        pmstorfmsp1(p,P)  pitorfr(1,P)

# define    fputrfmsp1(p,R,V,pf)  fputrfr(1,R,V,pf)

# define          getrfmsp1(p,V)  fgetrfmsp1(p,V,stdin)
# define             getrfr(r,V)  fgetrfr(r,V,stdin)

# define        putrfmsp1(p,R,V)  fputrfr(1,R,V,stdout)
# define           putrfr(r,R,V)  fputrfr(r,R,V,stdout)
