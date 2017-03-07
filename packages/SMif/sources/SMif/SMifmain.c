/************************************************************/
/*            Hauptprogramm von SMif                        */
/************************************************************/

#include "SMif.h"

#define FINAL_DELETE 1
#define Make_Exe     1
 
#if Make_Exe
int main (int argc, char *argv[]){
#else
int SMif (char* name1, char* name2) {
#endif
   
   SMifinfo *SMifptr;
   char *finalresult = NULL;
   int  resultlength, mm;
   int code;
   
#if Make_Exe
   char *name1 = NULL, *name2 = NULL;   
   if (argc != 3) {
	  printf ("Wrong # arguments: ");
	  printf ("should be \"%s TextFileName ScriptFileName\"\n",
			   argv[0]);
	  exit (1);
   }
   name1 = (char*)malloc(sizeof(char)*(strlen(argv[1])+1));
   name2 = (char*)malloc(sizeof(char)*(strlen(argv[2])+1));
   strcpy (name1, argv[1]);
   strcpy (name2, argv[2]);
#else
   if (name1 == NULL || name2 == NULL) {
	  printf ("Wrong arguments: should be \"%s SMif(TextFileName, ScriptFileName)\"\n");
	  return TCL_ERROR;
   }
#endif

   SMifptr = (SMifinfo *) malloc (sizeof (SMifinfo));
   if (SMif_Init (SMifptr, name1) == TCL_ERROR) {
	  printf ("Error: %s \n", SMifptr->interp->result);
#if Make_Exe
	  exit (1);
#else
	  return TCL_ERROR;
#endif
   }
 
   if ((code = Tcl_EvalFile (SMifptr->interp, name2)) == TCL_ERROR) {
	  printf ("Error: %s \n", SMifptr->interp->result);
#if Make_Exe
	  exit (1);
#else
	  return TCL_ERROR;
#endif
   }
    
   Tcl_DeleteInterp(SMifptr->interp);
   SMifptr->interp = NULL;

   resultlength = Tcl_DStringLength (&(SMifptr->result));      
   finalresult = (char*) malloc (sizeof(char) * (resultlength+1));
   strcpy (finalresult, Tcl_DStringValue(&(SMifptr->result)));
   printf ("%s \n",finalresult);
   
   #if FINAL_DELETE
   DeleteAll(SMifptr);
   #endif
   
   free (finalresult);
   return TCL_OK;
}
