
#include "SMif.h"

/* erzeugen von SMif Workspace: Init. von SMifptr ClientData 
   Definition von SMif-Befehlen... */
   
int SMif_Init (SMifinfo * SMifptr, char* infile) 
{
   FILE * infileptr;
   char line[MAXLINESIZE+1];
   int mm;
   SMifptr->interp = Tcl_CreateInterp();
   SMifptr->envinfo = (EnvInfo) malloc (sizeof(struct EnvInfoItem));
   InitEnvinfo (SMifptr->envinfo,(EnvInfo)NULL);
   Tcl_DStringInit (&(SMifptr->result));
      
   /* fbuffer */
   infileptr = fopen (infile,"r");
   if (infileptr == NULL) {
	  (void)fprintf (stderr, "cannot access %s\n", infile);
	  free (SMifptr);
	  exit (1);
   }
   SMifptr->fbuffer.eof = 0;
   SMifptr->fbuffer.linecount = 0;
   SMifptr->fbuffer.curline   = 0;
   while (!feof(infileptr)) {
	  (void)fgets (line,MAXLINESIZE,infileptr);
	  SMifptr->fbuffer.linecount ++;
   }
   SMifptr->fbuffer.linecount --; 
   (void)fseek (infileptr,0,SEEK_SET);
   SMifptr->fbuffer.lines = (LineBuffer*) malloc (sizeof(LineBuffer)*
							 SMifptr->fbuffer.linecount);
   for (mm = 0; mm < SMifptr->fbuffer.linecount; mm++) {
	  (void)fgets (line, MAXLINESIZE,infileptr);
	  if ( line[strlen(line)-1] == '\n')
		 line[strlen(line)-1] = '\0';
	  SMifptr->fbuffer.lines[mm].length = strlen (line);
	  SMifptr->fbuffer.lines[mm].curpos = 0;
	  SMifptr->fbuffer.lines[mm].line = (char*)malloc(sizeof(char)*
						(SMifptr->fbuffer.lines[mm].length+1) );
	  strcpy(SMifptr->fbuffer.lines[mm].line, line);
   }
	    
   (void)fclose (infileptr);
   
   /* commands */
   Tcl_CreateCommand (SMifptr->interp, "SKIP", (Tcl_CmdProc*) SKIPCmd, 
					  (ClientData)SMifptr, (Tcl_CmdDeleteProc*) NULL );
   Tcl_CreateCommand (SMifptr->interp, "GET", (Tcl_CmdProc*) GETCmd, 
					  (ClientData)SMifptr, (Tcl_CmdDeleteProc*) NULL);
   Tcl_CreateCommand (SMifptr->interp, "REPEAT", (Tcl_CmdProc*) REPEATCmd, 
					  (ClientData)SMifptr, (Tcl_CmdDeleteProc*) NULL);
   Tcl_CreateCommand (SMifptr->interp, "IGNORE", (Tcl_CmdProc*) IGNORECmd, 
					  (ClientData)SMifptr, (Tcl_CmdDeleteProc*) NULL);					  					  					
   Tcl_CreateCommand (SMifptr->interp, "SETITEM", (Tcl_CmdProc*) SETITEMCmd, 
					  (ClientData)SMifptr, (Tcl_CmdDeleteProc*) NULL);					  
   Tcl_CreateCommand (SMifptr->interp, "NOPOWER", (Tcl_CmdProc*) NOPOWERCmd, 
					  (ClientData)SMifptr, (Tcl_CmdDeleteProc*) NULL);
   Tcl_CreateCommand (SMifptr->interp, "STOPGET", (Tcl_CmdProc*) STOPGETCmd, 
					  (ClientData)SMifptr, (Tcl_CmdDeleteProc*) NULL);				  
   Tcl_CreateCommand (SMifptr->interp, "IF", (Tcl_CmdProc*) IFCmd, 
					  (ClientData)SMifptr,(Tcl_CmdDeleteProc*) NULL);
   Tcl_CreateCommand (SMifptr->interp, "SWITCH", (Tcl_CmdProc*) SWITCHCmd, 
					  (ClientData)SMifptr, (Tcl_CmdDeleteProc*) NULL);
   return TCL_OK;
}


/* Definition des SMif-Befehls: SWITCH */

int SWITCHCmd (ClientData clientData, Tcl_Interp *interp, int argc, char* argv[])
{
   SMifinfo * smifptr = (SMifinfo*) clientData;
   FileBuffer *fbptr = &(smifptr->fbuffer);
   SMif_table *temptabarr = NULL, *ignotabptr = &(smifptr->envinfo->ignotable); 
   char * curword = NULL;
   int mm, condcount;
   int otherwise = 0;
   int result = TCL_OK;
   
   if ( argc < 4 || strcmp(argv[1],"NEXTOBJ")!=0 || 
		(int)(argc / 2) *2 != argc ||
		argc == 4 && strcmp(argv[2],"OTHERWISE")==0 ) {
	  Tcl_AppendResult (interp, argv[0], ": wrong # args: should be \"SWITCH ",
			" NEXTOBJ {...} {subscript1} {...} {subscript2}  ... (OTHERWISE "
			"{subscriptn})\"",(char*)NULL);
	  return TCL_ERROR;
   }
   if (strcmp(argv[argc-2],"OTHERWISE") == 0) 
	  otherwise = 1;

   condcount = argc/2-1-otherwise;	  
   temptabarr = (SMif_table*)malloc(sizeof(SMif_table)*condcount);
   for (mm=0; mm < condcount; mm++) {
	  temptabarr[mm].wordtable = NULL;
	  temptabarr[mm].chartable = NULL;
	  if ( !ModifySMif_table(argv[mm*2+2],temptabarr+mm,MODIFYTABLE_ADD)) {	 
		 Tcl_AppendResult (interp, argv[0], " --- ",argv[mm*2+3],": wrong format: ",
						   "should be { [CHAR] ch1 ch2 ... [WORD] word1 word2 ... }\n",
						   (char*)NULL);
		 return TCL_ERROR;
	  }
   }
   
   curword = GetNextWord (fbptr, ignotabptr, (int*)NULL);
   if (!fbptr->eof) {
	  for (mm = 0; mm < condcount; mm++)
		 if (isinwordtable (curword, temptabarr[mm].wordtable) ||
			 isinchartable (curword[0],temptabarr[mm].chartable) ) {
			result = Tcl_Eval (smifptr->interp, argv[mm*2+3]);
			break;
		 }
	  if (mm == condcount &&  otherwise)
		 result = Tcl_Eval (smifptr->interp, argv[argc-1]);
   }
   if (curword!=NULL) free (curword);
   for (mm=0; mm < condcount; mm++) {
	  delchartable (&(temptabarr[mm].chartable));
	  delwordtable (&(temptabarr[mm].wordtable));   
   }
   return result;			 
}

/* Definition des SMif-befehls: IF */

int IFCmd (ClientData clientData, Tcl_Interp *interp, int argc, char* argv[])
{
   SMifinfo * smifptr = (SMifinfo*) clientData;
   SMif_table temptable, *ignotabptr;
   FileBuffer *fbptr = &(smifptr->fbuffer);
   char * curword = NULL;
   int result = TCL_OK;
   
   temptable.chartable = NULL;
   temptable.wordtable = NULL;
   ignotabptr = &(smifptr->envinfo->ignotable);
   
   Tcl_ResetResult (interp);
   if ( !(argc == 4 && strcmp(argv[1],"SEE") == 0) &&
		!(argc == 6 && strcmp(argv[1],"SEE")==0 && strcmp(argv[4],"ELSE")==0))
   {
	  Tcl_AppendResult (interp, argv[0],": wrong # args: should be \"IF SEE",
			" {...} { subscript }\" or \"IF SEE {...} {subscript1} ELSE {sub",
			"script2\"", (char*)NULL);
	  return TCL_ERROR;
   }
   
   if ( !ModifySMif_table(argv[2],&temptable,MODIFYTABLE_ADD)) {	 
	  Tcl_AppendResult (interp, argv[0],": wrong format: should be { [CHAR] ch1 ch2 ",
						"... [WORD] word1 word2 ... }\n",(char*)NULL);
	  return TCL_ERROR;
   }
   
   curword = GetNextWord (fbptr, ignotabptr, (int*)NULL);
   
   if (!fbptr->eof) {
	  if ( isinwordtable (curword, temptable.wordtable) ||
		   isinchartable (curword[0],temptable.chartable) ) 
		 result = Tcl_Eval (smifptr->interp, argv[3]);
	  else if (argc == 6) 
		 result = Tcl_Eval (smifptr->interp, argv[5]);
	  free (curword);
   }
   
   delchartable (&(temptable.chartable));
   delwordtable (&(temptable.wordtable));   
   return (result);
}
   
            
/* Definition des SMif-Befehls: LINESKIP  */

int SKIPCmd (ClientData clientData, Tcl_Interp *interp, int argc, char *argv[])
{
   SMifinfo * smifptr = (SMifinfo*) clientData;
   int step, mm, IsDigit = 1, templen;
   SMif_table  temptable, *ignotabptr;
   int  endwhile = 0;
   FileBuffer *fbptr = &(smifptr->fbuffer);
   LineBuffer *lbptr = NULL;
   char *tempword = NULL;
   int seen;
   
   temptable.chartable = NULL;
   temptable.wordtable = NULL;
   ignotabptr = &(smifptr->envinfo->ignotable);
   Tcl_ResetResult (interp);
   if (!(argc == 3 && strcmp(argv[2],"LINE")==0) &&
	   !(argc == 4 && strcmp(argv[1],"UNTIL")== 0 && 
	   (strcmp(argv[2],"SEEN")==0 || strcmp(argv[2],"SEE")==0) ) ) {
	  Tcl_AppendResult (interp, argv[0],": wrong # args:  should be \"SKIP n LINE\" or",
						" \"SKIP UNTIL SEE(N) { ... }\"",(char*)NULL);
	  return TCL_ERROR;
   }
   
   if (smifptr->envinfo->getinfo.subtype == LINENEXT) {
	  smifptr->envinfo->getinfo.err = SKIPERR;
	  return TCL_ERROR;
   } /* invalid in the subscript of GET LIST FOR NEXT ... */
				   
   if (argc == 3) {
	  templen = strlen(argv[1]);
	  if (!isdigit(argv[1][0]) && argv[1][0]!='+' && argv[1][0]!='-') IsDigit = 0;  
	  else
		 for (mm = 1; mm < templen; mm++)
		    if (!isdigit(argv[1][mm])) {
		       IsDigit = 0;
			   break;
			}
	  if (!IsDigit) {
		 Tcl_AppendResult (interp, argv[0],": expected integer but got ", "\"",
						   argv[1], "\"\n",(char*) NULL);
		 return TCL_ERROR;
	  }
	  step = atoi (argv[1]);
	  fbptr->curline+=step;
	  if (fbptr->curline >= fbptr->linecount) {
		 fbptr->curline = fbptr->linecount - 1;
		 fbptr->eof = 1;
	  } else fbptr->eof = 0;
	  if (fbptr->curline < 0) fbptr->curline = 0;
	  fbptr->lines[fbptr->curline].curpos = 0;
	  return TCL_OK;
   }
   else {
   
	  if ( !ModifySMif_table(argv[3],&temptable,MODIFYTABLE_ADD)) {	 
		 Tcl_AppendResult (interp, argv[0],": wrong format: should be { [CHAR] ch1 ch2 ",
						"... [WORD] word1 word2 ... }\n",(char*)NULL);
		 return TCL_ERROR;
	  }
	  if (strcmp(argv[2],"SEE")==0) seen = 0;
	  else seen = 1;
	  	  
	  while (!endwhile) {
		 tempword = GetNextWord(fbptr, ignotabptr, (int*)NULL);
		 lbptr = &(fbptr->lines[fbptr->curline]);
		 if (fbptr->eof || IsObjInTab(tempword,&(lbptr->curpos),&(temptable),seen) )
			endwhile = 1;
		 else
			lbptr->curpos += strlen(tempword);
		 free (tempword);
		 tempword = NULL;
	  }
	  
	  delchartable (&(temptable.chartable));
	  delwordtable (&(temptable.wordtable));
	  return TCL_OK;
   }
}


/* Definition des SMif-Befehls: REPEATCmd */
int REPEATCmd (ClientData clientData, Tcl_Interp *interp, int argc, char *argv[]) 
{
   SMifinfo * smifptr = (SMifinfo*) clientData;
   char *curword = NULL;
   SMif_table * repeattabptr = &(smifptr->envinfo->repeattable);
   FileBuffer * fbptr = &(smifptr->fbuffer);
   SMif_table * ignotabptr = &(smifptr->envinfo->ignotable);
   SMif_table * stoptabptr = &(smifptr->envinfo->stoptable);
   int endwhile = 0;
   
   Tcl_ResetResult (smifptr->interp);
   if (argc != 5 || strcmp (argv[1],"UNTIL") != 0 || 
	   strcmp (argv[2],"SEE") != 0 ) {
	  Tcl_AppendResult (interp, argv[0],": wrong args: should be \"UNTIL SEE {...}",
						" { Script }\"\n", (char*)NULL);
	  return TCL_ERROR;
   }
   if (ModifySMif_table (argv[3],repeattabptr,MODIFYTABLE_ADD)==0) {
	  Tcl_AppendResult (interp, argv[0],": wrong format: should be { [CHAR] ch1",
						" ch2 ... [WORD] word1 word2 ...}\n",(char*)NULL);
	  return TCL_ERROR;
   }
   
   while (!endwhile) {
	  curword = GetNextWord (fbptr, ignotabptr, (int*)NULL);
	  if ( fbptr->eof ||   /* curword == NULL */
		   isinwordtable (curword,repeattabptr->wordtable) ||
		   isinchartable (curword[0],repeattabptr->chartable) ||
		   isinwordtable (curword,stoptabptr->wordtable)   ||
		   isinchartable (curword[0],stoptabptr->chartable) )
		 endwhile = 1;
	  else
		 if (Tcl_Eval (smifptr->interp, argv[4])==TCL_ERROR) return TCL_ERROR;
		 	  
	  if (curword!=NULL) free(curword);
	  curword = NULL;
   }
   
   (void)ModifySMif_table (argv[3], repeattabptr, MODIFYTABLE_DEL);
   return TCL_OK;							     
}


int GETCmd (ClientData clientData, Tcl_Interp *interp, int argc, char *argv[])
{
   SMifinfo *smifptr = (SMifinfo*) clientData;
   GetInfo * getinfoptr = &(smifptr->envinfo->getinfo);
   EnvInfo   envinfonew = NULL;
   int mm, tempint;
   int option = UNDEFINED;
   int isdigit = 1, endwhile = 0, islevel0 = 0;
   Tcl_DString *polptr = NULL;
   char *poltemp = NULL;
            
   Tcl_ResetResult (interp);
   
   /* syntax checking */
   if (argc >= 2) {
	  if (strcmp(argv[1], "SINGLE") == 0) {
		 option = SMif_GETSINGLE;
		 if ( argc != 3 ) {
			Tcl_AppendResult (interp, "GET SINGLE: wrong #args: should be \"GET SINGLE",
							  " { script }\"\n", (char*)NULL);
			return TCL_ERROR;
		 }
	  }		 
	  else if (strcmp(argv[1], "LIST") == 0) {
		 option = SMif_GETLIST;
		 if (!( argc == 3 || 
				strcmp(argv[2],"FOR") ==0 && strcmp (argv[3], "NEXT") == 0 && 
				( argc == 6 && 
				  (strcmp (argv[4],"ITEM") ==0 || strcmp (argv[4], "LINE") == 0) ||
				  argc == 7 && 
				  (strcmp (argv[5],"ITEM") ==0 || strcmp (argv[5], "LINE") == 0) ) 
			  ) ) 
		 {
			Tcl_AppendResult (interp,"GET LIST: wrong args: should be \"GET LIST",
							  " { script }\"  or\n        \"GET LIST FOR NEXT (n) ",
							  "ITEM(LINE)	{ script }\"\n",(char*)NULL);
			return TCL_ERROR;
		 }	  
	  }
	  else if (strcmp(argv[1], "POL") == 0) {
		 option = SMif_GETPOL;
		 if ( !( argc == 3 ||
				 strcmp(argv[2],"FOR") == 0 && strcmp (argv[3],"NEXT")==0 &&
				 ( argc == 6 && strcmp (argv[4], "LINE") == 0 ||
				   argc == 7 && strcmp (argv[5], "LINE") == 0 )
			   ) )
		 {
			Tcl_AppendResult (interp, "GET POL: wrong args: should be \"GET POL",
							  " { script }\" or\n        \"GET POL FOR NEXT (n) ",
							  "LINE { script }\"\n", (char*)NULL);
			return TCL_ERROR;
		 }
	  }
	  else if (strcmp(argv[1], "INT") == 0) {
		 option = SMif_GETINT;
		 if ( argc != 3 ) {
			Tcl_AppendResult (interp, "GET INT: wrong #args: should be \"GET INT",
							  " { script }\"\n", (char*)NULL);
			return TCL_ERROR;
		 }
	  }
	  else {
		 Tcl_AppendResult (interp, "GET : bad option \"",argv[1],"\": should be",
						"SINGLE, LIST, POL or INT",(char*)NULL);
		 return TCL_ERROR;
	  }
   }
   else {
	  Tcl_AppendResult (interp, "GET : wrong # args, shold be \"GET option",
						" ? arg arg ... ?\"", (char*)NULL);
	  return TCL_ERROR;
   }
   
   /* semantik checking */
   if (getinfoptr->type == UNDEFINED) islevel0 = 1;
   if (!( islevel0 ||
		  getinfoptr->type == SMif_GETLIST && option == SMif_GETLIST)) 
   {
	  getinfoptr->err = TYPEERR;
	  return TCL_ERROR;
   }
   
   if (getinfoptr->type == SMif_GETLIST && getinfoptr->subtype != UNDEFINED)
   {
	  getinfoptr->err = SUBTYPEERR;
	  return TCL_ERROR;
   } /* invalid: run GET LIST under GET LIST FOR NEXT ... */
   
   /* create new level */
   envinfonew = (EnvInfo) malloc (sizeof(struct EnvInfoItem));
   InitEnvinfo (envinfonew,smifptr->envinfo);
   smifptr->envinfo = envinfonew;
   getinfoptr = &(smifptr->envinfo->getinfo);
   getinfoptr->type = option;
   
   if (argc == 6) {  /* GET LIST or GET POL */
	  if (option == SMif_GETLIST) {
		 if (strcmp (argv[4],"ITEM") == 0)
			getinfoptr->subtype = ITEMNEXT;
		 else getinfoptr->subtype = LINENEXT;
	  } else 
		 getinfoptr->subtype = LINENEXT; /* GET POL */
	  getinfoptr->count = 1;
   }
   else if (argc == 7) { /* GET LIST or GET POL */
	  if (option == SMif_GETLIST) {
		 if (strcmp (argv[5],"ITEM") == 0)
			getinfoptr->subtype = ITEMNEXT;
		 else
			getinfoptr->subtype = LINENEXT;
	  } else
		 getinfoptr->subtype = LINENEXT;
		 
	  tempint = strlen(argv[4]);
	  for (mm = 0; mm < tempint; mm++)
		 if (!isdigit(argv[4][mm])) {
			isdigit = 0;
			break;
		 }
	  if (!isdigit) {
		 Tcl_AppendResult (interp, "GET LIST or POL: error: expected positiv integer ",
						   "but got \"", argv[1], "\"\n",(char*) NULL);
		 return TCL_ERROR;
	  }
	  getinfoptr->count = atoi (argv[4]);
   }   
   
   /* Get: Start.... */
     
   if (option == SMif_GETLIST) {
	  if (islevel0) {
		 (void) Tcl_DStringAppend (&(smifptr->result),"\n[LIST]\n",-1);
		 (void)Tcl_DStringAppend (&(smifptr->result),"(",1);
	  }
	  else
		 (void)Tcl_DStringAppend (&(smifptr->result)," (",2);
   }
   
   /* run subscript */
   if (Tcl_Eval (interp,argv[argc-1]) == TCL_ERROR) {
	  if (getinfoptr->err == SUBTYPEERR) 
		 Tcl_AppendResult (interp, "Error: \"GET LIST\" should not run under a",
						   "\"GET LIST FOR NEXT ...\" command",(char*)NULL);
	  if (getinfoptr->err == TYPEERR && option == SMif_GETLIST) 
		 Tcl_AppendResult (interp, "Error: GET SINGLE(INT,POL) commands should not run under a GET ",
						   "LIST command",(char*)NULL);
	  if (getinfoptr->err == TYPEERR && option != SMif_GETLIST)
		 Tcl_AppendResult (interp, "Error: GET commands should not run under a GET SINGLE(INT,POL) ",
						   "comand", (char*)NULL);
	  if (getinfoptr->err == SKIPERR)
		 Tcl_AppendResult (interp, "Error: SKIP commands should not run under a GET comand with",
						   " option \"FOR NEXT (n) LINE\"\n", (char*)NULL);
	  if (getinfoptr->err == ITEMERR)
		 Tcl_AppendResult (interp, "Error: SETITEM commands should not run under a GET POL command",
						   (char*)NULL);
	  return TCL_ERROR;
   }
  
   /* Get */   
   
   switch (option) {
	  case SMif_GETLIST : 
		   while (!endwhile) {
			  if ( GetItemWord(smifptr,&endwhile,DIGITONLY) == TCL_ERROR)
				 return TCL_ERROR;
			  if (strcmp (interp->result, "")!=0)
				 (void)Tcl_DStringAppendElement (&(smifptr->result), interp->result);
		   }
		   (void)Tcl_DStringAppend (&(smifptr->result)," )",2);
		   break;
		   
	  case SMif_GETINT :
	  case SMif_GETSINGLE:
		   if ( GetItemWord(smifptr,(int*)NULL, DIGITONLY) == TCL_ERROR)
			  return TCL_ERROR;
		   if (strcmp (interp->result, "")!= 0) {
			  if (option == SMif_GETINT)
				 (void)Tcl_DStringAppend (&(smifptr->result),"\n[INT]\n", -1); 
			  else
				 (void)Tcl_DStringAppend (&(smifptr->result),"\n[SINGLE]\n", -1); 
			  (void)Tcl_DStringAppend (&(smifptr->result),interp->result,-1);
		   }
		   break;
		   
	  case SMif_GETPOL:

		   endwhile = 0;
		   polptr = (Tcl_DString*) malloc (sizeof (Tcl_DString));
		   Tcl_DStringInit (polptr);
		   while (!endwhile) {
			  if (GetItemWord(smifptr,&endwhile,ALLCHAR) == TCL_ERROR)
				 return TCL_ERROR;
			  (void)Tcl_DStringAppend (polptr, interp->result, -1);
		   }
		   poltemp = (char*) malloc(sizeof(char)*(Tcl_DStringLength(polptr)+1));
		   strcpy (poltemp, Tcl_DStringValue(polptr));
		   Tcl_DStringFree (polptr);

		   if (strcmp(poltemp,"") != 0) { /* not empty */
			  (void)Tcl_DStringAppend (&(smifptr->result),"\n[POL]\n", -1); 		   
			  if (MakeSMPol (poltemp, &(smifptr->result)) == TCL_ERROR) {
				 Tcl_AppendResult (interp, "Error: invalid polynomial",(char*)NULL);	
				 return TCL_ERROR;
			  }
			  (void)Tcl_DStringAppend (&(smifptr->result)," #",2);
		   }
   }
   
   if (polptr!=NULL) free (polptr);
   if (poltemp != NULL) free (poltemp);
   
   /* Abbau des Kellers */
   smifptr->envinfo = envinfonew->next;
   delchartable (&(envinfonew->ignotable.chartable));
   delchartable (&(envinfonew->npnltable.chartable));
   delchartable (&(envinfonew->stoptable.chartable));
   delchartable (&(envinfonew->repeattable.chartable));
   delwordtable (&(envinfonew->ignotable.wordtable));
   delwordtable (&(envinfonew->stoptable.wordtable));
   delwordtable (&(envinfonew->npnltable.wordtable));
   delwordtable (&(envinfonew->repeattable.wordtable));
   free (envinfonew->iteminfo.pattern);
   free (envinfonew);
   
   return TCL_OK;
         	 
}


/* beliebiges Polnomstring -> SIMATH POL */
int MakeSMPol (const char* pol, Tcl_DString* finalresult) 
{
   Tcl_DString *polptr = NULL; 
   Tcl_DString *result = NULL;
   int   templevel = 0, templen= 0, mm, nn, tempint;
   long  koeff = 1, koeff2;
   char  koeff_char[20];
   long  templong = 0;
   int   bodybegin, bodyend;
   char  *poltemp = NULL;
   char  *tempstr = NULL, *head = NULL, *tail = NULL;
   char  *bodyitem = NULL;
   struct SMif_polstruct polstruct = {0, NULL};
   struct SMif_polinfoitem *polinfoptr = NULL;
   SMif_chartable defaulttable = NULL;
   SMif_wordtable vartable = NULL;
   char ** varname = NULL;
   long *expolist=NULL;
   int result_first = 1, pol_first = 1;
   int withstar;
   char * tempvar = NULL;
   int varcount;
   int varbegin;
   struct SMif_wordlistitem *worditemptr=NULL;

   addchar (' ',&defaulttable);
   polptr = (Tcl_DString*) malloc (sizeof(Tcl_DString));
   result = (Tcl_DString*) malloc (sizeof(Tcl_DString));
   Tcl_DStringInit (result);
   poltemp = SMif_strtran (pol, "**", "^");

   /* check the pol string mult. with *? */
   /* '**' wird schon durch '^' ersetzt! */
   templen = strlen(poltemp);
   withstar = 0;
   for (mm = 0; mm < templen; mm++)
	  if (poltemp[mm] == '*') {
		 withstar = 1;
		 break;
	  }
   
   /* make variable-list */
   varbegin = -1;
   for (mm = 0; mm <= templen; mm++) {
	  if (varbegin != -1) 
		 if (withstar && !isalnum(poltemp[mm]) ||
			 !withstar && !isdigit(poltemp[mm]) ) {
			if (tempvar == NULL) free(tempvar);
			tempvar = SMif_substr(poltemp,varbegin,mm-varbegin);
			addword (tempvar, &vartable);
			varbegin = -1;
		 }
	  if (isalpha(poltemp[mm]) && varbegin == -1) 
		 varbegin = mm;
   }
   varcount = wordcount(vartable);
   varname = (char**) malloc (sizeof(char*)*varcount);
   expolist = (long*)malloc (sizeof(long)*varcount);
   for (mm=0; mm<varcount; mm++) expolist[mm] = 0;
   for (mm=0, worditemptr=vartable; worditemptr!=NULL ; 
			 worditemptr=worditemptr->next, mm++) {
	  varname[mm] = (char*)malloc(sizeof(char)*(strlen(worditemptr->SMifword)+1));
	  strcpy (varname[mm],worditemptr->SMifword);
   }

   
   SMif_getpolstruct (poltemp, &polstruct);
   if (polstruct.maxlevel < 0) 	return TCL_ERROR;

   while (polstruct.maxlevel > 0) {
	  for (polinfoptr = polstruct.polinfo; polinfoptr!=NULL &&
		   polinfoptr->locmaxlevel == 0; polinfoptr=polinfoptr->next) {
		 if (polinfoptr->to >= polinfoptr->from) {
			if (tempstr != NULL) free(tempstr);
			tempstr = SMif_substr(poltemp,polinfoptr->from,polinfoptr->to -
								   polinfoptr->from + 1);
			if (tempstr != NULL) {
			   if (!result_first && polinfoptr->negorpos == POSITIV)
				  (void)Tcl_DStringAppend (result,"+",1);
			   else if (polinfoptr->negorpos == NEGATIV)
				  (void)Tcl_DStringAppend (result,"-",1);
			   if (result_first) result_first = 0;
			   SMif_alltrim(tempstr,defaulttable);
			   (void)Tcl_DStringAppend (result,tempstr,-1);
			}
		 }
	  }
	  Tcl_DStringInit (polptr);
	  pol_first = 1;				 
	  for (; polinfoptr!=NULL; polinfoptr = polinfoptr->next) {
		 if (polinfoptr->to >= polinfoptr->from) {
			if (tempstr != NULL) free(tempstr);
			tempstr = SMif_substr(poltemp,polinfoptr->from,polinfoptr->to -
								  polinfoptr->from + 1);
			SMif_alltrim(tempstr,defaulttable);
			if (polinfoptr->locmaxlevel == 0 && strcmp(tempstr,"")!=0) {
			   if (polinfoptr->negorpos == POSITIV)
				  (void)Tcl_DStringAppend (polptr,"+",1);
			   else 
				  (void)Tcl_DStringAppend (polptr,"-",1);
			   Tcl_DStringAppend (polptr, tempstr, -1);
			}
			else {
			   templevel = 0;
			   if (polinfoptr->negorpos == NEGATIV)
				  koeff = -1;
			   else koeff = 1; 
			   templen = strlen(tempstr);
			   bodybegin = bodyend = 0;
			   for (mm = 0; mm < templen; mm++) {
				  if (tempstr[mm] == '(') {
					 templevel++;
					 if (templevel == 1) {
						if (head != NULL) free (head);
						head = SMif_substr(tempstr,0,mm);
						templong = atol (head);
						if (templong!=0)
						   koeff *= templong;
						else if (head[0] == '-')
						   koeff = 0 - koeff;
						for (nn = 0; nn == 0 && (head[nn] == '+' ||
							 head[nn] == '-') || nn < strlen(head) &&
							 isdigit(head[nn]); nn++)
						   head[nn] = ' ';
						SMif_alltrim(head,defaulttable);
						bodybegin = mm+1;
					 }
				  }
				  if (tempstr[mm] == ')') {
					 templevel --;
					 if (templevel == 0) {
						if (tail != NULL) free (tail);
						tail = SMif_substr(tempstr,mm+1,templen-mm-1);
						templong = atol(tail);
						if (templong!=0)
						   koeff *= templong;
						else if (tail[0] == '-')
						   koeff = 0 - koeff;
						for (nn = 0; nn == 0 && ( tail[nn] == '+' ||
							 tail[nn] == '-') || nn < strlen(tail) &&
							 isdigit(tail[nn]); nn++)
						   tail[nn] = ' ';
						SMif_alltrim(tail,defaulttable);
						bodyend = mm;
						break;
					 }                      
				  }                    
			   }              
			   tempint = bodybegin;
			   templevel = 0;
			   for (mm = bodybegin; mm <= bodyend; mm++) {
				  if (tempstr[mm] == '(') templevel++;
				  if (tempstr[mm] == ')') templevel--;
				  if ((tempstr[mm] == '+' || tempstr[mm] == '-') && templevel == 0 
					  && mm != bodybegin || mm == bodyend) {
					 if (bodyitem != NULL) free(bodyitem);
					 bodyitem = SMif_substr(tempstr,tempint,mm-tempint);
					 templong = atol(bodyitem);
					 if (templong!=0)
						koeff2 = templong * koeff;
					 else if (bodyitem[0] == '-')
						koeff2 = 0 - koeff;
					 else
						koeff2 = koeff;
					 for (nn = 0; nn == 0 && ( bodyitem[nn] == '+' ||
						  bodyitem[nn] == '-') || nn < strlen(bodyitem) &&
						  isdigit(bodyitem[nn]); nn++)
						bodyitem[nn] = ' ';
					 SMif_alltrim(bodyitem,defaulttable);
					 if (koeff2 > 0 && !pol_first)
						Tcl_DStringAppend(polptr,"+",1);
					 else if (koeff2 == -1)
						Tcl_DStringAppend(polptr,"-",1);
					 if (pol_first) pol_first = 0;
					 if (koeff2 != 1 && koeff2 != -1) {
						sprintf (koeff_char,"%ld",koeff2);
						SMif_alltrim(koeff_char,defaulttable);
						Tcl_DStringAppend(polptr,koeff_char,-1);
					 }
					 Tcl_DStringAppend(polptr,head,-1);
					 if (withstar && strcmp(head,"")!=0 && 
						 strcmp(bodyitem,"")!=0)
						Tcl_DStringAppend(polptr,"*",1);
					 Tcl_DStringAppend(polptr,bodyitem,-1);
					 if (withstar && strcmp(tail,"")!=0 &&
						 (strcmp(bodyitem,"")!=0 || strcmp(head,"")!=0))
						Tcl_DStringAppend(polptr,"*",1);
					 Tcl_DStringAppend(polptr,tail,-1);
					 tempint = mm;
				  }
			   }
			}   /* locmaxlevel = 1 , else */
		 } /* if ... */
	  } /* for (; ... */
	  if (poltemp != NULL) free (poltemp);
	  poltemp = (char*)malloc(sizeof(char)*(Tcl_DStringLength(polptr)+1));
	  strcpy (poltemp, Tcl_DStringValue(polptr));
	  Tcl_DStringFree (polptr);
	  SMif_getpolstruct (poltemp, &polstruct);
   }/* while */
		  
   if (!result_first && poltemp[0]!='-')
	  (void)Tcl_DStringAppend (result,"+",1);
   (void)Tcl_DStringAppend (result,poltemp,-1);
   if (poltemp != NULL) free (poltemp);
   poltemp = (char*)malloc(sizeof(char)*(Tcl_DStringLength(result)+1));
   strcpy (poltemp, Tcl_DStringValue(result)); /* sum of monomails */  
   Tcl_DStringFree (result);    
   SMif_getpolstruct (poltemp, &polstruct);
      
   /* final output */
   for (polinfoptr = polstruct.polinfo; polinfoptr!=NULL;
		polinfoptr=polinfoptr->next) {
	  if (tempstr!=NULL) free(tempstr);
	  tempstr = SMif_substr(poltemp,polinfoptr->from,
							polinfoptr->to-polinfoptr->from+1);
	  koeff = atol(tempstr);
	  if (koeff == 0) koeff = 1;
	  sprintf (koeff_char,"%ld",koeff);
	  SMif_alltrim(koeff_char,defaulttable);
	  if (polinfoptr == polstruct.polinfo) {
		 if (polinfoptr->negorpos == NEGATIV)
			Tcl_DStringAppend(finalresult,"-",1);
	  }
	  else {
		 if (polinfoptr->negorpos == NEGATIV)
			Tcl_DStringAppend(finalresult," - ",3);
		 else
			Tcl_DStringAppend(finalresult," + ",3);
	  }
	  Tcl_DStringAppend(finalresult,koeff_char,-1);
	  templen = strlen(tempstr);
	  templong = 0;
	  varbegin = 0;
	  for (mm=0; mm<varcount;mm++) expolist[mm] = 0;
	  mm = 0;
	  while ( mm < templen) {
		 for (;mm < templen && !isalpha(tempstr[mm]); mm++);
		 if ( mm >= templen) break;
		 varbegin = mm;
		 if (withstar) 
			for(;mm+1 < templen && isalnum(tempstr[mm+1]);mm++);
		 else
			for(;mm+1 < templen && isdigit(tempstr[mm+1]);mm++);
		 if (tempvar != NULL) free(tempvar);
		 tempvar = SMif_substr(tempstr,varbegin,mm-varbegin+1);
		 mm++;
		 if (tempstr[mm]!='^') templong = 1;
		 else {
			mm ++;
			templong = atol(tempstr+mm);
			if (templong == 0) templong = 1;
		 }
		 for(nn=0, worditemptr=vartable; worditemptr!=NULL ; 
			 worditemptr=worditemptr->next, nn++)
			if (strcmp(tempvar,worditemptr->SMifword)==0) {
			   expolist[nn] += templong;
			   break;
			}
	  }
	  /* output */
	  for (mm = 0; mm < varcount; mm++) {
		 Tcl_DStringAppend(finalresult,"*",1);
		 Tcl_DStringAppend(finalresult,varname[mm],-1);
		 Tcl_DStringAppend(finalresult,"^",1);
		 sprintf (koeff_char, "%ld",expolist[mm]);
		 SMif_alltrim(koeff_char,defaulttable);
		 Tcl_DStringAppend(finalresult,koeff_char,-1);
	  }
   }
   	
   if (poltemp != NULL) free (poltemp);
   poltemp = (char*)malloc(sizeof(char)*(Tcl_DStringLength(result)+1));
   strcpy (poltemp, Tcl_DStringValue(result)); /* sum of monomails */  

   /* free memory */    
   Tcl_DStringFree (result); 	    
   if (head != NULL) free (head);
   if (tail != NULL) free (tail);
   if (bodyitem!=NULL) free(bodyitem);
   if (poltemp != NULL) free (poltemp);
   if (polptr != NULL) free (polptr);
   if (result != NULL) free (result);
   if (tempstr != NULL) free (tempstr);
   if (expolist != NULL) free (expolist);
   if (varname != NULL) {
	  for (mm = 0; mm < varcount; mm++)
		 if (varname[mm]!=0) free (varname[mm]);
	  free (varname);
   }
   delchartable (&defaulttable);
   for (polinfoptr = polstruct.polinfo; polinfoptr!= NULL;) {
	  polstruct.polinfo = polinfoptr->next;
	  free (polinfoptr);
	  polinfoptr = polstruct.polinfo;
   }
   return TCL_OK;   
} 


/* Definition des SMif-Befehls : IGNORE   */
int IGNORECmd (ClientData clientData, Tcl_Interp *interp, int argc, char *argv[]) 
{
   SMifinfo * smifptr = (SMifinfo*) clientData;
   
   if (argc != 2 && !(argc == 4 && strcmp(argv[1],"NEWLINE")==0 &&
					  strcmp(argv[2],"AFTER") == 0) ) {
	  Tcl_ResetResult (interp);
	  Tcl_AppendResult (interp, argv[0],": wrong # args:  should be \"IGNORE {...}\" or\n",
						"                       \"IGNORE NEWLINE AFTER {...}\"\n",
						(char*)NULL);
	  return TCL_ERROR;
   }
   if (argc == 2 && ModifySMif_table (argv[1],&(smifptr->envinfo->ignotable),
	   MODIFYTABLE_ADD)==0  ||
	   argc == 4 && ModifySMif_table (argv[3],&(smifptr->envinfo->npnltable),
	   MODIFYTABLE_ADD)==0  ) {
	  Tcl_ResetResult (interp);
	  Tcl_AppendResult (interp, argv[0],": wrong format: should be { [CHAR] ch1 ch2 ",
						"... [WORD] word1 word2 ... }\n",(char*)NULL);
	  return TCL_ERROR;
   }
   return TCL_OK;
	  	  
}


/* SETITEM : Definition der ITEM SIZE und ITEM PATTERN */
int SETITEMCmd (ClientData clientData, Tcl_Interp *interp, int argc, char *argv[]) 
{
   SMifinfo * smifptr = (SMifinfo*) clientData;
   int templen, mm, count;
   
   Tcl_ResetResult (interp);   
   if (argc != 5 || strcmp (argv[1],"SIZE")!=0 || strcmp (argv[3],"PATTERN")!=0) {
	  Tcl_AppendResult (interp, argv[0],": wrong args: should be \"SETITEM SIZE n",
					   " PATTERN patternstr\"\n", (char*) NULL);
	  return TCL_ERROR;
   }
   templen = strlen(argv[2]);
   for (mm = 0; mm < templen; mm++)
	  if (!isdigit(argv[2][mm])) {
		 Tcl_AppendResult (interp, argv[0],": expected positiv integer but got ",
						   "\"",argv[2],"\"\n",(char*)NULL);
		 return TCL_ERROR;
	  }
   count = atoi (argv[2]);
      
   if (!IsValidPattern(argv[4],count,smifptr->interp)) {
	  Tcl_AppendResult (interp, argv[0], ": invalid patternstring \"",argv[4],
						"\"\n", (char*) NULL);
	  return TCL_ERROR;
   }	 
   
   if (smifptr->envinfo->getinfo.type == SMif_GETPOL) {
	  smifptr->envinfo->getinfo.err = ITEMERR;
	  return TCL_ERROR;
   }
   
   smifptr->envinfo->iteminfo.itemsize = count;   
   smifptr->envinfo->iteminfo.pattern = (char*) malloc (sizeof(char)*
										(strlen(argv[4])+2));
   (void)strcpy (smifptr->envinfo->iteminfo.pattern, argv[4]);
   (void)strcpy (smifptr->envinfo->iteminfo.pattern+strlen(argv[4])," ");
   return TCL_OK;
}


int NOPOWERCmd (ClientData clientData, Tcl_Interp *interp, int argc, char *argv[]) 
{
   SMifinfo * smifptr = (SMifinfo*) clientData;
   int isok = 1;
  
   /* nopower newline after : fuer die sich fortsetzende Ausgaben. */
   if (argc == 5 && strcmp ("IGNORE",argv[1])==0 && strcmp ("NEWLINE",argv[2])==0
	   && strcmp("AFTER",argv[3])==0 )
	  isok = ModifySMif_table (argv[4], &(smifptr->envinfo->npnltable),
							   MODIFYTABLE_DEL);
   else if (argc == 3 && strcmp("IGNORE",argv[1])==0) 
	  isok = ModifySMif_table (argv[2], &(smifptr->envinfo->ignotable),
							   MODIFYTABLE_DEL);

   else if (argc == 3 && strcmp (argv[1],"STOPGET")==0) 
	  isok = ModifySMif_table (argv[2], &(smifptr->envinfo->stoptable),
							   MODIFYTABLE_DEL); 
   
   else if (argc == 2 && strcmp (argv[1],"SETITEM")==0) {
	  smifptr->envinfo->iteminfo.itemsize = 1;
	  if (smifptr->envinfo->iteminfo.pattern!=NULL) {
		 free (smifptr->envinfo->iteminfo.pattern);
		 smifptr->envinfo->iteminfo.pattern = NULL;
	  }
   }
   else {
	  Tcl_ResetResult (interp);
	  Tcl_AppendResult (interp, argv[0],": wrong args: should be \"NOPOWER IGNORE",
						" {...}\" or ","\"NOPOWER STOPGET {...}\" or\n",
						"\"NOPOWER SETITEM\" or ", 
						"\"NOPOWER IGNORE NEWLINE AFTER {...}\"\n", (char*)NULL);
	  return TCL_ERROR;
   }
   if (!isok) {
	  Tcl_ResetResult (interp);
	  Tcl_AppendResult (interp, argv[0],": wrong format: should be { [CHAR} ch1 ch2 ",
						"... [WORD] word1 word2 ...}", (char*)NULL );
	  return TCL_ERROR;
   }
   return TCL_OK;
}


/* stopget: wann soll ein GET beendet werden ?  default: eof OR foreach... */

int STOPGETCmd (ClientData clientData, Tcl_Interp *interp, int argc, char *argv[]) 
{
   SMifinfo * smifptr = (SMifinfo*) clientData;
      
   if (argc != 4 || strcmp ("IF",argv[1])!=0 || strcmp("SEE",argv[2])!=0) {
	  Tcl_ResetResult (interp);
	  Tcl_AppendResult (interp, argv[0],": wrong args: should be \"STOPGET IF",
						" SEE {...}\"\n", (char*)NULL);
	  return TCL_ERROR;
   }
   if (ModifySMif_table (argv[3],&(smifptr->envinfo->stoptable),MODIFYTABLE_ADD)==0) {
	  Tcl_ResetResult (interp);
	  Tcl_AppendResult (interp, argv[0],": wrong format: should be { [CHAR] ch1 ch2 ",
						"... [WORD] word1 word2 ...}", (char*)NULL);
	  return TCL_ERROR;
   }
   return TCL_OK; 	     
}

void DeleteAll (SMifinfo *SMifptr)
{
   int mm;
   struct EnvInfoItem *envinfoptr,*envinfoptr2;
   for (mm = 0; mm < SMifptr->fbuffer.linecount; mm++) 
	  free (SMifptr->fbuffer.lines[mm].line);
   free (SMifptr->fbuffer.lines);
   for (envinfoptr = SMifptr->envinfo; envinfoptr!=NULL;) {
	  delchartable (&(envinfoptr->ignotable.chartable));
	  delchartable (&(envinfoptr->npnltable.chartable));
	  delchartable (&(envinfoptr->stoptable.chartable));
	  delchartable (&(envinfoptr->repeattable.chartable));
	  delwordtable (&(envinfoptr->ignotable.wordtable));
	  delwordtable (&(envinfoptr->stoptable.wordtable));
	  delwordtable (&(envinfoptr->npnltable.wordtable));
	  delwordtable (&(envinfoptr->repeattable.wordtable));
	  free (envinfoptr->iteminfo.pattern);
	  envinfoptr2 = envinfoptr;
	  envinfoptr = envinfoptr2->next;
	  free (envinfoptr2);
   }
   Tcl_DStringFree (&(SMifptr->result));
   free (SMifptr);
}


/* Initialisierung einer neuen GET_Umgebung ueber einer alten
   Umgebung (NULL, falls nicht vorhanden */
   
void InitEnvinfo (EnvInfo newenv, EnvInfo oldenv)
{  
   if (oldenv == NULL) {      /* level 0 */
	  newenv->envlevel = 0;
	  newenv->next = NULL;
	  newenv->ignotable.chartable = NULL;
	  newenv->ignotable.wordtable = NULL;
	  newenv->stoptable.chartable = NULL;
	  newenv->stoptable.wordtable = NULL;
	  newenv->npnltable.chartable = NULL;
	  newenv->npnltable.wordtable = NULL;
	  newenv->repeattable.chartable = NULL;
	  newenv->repeattable.wordtable = NULL;
	  newenv->iteminfo.itemsize = 1;
	  newenv->iteminfo.pattern  = NULL;
	  addchar ('\n',&(newenv->ignotable.chartable));
	  addchar ('\t',&(newenv->ignotable.chartable));
	  addchar (' ',&(newenv->ignotable.chartable));
   }
   else {                    /* level > 0 */ 
	  newenv->envlevel = oldenv->envlevel + 1;
	  newenv->next = oldenv;
	  newenv->ignotable.chartable = copychartable (oldenv->ignotable.chartable);
	  newenv->ignotable.wordtable = copywordtable (oldenv->ignotable.wordtable);
	  newenv->stoptable.chartable = copychartable (oldenv->stoptable.chartable);
	  newenv->stoptable.wordtable = copywordtable (oldenv->stoptable.wordtable);	  
	  newenv->npnltable.chartable = copychartable (oldenv->npnltable.chartable);
	  newenv->npnltable.wordtable = copywordtable (oldenv->npnltable.wordtable);
	  newenv->repeattable.chartable = copychartable (oldenv->repeattable.chartable);
	  newenv->repeattable.wordtable = copywordtable (oldenv->repeattable.wordtable);	  
	  newenv->iteminfo.itemsize = oldenv->iteminfo.itemsize;
	  if (oldenv->iteminfo.pattern != NULL) {
		 newenv->iteminfo.pattern = (char*) malloc (sizeof(char) * (strlen (
						 oldenv->iteminfo.pattern)+1));
		 (void)strcpy (newenv->iteminfo.pattern, oldenv->iteminfo.pattern);
	  } 
	  else newenv->iteminfo.pattern = NULL;
   }
   newenv->getinfo.type       = UNDEFINED;
   newenv->getinfo.subtype    = UNDEFINED;
   newenv->getinfo.err        = NOERROR;
   newenv->getinfo.count      = 0;
   newenv->getinfo.getcount   = 0;
}


/* Aenderung der SMif-tabelle */
int ModifySMif_table (char* instr, SMif_table * table, int flag)
{
   char * tempstr; 
   int count, wordcount, length;
   SMif_chartable ignotable = NULL;
   int ischar = 0, isword = 0;  /* bool */
   
   addchar ('\n',&ignotable);
   addchar ('\t',&ignotable);
   addchar (' ',&ignotable);
   count = 1;
   wordcount = SMif_wordcount (instr,ignotable);
   while (count <= wordcount) {
	  tempstr = SMif_getword (instr, count, ignotable);
	  if (strcmp (tempstr,"[CHAR]")== 0) {
		 isword = 0; 
		 ischar = 1;
	  } 
	  else if (strcmp (tempstr, "[WORD]")==0) {
		 isword = 1;
		 ischar = 0;
	  }
	  else {
		 length = strlen (tempstr);
		 if (count == 1) { free (tempstr); return 0; }
		 if (ischar) {
			if (length != 1) {
			   if (length == 2 && tempstr[0] == '\\')
				  switch (flag) {
					 case MODIFYTABLE_ADD: addchar (tempstr[1],&(table->chartable));
										   break;
					 case MODIFYTABLE_DEL: delchar (tempstr[1],&(table->chartable));
				  }
			   else {
				  free (tempstr);
				  return 0;
			   }
			} 
			else 
			   switch (flag) {
				  case MODIFYTABLE_ADD: addchar(tempstr[0],&(table->chartable));
										break;
				  case MODIFYTABLE_DEL: delchar(tempstr[0],&(table->chartable));
			   }
		 }
		 if (isword) 
			switch (flag) {
			   case MODIFYTABLE_ADD: addword (tempstr,&(table->wordtable));
									 break;
			   case MODIFYTABLE_DEL: delword (tempstr,&(table->wordtable));
			}
	  }
	  free (tempstr);
	  count ++;
   }
   return 1;
}			   
	   
	   
/* check: ist der String eine gueltige Patternbeschreibung ? */
int IsValidPattern (const char* str, int count, Tcl_Interp* interp) 
{
   int occour = SMif_occour (str,"$");
   char nummer[10], *tempstr = NULL;
   int mm, nn, tempint, pos;
   
   for (mm = 1; mm <= occour; mm++) {
	  pos = SMif_at (str, "$", mm);
	  for (nn = 0; isdigit(str[pos+nn+1]);nn++)
		 nummer[nn] = str[pos+nn+1];
	  nummer[nn] = '\0';
	  tempint = atoi (nummer);
	  if (tempint < 1 || tempint > count) 
		 return 0;
   }
   
   /* setze $1 durch 1, $2 durch 2 ... und berechnen: Syntax OK? */
   tempstr = SMif_strtran (str, "$","");
   if (Tcl_ExprString(interp,tempstr)==TCL_ERROR) {
      Tcl_ResetResult (interp);
	  free (tempstr);
	  Tcl_AppendResult (interp, "\n",(char*)NULL);
	  return 0;
   }
   Tcl_ResetResult (interp);
   free (tempstr);
   return 1;  
}


/* check: ist das aktuelle Wort bzw. sind die Zeichen des Wortes in der Tabelle?*/
int IsObjInTab (char* tempword, int * curposptr, SMif_table * tableptr, int seen) 
{
   int templen, mm;
			   
   if (tempword == NULL) return 0;
   templen = strlen(tempword);
   if (seen) {
	  for (mm=0; mm < templen; mm++) 
		 if ( isinchartable (tempword[mm],tableptr->chartable)) {
			(*curposptr) += (mm+1);
			return 1;
		 }
	  if (isinwordtable (tempword, tableptr->wordtable)) {
		 (*curposptr) += templen;	
		 return 1;
	  }
   } else {
	  if (isinwordtable (tempword, tableptr->wordtable))
		 return 1;
	  for (mm=0; mm < templen; mm++)
		 if (isinchartable (tempword[mm],tableptr->chartable)) {
			(*curposptr) += mm;
			return 1;
		 }
   }
   return 0;
}	
	  
	  
/* IsNPNLString */
int IsNPNLString (char* string, SMif_table * npnltabptr) 
{
   int length, occours;
   struct SMif_charlistitem * charitemptr;
   struct SMif_wordlistitem * worditemptr;
   
   if (string == NULL || npnltabptr->chartable == NULL && 
	   npnltabptr->wordtable == NULL) return 0;
   length = strlen(string);
   for (charitemptr = npnltabptr->chartable; charitemptr!=NULL; 
		charitemptr = charitemptr->next)
	  if (string[length-1] == charitemptr->SMifchar) {
		 string[length-1] = '\0';
		 return 1;
	  }
   for (worditemptr = npnltabptr->wordtable; worditemptr!=NULL;
		worditemptr = worditemptr->next)
	  if ( (occours = SMif_occour(string, worditemptr->SMifword)) > 0 &&
		   SMif_at (string, worditemptr->SMifword, occours) + 
		   strlen(worditemptr->SMifword)  == length) {
		 string[SMif_at(string,worditemptr->SMifword,occours)] = '\0';
		 return 1;
	  }
   return 0;
}  


/* Get next word from current position */
char * GetNextWord (FileBuffer* fbptr, SMif_table* ignotabptr, int *lgetcount)
{
   LineBuffer* lbptr = &(fbptr->lines[fbptr->curline]);
   char * curword = NULL;
   
   if (fbptr->eof) return NULL;
   curword = SMif_getword (lbptr->line+lbptr->curpos,1,
			  ignotabptr->chartable);
   lbptr->curpos += SMif_lwastecount (lbptr->line+lbptr->curpos,
			  ignotabptr->chartable);		   
   while ( curword == NULL && !fbptr->eof || 
		   isinwordtable(curword,ignotabptr->wordtable))
   {
	  if (curword == NULL) {
		 fbptr->curline ++;
		 if (fbptr->curline >= fbptr->linecount) {
			fbptr->curline = fbptr->linecount-1;
			fbptr->eof = 1;
			break;
		 } else {
			lbptr ++;
			if (lgetcount != NULL) (*lgetcount)++;
			lbptr->curpos = 0;
		 }
	  } else {
		 lbptr->curpos += strlen(curword);
		 free(curword);
	  }
	  curword = SMif_getword(lbptr->line+lbptr->curpos,1,
				ignotabptr->chartable);
	  lbptr->curpos += SMif_lwastecount (lbptr->line+lbptr->curpos,
					   ignotabptr->chartable);
   }    
   return curword;
}

/* Get next word with attention of NPNL from current position */
char * GetNextWord_NPNL (FileBuffer* fbptr, SMif_table* ignotabptr,
						 SMif_table* npnltabptr, NPNLTrack *trackheadptr, int* lgetcount)
{
   NPNLTrack tracktemp=NULL, tracktail = NULL;
   int linerestcount = 0;
   int npnlcount = 0;
   LineBuffer* lbptr = &(fbptr->lines[fbptr->curline]);
   char *result = NULL, *tempstr = NULL;
   int isnpnl, seeeof;
   int templen;
   
   if (*trackheadptr != NULL) {
	  for (tracktemp = *trackheadptr; tracktemp!=NULL;) {
		 *trackheadptr = tracktemp->next;
		 if (tracktemp->word != NULL) free (tracktemp->word);
		 free (tracktemp);
		 tracktemp = *trackheadptr;
	  }
	  *trackheadptr = tracktemp = NULL;
   }
      
   if (npnltabptr->chartable == NULL && npnltabptr->wordtable == NULL)
	  return (GetNextWord(fbptr,ignotabptr,lgetcount));
   if (!fbptr->eof)
	  linerestcount = SMif_wordcount (lbptr->line+lbptr->curpos,ignotabptr->chartable);
   
   while (!fbptr->eof && (result == NULL || 
		  isinwordtable(result,ignotabptr->wordtable)) ) {
	  if (result != NULL) {
		 free (result);
		 result = NULL; 
	  }
	  if (linerestcount >= 1) {
		 result =  SMif_getword(lbptr->line+lbptr->curpos,1,ignotabptr->chartable);
		 lbptr->curpos += SMif_lwastecount (lbptr->line+lbptr->curpos,
						  ignotabptr->chartable);			   
		 if (linerestcount == 2) {
			if (tempstr != NULL) free (tempstr);
			tempstr = SMif_getword(lbptr->line + lbptr->curpos, 2, 
								   ignotabptr->chartable);
			if ( isinwordtable (tempstr, ignotabptr->wordtable)) {
			   free (tempstr);
			   tempstr = NULL;
			}
		 }	   
		 		  
		 if (linerestcount == 1 && IsNPNLString(result,npnltabptr) ||
			  linerestcount == 2 && tempstr != NULL &&
			  ( isinwordtable (tempstr, npnltabptr->wordtable) || 
				strlen(tempstr)==1 && isinchartable (tempstr[0],npnltabptr->chartable)
			   ) )   /* NPNL */
		 {
			npnlcount = 1;				  
			isnpnl = 1;
			seeeof = 0;

			if (*trackheadptr != NULL) {
			   for (tracktemp = *trackheadptr; tracktemp!=NULL;) {
				  *trackheadptr = tracktemp->next;
				  if (tracktemp->word != NULL) free (tracktemp->word);
				  free (tracktemp);
				  tracktemp = *trackheadptr;
			   }
			   *trackheadptr = tracktemp = NULL;
			}
		    *trackheadptr = (NPNLTrack) malloc (sizeof(struct NPNLTrackItem));
			(*trackheadptr)->line   = 0;
			(*trackheadptr)->seeeof = 0;
			(*trackheadptr)->curlen = strlen(result);
			(*trackheadptr)->word   = result;
			result = NULL;
			(*trackheadptr)->next = NULL;
			(*trackheadptr)->last = NULL;
			tracktail = *trackheadptr;
			 				  
			if (fbptr->curline >= fbptr->linecount -1) {
			   (*trackheadptr)->seeeof = 1;
			   isnpnl = 0;
			}  /* last line: keine Fortsetzung! */	
				  	  
			while (isnpnl) {
					
				linerestcount = SMif_wordcount ((lbptr+npnlcount)->line,
												ignotabptr->chartable);			 
				
				tracktemp = (NPNLTrack)malloc(sizeof(struct NPNLTrackItem));
				tracktemp->seeeof = 0;
				tracktemp->line   = npnlcount;
				tracktemp->curlen = (*trackheadptr)->curlen; /* sum */
				tracktemp->next = *trackheadptr;
				tracktemp->last = NULL;
				tracktemp->word = SMif_getword((lbptr+npnlcount)->line,1,
								   ignotabptr->chartable);					 				
				(lbptr+npnlcount)->curpos = SMif_lwastecount( (lbptr+npnlcount)->line,
											ignotabptr->chartable);		
				(*trackheadptr)->last  = tracktemp;
				*trackheadptr = tracktemp;
									 
				if (linerestcount == 0) break;
							
				if (linerestcount == 2) {
				   if (tempstr != NULL) free (tempstr);
				   tempstr = SMif_getword ((lbptr+npnlcount)->line, 2, 
								   ignotabptr->chartable);
				   if (isinwordtable (tempstr, ignotabptr->wordtable)) {
					  free (tempstr);
					  tempstr = NULL;
				   }
				}
				if (linerestcount == 1 && IsNPNLString ((*trackheadptr)->word,npnltabptr) ||
					linerestcount == 2 && tempstr != NULL &&
					( isinwordtable (tempstr, npnltabptr->wordtable) ||
					  strlen(tempstr)==1 && 
					  isinchartable (tempstr[0],npnltabptr->chartable) ) ) 
				{
				   if (fbptr->curline + npnlcount + 1 >= fbptr->linecount) {
					  (*trackheadptr)->seeeof = 1;
					  isnpnl = 0;
				   }
				   else npnlcount ++;
				}						   
				else isnpnl = 0; 
					 
				(*trackheadptr)->curlen += strlen((*trackheadptr)->word);					 
			}  /* while (isnpnl) */
				  
			result = (char*)malloc(sizeof(char)*((*trackheadptr)->curlen+1));
			templen = 0;
			for (tracktemp = tracktail; tracktemp != NULL && tracktemp->word!=NULL; 
				 tracktemp = tracktemp->last) {   /* word == NULL : empty line */
			   (void)strcpy( result+templen, tracktemp->word);
				templen = tracktemp->curlen;
			}			   
		 } /* if NPNL */	  
	  }   /* end of "if (linerestcount >= 1) {...}" */
	  else {
		 while (linerestcount < 1) {  /* linerestcount < = 0 */
			fbptr->curline ++;
			if (fbptr->curline >= fbptr->linecount) {
			   fbptr->eof = 1; 
			   fbptr->curline = fbptr->linecount - 1;
			   break; 
			} else {
			   lbptr ++;
			   if (lgetcount != NULL) (*lgetcount)++;
			   linerestcount = SMif_wordcount (lbptr->line,
									 ignotabptr->chartable);
			}
		 }
	  }
   } 
   if (tempstr != NULL) free(tempstr);
   return result;
}


void SetNewFbptr (FileBuffer * fbptr, NPNLTrack trackhead, int breakp)
{
   NPNLTrack tracktemp = NULL;
   LineBuffer * lbptr = &(fbptr->lines[fbptr->curline]);
   
   if (trackhead != NULL) {
	  for (tracktemp = trackhead; tracktemp->next != NULL &&
		   tracktemp->next->curlen >= breakp + 1; tracktemp = tracktemp->next);
	  fbptr->curline += tracktemp->line;
	  lbptr += tracktemp->line; 
	  if (tracktemp->next == NULL)
		 lbptr->curpos += breakp;
	  else
		 lbptr->curpos += (breakp - tracktemp->next->curlen);
   } else
	  lbptr->curpos += breakp;
}


/* GETItemWord : return 1 : end */
int GetItemWord (SMifinfo *smifptr, int *stopget, int flag)
{
   int mm , nn, ll, templen, tempcount, requiredint;
   int breakget = 0;
   char *curword = NULL;
   Tcl_Interp * interp = smifptr->interp;
   SMif_table *ignotabptr = &(smifptr->envinfo->ignotable);
   SMif_table *npnltabptr = &(smifptr->envinfo->npnltable);
   SMif_table *repeattabptr = &(smifptr->envinfo->repeattable);
   SMif_table *stoptabptr = &(smifptr->envinfo->stoptable);
   FileBuffer * fbptr = &(smifptr->fbuffer);
   GetInfo    *getinfoptr = &(smifptr->envinfo->getinfo);
   ItemInfo   *iteminfoptr = &(smifptr->envinfo->iteminfo);
   char  **itemword = NULL;
   char  *tempstr1 = NULL, *tempstr2 = NULL;
   static char  tempname[4];
   struct SMif_intinwordinfo intinwordinfo;
   struct SMif_intinfoitem  *intinfoptr = NULL;
   NPNLTrack trackhead = NULL, tracktemp = NULL;    
   
   itemword = (char**) malloc (sizeof(char*) * iteminfoptr->itemsize);
   for (nn=0; nn < iteminfoptr->itemsize; nn++)
	  itemword[nn] = NULL;
   tempname[0] = '$';
   intinwordinfo.count = 0;
   intinwordinfo.intinfo = NULL;
   
   	  
   mm = 0;
   while ( mm < iteminfoptr->itemsize) {
	  
	  if ((getinfoptr->type == SMif_GETLIST || 
		   getinfoptr->type == SMif_GETPOL) && 
		   getinfoptr->subtype == LINENEXT)
		 curword = GetNextWord_NPNL (fbptr, ignotabptr, npnltabptr, 
							  &trackhead, &(getinfoptr->getcount));
	  else
		 curword = GetNextWord_NPNL (fbptr, ignotabptr, npnltabptr,
							  &trackhead, (int*)NULL);
	  	  		 
	  if (fbptr->eof || ( getinfoptr->type == SMif_GETLIST ||
		  getinfoptr->type == SMif_GETPOL) && 
		  getinfoptr->subtype == LINENEXT && 
		  getinfoptr->getcount >= getinfoptr->count)  /* fbptr->eof <==> curword == NULL */
	  {
		 if (curword != NULL) {
			free (curword); curword = NULL;
		 } 
		 breakget = 1;
		 break;
	  }			 
		 
	  /* check: break get command ? */
	  templen = strlen(curword);    /* word */
	  if (isinwordtable (curword,stoptabptr->wordtable) ||
		  isinwordtable (curword,repeattabptr->wordtable) ||
		  isinchartable (curword[0],stoptabptr->chartable) ||
		  isinchartable (curword[0],repeattabptr->chartable) )
	  {  
		 free (curword);
		 curword = NULL;
		 breakget = 1;
		 break; 
	  }
		 
	  for (nn = 0; nn < templen; nn++)   /* char */
		 if (isinchartable (curword[nn],stoptabptr->chartable) ||
			 isinchartable (curword[nn],repeattabptr->chartable) )
		 {
			curword[nn] = '\0';
			breakget = 1;
			break;
		 }
		 
	  if (flag == DIGITONLY) {
		 SMif_findintinword (curword, &intinwordinfo);
		 		 
		 requiredint = iteminfoptr->itemsize - mm;
		 for (intinfoptr = intinwordinfo.intinfo; 
			  intinfoptr != NULL && mm < iteminfoptr->itemsize;
			  intinfoptr = intinfoptr->next, mm++) 
		 {
			itemword[mm] = (char*)malloc (sizeof(char)*(intinfoptr->length+1));
			(void) strncpy (itemword[mm],curword+intinfoptr->pos, intinfoptr->length);
			itemword[mm][intinfoptr->length] = '\0';
		 }
		 
		 if (intinfoptr!=NULL && mm == iteminfoptr->itemsize) /* more int than required */
		 {
			breakget = 0;
			if (trackhead!=NULL) trackhead->seeeof = 0;
			for (intinfoptr = intinwordinfo.intinfo, ll = 1; ll < requiredint; ll++)
			   intinfoptr = intinfoptr->next;
			SetNewFbptr (fbptr, trackhead, intinfoptr->pos + intinfoptr->length);		
		 }	
		 else if (breakget) {
			SetNewFbptr (fbptr, trackhead, nn);
			break;
		 }
		 else SetNewFbptr (fbptr, trackhead, templen);
	  }
	  else if (flag == ALLCHAR) {
		 itemword[mm] = (char*)malloc (sizeof(char)*(strlen(curword)+1));
		 (void) strcpy (itemword[mm],curword);
		 mm ++;
		 if (breakget) {
			SetNewFbptr (fbptr, trackhead, nn);
			break;
		 }
		 else SetNewFbptr (fbptr, trackhead, templen);
	  } 
	  
	  if (trackhead!=NULL && trackhead->seeeof) {
			fbptr->eof = 1;
			breakget = 1;
			break;
	  }
	  if (curword != NULL) {
		 free (curword);
		 curword = NULL;
	  }
   } /* while ( mm < size ) */	 											 
	
   Tcl_ResetResult (interp);		   
   if (itemword[0]!=NULL) {
	  if (itemword[iteminfoptr->itemsize-1] == NULL 
		  && iteminfoptr->pattern!=NULL) 
	  {
		 tempcount = (itemword[mm] == NULL ? mm : mm+1);  /* nummer of valid items */
		 for (mm = tempcount+1; mm <= iteminfoptr->itemsize; mm++) {
			sprintf (tempname+1, "%d", mm);
			if (mm >= 10) tempname[3] = '\0';
			else tempname[2] = '\0';
			if (SMif_at (iteminfoptr->pattern, tempname, 1) != -1) {
			   Tcl_AppendResult (interp, "GET LIST: conflict with ITEM definition",
							 (char*)NULL );
			   return TCL_ERROR;
			}			      
		 } 
	  } else
		 tempcount = iteminfoptr->itemsize;
 
	  if (iteminfoptr->pattern!=NULL) {
		 tempstr1 = (char*) malloc(sizeof(char)*(strlen(iteminfoptr->pattern)+1));
		 strcpy (tempstr1, iteminfoptr->pattern);
		 for (mm = 10; mm <= tempcount; mm++) {
			sprintf (tempname+1,"%d",mm);
			tempname[3] = '\0';
			tempstr2 = SMif_strtran (tempstr1,tempname,itemword[mm-1]);
			free (tempstr1);
			tempstr1 = tempstr2;
			tempstr2 = NULL;
		 }
		 for (mm = 1; mm <= (tempcount > 9 ? 9 : tempcount); mm++) {
			sprintf (tempname+1,"%d",mm);
			tempname[2] = '\0';
			tempstr2 = SMif_strtran (tempstr1,tempname,itemword[mm-1]);
			free (tempstr1);
			tempstr1 = tempstr2;
			tempstr2 = NULL;
		 }
		 if (Tcl_ExprString(interp,tempstr1)==TCL_ERROR) {
			free (tempstr1);
			return TCL_ERROR;
		 }
	  }
	  else 
		 Tcl_AppendResult (interp,itemword[0],(char*)NULL);
   
	  if (getinfoptr->type == SMif_GETLIST && getinfoptr->subtype == ITEMNEXT) {
		 getinfoptr->getcount++;
		 if (getinfoptr->getcount ==  getinfoptr->count) 
			breakget = 1;
	  }   
   }	  
   
   if (stopget != NULL)
	  *stopget = breakget;
	  
   for (mm = 0; mm < iteminfoptr->itemsize; mm++) 
	  if (itemword[mm]!=NULL) free (itemword[mm]);
   
   if (tempstr1 != NULL) free (tempstr1);
   if (tempstr2 != NULL) free (tempstr2);
   if (curword != NULL) free (curword);
   if (itemword != NULL) free (itemword);
   if (trackhead != NULL) 
	  for (tracktemp = trackhead; tracktemp!=NULL;) {
		 trackhead = tracktemp->next;
		 if(tracktemp!=NULL) free (tracktemp->word);
		 free (tracktemp);
		 tracktemp = trackhead;
	  }
   if (intinwordinfo.intinfo != NULL)
	  for (intinfoptr = intinwordinfo.intinfo; intinfoptr!=NULL;) {
		 intinwordinfo.intinfo = intinfoptr->next;
		 free (intinfoptr);
		 intinfoptr = intinwordinfo.intinfo;
	  }
   return TCL_OK;
}

