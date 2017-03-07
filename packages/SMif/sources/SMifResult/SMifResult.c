#include "SMifResult.h"
 
void SMifRes_Init (SMifRes *smifresptr)
{
   *smifresptr = (SMifRes) malloc (sizeof(struct SMifResult));
   (*smifresptr)->count = 0;
   (*smifresptr)->errcode = SMif_ok;
   (*smifresptr)->errstr = NULL;
   (*smifresptr)->result = NULL;
   (*smifresptr)->cshfile = (char*) malloc (sizeof(char)*10);
   strcpy ((*smifresptr)->cshfile,"/bin/csh");
}

void SMifRes_SetCsh (SMifRes smifres, char* cshfile)
{
   if (cshfile == NULL) return;
   if (smifres->cshfile != NULL) free (smifres->cshfile);
   smifres->cshfile = (char*) malloc (sizeof(char)*(strlen(cshfile)+1));
   strcpy (smifres->cshfile, cshfile);
}

void SMifRes_Free (SMifRes *smifresptr)
{
   if (*smifresptr == NULL) return;
   if ((*smifresptr)->cshfile != NULL) free ((*smifresptr)->cshfile);
   if ((*smifresptr)->errstr != NULL) free ((*smifresptr)->errstr);
   if ((*smifresptr)->result != NULL) free ((*smifresptr)->result);
   free (*smifresptr);
   *smifresptr = NULL;
}

void SMifRes_FromFile (SMifRes smifres, char * filename, char * scriptname)
{
   FILE * fileptr = NULL;
   char   line[MAXLINE];
   char   errmsg[MAXERROR];
   int    ch_pid, ch_stat, status;
   int    tempint, blankcount;
   int    mm;
   
   if (smifres->errstr != NULL) {
	  free (smifres->errstr);
	  smifres->errstr = NULL;
   }
   if (smifres->result != NULL) {
	  free (smifres->result);
	  smifres->result = NULL;
   }
   smifres->errcode = SMif_ok;
   smifres->count   = 0;
   
   if (filename == NULL || scriptname == NULL ||
	   strcmp(filename,"") == 0 || strcmp(scriptname,"")==0) {
	  SMifRes_seterror (smifres,
		"SMifRes_FromFile Error: textfile or scriptfile not defined\n");
	  return;
   }
   
   if (smifres->cshfile == NULL) {
	  SMifRes_seterror (smifres,
		"SMifRes_FromFile Error: shell script interpreter csh not defined\n");
	  return;
   }
   
   if ((fileptr = fopen (SMif_execfile,"w"))== NULL) {
	  SMifRes_seterror (smifres,
		"SMifRes_FromFile Error: create tempfile: Permission denied\n");
	  return;
   }
   
   sprintf (line, "#!%s\n",smifres->cshfile);
   fputs (line,fileptr);
   sprintf (line,"%s %s %s >& %s\n",SMif_exec, filename, scriptname, SMif_output);
   fputs (line,fileptr);
   fclose (fileptr);
   if (chmod (SMif_execfile,S_IRWXU) != 0) { /* read,write,run from owner */
          if (errno!=0) {
          #if _USE_STRERROR            
             SMifRes_seterror (smifres, strerror(errno));
          #else
             if (errno <= sys_nerr)
                SMifRes_seterror (smifres, sys_errlist[errno]);
             else
                SMifRes_seterror (smifres, "chmod error\n");
          #endif
          }
	  else SMifRes_seterror (smifres, "SMifRes_FromFile : chmod error\n");
	  errno = 0;
	  return;
   }
   
   if (( ch_pid = fork()) < 0) {
	  if (errno != 0)  {
          #if _USE_STRERROR            
             SMifRes_seterror (smifres, strerror(errno));
          #else
             if (errno <= sys_nerr)
                SMifRes_seterror (smifres, sys_errlist[errno]);
             else
                SMifRes_seterror (smifres, "fork error\n");
          #endif
          }
	  else SMifRes_seterror (smifres, "SMifRes_FromFile : fork error\n");
	  errno = 0;
	  return;
   } 
   else if (ch_pid == 0) {	 /* child process */
      execl(SMif_execfile, SMif_execfile, (char*)0);
      if (errno!=0)  {
      #if _USE_STRERROR            
         SMifRes_seterror (smifres, strerror(errno));
      #else
         if (errno <= sys_nerr)
            SMifRes_seterror (smifres, sys_errlist[errno]);
         else
            SMifRes_seterror (smifres, "execl error");
      #endif
      }
      else SMifRes_seterror (smifres, "SMifRes_FromFile : execl error\n");
      errno = 0;
      return;
   } 
   else {        /* parent */
      while ((status = wait(&ch_stat)) != ch_pid) {
         if (status < 0 && errno == ECHILD)  /* no existing unwaited-for child */ 
            break;
         errno = 0;
      }
      if ((fileptr = fopen (SMif_output,"r")) == NULL) {
		 SMifRes_seterror (smifres, "SMifRes_FromFile : SMif outputfile not found\n");
		 return;
	  }
	  strcpy (line, "");  /* empty line returned from fgets "\n" */	  
	  blankcount = -1;
	  while (!feof(fileptr) && strcmp(line,"")==0) {
		 fgets (line, MAXLINE, fileptr);
		 if ((mm = strlen(line)) >0 && line[mm-1] == '\n')
			line[mm-1] = '\0';
		 blankcount ++;
	  }
	  if (feof(fileptr))
		 SMifRes_seterror (smifres, "no result found\n");
	  else if (strcmp (line, "[POL]")!= 0 && strcmp(line,"[INT]")!=0 &&
			   strcmp (line, "[SINGLE]")!= 0 && strcmp(line,"[LIST]")!=0) {
		 strcpy (errmsg,"");
		 while (!feof(fileptr)) {
			strcpy (errmsg + strlen(errmsg),line);
			fgets(line, MAXLINE, fileptr);
		 }
		 SMifRes_seterror (smifres, errmsg);
	  }
	  else {
		 while (!feof(fileptr) && strcmp(line,"\n")!=0) { /* empty line*/
			tempint ++;
			fgets (line, MAXLINE, fileptr);
		 }
		 smifres->count = tempint / 2;
		 smifres->result = (struct SMifResultItem *) malloc (smifres->count * 
							sizeof (struct SMifResultItem));
		 for (tempint = 0; tempint < smifres->count; tempint++) {
			smifres->result[tempint].type = SM_unknown;
			smifres->result[tempint].resultstr = NULL;
		 }
		 
		 (void)fseek (fileptr,0,SEEK_SET);
		 for (tempint = 0; tempint < blankcount; tempint++)
			fgets (line, MAXLINE, fileptr);
		 tempint = 0;
		 while (!feof(fileptr)) {
			fgets (line, MAXLINE, fileptr);
			if ((mm = strlen(line)) >0 && line[mm-1] == '\n')
			   line[mm-1] = '\0';
			if (strcmp (line,"")==0) 
			   break;
			else if (strcmp (line, "[POL]") == 0) 
			   smifres->result[tempint].type = SM_pol;
			else if (strcmp (line, "[SINGLE]") == 0)
			   smifres->result[tempint].type = SM_single;
			else if (strcmp (line, "[LIST]") == 0)
			   smifres->result[tempint].type = SM_list;
			else if (strcmp (line, "[INT]") == 0)
			   smifres->result[tempint].type = SM_int;
			   			   			   
			fgets(line, MAXLINE, fileptr);
			if ((mm = strlen(line)) >0 && line[mm-1] == '\n')
			   line[mm-1] = '\0';			
			smifres->result[tempint].resultstr = (char*)malloc(sizeof(char)*
							(strlen(line)+1));
			strcpy (smifres->result[tempint].resultstr,line);
			tempint++;
		 }
	  }
	  (void)fclose(fileptr);
   }
#if FINALCLEAN
   SMifRes_deltmp(smifres);
#endif  
}
 
void SMifRes_FromProg (SMifRes smifres, char* progname, char* paralist, char* scriptname)
{
   FILE * fileptr = NULL;
   char   line[MAXERROR];
   char   errmsg[MAXERROR];
   int    ch_pid, ch_stat, status;
   
   if (smifres->errstr != NULL) {
	  free (smifres->errstr);
	  smifres->errstr = NULL;
   }
   if (smifres->result != NULL) {
	  free (smifres->result);
	  smifres->result = NULL;
   }
   smifres->errcode = SMif_ok;
   smifres->count   = 0;
   
   if (progname == NULL || scriptname == NULL ||
	   strcmp(progname,"") == 0 || strcmp(scriptname,"")==0) {
	  SMifRes_seterror (smifres,
		"SMifRes_FromProg Error: progname or scriptfile not defined\n");
	  return;
   }
   
   if (smifres->cshfile == NULL) {
	  SMifRes_seterror (smifres,
		"SMifRes_FromProg Error: shell script interpreter csh not defined\n");
	  return;
   }

#if BEGINCLEAN 
   SMifRes_deltmp(smifres);
#endif   
 
   if ((fileptr = fopen (SMif_execfile,"w"))== NULL) {
	  SMifRes_seterror (smifres,
		"SMifRes_FromProg Error: create tempfile: Permission denied\n");
	  return;
   }
   
   sprintf (line, "#!%s\n",smifres->cshfile);
   fputs (line,fileptr);
   if (paralist == NULL)
	  sprintf (line,"%s >& %s\n",progname, SMif_progoutput);
   else
	  sprintf (line,"%s %s >& %s\n",progname, paralist, SMif_progoutput);
   fputs (line,fileptr);
   fclose (fileptr);
   
   if (chmod (SMif_execfile,S_IRWXU) != 0) { /* read,write,run from owner */
	  if (errno!=0)  {
          #if _USE_STRERROR            
             SMifRes_seterror (smifres, strerror(errno));
          #else
             if (errno <= sys_nerr)
                SMifRes_seterror (smifres, sys_errlist[errno]);
             else
                SMifRes_seterror (smifres, "chmod error");
          #endif
          }
	  else SMifRes_seterror (smifres, "SMifRes_FromProg : chmod error\n");
	  errno = 0;
	  return;
   }
   
   if (( ch_pid = fork()) < 0) {
	  if (errno != 0)  {
          #if _USE_STRERROR            
             SMifRes_seterror (smifres, strerror(errno));
          #else
             if (errno <= sys_nerr)
                SMifRes_seterror (smifres, sys_errlist[errno]);
             else
                SMifRes_seterror (smifres, "fork error");
          #endif
          }
	  else SMifRes_seterror (smifres, "SMifRes_FromProg : fork error\n");
	  errno = 0;
	  return;
   } 
   else if (ch_pid == 0) {	 /* child process */
      execl(SMif_execfile, SMif_execfile, (char*)0);
      if (errno!=0)  {
      #if _USE_STRERROR            
         SMifRes_seterror (smifres, strerror(errno));
      #else
         if (errno <= sys_nerr)
            SMifRes_seterror (smifres, sys_errlist[errno]);
         else
            SMifRes_seterror (smifres, "execl error\n");
      #endif
      }
      else SMifRes_seterror (smifres, "SMifRes_FromProg : execl error\n");
      errno = 0;
      return;
   } 
   else {        /* parent */
      while ((status = wait(&ch_stat)) != ch_pid) {
         if (status < 0 && errno == ECHILD)  /* no existing unwaited-for child */ 
            break;
         errno = 0;
      }
	  SMifRes_FromFile (smifres, SMif_progoutput, scriptname);
   }
}
 

void SMifRes_deltmp (SMifRes smifres)
{
   FILE * fileptr = NULL;
   char   line[MAXERROR];
   int    ch_pid, ch_stat, status;
      
   if ((fileptr = fopen (SMif_execfile,"w"))== NULL)
	  return;	  
   sprintf (line, "#!%s\n",smifres->cshfile);
   fputs (line,fileptr);
   fputs ("alias rm rm >& /dev/null\n",fileptr);
   sprintf (line, "rm %s >& /dev/null\n", SMif_progoutput);
   fputs (line, fileptr);
   sprintf (line, "rm %s >& /dev/null\n", SMif_output);
   fputs (line, fileptr);
#if FINALCLEAN
   sprintf (line, "rm %s >& /dev/null\n", SMif_execfile);
   fputs (line, fileptr);
#endif
   fputs ("alias rm rm -i >& /dev/null\n", fileptr);
   (void)fclose (fileptr);
   if (chmod (SMif_execfile,S_IRWXU) != 0) { /* read,write,run from owner */
	  errno = 0;  /* nothing to do */
	  return;
   }   
     
   if (( ch_pid = fork()) < 0) {
	  errno = 0;
	  return;
   }
   else if (ch_pid == 0) {	 /* child process */
      execl(SMif_execfile, SMif_execfile, (char*)0);
	  errno = 0;
   } 
   else         /* parent */
      while ((status = wait(&ch_stat)) != ch_pid) {
         if (status < 0 && errno == ECHILD)  /* no existing unwaited-for child */ 
            break;
         errno = 0;
      }         
}
 
 
void SMifRes_seterror (SMifRes smifres, char* errstr)
{
   char SMifRes_temperr[MAXERROR];
   
   strcpy (SMifRes_temperr, errstr); 
   smifres->errcode = SMif_error;
   if (smifres->errstr!=NULL) free(smifres->errstr);
   smifres->errstr = (char*)malloc(sizeof(char)*(strlen(SMifRes_temperr)+1));
   strcpy (smifres->errstr,SMifRes_temperr);
}   
