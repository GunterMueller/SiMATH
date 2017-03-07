/*
// SMifpowerstring: more string functions
*/ 
  
#include "SMifpowerstring.h"

/*****************************************************************************/
/*                            SMif_ltrim                                     */
/*  Loescht die Zeichen, die in der Tabelle 'table' vorkommen, vom linken    */
/*  Seite des Strings 'string'.  Returnvalue: Anzahl der geloeschten Zeichen */
/*  -1 , falls NULL String.                                                  */
/*****************************************************************************/
           
int SMif_ltrim (char *string, SMif_ignotable table)
{
   int tempint, tempint2;
   if (string==NULL) return (-1);
   for (tempint=0; isignoredc(string[tempint],table); tempint++);
   if (tempint > 0){
	  for (tempint2 = 0; string[tempint2+tempint]!='\0';tempint2++)
		 string[tempint2] = string[tempint2+tempint];
	  string[tempint2] = '\0';
   }
   return tempint;
}

/*****************************************************************************/
/*                           SMif_rtrim                                      */
/*  Loescht die Zeichen, die in der Tabelle 'table' vorkommen, vom rechten   */
/*  Seite des Strings 'string'. Returnvalue: Anzahl der geloeschten Zeichen  */
/*  -1, falls string == NULL.                                                */
/*****************************************************************************/

int SMif_rtrim (char* string, SMif_ignotable table)
{ 
   int len, tempint;
   if (string==NULL) return (-1);
   len = strlen(string)-1;
   for (tempint=0; isignoredc(string[len-tempint],table); tempint++);
   string[len-tempint+1] = '\0';
   return tempint;
}

/*****************************************************************************/
/*                           SMif_alltrim                                    */
/*  Eine Kombination von SMif_ltrim und SMif_rtrim.                          */
/*****************************************************************************/

int SMif_alltrim (char* string, SMif_ignotable table)
{
   int temp1, temp2;
   if ( (temp1 = SMif_ltrim(string,table)) == -1) return -1;
   if ( (temp2 = SMif_rtrim(string,table)) == -1) return -1;
   return (temp1+temp2);
}

/*****************************************************************************/
/*                          SMif_wordcount                                   */
/*  Anzahl der Woerter im String 'string' bzgl. der Tabelle der zu igno-     */
/*  rierende Zeichen 'table'.                                                */
/*****************************************************************************/

int SMif_wordcount (const char* string, SMif_ignotable table )
{
   int temp = 0, count = 0;
   if (string == NULL) return 0;
   while (string[temp]!='\0') {
	  for ( ;isignoredc(string[temp],table); temp++); 
	  if (string[temp]!='\0') {
		 count++;
		 for (;!isignoredc(string[temp],table) && string[temp]!= '\0';temp++);
	  }
   }
   return count;
}

/*****************************************************************************/
/*                               SMif_wordpos                                */
/* An welcher Stelle liegt das zu suchende Word 'tofind' im string 'string'? */
/* Returnvalue: -1 : NULL pointer. 0 : nicht gefunden. 1 : das erste.   2 .. */
/*****************************************************************************/

int SMif_wordpos (const char* string, const char* tofind, 
				  SMif_ignotable table, int which)
{
   int temp = 0, pos = 0, count = 0;
   int temp2;
   int len = strlen(tofind);
   for (temp2 = 0; temp2 < len; temp2++)  /* is 'tofind' a word? */
	  if (isignoredc(tofind[temp2],table)) return -1;   
   if (string == NULL || tofind == NULL || len == 0) return -1;
   while (string[temp] != '\0') {
	  for (;isignoredc(string[temp],table);temp++);
	  if (string[temp] != '\0'){
		 pos ++;
		 for (temp2=0; temp2<=len-1 && string[temp+temp2]==tofind[temp2];
			  temp2++);
		 if (temp2 == len && (count++) == which) return pos; 
		 temp+=temp2;
		 for (;!isignoredc(string[temp],table) && string[temp]!='\0';temp++);
	  }
   }
   return 0;
}

/*****************************************************************************/
/*                            SMif_substrwords                               */
/*  gibt die Teilstring der String 'string' zurueck, die das 'pos'-te bis    */
/*  'pos + count -1'-te Wort beinhaltet.  (NULL falls 'string' == NULL oder  */
/*  SMif_wordcount('string') < pos )                                         */
/*  !! Die Zurueckgegebene Teilstring muss vom Aufrufer freigegeben werden.  */
/*****************************************************************************/
 
char* SMif_substrwords (const char* string, SMif_ignotable table,
					   int pos, int count) 
{
   int posw, posc, mm;
   int lable1, lable2; 
   char *tempstr;
   
   if (string == NULL) return NULL;
   lable1 = lable2 = -1;
   posw = posc = 0;
   while (string[posc] != '\0') {
	  for (;isignoredc(string[posc],table); posc++);
	  if (string[posc] != '\0') {
		 posw ++;
		 if (posw == pos) lable1 = posc; 
		 for (; !(isignoredc(string[posc],table)) && string[posc]!= '\0';posc++);
		 if (count != 0 && posw == pos + count -1)
			lable2 = posc;
	  }
   }
   if (lable1 == -1) return NULL;
   if (lable2 == -1) lable2 = posc;
   tempstr = (char*) malloc (sizeof(char) * (lable2 - lable1 +1));
   for (mm = 0; mm < lable2 - lable1; mm++)
	  tempstr[mm] = string[mm+lable1];
   tempstr[mm] = '\0';
   return tempstr;
}

/*****************************************************************************/
/*                          SMif_getword                                     */
/*  gibt das 'pos'-te Wort in der String 'string' bzgl. 'table' zurueck.     */
/*  !! das zurueckgegebene Wort muss vom Aufrufer freigegeben werden.        */
/*  ( NULL falls misslungen. )                                               */
/*****************************************************************************/
				 
char* SMif_getword (const char* string, int pos, SMif_ignotable table)
{
   int temp = 0, count = 0;
   int temp2, temp3; char * word = NULL;
   if (string == NULL || pos <1) return NULL;
   while (string[temp]!='\0') {
	  for (;isignoredc(string[temp],table);temp++);
	  if (string[temp]!='\0') {
		 count++;
		 for (temp2=0; ! isignoredc(string[temp+temp2],table) && 
			  string[temp+temp2]!='\0'; temp2++);
		 if (pos == count) {
			word = (char*) malloc (sizeof(char)* (temp2+1));
			if (word == NULL) return word;
			for (temp3 = 0; temp3 < temp2; temp3++)
			   word[temp3] = string[temp+temp3];
			word[temp2] = '\0';
			return word;
		 }
		 temp+=temp2;
	  }
   }
   return NULL;
}       		 		     

/*****************************************************************************/
/*                            SMif_occour                                    */
/*  gibt die Anzahl der  Vorkommen von 'tofind' in 'string' zurueck.         */
/*  (ignotable unabhaengig)                                                  */
/*****************************************************************************/

int SMif_occour (const char *string, const char *tofind)
{
   int temp1 = 0, temp2 = 0, count = 0;
   
   if (string == NULL || tofind == NULL) return -1;
   while (string[temp1]!='\0') {
	   for (temp2 = 0; string[temp1+temp2] == tofind[temp2]; temp2++);
	   if (tofind[temp2] == '\0') {
		  count ++; 
		  temp1 += temp2;
	   } else temp1++;
   }
   return count;
}
 
/*****************************************************************************/
/*                            SMif_at                                        */
/*  gibt die Position des 'which'-ten Vorkommens von 'tofind' zurueck.       */
/*  Anfangsposition 0, -1, falls nicht gefunden.                             */
/*  (ignotable unabhaengig)                                                  */
/*****************************************************************************/
    
int SMif_at (const char* string, const char* tofind, int which)
{
   int temp1 = 0, temp2 = 0, count = 0;		 
   
   if (string == NULL || tofind == NULL || which < 1) return -1;
   while (string[temp1] != '\0') {
	  for (temp2 = 0; string[temp1+temp2] == tofind[temp2] && 
		   tofind[temp2] != '\0'; temp2++);
	  if (tofind[temp2] == '\0' && (++count) == which ) return temp1;
	  temp1 ++;
   }
   return -1;
}

/*****************************************************************************/
/*                            SMif_substr                                    */
/* gibt die Teilstring von 'string' ab Posion 'pos' mit Laenge 'count' zu-   */
/* rueck. Falls count zu groess ist, dann nur bis Stringende.                */
/* !!! Die zurueckgegebene String muss vom Aufrufer freigegeben werden.      */
/*****************************************************************************/

char * SMif_substr (const char* string, int pos, int count)
{
   int len1, len2;
   char *rtn;
   
   len1 = strlen (string);
   if (pos + count > len1 || count < 0) len2 = len1 - pos;
   else len2 = count;
   rtn = (char*) malloc (sizeof(char) * (len2 + 1));
   for (len1 = 0; len1 < len2; len1++) rtn[len1] = string[pos+len1];
   rtn[len1] = '\0';
   return rtn;
}

/*****************************************************************************/
/*                           SMif_strtran                                    */
/*  ersetzt die Teilstring 'tofind' durch 'transtr' in 'string'. Das Ergib-  */
/*  niss wird zurueckgegeben. (ignotable unabhaengig)                        */
/*  !!! Die zurueckgegebens String muss vom Aufrufer freigegenben werden.    */
/*****************************************************************************/
 
char * SMif_strtran (const char* string, const char* tofind, const char* transtr)
{
   int len1 = strlen (string);
   int len2 = strlen (tofind);
   int len3 = strlen (transtr);
   int mm, temp1, temp2, outp;
   int occours = SMif_occour (string, tofind);
   char *result = (char*) malloc (sizeof(char)*(len1+(len3-len2)*occours+1));
   if (string == NULL || tofind == NULL) return NULL;
   
   temp1 = outp = 0;
   while (string[temp1]!='\0') {
	   for (temp2 = 0; string[temp1+temp2] == tofind[temp2] && 
					   string[temp1+temp2] != '\0'; temp2++);
	   if (tofind[temp2] == '\0') {
		  for (mm = 0; mm < len3; mm++) 
			 result[outp+mm] = transtr[mm];
		  outp += mm;
		  temp1 += temp2;
	   } 
	   else {  
		  result[outp] = string[temp1];
		  temp1 ++;
		  outp ++;
	   }
   } 
   result[outp] = '\0';
   return result;  
}

/*****************************************************************************/
/*                          SMif_clearignoredc                               */
/* ersetzt jedes Vorkommen von nacheinander folgenden zu ignorierenden Zei-  */
/* chen durch ein einziges Zeichen 'tren'.                                   */
/* !!! Das zurueckgegebene String muss vom Aufrufer freigegeben werden.      */
/*****************************************************************************/
     		  
char * SMif_clearignoredc (char* string, SMif_ignotable table, char tren)
{
   char* result;
   int len, mm, gettren, pos;
   
   gettren = pos = 0;
   if (string == NULL) return NULL;
   len = strlen(string);
   result = (char*) malloc (sizeof(char)*(len+1));
   for (mm=0; mm < len; mm++) {
	  if (isignoredc(string[mm],table))
		 if ( !gettren && pos!=0) {
			gettren = 1;
			result[pos] = tren; pos++;
		 }
	  else {
		 result[pos] = string[mm];
		 pos ++;
		 if (gettren) gettren = 0;
	  }
   }
   result[pos] = '\0';
   return result;
}

/*****************************************************************************/
/*                           SMif_lwastecount                                */
/*  gibt die Anzahl der Zeichen, die vor dem ersten Wort bzgl. 'table' in    */
/*  'string' liegen, zurueck.                                                */
/*****************************************************************************/

int SMif_lwastecount (char* string, SMif_ignotable table)
{
   int num , len;
   
   if (string == NULL) return 0;
   len = strlen(string);
   for (num = 0; num < len && isignoredc(string[num],table); num++);
   return num;
}
