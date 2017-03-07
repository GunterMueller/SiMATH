/*C
			isminus( hilf )

	"isminus".
	char isminus; char hilf;
	z = isminus(a);

	isminus entscheidet ob hinter dem Zeichen hilf ein unaeres
	oder ein binaeres Minus folgt.
	Der include-file <_list.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
H*/
/*cS
	isminus ruft auf:

		  Macros:
Sc*/

#include <_list.h>

char isminus( hilf )
char hilf;

{
	char z = '-';
	switch ( hilf ) {
		case '>':
		case '<':
		case '=':
		case '(':
		case '[':
		case '{':
		case '+':
		case '-':
		case '*':
		case '/':
		case ':':
		case '^':
		case ',': z = '#';
			  break;
	}
	return( z );
}
