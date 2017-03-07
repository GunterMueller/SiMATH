/*C
			getline( s, vorb )

	"getline in GNU-version".
	char *getline( s, vorb ); char *s; single vorb;
	str = getline( s, vorb );

	Falls vorb = 0, enthaelt s das Promptzeichen. getline liest
	mit Hilfe von readline eine Zeile ein. Sie wird an den
	history-Speicher uebergeben und mittels str zurueckgegeben.
	In diesem Fall realisiert initgnu() das completion der
	vordefinierten simcalc-Worte.
	Ist vorb = 1, wird der String s dem history-Speicher
	uebergeben und unveraendert zurueckgegeben.
C*/
/*H
	Version  1      28.09.1993      S.Schmitt/U.Schneiders
	Version  1.1	03.11.1994	S.Schmitt/U.Schneiders
					gemaess readline-2.0 (fileman.c)
					Function -> CPPFunction
					dupstr neu
	Version  2      06.03.1996      S.Schmitt (getgnu -> getline,
						   xmalloc -> malloc)
H*/

#include <_calc.h>
#include <readline/readline.h>

char *dupstr (s)
char *s;
{
   char *r;
   r = malloc (strlen (s) + 1);
   strcpy (r, s);
   return (r);
}

char *command_generator(text,state)
char *text;
int state;
{
	static int i,len;
	char *name;
	
	if(!state)
	{
		i=1;
		len = strlen(text);
	}
	while((name = varlist[i].varname)&& ((i++)<MXNUM))
	{
		if(strncmp(name,text,len)==0)
			return(dupstr(name));
	}
	return((char *)NULL);
}


char **fileman_completion(text,start,end)
char *text;
int start,end;
{
	char **matches;
	char *command_generator();
	
	matches = (char **)NULL;
	matches = completion_matches(text,command_generator);
	return(matches);
}

initgnu()
{
	char **fileman_completion();
	rl_readline_name = "> ";
	rl_attempted_completion_function = (CPPFunction *)fileman_completion;
}

char *getline( s, vorb )
char *s;
single vorb;
{       
	char *line_read;
	char *readline();
	single i;
	if(!vorb || vorb == (-1))
	{ 	
		initgnu();
		line_read = readline(s);
		if(line_read==NULL) line_read = "quit";
		else
		{ 	while(*line_read == ' ') line_read++;
			i=strlen(line_read)-1;
			while(i>0 && line_read[i]==' ')  i--;
			line_read[++i] = '\0';	
			if(line_read == NULL) line_read = "quit";
		}
		if( !vorb && line_read && *line_read && *line_read != '&')	
		add_history( line_read );
		return(line_read);
	}
	else
	{
		add_history(s);
		return(s);
	}	
}
/*initgnu()
{
	char **fileman_completion();
	rl_readline_name = "> ";
	rl_attempted_completion_function = (CPPFunction *)fileman_completion;
} */

/*char **fileman_completion(text,start,end)
char *text;
int start,end;
{
	char **matches;
	char *command_generator();
	
	matches = (char **)NULL;
	matches = completion_matches(text,command_generator);
	return(matches);
} */

/*char * command_generator(text,state)
char *text;
int state;
{
	static int i,len;
	char *name;
	
	if(!state)
	{
		i=1;
		len = strlen(text);
	}
	while((name = varlist[i].varname)&& ((i++)<MXNUM))
	{
		if(strncmp(name,text,len)==0)
			return(name);
	}
	return((char *)NULL);
} */
