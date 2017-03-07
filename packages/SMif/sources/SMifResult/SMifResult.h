#ifndef _SMifResult_h_
#define _SMifResult_h_

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>

#include "_SMifRes.h"

#define SMif_exec        "SMif"
#define SMif_execfile    ".~~SMif_exec"
#define SMif_progoutput  ".~~SMif_tmp1"
#define SMif_output      ".~~SMif_tmp2"
#define MAXLINE          3000
#define MAXERROR         700
#define FINALCLEAN       0
#define BEGINCLEAN       0

#ifndef S_IRWXU
#define S_IRWXU (mode_t)00700
#endif

#ifndef SEEK_SET
#define SEEK_SET 0
#endif

#define _USE_STRERROR 0
extern int errno;

#if !_USE_STRERROR
extern int sys_nerr;
extern char* sys_errlist[];
#endif

void SMifRes_FromFile (SMifRes, char*, char*);
void SMifRes_FromProg (SMifRes, char*, char*, char*);
void SMifRes_SetCsh   (SMifRes, char*);
void SMifRes_Init     (SMifRes *);
void SMifRes_Free     (SMifRes *);

static void SMifRes_seterror (SMifRes, char*);
static void SMifRes_deltmp (SMifRes);

#endif
