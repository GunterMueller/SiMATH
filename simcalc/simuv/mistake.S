/*C
				mistake ( nr )
				mistake1( nr, arg1 )
				mistake2( nr, arg1, arg2 )
				
	"mistake"
	mistake*( nr )  single nr; [single arg1;] [single arg2;]

	nr ist eine in der Datei calcul/calc.errors enthaltene 
	Fehlernummer.
	mistake* gibt die zugehoerige Fehlermeldung aus.
	arg1 (und arg2) sind Argumente, die der Ausgabefunktion printf
	uebergeben werden, falls die auszugebende Fehlermeldung ein
	(bzw. zwei) '%'-Zeichen enthaelt.
C*/
/*H
	Version  1      22.06.1988      C.Hollinger/U.Schneiders
	Version  2	12.01.1993	Pascale Serf
	Version  2.1	03.01.1994	U.Schneiders (double->single)
					wegen HP
H*/

#include <_calc.h>

# define Z_LAENGE 128
char err_str[16];

static error_print(err_str,arg1,arg2)
char *err_str;
single arg1,arg2;
{
# undef fgets
	extern char *fgets();
	extern FILE *fopen();
	FILE *pf;
	char zeile[Z_LAENGE], *t, file[100];
	char str[1024];
	single len = strlen(err_str), anz, i;

	/* Datei "calc.errors" im Verzeichnis SM_HOME/calcul oeffnen */
	sprintf(file,"%s%s",SM_HOME,"/calcul/calc.errors");
	if ( ( pf = fopen(file,"r") ) == NULL )  {
		printf("\n*** mistake: Can't open \"%s\".\n",file);
		return;
	}

	/* Fehlernummer suchen und zugehoerige Fehlermeldung schreiben */
	while ( (t = fgets(zeile,Z_LAENGE,pf))  &&  strncmp(zeile,err_str,len) );
	if (t)  {
		sscanf(zeile, "%11s %1d", err_str, &anz);
		for ( i=1 ; i<=anz ; i++ ) {
			if ( i == 1 ) sprintf(str, " ***** Error: ");
			else          strcat (str, "              ");
			*zeile = '\0';
			fgets(zeile,Z_LAENGE,pf);
			strcat(str, zeile);
		}
		printf(str, arg1, arg2); /* printf statt printw, damit SIMATH- */
					 /* Typen korrekt ausgegeben werden    */
		if ( ps ) {
			fprintf(datei, "out: ");
			fprintf(datei, str+5, arg1, arg2);
		}
	}
	else    printf("\n*** mistake: unknown error string \"%s\"\n", err_str);
	fclose(pf);
}

mistake(nr)
single nr;
{
	sprintf(err_str,"_ERR_NR_%d%d%d",nr/100,nr%100/10,nr%10);
	error_print(err_str,0,0);
}


mistake1(nr,arg1)
single nr;
single arg1;
{
	sprintf(err_str,"_ERR_NR_%d%d%d",nr/100,nr%100/10,nr%10);
	error_print(err_str,arg1,0);
}


mistake2(nr,arg1,arg2)
single nr;
single arg1,arg2;
{
	sprintf(err_str,"_ERR_NR_%d%d%d",nr/100,nr%100/10,nr%10);
	error_print(err_str,arg1,arg2);
}
