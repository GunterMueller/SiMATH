/*M
.SH NAME
stoptime - stop and print time

.SH SYNOPSIS
.nf
#include<_ec3.h>

int stoptime(a)
int a; 

.SH DESCRIPTION
stoptime() returns the time that has elapsed
since the last call to stoptime(0) in 1/100 sec.
For any non-zero value a, the result will
be printed to stdout.
.PP
.TP 4
.B a
is a flag where for a==0 the current time will be
remembered whereas for a<0 the result will
be written as 'xxx cs' respectively as 'xx
h xx m xx s xx cs' for a>0.  

.SH EXAMPLES
.nf
stoptime(13) may result in 2 h 18 m 23 s 10 cs.
stoptime(-3) may result in 1995 cs.

.SH SEE ALSO
settime
M*/

/*H 
	Version 1	09.09.93	Marc Conrad         
	Version 2	11.10.95	fuer lange Laufzeiten. MC
	Version 3	07.02.96	falschen Rueckgabewert 
					fuer a>0 korrigiert. PS
	Version 4	27.04.96	HZ is defined in the SIMATH header
					_list.h. MP
   DATE stoptime      : 931130.951201.960201.960601
H*/

# include <_list.h>   

single stoptime ( a )       
single a;
{
	struct tms buffer;
	single tdiff, tnow, h, m, s, cs;
   /***    "Ausgangszeit", initialized by 0    ***/
	static tstoplast;
   /***    computing current time    ***/  
	times( &buffer );
	tnow = buffer.tms_utime;
   /***    printing time difference and storing current time    ***/
	tdiff = (int) ( ((float) (tnow - tstoplast)) * ((float) 100) / ((float) HZ));
	    /* tdiff is C integer for processes running at most 248 days. */
        if (a == 0) tstoplast = tnow;      
        else if (a < 0 ) printf(" t(%d): %d cs\n",-a,tdiff);     
	else {
		s = tdiff/100;
		cs = tdiff%100;
		h = s/3600;
		s -= h*3600;
		m = s/60;
		s = s%60;
                printf (" t(%d): %d h %2d m %2d s %2d cs\n",a,h,m,s,cs);
	}
	return( tdiff );
}



