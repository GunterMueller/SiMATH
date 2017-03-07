/*C
			scr_page( name )

	"screen page"
	scr_page( name )  char *name;

	scr_page simuliert "more" fuer die Datei name.
	Mit "_ERR_NR_" gekennzeichnete Fehlernummern werden dabei 
	durch die zugehoerigen in calcul/calc.errors enthaltenen 
	Fehlermeldungen ersetzt.
C*/
/*H
	Version  1      14.02.1990      V.Schwinn
	Version  2	12.01.1993	Pascale Serf
	Version  3      20.07.1995	S.Schmitt/U.Schneiders
H*/


#include <_calc.h>

# undef fgets
extern char *fgets();
extern FILE *fopen();
int scr_laenge, weiter, z_nr;
FILE *simpf;

#define Z_LAENGE 128

static error_prin(err_str,na)
char *err_str,*na;
{
	FILE *pf;
	char zeile[Z_LAENGE], *t, file[100], nz[Z_LAENGE], nzeile[Z_LAENGE];
	int len = strlen(err_str), anz, i, j, k, l, nlen, namlen;

	/* Datei "calc.errors" im Verzeichnis SM_HOME/calcul oeffnen */
	sprintf(file,"%s%s",SM_HOME,"/calcul/calc.errors");
	if ( ( pf = fopen(file,"r") ) == NULL )  {

/****** LINE 
		strcpy(nz,"\n*** scr_page: Can't open \"");
		sprintf(nz, "%s%s",file,"\".\n");
		nlen=strlen(nz);
		j=0;
		{	if(LINELN)
			{	if(nz[i]=='\n') outct=0;
				else outct++;
			}
			nzeile[j]=nz[i];
			j++;
			if(LINELN && LINELN==outct)
			{	nzeile[j]='\n';
				outct=0;
				j++;
			}
		}
		nzeile[j] = '\0';
		fprintf(simpf, nzeile);
LINE ******/

		fprintf(simpf,"\n*** scr_page: Can't open \"%s\".\n",file);
		return;
	}

	/* Fehlerstring suchen und zugehoerige Fehlermeldung schreiben */
	while ( (t = fgets(zeile,Z_LAENGE,pf))  &&  strncmp(zeile,err_str,len) );
	if (t)  {
		sscanf(zeile, "%11s %1d", err_str, &anz);
		for ( i=0 ; i<=anz ; i++ ) {
			if ( i==0 ) 
			{

/***** LINE 
				nlen=strlen(nz);
				for(j=0;j<nlen;j++) nz[j]='\0';
				nlen=strlen(nzeile);
				for(j=0;j<nlen;j++) nzeile[j]='\0';

				strcpy(nz,"                Error message:\n");
				nlen=strlen(nz);
				j=0;
				for(k=0;k<nlen;k++)
				{	if(LINELN)
					{	if(nz[k]=='\n') outct=0;
						else outct++;
					}
					nzeile[j]=nz[k];
					j++;
					if(LINELN && LINELN==outct)
					{	nzeile[j]='\n';
						outct=0;
						j++;
					}
				}
				nzeile[j] = '\0';
				fprintf(simpf,nzeile);
LINE *****/
				fprintf(simpf,"                Error message:\n");
			}
			else {
/***** LINE 
				nlen=strlen(nz);
				for(j=0;j<nlen;j++) nz[j]='\0';
				nlen=strlen(nzeile);
				for(j=0;j<nlen;j++) nzeile[j]='\0';
LINE *****/


				fgets(zeile,Z_LAENGE,pf);
/****** LINE 
				strcpy(nzeile, "                ");
				strcat2(nz,nzeile,zeile);
				nlen=strlen(nz);
				j=0;
				for(k=0;k<nlen;k++)
				{	if(LINELN)
					{	if(nz[k]=='\n') outct=0;
						else outct++;
					}
					if(nz[k]!='%'|| k == nlen-1 || nz[k+1]!='s')
					{	nzeile[j]=nz[k];
						j++;
					}
					else
					{	k++;
						outct--;
						namlen=strlen(na);
						for(l=0;l<namlen;l++)
						{	
							if(LINELN && LINELN==outct)
							{	nzeile[j]='\n';
								outct=0;
								j++;
							}
							nzeile[j]=na[l];
							j++;
							if(LINELN) outct++;
						}
					}
					if(LINELN && LINELN==outct)
					{	nzeile[j]='\n';
						outct=0;
						j++;
					}
				}
				nzeile[j] = '\0';
				fprintf(simpf,nzeile);
LINE *******/
				if(!strlen(na)) 
				      fprintf(simpf,"                %s",zeile);
                                else
                                {     fprintf(simpf,"                ");
                                      fprintf(simpf,zeile,na);
                                }
			}
		}
	}
	else 
	{
		fprintf(simpf,"\n*** scr_page: unknown error string \"%s\"\n", err_str);
	}
	fclose(pf);
}

scr_page(name)                   
char *name;
{	
	char zeile[Z_LAENGE],neuz[Z_LAENGE], err_str[16];
	char st[35];
	FILE *pf;
	single i,j,k,len;
	*st = '\0';
	
	if( !isatty(fileno(stdin)) ) scr_laenge = 1000;
	else scr_laenge = 21;

	pf = fopen(name, "r");
	if (pf == NULL) printf("\n\nCan't open %s.\n\n", name);	
        else
        {	
		simpf=fopen(dhelp,"w");
		z_nr   = 0;       
                weiter = 1;

		do
		{
			if (fgets(zeile, Z_LAENGE, pf) == NULL) break;

			if ( !strncmp(zeile, "_ERR_NR_", 8) )
			{
				strncpy(err_str, zeile, 11); err_str[11] = '\0';
				j=0;
				if(*(zeile+11)!='\0' && *(zeile+11)=='_')
				{	while(*(zeile+12+j)!='\0' && *(zeile+12+j)!='_')
					{	st[j]= *(zeile+12+j);
						j++;
					}
					st[j]='\0';
				}
				error_prin(err_str,st);
				for(i=0;i<=j;i++) st[i]='\0';
				continue;
			}

			len = strlen(zeile);

			j=0;
			for(i=0;i<len;i++)
			{	
/**** LINE 			if(LINELN)
				{	if(zeile[i] == '\n') outct = 0;
					else outct++;
				}
LINE *****/
				if(zeile[i] != '\t')
				{	neuz[j] = zeile[i];
					j++;
				}
				else
				{ 	for(k=0;k<8;k++)
						neuz[j] = ' ';
					j=j+8;
/***** LINE 
					{	if(LINELN && LINELN==outct)
						{	neuz[j] = '\n';
							outct=0;
							j++;
						}
						neuz[j] = ' ';
						j++;
						if(LINELN) outct++;
					}
LINE *******/
					
				}
/**** LINE 
				if(LINELN && LINELN==outct)
				{	neuz[j] = '\n';
					outct=0;
					j++;
				}	
LINE ******/
			}
			neuz[j] = '\0';
			fprintf(simpf,neuz);
		}
		while (weiter);

		fclose(pf);
		fflush(simpf);
		fclose(simpf);
		strcat3(st,comm," ",dhelp);
		system(st);
		unlink(dhelp);
        }
}
