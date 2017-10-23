#include "../include/smconfig.h"
#include <stdio.h>

 /*
  * INCLUDES
  */

 /* - fix me - */

 /*
  * It is not clear anymore what all these headers are good for.
  * It seems to be a good idea to remove all the
  * headers which are not used or not used anymore.
  */

#include <ar.h>					  /* required somewhere in isinarchive() and maybe somewhere else */
#include <ctype.h>
#include <fcntl.h>
#include <setjmp.h>				  /* reqired by setjmp() and longjmp() */
#include <string.h>				  /* strcat() should be declared here */
#include <signal.h>				  /* required to catch SIGINT */
#include <sys/file.h>
#include <sys/param.h>				  /* MAXPATHLEN should be defined here */
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>				  /* required by wait() in my_system() */

#ifdef HAVE_MALLOC_H
#include <malloc.h>				  /* reqired by malloc() (of course). Apollos don't have malloc.h */
#endif

#ifdef HAVE_SGTTY_H
#include <sgtty.h>
#endif

#ifdef HAVE_UNISTD_H
#include <unistd.h>				  /* at least on some hosts, access() needs this */
#endif

#ifdef TIME_WITH_SYS_TIME
#include <sys/time.h>
#include <time.h>
#else
#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#else
#include <time.h>
#endif
#endif

 /*
  * DEFINES
  */

#ifdef ___APOLLO
#ifndef R_OK
#define R_OK 4					  /* Apollos know about access(), but you have to define R_OK by
						   * yourself. Strange. */
#endif
#endif

#define defaults_file_name ".SM.default"	  /* the name of the file storing libraries and file names */
#define	DEVELOP_FILE_NAME "develop"		  /* the name of the file used while writing the
						   * documentation in .man or .tex format. */
#define	STR_SIZE 256				  /* used somewhere in the functions dealing with the
						   * documentation */
#define MAX_SM_CMD 64				  /* the maximal number of SM commands */
#define MAX_DATELINE 16				  /* the maximal length of a date line entry */
#define MAX_NAME_LENGTH 64			  /* the maximal length of the name of a SIMATH program */
#define MAX_LIB_LENGTH 64			  /* the maximal length of the name of an object library */
#define MAX_SRC_LIB_LENGTH 1024			  /* the maximal length of the path to a source library */
#define MAX_DOC_LENGTH 64			  /* the maximal length of the string describing the documentation
						   * style */
#define MAX_HELP_LENGTH 256			  /* the length of something used in the documentation procedures */
#define MAX_ARCHIVE_LENGTH 128			  /* used in isinarchive() and in getheader() */
#define MAX_V_LENGTH 16				  /* the maximal length of the version number */
#define MAX_TOKENS 64				  /* the maximal number of tokens (separated by blanks) in a line
						   * of the commands file */
#define MAX_CMDS_LENGTH 1024			  /* the maximal length of a line in the commands file */
#define MAX_COMMAND_LENGTH 2048			  /* the maximal length of a command given to my_system() or
						   * parse_command_string() */
#define MAX_CONTENT_LENGTH 1024			  /* (more or less) the maximal length of a line in the commands
						   * file */
#define MAX_CPPFLAGS 1024			  /* the maximal number of characters in CPPFLAGS */
#define MAX_CFLAGS 64				  /* the maximal number of characters in CFLAGS */
#define MAX_LDPATH 1024				  /* the maximal number of characters in LDPATH */
#define MAX_LDFLAGS 1024			  /* the maximal number of characters in LDFLAGS */
#define MAX_XDVIFLAGS 1024			  /* the maximal number of characters in XDVIFLAGS */
#define MAX_ROFFFLAGS 1024			  /* the maximal number of characters in ROFF_FLAGS */
#define MAX_PAGEROFFFLAGS 1024			  /* the maximal number of characters in PAGEROFF_FLAGS */
#define MAX_TOKEN_LENGTH 32			  /* the maximal length of the first word read from the commands */

 /*
  * These are required somewhere in functions dealing with the doumentation.
  */

#define	SOURCE		1
#define DEVELOP		2
#define LATEX_DOKU	3
#define MAN_DOKU	4
#define SHORT		5

#define MAX_KEYS	9

 /*
  * Some macros for building big strings from smaller strings. Why not use sprintf()?
  */

#define strcat2(s, a, b) (*s = '\0', strcat(strcat(s, a), b))
#define strcat3(s, a, b, c) strcat(strcat2(s, a, b), c)
#define strcat4(s, a, b, c, d) strcat(strcat(strcat2(s, a, b), c), d)

 /*
  * This macro checks if its first argument is a string of positive length.
  * It displays an error message (containing its second argument)
  * if the first argument is the empty string.
  */

#define isdefined(var, name) \
if (!var[0]) {printf("SM: name undefined\n"); break;}

 /*
  * This is executed if CTRL-D is pressed and gets reads EOF
  * in '^D', 'A', 'a', 'N', '?', '~/@', 'C'.
  * Of course Apollos want something special.
  */

#ifdef ___APOLLO
#define CTRL_D {clearerr(stdin); break;}
#else
#define CTRL_D {clearerr(stdin); putchar('\n'); break;}
#endif

 /*
  * DECLARATIONS
  */

 /*
  * Usually getenv() should be declared in <stdlib.h>.
  * Since on some systems (yes, Apollo) <stdlib.h> does not
  * exist, it might be better do declare getenv() explicitely.
  */

char           *getenv();

FILE           *commands_file;			  /* this is `.SM.cmds' */

jmp_buf         envnt;

int             af;				  /* used in isinarchive() and in getheader () */
int             key_cnt = 0;			  /* actual number of keys in keyword search */
int             success;			  /* used in isinarchive() and in getheader () */

char            version_nr[MAX_V_LENGTH];	  /* you guessed it */
char            LIB[MAX_SRC_LIB_LENGTH];	  /* the current source library */
char            lib[MAX_LIB_LENGTH];		  /* the cuurent library */
char            backup[MAX_CMDS_LENGTH];	  /* used to store intermediate results */
char            lib_long[MAXPATHLEN];		  /* the path to the current library */
char            b2[MAX_ARCHIVE_LENGTH];		  /* used in isinarchive() and in getheader() */
char            rline[MAX_CMDS_LENGTH];		  /* used to read some strings from the terminal, in particular
						   * additional libraries */
char            helptxt[MAX_HELP_LENGTH];	  /* used in the documentation procedures */
char            name[MAX_NAME_LENGTH];		  /* the name of the program without any extensions */
char            name_P[MAX_NAME_LENGTH];	  /* the name of the program including the extension .P */
char            name_S[MAX_NAME_LENGTH];	  /* the name of the program including the extension .S */
char            name_c[MAX_NAME_LENGTH];	  /* the name of the program including the extension .c */
char            name_o[MAX_NAME_LENGTH];	  /* the name of the program including the extension .o */
char            name_x[MAX_NAME_LENGTH];	  /* the name of the program including the extension .x */
char            cmd[MAX_CMDS_LENGTH];		  /* some commands are executed using system(cmd) */

 /*
  * Some paths to important SIMATH directories.
  */

char            SM_DOC[MAXPATHLEN];
char            SM_EXEC[MAXPATHLEN];
char            SM_CMDS[MAXPATHLEN];
char            SM_SH[MAXPATHLEN];
char            SM_SRC[MAXPATHLEN];
char            SM_HEADER[MAXPATHLEN];
char            SM_TMP[MAXPATHLEN];

 /*
  * Used in the documentation system.
  */

char            filename[MAXPATHLEN];
char            filename2[MAXPATHLEN];
char            filename3[MAXPATHLEN];
char		helpstr[MAXPATHLEN];

char            cmds_line[MAX_CMDS_LENGTH];
char            token[MAX_TOKEN_LENGTH];
char            content[MAX_CONTENT_LENGTH];

char            CC_PATH[MAXPATHLEN];
char            CC_CMD[MAX_TOKEN_LENGTH];
char            CPP_PATH[MAXPATHLEN];
char            CPP_CMD[MAX_TOKEN_LENGTH];
char            CCC_PATH[MAXPATHLEN];
char            CCC_CMD[MAX_TOKEN_LENGTH];
char            LPR_PATH[MAXPATHLEN];
char            LPR_CMD[MAX_TOKEN_LENGTH];
char            SM_PREV3_PATH[MAXPATHLEN];
char            SM_PREV3_CMD[MAX_TOKEN_LENGTH];
char            SM_PRE_PATH[MAXPATHLEN];
char            SM_PRE_CMD[MAX_TOKEN_LENGTH];
char            AR_PATH[MAXPATHLEN];
char            AR_CMD[MAX_TOKEN_LENGTH];
char		ROFF_CMD[MAX_TOKEN_LENGTH];
char		ROFF_FLAGS[MAX_ROFFFLAGS];
char            LS_PATH[MAXPATHLEN];
char            LS_CMD[MAX_TOKEN_LENGTH];
char            EMACS_PATH[MAXPATHLEN];
char            EMACS_CMD[MAX_TOKEN_LENGTH];
char            VI_PATH[MAXPATHLEN];
char            VI_CMD[MAX_TOKEN_LENGTH];
char            PAGE_PATH[MAXPATHLEN];
char            PAGE_CMD[MAX_TOKEN_LENGTH];
char		PAGE_ROFF_FLAGS[MAX_PAGEROFFFLAGS];
char            RANLIB_PATH[MAXPATHLEN];
char            RANLIB_CMD[MAX_TOKEN_LENGTH];

char            CPPFLAGS[MAX_CPPFLAGS];
char            CFLAGS[MAX_CFLAGS];
char            LDPATH[MAX_LDPATH];
char            LDFLAGS[MAX_LDFLAGS];

char            XDVI_CMD[MAX_TOKEN_LENGTH];
char            XDVI_PATH[MAXPATHLEN];
char            XDVIFLAGS[MAX_XDVIFLAGS];

char            KEY[MAX_KEYS+1][STR_SIZE];	  /* string for use in egrep  */

struct ar_hdr   header;				  /* who knows */

 /*
  * parse_command_string() takes a string command_string and
  * returns an array of strings suitable for my_system().
  */

parse_command_string(command_string, command_array, command_array_save)
    char           *command_string;
    char          **command_array;
    char          **command_array_save;
{
    char           *part;
    int             command_counter;

    for (command_counter = 0; command_counter < MAX_TOKENS; command_counter++) {
	command_array[command_counter] = command_array_save[command_counter];
    }

    command_counter = 0;
    part = strtok(command_string, " \n");
    strcat(part, "\0");
    strcpy(command_array[command_counter], part);
    while (1) {
	part = strtok(NULL, " \n");
	if (part == NULL)
	    break;
	else {
	    command_counter++;
	    strcat(part, "\0");
	    strcpy(command_array[command_counter], part);
	}
    }
    command_counter++;
    command_array[command_counter] = (char *) NULL;
}

 /*
  * my_system() does all the exec and fork stuff.
  * It might be a good idea to tell my_system to use execl() instead if execv(),
  * but at this moment it seems to be easier to convert a string of commands
  * to an array of commands as it is done in parse_command_string().
  */

int             my_system(command, flag, background)
    char          **command;
    int             flag, background;
{
    int             pid;

    /*
     * On Apollos, the wait() system call works in a different way.
     * There might be some other systems on which the
     * declaration of status as int causes problems.
     */

#ifdef ___APOLLO
    union wait      status;

#else
    int             status;

#endif

    int             i;
    int             retValue;

#ifdef TEST
    for (i = 0; command[i]; i++)
	fprintf(stderr, "my_system: arg[%d]: %s\n",
		i, command[i]);
#endif

    switch (pid = fork()) {
    case -1:
	perror("fork");
	retValue = (-1);
	break;
    case 0:
	command++;
	if (flag)
	    page(command);
	else {

#ifdef ___APOLLO

/*
 * The following construction is required for Apollo consoles.
 * It prevents Apollos from suppressing
 * error messages from the compiler ('o', 'c', 't', 'C', 'T').
 */

	    int             i;

	    for (i = 3; i <= 20; i++)
		close(i);
#endif
	    if (execv(command[-1], command)) {
		perror(command[-1]);
		exit(-1);
	    }
	}
    default:
	if (background)
	    retValue = 0;
	else {
	    while (wait(&status) != pid);

#ifdef ___APOLLO
	    retValue = status.w_retcode;
#else
	    retValue = WEXITSTATUS(status);
#endif

	}

	break;
    }
    return (retValue);
}

 /* - fix me - */

 /*
  * Currently, append_ext() is called much too often.
  * It should enough to call append_ext() whenever the file name
  * changes. On the other hand, append_ext() doesn't consume too much time.
  */

 /*
  * append_ext() appends the usual extension to name and writes
  * the new strings to appropriate arrays.
  */

void            append_ext()
{
    sprintf(name_P, "%s.P", name);
    sprintf(name_S, "%s.S", name);
    sprintf(name_c, "%s.c", name);
    sprintf(name_o, "%s.o", name);
    sprintf(name_x, "%s.x", name);
}

 /*
  * get_commmands() is called for `SM.cmds' in SM_HOME (if it exists),
  * then for `.SM.cmds' in the user's home directory (if it exists)
  * and finally for `.SM.cmds' in the current working directory (if it exists).
  */

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
	else if (strcmp(token, "CC_PATH") == 0)
	    strcpy(CC_PATH, content);
	else if (strcmp(token, "CPP_CMD") == 0)
	    strcpy(CPP_CMD, content);
	else if (strcmp(token, "CPP_PATH") == 0)
	    strcpy(CPP_PATH, content);
	else if (strcmp(token, "CCC_CMD") == 0)
	    strcpy(CCC_CMD, content);
	else if (strcmp(token, "CCC_PATH") == 0)
	    strcpy(CCC_PATH, content);
	else if (strcmp(token, "LPR_CMD") == 0)
	    strcpy(LPR_CMD, content);
	else if (strcmp(token, "LPR_PATH") == 0)
	    strcpy(LPR_PATH, content);
	else if (strcmp(token, "SM_PREV3_CMD") == 0)
	    strcpy(SM_PREV3_CMD, content);
	else if (strcmp(token, "SM_PREV3_PATH") == 0)
	    strcpy(SM_PREV3_PATH, content);
	else if (strcmp(token, "SM_PRE_CMD") == 0)
	    strcpy(SM_PRE_CMD, content);
	else if (strcmp(token, "SM_PRE_PATH") == 0)
	    strcpy(SM_PRE_PATH, content);
	else if (strcmp(token, "AR_CMD") == 0)
	    strcpy(AR_CMD, content);
	else if (strcmp(token, "AR_PATH") == 0)
	    strcpy(AR_PATH, content);
	else if (strcmp(token, "ROFF_CMD") == 0)
	    strcpy(ROFF_CMD, content);
	else if (strcmp(token, "ROFF_FLAGS") == 0)
	    strcpy(ROFF_FLAGS, content);
	else if (strcmp(token, "LS_CMD") == 0)
	    strcpy(LS_CMD, content);
	else if (strcmp(token, "LS_PATH") == 0)
	    strcpy(LS_PATH, content);
	else if (strcmp(token, "EMACS_CMD") == 0)
	    strcpy(EMACS_CMD, content);
	else if (strcmp(token, "EMACS_PATH") == 0)
	    strcpy(EMACS_PATH, content);
	else if (strcmp(token, "VI_CMD") == 0)
	    strcpy(VI_CMD, content);
	else if (strcmp(token, "VI_PATH") == 0)
	    strcpy(VI_PATH, content);
	else if (strcmp(token, "PAGE_CMD") == 0)
	    strcpy(PAGE_CMD, content);
	else if (strcmp(token, "PAGE_PATH") == 0)
	    strcpy(PAGE_PATH, content);
	else if (strcmp(token, "PAGE_ROFF_FLAGS") == 0)
	    strcpy(PAGE_ROFF_FLAGS, content);
	else if (strcmp(token, "RANLIB_CMD") == 0)
	    strcpy(RANLIB_CMD, content);
	else if (strcmp(token, "RANLIB_PATH") == 0)
	    strcpy(RANLIB_PATH, content);
	else if (strcmp(token, "CPPFLAGS") == 0)
	    strcpy(CPPFLAGS, content);
	else if (strcmp(token, "CFLAGS") == 0)
	    strcpy(CFLAGS, content);
	else if (strcmp(token, "LDPATH") == 0)
	    strcpy(LDPATH, content);
	else if (strcmp(token, "LDFLAGS") == 0)
	    strcpy(LDFLAGS, content);
	else if (strcmp(token, "XDVI_CMD") == 0)
	    strcpy(XDVI_CMD, content);
	else if (strcmp(token, "XDVI_PATH") == 0)
	    strcpy(XDVI_PATH, content);
	else if (strcmp(token, "XDVIFLAGS") == 0)
	    strcpy(XDVIFLAGS, content);
    }
    fclose(commands_file);

#ifdef TEST
    printf("get_commands: setting CC_CMD to `%s\'\n", CC_CMD);
    printf("get_commands: setting CC_PATH to `%s\'\n", CC_PATH);
    printf("get_commands: setting CPP_CMD to `%s\'\n", CPP_CMD);
    printf("get_commands: setting CPP_PATH to `%s\'\n", CPP_PATH);
    printf("get_commands: setting CCC_CMD to `%s\'\n", CCC_CMD);
    printf("get_commands: setting CCC_PATH to `%s\'\n", CCC_PATH);
    printf("get_commands: setting LPR_CMD to `%s\'\n", LPR_CMD);
    printf("get_commands: setting LPR_PATH to `%s\'\n", LPR_PATH);
    printf("get_commands: setting SM_PREV3_CMD to `%s\'\n", SM_PREV3_CMD);
    printf("get_commands: setting SM_PREV3_PATH to `%s\'\n", SM_PREV3_PATH);
    printf("get_commands: setting SM_PRE_CMD to `%s\'\n", SM_PRE_CMD);
    printf("get_commands: setting SM_PRE_PATH to `%s\'\n", SM_PRE_PATH);
    printf("get_commands: setting AR_CMD to `%s\'\n", AR_CMD);
    printf("get_commands: setting AR_PATH to `%s\'\n", AR_PATH);
    printf("get_commands: setting ROFF_CMD to `%s\'\n", ROFF_CMD);
    printf("get_commands: setting ROFF_FLAGS to `%s\'\n", ROFF_FLAGS);
    printf("get_commands: setting LS_CMD to `%s\'\n", LS_CMD);
    printf("get_commands: setting LS_PATH to `%s\'\n", LS_PATH);
    printf("get_commands: setting EMACS_CMD to `%s\'\n", EMACS_CMD);
    printf("get_commands: setting EMACS_PATH to `%s\'\n", EMACS_PATH);
    printf("get_commands: setting VI_CMD to `%s\'\n", VI_CMD);
    printf("get_commands: setting VI_PATH to `%s\'\n", VI_PATH);
    printf("get_commands: setting PAGE_CMD to `%s\'\n", PAGE_CMD);
    printf("get_commands: setting PAGE_PATH to `%s\'\n", PAGE_PATH);
    printf("get_commands: setting PAGE_ROFF_FLAGS to `%s\'\n", PAGE_ROFF_FLAGS);
    printf("get_commands: setting RANLIB_CMD to `%s\'\n", RANLIB_CMD);
    printf("get_commands: setting RANLIB_PATH to `%s\'\n", RANLIB_PATH);
    printf("get_commands: setting CPPFLAGS to `%s\'\n", CPPFLAGS);
    printf("get_commands: setting CFLAGS to `%s\'\n", CFLAGS);
    printf("get_commands: setting LDPATH to `%s\'\n", LDPATH);
    printf("get_commands: setting LDFLAGS to `%s\'\n", LDFLAGS);
    printf("get_commands: setting XDVI_CMD to `%s\'\n", XDVI_CMD);
    printf("get_commands: setting XDVI_PATH to `%s\'\n", XDVI_PATH);
    printf("get_commands: setting XDVIFLAGS to `%s\'\n", XDVIFLAGS);
#endif

}

 /*
  * getheader() does something I dont't really understand.
  */

long            getheader()
{
    int             n;
    long            size;
    int             i = 15;

    while (b2[i] == ' ')
	i--;
    n = read(af, &header, sizeof(struct ar_hdr));
    if (n != sizeof(struct ar_hdr))
	return (0);
    sscanf(header.ar_size, "%ld", &size);
    if (!strncmp(header.ar_name, b2, i)) {
	success = 1;
	return (0);
    }
    if (size & 1)
	size++;
    return (size);
}

 /*
  * isinarchive() checks wether a given file already exists in a given archive,
  * so the user can think about replacing the given file in the given archive
  * with his own new version of the given file. (All this would not
  * be necessary if there were no archives.)
  */

int             isinarchive(archive, member)
    char           *archive, *member;
{
    char            buf[BUFSIZ];
    long            pos;

    success = 0;
    strcat2(b2, member, "                ");
    b2[16] = '\0';
    if ((af = open(archive, 0, 0)) < 0) {
#ifdef TEST
	perror(archive);
#endif
	return (0);
    }
    if ((read(af, buf, SARMAG) != SARMAG) || (strncmp(buf, ARMAG, 7))) {
	close(af);
	return (0);
    }
    while ((pos = getheader()) > 0) {

#ifdef ___APOLLO
	lseek(af, pos, L_INCR);
#else
	lseek(af, pos, SEEK_CUR);
#endif

    }
    close(af);
    return (success);
}

 /*
  * remove_file() simply prints a string asking the user if a given file
  * should be overwritten. Notice that this procedure was once called
  * loesch_message() which sounded really nice but I could not find out if
  * "loesch_message" is German or English.
  */

int             remove_file(remove_name)
    char            remove_name[MAX_NAME_LENGTH];
{
    printf("\nSM: `%s\' exists\n", remove_name);
    printf("overwrite? (y/n) ");
}

 /*
  * page() pipes the output of some commands through something like "more" or "page".
  * Notice that page() ueses execl() in some cases.
  */

int             page(command)
    char           *command[];
{
    int             p[2];
    int             page_pid;

    if (pipe(p) < 0)
	return (0);
    switch (page_pid = fork()) {
    case 0:
	close(p[0]);
	close(1);
	dup(p[1]);
	close(p[1]);
	if (execv(command[-1], command)) {
	    perror(command[-1]);
	    return (-1);
	}
    case -1:
	return (-1);
    default:
	close(p[1]);
	close(0);
	dup(p[0]);
	close(p[0]);
	execl(PAGE_PATH, PAGE_CMD, 0);
	perror("page");
	return (-1);
    }
}

 /*
  * head() simply prints the usual greetings from SM.
  */

void            head()
{
    printf("\n\n\n");
    printf("\n                         **************************           ");
    printf("\n                         *                        *           ");
    printf("\n                         *      S I M A T H       *           ");
    printf("\n                         *                        *           ");
    printf("\n                         **************************           ");
    printf("\n\n\n");
    printf("\n                      Version %s started at ", version_nr);
    sm_time();
    printf("\n");
}

 /*
  * menu() simply prints the SM menu.
  */

void            menue()
{
    printf("   (N)AME:     (e,E)dit     (p)re        (o)bj        (c)omp       (C)comp \n");
    printf("   object:     (a)r name    (d)ir        ar(+)obj     ar(-)obj     (r)anlib\n");
    printf("  USR-SRC:     (A)R NAME    (D)IR        AR(*)SRC     AR(_)SRC     (S)ELECT\n");
    printf("   SM-SRC:     E(X)TRACT    (~,@,.)                                        \n");
    printf("          (!)  ($)  (?)     (P)RINT      (H)ELP       (R)UN        (Q)UIT  \n");
}

 /*
  * getline() seems to do what is usually done by gets() or fgets().
  * It is not clear anymore what getline() is required for.
  */
#ifndef __USE_XOPEN2K8
/* char           *getline(s, n, pf) */
/* GM */
char           *getline(s, n, pf)
    char           *s;
    int             n;
    FILE           *pf;
{
    char           *ss;
    char            ch;

    ss = s;
    while ((n--) > 0 && (ch = getc(pf)) != '\n' && ch != (char) EOF)
	*s++ = ch;
    *s = '\0';
    if (*ss == '\0' && ch == (char) EOF)
	ss = NULL;
    return (ss);
}

#endif

 /*
  * trap_sig_int() is called if SM receives a SIGINT signal.
  */

void            trap_sig_int()
{
    signal(SIGINT, trap_sig_int);
    putchar('\n');
    longjmp(envnt, 0);
}

 /*
  * sm_time() prints the current time.
  */

sm_time()
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
    printf("%d:%d%d:%d%d\n\n", hour, min / 10, min % 10, sec / 10, sec % 10);
}

 /* 
  * print_default_name() prints the values of LIB, lib and name.
  */

void		print_default_names()
{
    if (*LIB != '\0')
	printf("\n current source library: %s", LIB);
    else
	printf("\n no source library");
    if (*lib != '\0') {
	strcat4(lib_long, SM_HOME, "/lib/lib", lib, ".a"); 
	printf("\n current object library: %s", lib_long);
    }
    else
	printf("\n no object library");
    if (*name != '\0')
	printf("\n current file name:      %s", name);
    else
	printf("\n no file name");

    printf("\n\n\n");
}

 /*
  * read_default_names() reads the stuff that is usually contained in .SM.default.
  */

void		read_default_names()
{
    FILE           *defaults_file;

    defaults_file = fopen(defaults_file_name, "r");
    if (defaults_file != NULL) {
	getline(LIB, MAX_SRC_LIB_LENGTH, defaults_file);
	getline(lib, MAX_LIB_LENGTH, defaults_file);
	getline(name, MAX_NAME_LENGTH, defaults_file);
    }
    print_default_names();
}

 /*
  * write_default_names() writes some informations about
  * libraries and file names to .SM.default.
  */

void		write_default_names()
{
    FILE           *defaults_file;

    defaults_file = fopen(defaults_file_name, "w");
    if (defaults_file != NULL) {
	fprintf(defaults_file, "%s\n", LIB);
	fprintf(defaults_file, "%s\n", lib);
	fprintf(defaults_file, "%s\n", name);

	chmod(defaults_file_name, 00777);
    }
    else
	printf("\nSM: can't open `%s\'\n", defaults_file_name);
}

 /*
  * version_number() reads the version number from the file smconfig.h.
  * This is done at run time, not at compile time.
  */

version_number()
{
    FILE           *defaults_file;
    char            config_name[MAXPATHLEN];

    strcat2(config_name, SM_HOME, "/include/smconfig.h");
    defaults_file = fopen(config_name, "r");
    if (defaults_file == NULL) {
	printf("SM: can't open `%s\'\n", config_name);
	exit(1);
    }
    do
	fgets(version_nr, MAX_V_LENGTH, defaults_file);
    while (strncmp(version_nr, "SIMATH-Version", 14));
    fscanf(defaults_file, "%s", version_nr);

    fclose(defaults_file);
}

main()
{
    char            command_string[MAX_COMMAND_LENGTH];	/* this string will be given to parse_command_string() */
    char           *command_array[MAX_TOKENS];	  /* this array will be given to my_system() */
    char           *command_array_save[MAX_TOKENS];	/* this array saves the adresses in the command_array */
    char            chmod_cmd[MAX_NAME_LENGTH];	  /* used to change the mode of some temporary files */
    char            smcmd_array[MAX_SM_CMD];	  /* this reads the characters typed at the SM prompts */
    char           *smcmd;			  /* a pointer to smcmd_array */

    int             dcn;			  /* the last command to execute */
    int             GO = 1;			  /* set as long as SM expects further commands */
    int             lsflag;			  /* who knows */
    int             remove_name_c;		  /* set if name_c will be removed */
    int             prompt = 1;			  /* SM prints a prompt if this is set */
    int             f1, f2;			  /* two flags storing the exit status of the SIMATH preprocessors */
    int             g1 = 0, g2 = 0, g3 = 0;	  /* three flags storing the existence of the commands files */
    int             init_array;			  /* uses to initialize command_array and in particular
						   * command_array_save */

/*
 * The next lines allocate memomry for the command array and initialize the strings.
 */

    for (init_array = 0; init_array < MAX_TOKENS; init_array++) {
	command_array[init_array] = (char *) malloc(128 * sizeof(char));
	command_array_save[init_array] = command_array[init_array];
    }

    signal(SIGINT, trap_sig_int);
    version_number();

    sprintf(SM_SH,	"%s/bin", SM_HOME);
    sprintf(SM_EXEC,	"%s/bin", SM_HOME);
    sprintf(SM_SRC,	"%s/sources", SM_HOME);
    sprintf(SM_DOC,	"%s/etc", SM_HOME);
    sprintf(SM_HEADER,	"%s/include", SM_HOME);
    sprintf(SM_TMP, "/tmp");

    /*
     * First we check for a file named `SM.cmds' in SM_HOME/etc,
     * then for the file `.SM.cmds' in the user's home directory and finally
     * for `.SM.cmds' in the current working directory.
     * If one or more of these files exist, they are read by get_commands()
     * and later calls to get_commands() override earlier calls, so that the
     * contents of `.SM.cmds' in the current working directory are
     * considered to be of the highest priority.
     */

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

    head();
    read_default_names();
    setjmp(envnt);
    menue();

    while (GO) {

	if (prompt)
	    printf(" < ");
	prompt = 1;

	smcmd = smcmd_array;
	if (gets(smcmd) == NULL) {
	    write_default_names();

#ifndef ___APOLLO
	    putchar('\n');
#endif
	    printf("\n\n                    SM terminated at ");
	    sm_time();
	    printf("n");
	    exit(2);
	}
	while ((dcn = *smcmd++) != '\0') {

	    if (isspace(dcn))
		continue;

	    switch (dcn) {

	    case 'P':
		append_ext();
		isdefined(name, file name);
		printf(" PRINT `%s\'\n", name_S);
		sprintf(command_string, "%s %s %s\0",
			LPR_PATH, LPR_CMD, name_S);
		parse_command_string(command_string, command_array, command_array_save);
		my_system(command_array, 0, 0);
		break;

	    case 'R':
		append_ext();
		isdefined(name, file name);
		printf(" RUN `%s'\n", name);
		fflush(stdout);
		sprintf(command_string, "%s %s\0",
			name_x, name_x);
		parse_command_string(command_string, command_array, command_array_save);
		my_system(command_array, 0, 0);
		break;

	    case 'H':
		print_default_names();
		menue();
		break;

	    case 27:

/*
 * It seems that this was necessary on MX's where the keys
 * MODE, PRINT, HELP and START did strange things.
 */

		break;

            case 'X':                                                                    
                append_ext();                                                           
                lsflag = 'y';                                                   
                isdefined(name, file name);
                if (!access(name_S, F_OK)) {
                    printf("\nSM: `%s.S\' already exists\n\n ", name);
                    sprintf(command_string, "%s %s -l %s\0",                             
                            LS_PATH, LS_CMD, name_S);
                    parse_command_string(command_string, command_array, command_array_save);
                    my_system(command_array, 0, 0);                                                     
                    printf("\noverwrite? (y/n) ");
                    while (isspace(lsflag = getchar()));
                    while (getchar() != '\n');
                    putchar('\n');
                } 
                if (lsflag == 'y') {
                    sprintf(cmd, "rm -f %s; %s/bin/xsrc %s", name_S,SM_HOME, name_S);
		    system(cmd);
                }
                break;


	    case 'S':
		append_ext();
		lsflag = 'y';
		isdefined(name, file name);
		isdefined(LIB, source library);
		if (!access(name_S, F_OK)) {
		    printf("\nSM: `%s.S\' already exists\n\n ", name);
		    sprintf(command_string, "%s %s -l %s\0",
			    LS_PATH, LS_CMD, name_S);
		    parse_command_string(command_string, command_array, command_array_save);
		    my_system(command_array, 0, 0);
		    printf("\noverwrite? (y/n) ");
		    while (isspace(lsflag = getchar()));
		    while (getchar() != '\n');
		    putchar('\n');
		}
		if (lsflag == 'y') {
		    sprintf(command_string, "%s %s x %s %s\0",
			    AR_PATH, AR_CMD, LIB, name_S);
		    parse_command_string(command_string, command_array, command_array_save);
		    if (!my_system(command_array, 0, 0)) {
			printf(" `%s.S\' extracted from `%s\'\n", name, LIB);
			strcat2(chmod_cmd, "chmod 644 ", name_S);
			system(chmod_cmd);
		    }
		}
		break;

	    case '_':
		append_ext();
		isdefined(name, file name);
		isdefined(LIB, source library);
		sprintf(command_string, "%s %s d %s %s\0",
			AR_PATH, AR_CMD, LIB, name_S);
		parse_command_string(command_string, command_array, command_array_save);
		if (!my_system(command_array, 0, 0))
		    printf(" `%s.S\' deleted from `%s\'\n", name, LIB);
		break;

	    case '*':
		append_ext();
		lsflag = 'y';
		isdefined(name, file name);
		isdefined(LIB, source library);
		if (access(name_S, F_OK)) {
		    printf("SM: no file `%s\'\n", name_S);
		    lsflag = 'n';
		}
		if (lsflag == 'y' && isinarchive(LIB, name_S)) {
		    printf("\nSM: `%s.S\' already exists in `%s\'\n\n ", name, LIB);
		    sprintf(command_string, "%s %s tv %s %s\0",
			    AR_PATH, AR_CMD, LIB, name_S);
		    parse_command_string(command_string, command_array, command_array_save);
		    my_system(command_array, 0, 0);
		    printf("\noverwrite? (y/n) ");
		    while (isspace(dcn = *smcmd))
			smcmd++;
		    if (dcn == 'y' || dcn == 'n') {
			lsflag = dcn;
			smcmd++;
			putchar('\n');
			putchar('\n');
		    }
		    else {
			while (isspace(lsflag = getchar()));
			while (getchar() != '\n');
			putchar('\n');
		    }
		}
		if (lsflag == 'y') {
		    sprintf(command_string, "%s %s r %s %s\0",
			    AR_PATH, AR_CMD, LIB, name_S);
		    parse_command_string(command_string, command_array, command_array_save);
		    if (my_system(command_array, 0, 0));
		    else {
			printf(" `ar r %s %s\' done\n", LIB, name_S);
			unlink(name_S);
		    }
		}
		break;

	    case 'D':
		append_ext();
		isdefined(LIB, source library);
		sprintf(command_string, "%s %s tv %s\0",
			AR_PATH, AR_CMD, LIB);
		parse_command_string(command_string, command_array, command_array_save);
		my_system(command_array, 1, 0);
		break;

	    case 'A':
		append_ext();
		strcpy(backup, LIB);
		if (LIB[0] != '\0') {
		    printf(" current source library: %s  ", LIB);
		    printf("\n new source library:     ");
		    if (gets(rline) == NULL)
			CTRL_D;
		}
		else {
		    printf(" source library: ");
		    if (gets(rline) == NULL)
			CTRL_D;
		}
		sscanf(rline, "%s", LIB);
		if (LIB[0] == '\0')
		    strcpy(LIB, backup);
		if (LIB[0] == '\'') {
		    strcpy(backup, LIB + 1);
		    strcat3(LIB, SM_HOME, "/sources/srclib.", backup);
		}
		break;

	    case 'o':
		append_ext();
		isdefined(name, file name);
		if (!access(name_c, F_OK)) {
		    remove_file(name_c);
		    while (isspace(dcn = *smcmd))
			smcmd++;
		    if (dcn == 'y' || dcn == 'n') {
			remove_name_c = dcn;
			smcmd++;
			putchar('\n');
			putchar('\n');
		    }
		    else {
			while (isspace(remove_name_c = getchar()));
			while (getchar() != '\n');
			putchar('\n');
		    }
		    if (remove_name_c != 'y')
			break;
		}
		printf("\n SM preprocessor started at ");
		sm_time();
		sprintf(command_string, "%s %s %s %s\0",
			SM_PRE_PATH, SM_PRE_CMD, name_S, name_P);
		parse_command_string(command_string, command_array, command_array_save);
		f1 = my_system(command_array, 0, 0);
		sprintf(command_string, "%s %s %s %s\0",
			SM_PREV3_PATH, SM_PREV3_CMD, name_P, name_c);
		parse_command_string(command_string, command_array, command_array_save);
		f2 = my_system(command_array, 0, 0);
		if (!f1 && !f2) {
		    printf("\n SM preprocessor terminated correctly at ");
		    sm_time();
		    printf("\n Compiler started at ");
		    sm_time();
		    sprintf(command_string, "%s %s %s -c %s %s\0",
			    CC_PATH, CC_CMD, CPPFLAGS, CFLAGS, name_c);
		    fflush(stdout);
		    parse_command_string(command_string, command_array, command_array_save);
		    if (!my_system(command_array, 0, 0))
			printf("\n Compiler terminated correctly at ");
		    else
			printf("\n Compiler terminated incorrectly at ");
		}
		else
		    printf("\n SM preprocessor terminated incorrectly at ");
		sm_time();
		unlink(name_c);
		unlink(name_P);
		break;

	    case 'p':
		append_ext();
		isdefined(name, file name);
		if (!access(name_c, F_OK)) {
		    remove_file(name_c);
		    while (isspace(dcn = *smcmd))
			smcmd++;
		    if (dcn == 'y' || dcn == 'n') {
			remove_name_c = dcn;
			smcmd++;
			putchar('\n');
			putchar('\n');
		    }
		    else {
			while (isspace(remove_name_c = getchar()));
			while (getchar() != '\n');
			putchar('\n');
		    }
		    if (remove_name_c != 'y')
			break;
		}
		printf("\n SM preprocessor started at ");
		sm_time();
		sprintf(command_string, "%s %s %s %s\0",
			SM_PRE_PATH, SM_PRE_CMD, name_S, name_P);
		parse_command_string(command_string, command_array, command_array_save);
		f1 = my_system(command_array, 0, 0);
		sprintf(command_string, "%s %s %s %s\0",
			SM_PREV3_PATH, SM_PREV3_CMD, name_P, name_c);
		parse_command_string(command_string, command_array, command_array_save);
		f2 = my_system(command_array, 0, 0);
		if (!f1 && !f2) {
		    printf("\n SM preprocessor terminated correctly at ");
		    sm_time();
		    printf("\n C preprocessor started at ");
		    sm_time();
		    sprintf(command_string, "%s %s %s %s\0",
			    CPP_PATH, CPP_CMD, CPPFLAGS, name_c);
		    parse_command_string(command_string, command_array, command_array_save);
		    if (!my_system(command_array, 0, 0)) {
			printf("\n C preprocessor terminated correctly at ");
			sm_time();
		    }
		    else {
			printf("\n C preprocessor terminated incorrectly at ");
			sm_time();
		    }
		}
		else {
		    printf("\n SM preprocessor terminated incoreectly at ");
		    sm_time();
		}
		unlink(name_c);
		unlink(name_P);
		break;

	    case '-':
		append_ext();
		isdefined(name, file name);
		isdefined(lib, object library);
		sprintf(command_string, "%s %s d %s %s\0",
			AR_PATH, AR_CMD, lib_long, name_o);
		parse_command_string(command_string, command_array, command_array_save);
		if (!my_system(command_array, 0, 0))
		    printf(" `%s.o\' deleted from `%s\'\n", name, lib_long);
		break;

	    case '+':
		append_ext();
		lsflag = 'y';
		isdefined(name, file name);
		isdefined(lib, object library);
		if (access(name_o, F_OK)) {
		    printf("SM: no file `%s\'\n", name_o);
		    lsflag = 'n';
		}
		if (lsflag == 'y' && isinarchive(lib_long, name_o)) {
		    printf("\nSM: `%s.o\' already exists in `%s\'\n\n ", name, lib_long);
		    sprintf(command_string, "%s %s tv %s %s\0",
			    AR_PATH, AR_CMD, lib_long, name_o);
		    parse_command_string(command_string, command_array, command_array_save);
		    my_system(command_array, 0, 0);
		    printf("\noverwrite? (y/n) ");
		    while (isspace(dcn = *smcmd))
			smcmd++;
		    if (dcn == 'y' || dcn == 'n') {
			lsflag = dcn;
			smcmd++;
			putchar('\n');
			putchar('\n');
		    }
		    else {
			while (isspace(lsflag = getchar()));
			while (getchar() != '\n');
			putchar('\n');
		    }
		}
		if (lsflag == 'y') {
		    sprintf(command_string, "%s %s r %s %s\0",
			    AR_PATH, AR_CMD, lib_long, name_o);
		    parse_command_string(command_string, command_array, command_array_save);
		    if (my_system(command_array, 0, 0));
		    else {
			printf(" `ar r %s %s\' done\n", lib_long, name_o);
			unlink(name_o);
		    }
		}
		break;

	    case 'a':
		append_ext();
		strcpy(backup, lib);
		if (lib[0] != '\0') {
		    printf(" current object library: %s  ", lib_long);
		    printf("\n new object library:     %s%s*.a ,", SM_HOME, "/lib/lib");
		    printf("\n                          * = ");
		    if (gets(rline) == NULL)
			CTRL_D;
		}
		else {
		    printf(" object library: %s%s*.a,", SM_HOME, "/lib/lib");
		    printf("\n                 * = ");
		    if (gets(rline) == NULL)
			CTRL_D;
		}
		sscanf(rline, "%s", lib);
		if (lib[0] == '.')
		    lib[0] = '\0';
		else {
		    if (lib[0] == '\0')
			strcpy(lib, backup);
		    strcat4(lib_long, SM_HOME, "/lib/lib", lib, ".a");
		}
		break;

	    case 'd':
		append_ext();
		isdefined(lib, object library);
		sprintf(command_string, "%s %s tv %s\0",
			AR_PATH, AR_CMD, lib_long);
		parse_command_string(command_string, command_array, command_array_save);
		my_system(command_array, 1, 0);
		break;

	    case 'r':
		append_ext();
		isdefined(lib, object library);
		if (strcmp(RANLIB_CMD, "null") != 0) {
		    sprintf(command_string, "%s %s %s",
			    RANLIB_PATH, RANLIB_CMD, lib_long);
		    parse_command_string(command_string, command_array, command_array_save);
		    my_system(command_array, 0, 0);
		}
		printf(" `ranlib %s\' done\n", lib_long);
		break;

	    case '!':
		append_ext();
		*smcmd = '\0';
		printf(" >>> branching to a subshell\n");
		printf("     Type `CTRL-D' or `exit\'");
		printf(" in order to return to SM\n");
		system("$SHELL");
		break;

	    case 'Q':
		append_ext();
		write_default_names();
		GO = 0;
		*smcmd = '\0';
		printf("\n\n                    SM terminated at ");
		sm_time();
		printf("\n");
		break;

	    case 'e':
		append_ext();
		isdefined(name, file name);
		sprintf(command_string, "%s %s %s\0",
			VI_PATH, VI_CMD, name_S);
		parse_command_string(command_string, command_array, command_array_save);
		my_system(command_array, 0, 0);
		break;

	    case 'E':
		append_ext();
		isdefined(name, file name);
		sprintf(command_string, "%s %s %s\0",
			EMACS_PATH, EMACS_CMD, name_S);
		parse_command_string(command_string, command_array, command_array_save);
		my_system(command_array, 0, 0);
		break;

	    case 'c':
		append_ext();
		isdefined(name, file name);
		if (!access(name_c, F_OK)) {
		    remove_file(name_c);
		    while (isspace(dcn = *smcmd))
			smcmd++;
		    if (dcn == 'y' || dcn == 'n') {
			remove_name_c = dcn;
			smcmd++;
			putchar('\n');
			putchar('\n');
		    }
		    else {
			while (isspace(remove_name_c = getchar()));
			while (getchar() != '\n');
			putchar('\n');
		    }
		    if (remove_name_c != 'y')
			break;
		}
		printf("\n SM preprocessor started at ");
		sm_time();
		sprintf(command_string, "%s %s %s %s\0",
			SM_PRE_PATH, SM_PRE_CMD, name_S, name_P);
		parse_command_string(command_string, command_array, command_array_save);
		f1 = my_system(command_array, 0, 0);
		sprintf(command_string, "%s %s %s %s\0",
			SM_PREV3_PATH, SM_PREV3_CMD, name_P, name_c);
		parse_command_string(command_string, command_array, command_array_save);
		f2 = my_system(command_array, 0, 0);
		if (!f1 && !f2) {
		    printf("\n SM preprocessor terminated correctly at ");
		    sm_time();
		    printf("\n Compiler started at ");
		    sm_time();
		    if (*lib != '\0')
			sprintf(command_string, "%s %s %s %s -o %s %s %s -l%s %s\0",
				CC_PATH, CC_CMD, CPPFLAGS, CFLAGS, name_x, name_c, LDPATH, lib, LDFLAGS);
		    else
			sprintf(command_string, "%s %s %s %s -o %s %s %s %s\0",
				CC_PATH, CC_CMD, CPPFLAGS, CFLAGS, name_x, name_c, LDPATH, LDFLAGS);
		    parse_command_string(command_string, command_array, command_array_save);
		    if (!my_system(command_array, 0, 0))
			printf("\n Compiler terminated correctly at ");
		    else
			printf("\n Compiler terminated incorrectly at ");
		}
		else
		    printf("\n SM preprocessor terminated incorrectly at ");
		sm_time();
		unlink(name_c);
		unlink(name_P);
		break;

	    case 'm':
	    case 'M':
		append_ext();
		isdefined(name, file name);
		sprintf(cmd, "./%s", name_S);
		if (access(cmd, F_OK)) {
		    printf("\n `%s\' does not exist\n\n", name_S);
		    break;
		}
		comment(name, DEVELOP);
		break;

	    case '?':
		append_ext();
		key_index();
		*smcmd = '\0';
		break;

	    case '~':
	    case '@':
		append_ext();
		if (*smcmd != '\0')
		    strcpy(helptxt, smcmd);
		else {
		    printf(" documentation of: ");
		    if (gets(rline) == NULL)
			CTRL_D
			    sscanf(rline, "%s", helptxt);
		}
		if (*helptxt != '\0')
		    comment(helptxt, MAN_DOKU);
		*smcmd = '\0';
		break;

	    case '.':
		append_ext();
		if (*smcmd != '\0')
		    strcpy(helptxt, smcmd);
		else {
		    printf(" short description of: ");
		    if (gets(rline) == NULL)
			CTRL_D
			    sscanf(rline, "%s", helptxt);
		}
		if (*helptxt != '\0')
		    comment(helptxt, SHORT);
		*smcmd = '\0';
		break;

	    case 'C':
		append_ext();
		isdefined(name, file name);
		if (!access(name_c, F_OK)) {
		    remove_file(name_c);
		    while (isspace(dcn = *smcmd))
			smcmd++;
		    if (dcn == 'y' || dcn == 'n') {
			remove_name_c = dcn;
			smcmd++;
			putchar('\n');
			putchar('\n');
		    }
		    else {
			while (isspace(remove_name_c = getchar()));
			while (getchar() != '\n');
			putchar('\n');
		    }
		    if (remove_name_c != 'y')
			break;
		}
		printf(" Press `<RET>' or enter additional object libraries ar1 ar2 ...\n");
		printf(" Linking is done with ar1 as first library\n: ");
		if (gets(rline) == NULL)
		    CTRL_D;
		printf("\n Compiler started in the background at ");
		sm_time();
		if (*lib != '\0')
		    sprintf(command_string, "%s %s %s %s %s",
			    CCC_PATH, CCC_CMD, name, lib, rline);
		else
		    sprintf(command_string, "%s %s %s %s",
			    CCC_PATH, CCC_CMD, name, rline);
		parse_command_string(command_string, command_array, command_array_save);
		my_system(command_array, 0, 1);
		break;

	    case 'N':
		strcpy(backup, name);
		if (name[0] != '\0') {
		    printf(" current file name: %s  ", name);
		    printf("\n new file name:     ");
		    if (gets(rline) == NULL)
			CTRL_D;
		}
		else {
		    printf(" file name: ");
		    if (gets(rline) == NULL)
			CTRL_D;
		}

		sscanf(rline, "%s", name);
		if (name[0] == '\0')
		    strcpy(name, backup);
		append_ext();
		break;

	    case '$':
		system(smcmd);
		*smcmd = '\0';
		break;

	    default:
		*smcmd = '\0';
		menue();
		break;
	    }
	}
    }

/*
 * Move the cursor to the correct location.
 */

    printf(" %c", 8);
    exit(3);
}

 /*
  * The rest of this file has been written by Georg Lay. It is more or less unchanged.
  * Most of this stuff is quite complicated and difficult to read and maintain.
  * There will be a lot of problems if the standard for the
  * documentation of SIMATH programs should be changed.
  */

 /*
  * key_index() (YES!) executes the key index. What else?
  */

key_index()
{
    FILE           *pftmp;

    char            str[STR_SIZE], STR[STR_SIZE];
    char            c;
    int             i, del_key;
    int             anz;			  /* number of matching lines    */

    printf("\n you entered the SM keyword index, type '?' for help\n");

    if (key_cnt != 0)	list_keys();

    anz = get_num_keys();

    while (1) {
	if (anz <= 0)
	    printf("\n nothing found ");
	else
	    printf("\n found %d functions ", anz);

	printf("matching %d key%s", key_cnt, (key_cnt == 1) ? "" : "s");
	printf("\n > ");

overread:
	switch (getchar()) {

	case ' ':
	case '\t':
	    goto overread;

	case '\n':
	    ungetc('\n', stdin);

	default:
	    printf("\n type '?' for help\n");
	    break;

	case '0':
	    key_cnt = 0;
	    anz = get_num_keys();
	    break;

	case '.':
	    if (get_str(str, "short description of"))
		comment(str, SHORT);
	    break;

	case '~':
	case '@':
	    if (get_str(str, "documentation of"))
		comment(str, MAN_DOKU);
	    break;

/**************************** NEW ***************************/
/* We are using the shell script ``smsrc '' to display the 
   source of the file str  
*/
	case 's':
	case 'S':
	    if (get_str(str, "source of"))
            sprintf(cmd, "%s/bin/smsrc %s.S %d", SM_HOME, str,getpid());
            
            #ifdef TEST                   
            printf ("system (\"%s\")\n",cmd);                                    
            #endif                                                           
            system(cmd);                                                        
	    break;

/**********************************************************/

	case '+':
	    if (key_cnt == MAX_KEYS) {
		printf("\n not more than %d keys !\n", MAX_KEYS);
		break;
	    }

	    if (!get_str(str, "add key"))
		break;
	    if (!strcmp (str, "!")) break;
	    key_cnt++;

	    strcpy (KEY[key_cnt], str);

	    anz = get_num_keys();
	    list_keys();
	    break;

	case '-':
	    if (key_cnt == 0) {
		printf("\n there is no key you can delete!\n");
		break;
	    }
	    if (!get_str(str, "delete key nr"))
		break;

	    del_key = (*str) - '0';

	    if (del_key < 1 || del_key > key_cnt) {
		printf("\n key (%d) is void:", del_key);
		list_keys();
		break;
	    }
	    for (i = del_key; i < key_cnt; i++)
		strcpy(KEY[i], KEY[i + 1]);

	    key_cnt--;
	    printf(" key (%d) deleted:\n", del_key);

	    anz = get_num_keys();
	    list_keys();
	    break;

	case 'c':
	case 'C':
	    if (key_cnt == 0) {
		printf("\n there is no key you can change!\n");
		break;
	    }
	    if (key_cnt == 1)
		if (ungetc(getchar(), stdin) == '\n') {
		    del_key = 1;
		    goto CHANGE;
		}
	    if (!get_str(str, "change key nr"))
		break;

	    del_key = (*str) - '0';

	    if (del_key < 1 || del_key > key_cnt) {
		printf("\n key (%c) is void:", *str);
		list_keys();
		break;
	    }
    CHANGE:
	    if (*KEY[del_key] == '!')
		sprintf(STR, "change key (%d) NOT '%s' to", del_key, KEY[del_key] + 1);
	    else
		sprintf(STR, "change key (%d)  '%s' to", del_key, KEY[del_key]);

	    if (!get_str(str, STR))
		break;

	    if (!strcmp (str, "!")) break;
	    strcpy(KEY[del_key], str);
	    anz = get_num_keys();
	    list_keys();
	    break;

	case 'p':
	case 'P':
	    printf("\n");
	    build_cmd(cmd, 0);
#ifdef TEST
	    printf ("system (\"%s\")\n",cmd);
#endif
	    system(cmd);
	    break;

	case 'q':
	case 'Q':
	    printf("\n returning to SM\n\n");
	    while (getchar() != '\n');
	    return (0);

	case 'l':
	case 'L':
	    list_keys();
	    break;

	case '?':
	    sprintf(str, "%s %s/key.doc",PAGE_CMD, SM_DOC);
#ifdef TEST
	    printf ("system (\"%s\")\n",str);
#endif
	    system(str);
	    break;
	}
	while (getchar() != '\n');
    }

}

 /*
  * get_str().
  */

get_str(str, msg)
char           *str, *msg;
{
    if (ungetc(getchar(), stdin) == '\n') {
	printf("\n %s: ", msg);
	getchar();
    }
    getline(str, STR_SIZE / 2, stdin);

    ungetc('\n', stdin);

    return (*str != '\0');
}

 /*
  * list_keys()
  */

list_keys()
{
    int i;

    printf("\n---------------------------------\n");
    if (key_cnt == 0)
	printf(" no keys selected\n");
    else
	for (i = 1; i <= key_cnt; i++)
	    if (*KEY[i] == '!')
		printf ("(%d) NOT  '%s'\n", i, KEY[i] + 1);
    	    else
		printf ("(%d)      '%s'\n", i, KEY[i]);
    printf("---------------------------------\n");
}


 /*
  * exists() checks whether or not a SIMATH function exists. A function exists iff
  * its source (if any) contains a /*C, /*T or /*M comment, i.e. iff
  * the file KEYWORDS contains a line like '^name\t...'.
  * FUNC == 1: exists a function 'name' ?
  * FUNC != 1: exists a function/Macro 'name' ?
  */

exists(name, FUNC)
    char           *name;
    int             FUNC;
{
    FILE           *pin;

    char            cmd[MAX_CMDS_LENGTH], STR[MAX_NAME_LENGTH], *func;

    func = (FUNC == 1) ? "| egrep -v '(MACRO)'" : "";

    sprintf (cmd, "egrep '^%s\t' %s/KEYWORDS %s", name, SM_DOC, func);
#ifdef TEST
    printf ("popen (\"%s\")\n",cmd);
#endif
    pin = popen (cmd,"r");

    *STR = '\0';
    fscanf (pin, "%s", STR);
    pclose (pin);

    return (*STR != '\0');
}

 /*
  * get_size_of_win() returns 80 because the functions determining 
  * the size of a windows depend a lot on the system.
  * On some systems  
	"ioctl (filedes, TIOCGWINSZ, &win_size); return (win_size.ws_col);"
  * or something like that should work.
  */

get_size_of_win()
{
    return (80);
}

 /*
  * build_cmd().
  * writes an egrep-string to grep for keywords KEY[] to cmd.
  * count != 0: count matching lines
  * count == 0: grep  matching lines 
  */

build_cmd(cmd, count)
    char            cmd[];
    int             count;
{
    int             i;
    char            *c, *cnt;
    char            str[MAX_CMDS_LENGTH], KeyFile[MAXPATHLEN];

    c = (count == 1) ? "-c" : "";			/* just count lines ? */
    sprintf(KeyFile, "%s/KEYWORDS", SM_DOC);		/* the KEYWORD file name */

    if (key_cnt == 0)
	sprintf(str, "  egrep %s '\t' %s", c, KeyFile);
    else {
	*str = '\0';
	for (i = 1; i <= key_cnt; i++) {
	    cnt = (i == key_cnt) ? c : "";		/* count lines ? */
	    if (*KEY[i] == '!')
		sprintf(str, "%s| egrep %s -v '%s' %s", str, cnt, KEY[i]+1, KeyFile);
	    else
		sprintf(str, "%s| egrep %s -i '%s' %s", str, cnt, KEY[i]  , KeyFile);
	    *KeyFile = '\0';
	}
    }

/*
 * str + 2 as we have to delete the first 2 chars "| "
 */

    if (count == 1)
	sprintf(cmd, "%s", str+2);
    else
	sprintf(cmd,"%s | %s/FormatKeywords %d | %s",str+2,SM_EXEC,get_size_of_win()-1,PAGE_CMD);

    return (0);
}

 /*
  * get_num_keys() gets the number of matching functions.
  */

get_num_keys()
{
    FILE           *pin;
    int             anz;

    build_cmd (cmd, 1);
#ifdef TEST
    printf ("popen (\"%s\")\n",cmd);
#endif
    pin = popen (cmd,"r");

    fscanf (pin, "%d", &anz);
    pclose (pin);
    return (anz);
}

 /*
  * is_doku_wirtten_in()
  * cuts the lines of the file src that are between a 'c' documentation like
/*'c'
 .
 doc...
 .
'c'* /
  * writes them to the file out and returns a nonzero value if such a doc exists.
  */

is_doku_written_in (c, src, out)
    char            c, *src, *out;
{
    int             fildes;
    int             cnt;
    struct stat     buf;

    sprintf(cmd, "%s/cut_doc %c < %s > %s", SM_SH, c, src, out);
    system(cmd);

    if ((fildes = open(out, O_RDONLY)) == -1) {
	printf("\n\n SM: cannot open '%s' for reading\n\n",
	       c, out);
	return (0);
    }
    fstat(fildes, &buf);
    close(fildes);

    return (buf.st_size > 20);
}

 /*
  * get_date_of_change() gets the date of the last change from the date line.
  * These things become too complicated
  * and on some systems the nroff/troff stuff doesn't work correctly.
  */

get_date_of_change(name, src, last_change)
    char           *name, *src, *last_change;
{
    FILE           *pin;

    *last_change = '\0';

    sprintf(cmd, "\
	grep '^   DATE %s' < %s | \
	awk '{ print $NF; }' | \
	awk -F. '{print $NF; }'",
	    name, src);

#ifdef TEST
    printf ("popen (\"%s\")\n",cmd);
#endif
    pin = popen (cmd,"r");
    fscanf(pin, "%s", last_change);
    pclose(pin);

    return (0);
}


char *MonthName[] = {
        "JANUARY",      "FEBRUARY",     "MARCH",        "APRIL",
        "MAY",		"JUNE",		"JULY",		"AUGUST",
        "SEPTEMBER",	"OCTOBER",      "NOVEMBER",     "DECEMBER"
        };

/*
 * expand_date() expands strings like "940501" to "1 May 1994"
 */ 

expand_date (date, date_x)
char *date, *date_x;
 {
 int day, month, year;

 day	= 10*(date[4]-'0') + date[5]-'0';
 month	= 10*(date[2]-'0') + date[3]-'0';
 year	= 10*(date[0]-'0') + date[1]-'0';

 if (month < 1 || month > 12 || year < 0 || year > 99) *date_x = '\0';
 else {
    year += (year < 80) ? 2000 : 1900;
    if (day < 1 || day > 31)	sprintf (date_x,"%s %d",MonthName[month-1],year);
    else			sprintf (date_x,"%d %s %d",day,MonthName[month-1],year);
    }
 }

 /*
  * get_srclib_name().
  */

get_srclib_name(srcname, libname)
    char           *srcname, *libname;
{
    char            cmd[MAX_CMDS_LENGTH];
    FILE           *pin;

    *libname = '\0';

    if (!exists(srcname, 0))
	return (1);

    sprintf(cmd, "\
	egrep '^%s\\:' %s/INDEX | awk -F: '{print $2; }'",
	    srcname, SM_DOC);

#ifdef TEST
    printf ("popen (\"%s\")\n",cmd);
#endif
    pin = popen (cmd, "r");
    if (pin == NULL) return (0);

    fscanf(pin, "%s", libname);
    pclose(pin);

    return (1);
}

 /*
  * comment() displays the online help.
  */

comment(txt, style)
    char            txt[];
    int             style;
{
 if (style == SHORT) {
    sprintf (cmd, "egrep '^%s\t' %s/KEYWORDS | %s/FormatKeywords %d | more",            txt, SM_DOC, SM_EXEC, get_size_of_win()-1);
#ifdef TEST
        printf ("system (\"%s\")\n",cmd);
#endif
        system (cmd);
        return (1);
    }


/***********************   NEW  *******************************/


    sprintf(cmd, "%s/bin/smman %s.S %d", SM_HOME, txt, getpid());

/***************************************************************/


#ifdef TEST
    printf ("system (\"%s\")\n",cmd);
#endif
    system(cmd);

    return (1);
}
