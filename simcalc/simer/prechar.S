/*C
			prechar( str, pos )

	"preceding character".
	prechar(str, pos)  char *str; single pos;

	Das Zeichen vor *(str+pos), das ungleich ' ' ist, wird 
	zurueckgegeben. 
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      20.10.1993      S.Schmitt/U.Schneiders
H*/
/*cS
	prechar ruft auf:
		  Macros:
Sc*/
 
#include <_calc.h>

char prechar( str, pos )
char *str;
single pos;
{     	single i=1;
	while(i<=pos && *(str+pos-i) == ' ') i++;
	if(i>pos) return('\0');
	else return(*(str+pos-i));
}
