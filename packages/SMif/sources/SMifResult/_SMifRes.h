#ifndef _SMifRes_h
#define _SMifRes_h

#define SM_single  1
#define SM_int     2
#define SM_list    3
#define SM_pol     4
#define SM_unknown 0

#define SMif_error   0
#define SMif_ok      1

struct SMifResultItem {
#ifdef __EC4__
   single type;
#else
   long type;
#endif
   char *resultstr;
};

struct SMifResult {
#ifdef __EC4__
   single count;
   single errcode;
#else
   int   count;
   int   errcode;
#endif
   char* cshfile;
   char *errstr;
   struct SMifResultItem *result;
};

typedef struct SMifResult * SMifRes;

/* macros definition */
#define SMifRes_Count(smifres) smifres->count
#define SMifRes_Error(smifres) smifres->errcode
#define SMifRes_Errmsg(smifres) smifres->errstr		

#define SMifRes_Type(smifres,nr) \
		(nr < 1 || nr > smifres->count)? \
		SM_unknown : smifres->result[nr-1].type
#define SMifRes_Get(smifres,nr) \
		(nr < 1 || nr > smifres->count)? \
		(char*)0:smifres->result[nr-1].resultstr

#endif 




