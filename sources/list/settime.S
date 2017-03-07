/*M
.SH NAME
settime - set time

.SH SYNOPSIS
.nf
#include<_ec3.h>

int settime()

.SH DESCRIPTION
settime() returns the time that has elapsed
since the last call to settime() in 1/100 sec.
At the first call, the time that has elapsed
since the start of the program is returned.

.SH SEE ALSO
stoptime
M*/

/*H
	Version 1      	18.03.1987      R. Boeffgen
	Version 2      	07.12.1989      einheitl. Version fuer MX2(+), SUN und
					Apollo. PS
	Version 3	07.10.1994	return-Anweisung geaendert, damit das
					Ergebnis auch fuer sehr lang laufende
					Prozesse korrekt bleibt. MP
	Version 4	10.10.1995	Neue Doku und parsen nach float bei 
					Ausgabe MC.
	Version 5	27.04.96	HZ is defined in the SIMATH header
					_list.h. MP
   DATE settime       : 890501.900101.941201.951201.960601
H*/

# include <_list.h>   

single settime ( )
{
	struct tms buffer;
	single tdiff, tnow;
   /***    Ausgangszeit als mit Null vorbelegte static-Definition    ***/
	static tlast;
   /***    aktuelle Rechenzeit feststellen    ***/
	times( &buffer );
	tnow = buffer.tms_utime;
   /***    Zeitdifferenz ausgeben und aktuelle Zeit speichern    ***/
	tdiff = tnow - tlast;
	tlast = tnow;
	return( (int) (((float) tdiff) * 100.0) / ((float) HZ ));
}
