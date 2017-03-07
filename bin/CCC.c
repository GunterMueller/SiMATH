#include "../include/smconfig.h"

#include <stdio.h>
#include <time.h>
#include <string.h>				  /* for strcat() and things like that */
#include <sys/param.h>				  /* MAXPATHLEN should be defined here */

#ifdef HAVE_UNISTD_H
#include <unistd.h>				  /* at least on some hosts, access() needs this */
#endif

#ifdef ___APOLLO
#ifndef R_OK
#define R_OK 4					  /* Apollos know about access(), but you have to define R_OK by
						   * yourself. Strange. */
#endif
#endif

 /* - fix me - */

 /*
  * Some of the following #define's are also used in SM.c. It is probably better to define these things only once
  * and include the stuff in SM.c as well as in CCC.c. Some of the functions used here are quite similar to
  * functions used in SM.c.
  */

#define MAX_CFLAGS 64				  /* the maximal number of characters in CFLAGS */
#define MAX_CMDS_LENGTH 1024			  /* the maximal length of a line in the commands file */
#define MAX_COMMAND_LENGTH 2048			  /* the maximal length of a command given to my_system() */
#define MAX_CONTENT_LENGTH 1024			  /* (more or less) the maximal length of a line in the commands */
#define MAX_CPPFLAGS 1024			  /* the maximal number of characters in CPPFLAGS */
#define MAX_LDPATH 1024				  /* the maximal number of characters in LDPATH */
#define MAX_LDFLAGS 1024			  /* the maximal number of characters in LDFLAGS */
#define MAX_NAME_LENGTH 64			  /* the maximal length of the name of a SIMATH program */
#define MAX_TOKEN_LENGTH 32			  /* the maximal length of the first word read from the commands */

#define strcat2(s, a, b) (*s='\0', strcat(strcat(s, a), b))

FILE           *fout;				  /* apparently, compiler messages are written to this file */
FILE           *commands_file;			  /* this is `.SM.cmds' */

char            name[MAX_NAME_LENGTH];		  /* the name of the program to compile */
char            name_c[MAX_NAME_LENGTH];	  /* `name' including a `.c' extension */
char            name_x[MAX_NAME_LENGTH];	  /* `name' including a `.x' extension */
char            name_P[MAX_NAME_LENGTH];	  /* `name' including a `.P' extension */
char            name_S[MAX_NAME_LENGTH];	  /* `name' including a `.S' extension */
char            MSG[MAX_NAME_LENGTH];		  /* messages from the compiler */
char            ERR[MAX_NAME_LENGTH];		  /* error messages form the compiler */
char            SM_pre[MAX_COMMAND_LENGTH];	  /* the command string for the first preprocessor */
char            SM_preV3_1[MAX_COMMAND_LENGTH];	  /* the command string for the second preprocessor */
char            C[MAX_COMMAND_LENGTH];		  /* the command string for the compiler */
char            c[MAX_COMMAND_LENGTH];		  /* something similar */

char            CC_CMD[MAX_TOKEN_LENGTH];
char            SM_PREV3_PATH[MAXPATHLEN];
char            SM_PRE_PATH[MAXPATHLEN];
char            CPPFLAGS[MAX_CPPFLAGS];
char            CFLAGS[MAX_CFLAGS];
char            LDPATH[MAX_LDPATH];
char            LDFLAGS[MAX_LDFLAGS];

char            SM_CMDS[MAXPATHLEN];

char            cmds_line[MAX_CMDS_LENGTH];
char            token[MAX_TOKEN_LENGTH];
char            content[MAX_CONTENT_LENGTH];

sm_time(fout)
    FILE           *fout;
{
    time_t            l, *pl, time();
    struct tm      *ptr, *localtime();
    int             hour, min, sec;

    pl = &l;
    time(pl);
    ptr = localtime(pl);
    hour = ptr->tm_hour;
    min = ptr->tm_min;
    sec = ptr->tm_sec;
    fprintf(fout, "%d:%d%d:%d%d\n\n", hour, min / 10, min % 10, sec / 10, sec % 10);
}

void            get_commands(cmds_file)
    char           *cmds_file;
{

#ifdef TEST
    printf("get_commands: trying to read commands form `%s\'\n", SM_CMDS);
#endif

    commands_file = fopen(cmds_file, "r");
    while (fgets(cmds_line, MAX_CMDS_LENGTH, commands_file) != NULL) {
	strcpy(token, strtok(cmds_line, " "));
	strcpy(content, strtok(NULL, "\n"));
	if (strcmp(token, "CC_CMD") == 0)
	    strcpy(CC_CMD, content);
	else if (strcmp(token, "SM_PREV3_PATH") == 0)
	    strcpy(SM_PREV3_PATH, content);
	else if (strcmp(token, "SM_PRE_PATH") == 0)
	    strcpy(SM_PRE_PATH, content);
	else if (strcmp(token, "CPPFLAGS") == 0)
	    strcpy(CPPFLAGS, content);
	else if (strcmp(token, "CFLAGS") == 0)
	    strcpy(CFLAGS, content);
	else if (strcmp(token, "LDPATH") == 0)
	    strcpy(LDPATH, content);
	else if (strcmp(token, "LDFLAGS") == 0)
	    strcpy(LDFLAGS, content);
    }
    fclose(commands_file);

#ifdef TEST
    printf("get_commands: setting CC_CMD to `%s\'\n", CC_CMD);
    printf("get_commands: setting SM_PREV3_PATH to `%s\'\n", SM_PREV3_PATH);
    printf("get_commands: setting SM_PRE_PATH to `%s\'\n", SM_PRE_PATH);
    printf("get_commands: setting CPPFLAGS to `%s\'\n", CPPFLAGS);
    printf("get_commands: setting CFLAGS to `%s\'\n", CFLAGS);
    printf("get_commands: setting LDPATH to `%s\'\n", LDPATH);
    printf("get_commands: setting LDFLAGS to `%s\'\n", LDFLAGS);
#endif

}

main(argc, argv)
    int             argc;
    char           *argv[];
{
    int             g1 = 0, g2 = 0, g3 = 0;	  /* three flags storing the existence of the commands files */
    int             counter, a;

    sprintf(SM_CMDS, "%s/etc/SM.cmds", SM_HOME);
    if (access(SM_CMDS, R_OK) == 0) {
	get_commands(SM_CMDS);
	g1 = 1;
    }
    sprintf(SM_CMDS, "%s/.SM.cmds", getenv("HOME"));
    if (access(SM_CMDS, R_OK) == 0) {
	get_commands(SM_CMDS);
	g2 = 1;
    }
    sprintf(SM_CMDS, ".SM.cmds");
    if (access(SM_CMDS, R_OK) == 0) {
	get_commands(SM_CMDS);
	g3 = 1;
    }

    if ((g1 == 0) && (g2 == 0) && (g3 == 0)) {
	printf("SM: cannot access command files: something's wrong ...\n");
	exit(1);
    }

    /*
     * We print an error message if CCC gets exactly one argument.
     */

    if (argc == 1) {
	printf("%s: usage: %s name [mod1, mod2, ... , modn]\n", argv[0], argv[0]);
	printf("%s: `name.S' is the source file.\n", argv[0]);
	printf("%s: `%s/modlib/libmodi.a' is the i-th object library.\n", argv[0], SM_HOME);
	exit(1);
    }

    /*
     * This reads name of the program to be compiled.
     */

    strcpy(name, *++argv);
    argv++;
    argc -= 2;

    /*
     * We open the file storing the messages from the compiler.
     */

    strcat2(MSG, name, "_M");
    fout = fopen(MSG, "w");
    if (fout == NULL) {
	printf("Can't open `%s'.\n", MSG);
	exit(3);
    }

    strcat2(ERR, name, "_CC");

    /*
     * Create all the strings needed.
     */

    sprintf(name_S, "%s.S\0", name);
    sprintf(name_P, "%s.P\0", name);
    sprintf(name_c, "%s.c\0", name);
    sprintf(name_x, "%s.x\0", name);
    sprintf(SM_pre, "%s %s %s\0", SM_PRE_PATH, name_S, name_P);
    sprintf(SM_preV3_1, "%s %s %s\0", SM_PREV3_PATH, name_P, name_c);
    sprintf(c, "%s %s %s -o %s %s %s\0", CC_CMD, CPPFLAGS, CFLAGS, name_x, name_c, LDPATH);

    /*
     * Here we create a string from the array of libraries given to CCC as arguments.
     */

    for (counter = 1; counter <= argc; counter++)
	sprintf(c, "%s -l%s", c, *argv++);

    sprintf(c, "%s %s 2> %s\0", c, LDFLAGS, ERR);

#ifdef TEST
    printf("CCC: SM_pre = \"%s\"\n", SM_pre);
    printf("CCC: SM_preV3_1 = \"%s\"\n", SM_preV3_1);
    printf("CCC: c = \"%s\"\n", c);
#endif

    fprintf(fout, "\nSM preprocessor started for \"%s\" at  ", name);
    sm_time(fout);
    if (!system(SM_pre) && !system(SM_preV3_1)) {
	fprintf(fout, "\nSM preprocessor terminated correctly for \"%s\" at  ", name);
	sm_time(fout);
	fprintf(fout, "\nCompiler started for \"%s\" at  ", name);
	sm_time(fout);
	fclose(fout);
	a = system(c);
	fout = fopen(MSG, "a");
	if (fout == NULL) {
	    printf("Can't open `%s'.\n", MSG);
	    exit(3);
	}
	if (!a) {
	    unlink(ERR);
	    fprintf(fout, "\nCompiler terminated correctly for \"%s\" at  ", name);
	}
	else
	    fprintf(fout, "\nCompiler terminated incorrectly for \"%s\" at  ", name);
    }
    else
	fprintf(fout, "\nSM preprocessor terminated incorrectly for \"%s\" at  ", name);
    sm_time(fout);
    unlink(name_P);
    unlink(name_c);
    fclose(fout);
    strcat2(ERR, "cat ", MSG);
    system(ERR);
    unlink(MSG);
    exit(0);
}
