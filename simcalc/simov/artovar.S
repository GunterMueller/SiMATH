/*C
			artovar( arstr, varstr )

	"array to variable".
	artovar(arstr,varstr); char *arstr, *varstr;
	X=artovar( arstr, varstr );

	Der Laufindex der Array-Variable wird ausgewertet.
	Auf varstr wird die Variable geschrieben.
	Laeuft artovar fehlerfrei ab, so ist X=1, sonst X=0.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      15.03.1994      S.Schmitt/U.Schneiders
H*/
/*cS
	artovar ruft auf: 
Sc*/
 
#include <_calc.h>

artovar( arstr, varstr )
char *arstr, *varstr;

{       /*** Deklarationen und Vorbesetzungen ***/
	single i=0,j=0, d, k;
	
	d=strlen(arstr);
	if(strchr(arstr,'[')==NULL) 
	{	strcpy(varstr,arstr);
		return(1);
	}
	while(*(arstr+i) == ' ') i++;
	if(!isalpha(*(arstr+i)))
	{	d=0;
		while(d<=j) 
		{	*(varstr+d) = '\0';
			d++;
		}
		return(0);
	}
	while(isalnum(*(arstr+i)))
	{	*(varstr+j) = *(arstr+i);
		j++;
		i++;
	}
	if(j>20) 
	{	d=0;
		while(d<=j) 
		{	*(varstr+d) = '\0';
			d++;
		}
		return(0);
	}
	while(*(arstr+i)==' ') i++;
	if(*(arstr+i)!='[') 
	{	d=0;
		while(d<j)
		{	*(varstr+d) = '\0';
			d++;
		}
		return(0);
	}
	else    /** Auswertung des Klammerausdrucks **/
	{
		obj c;
		char arg[MAXLV];
		init(c);
		*arg = '\0';

		k=1; d=i+1;
		while(*(arstr+d)!='\0') 
		{	if(*(arstr+d)=='[') k++;
			else if(*(arstr+d) == ']') k--;
			d++;
		}
		if(k)	
		{	d=0;
			while(d<j)
			{	*(varstr+d) = '\0';
				d++;
			}
			return(0);
		}

		absvalex(arstr+i+1, arg);
		i=i+strlen(arg)+2;
		while(*(arstr+i)!= '\0' && *(arstr+i)==' ') i++;
		if(*(arstr+i)!='\0') 
		{	d=0;
			while(d<j)
			{	*(varstr+d) = '\0';
				d++;
			}
			return(0);
		}
		d=0;
		k=0;
		while(*(arg+k)!='\0')
		{	if(*(arg+k)!=' ') 
			{	if(d!=k) *(arg+d) = *(arg+k);
				d++;
				k++;
			}
			else k++;
		}
		while(d<k) 
		{	*(arg+d)='\0';
			d++;
		}
		if(!error(arg))
		{	d=0;
			while(d<j)
			{	*(varstr+d) = '\0';
				d++;
			}
			return(0);
		}
		c=basad(arg);
		if(c==ERROR || c==ERROR-1)
		{	if( c== ERROR-1) mistake(32);
			d=0;
			while(d<j)
			{	*(varstr+d) = '\0';
				d++;
			}
			return(0);
		}
		if( lsecond(c) || !isatom(lfirst(c)) || (c=lfirst(c))<0 || c>= 10000 )
		{	
			mistake(307);
			d=0;
			while(d<j)
			{	*(varstr+d) = '\0';
				d++;
			}
			return(0);
		}
		*(varstr+j) = '['; j++;
		sputi(c, varstr+j); j++;
		if(c>=10) j++;
		if(c>=100) j++;
		if(c>=1000) j++;
		*(varstr+j)=']';
		*(varstr+j+1) = '\0';
		return(1);
	}
}
