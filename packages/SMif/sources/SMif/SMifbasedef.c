/*******************************************************************/
/*      SMifbasedef.c : Definition der Funktionen zur Bearbeitung  */
/*                      von SMif_chartable und SMif_wordtable      */
/*      Includedatei  : SMifbasedef.h                              */
/*******************************************************************/


#include "SMifbasedef.h"
#include <string.h> 
 
int isinchartable (char ch, SMif_chartable table)
{
   struct SMif_charlistitem * itemptr;
   for (itemptr = table; itemptr != NULL; itemptr = itemptr->next) 
	  if (ch == itemptr->SMifchar) return 1;
   return 0;
}

void addchar (char ch, SMif_chartable* tableptr)
{
   struct SMif_charlistitem *itemptr, *itemptr2;
   if (*tableptr == NULL) {
	  itemptr = (struct SMif_charlistitem *) malloc (sizeof(struct SMif_charlistitem));
	  itemptr->SMifchar = ch;
	  itemptr->next = NULL;
	  *tableptr = itemptr;
   }
   else {
	  for (itemptr2=*tableptr; itemptr2->next != NULL; itemptr2=itemptr2->next)
		 if (itemptr2->SMifchar == ch) return; 
	  if (itemptr2->SMifchar == ch) return;
	  itemptr = (struct SMif_charlistitem *) malloc (sizeof(struct SMif_charlistitem));
	  itemptr->SMifchar = ch;
	  itemptr->next = NULL;
	  itemptr2->next = itemptr;
   }
}


void delchar (char ch, SMif_chartable* tableptr)
{
   struct SMif_charlistitem * itemptr, *itemptr2;
   if (*tableptr == NULL) return;
   
   if ((*tableptr)->SMifchar == ch) {
	  itemptr = (*tableptr)->next;
	  free (*tableptr);
	  *tableptr = itemptr;
   } 
   else 
	  for (itemptr = *tableptr; itemptr->next!=NULL; itemptr = itemptr->next)
		 if (itemptr->next->SMifchar == ch) {
			itemptr2 = itemptr->next->next;
			free (itemptr->next);
			itemptr->next = itemptr2;
			break;
		 }
}


void delchartable (SMif_chartable* tableptr)
{
   struct SMif_charlistitem * itemptr, *itemptr2;
   for (itemptr = *tableptr; itemptr != NULL;) {
	  itemptr2 = itemptr->next;
	  free (itemptr);
	  itemptr = itemptr2;
   }
   *tableptr = NULL;
}


SMif_chartable copychartable (SMif_chartable table)
{
   SMif_chartable newtable = NULL ;
   struct SMif_charlistitem * itemptr, *itemptr2, *itemptr3;
  
   if (table == NULL) return NULL;
   for (itemptr = table; itemptr!=NULL; itemptr = itemptr->next) {
	  if (newtable == NULL) {
		 newtable = (SMif_chartable) malloc (sizeof(struct SMif_charlistitem));
		 newtable->SMifchar = itemptr->SMifchar;
		 newtable->next = NULL;
		 itemptr2 = newtable;
	  }
	  else {
		 itemptr3 = (SMif_chartable) malloc (sizeof(struct SMif_charlistitem));
		 itemptr3->SMifchar = itemptr->SMifchar;
		 itemptr3->next = NULL;
		 itemptr2->next = itemptr3;
		 itemptr2 = itemptr3;
	  }
   }
   return newtable;
}
	  

     
int isinwordtable (char* word, SMif_wordtable table)
{
   struct SMif_wordlistitem * itemptr;
   for (itemptr = table; itemptr != NULL; itemptr = itemptr->next) 
	  if (strcmp(word, itemptr->SMifword)==0) return 1;
   return 0;
}

int wordcount (SMif_wordtable table)
{
   int mm;
   struct SMif_wordlistitem * itemptr;
   for (mm = 0,itemptr = table; itemptr!= NULL; mm++, itemptr = itemptr->next);
   return mm;
}

void addword (char* word, SMif_wordtable* tableptr)
{
   struct SMif_wordlistitem *itemptr, *itemptr2;
   if (*tableptr == NULL) {
	  itemptr = (struct SMif_wordlistitem *) malloc (sizeof(struct SMif_wordlistitem));
	  itemptr->SMifword = (char*) malloc (sizeof(char)*(strlen(word)+1));
	  (void)strcpy (itemptr->SMifword, word);
	  itemptr->next = NULL;
	  *tableptr = itemptr;
   }
   else {
	  for (itemptr2=*tableptr; itemptr2->next != NULL; itemptr2=itemptr2->next)
		 if (strcmp(itemptr2->SMifword, word)==0 ) return; 
	  if (strcmp(itemptr2->SMifword,word)==0) return;
	  itemptr = (struct SMif_wordlistitem *) malloc (sizeof(struct SMif_wordlistitem));
	  itemptr->SMifword = (char*) malloc (sizeof(char)*(strlen(word)+1));
	  strcpy (itemptr->SMifword,word);
	  itemptr->next = NULL;
	  itemptr2->next = itemptr;
   }
}


void delword (char* word, SMif_wordtable* tableptr)
{
   struct SMif_wordlistitem * itemptr, *itemptr2;
   if (*tableptr == NULL) return;
   
   if (strcmp((*tableptr)->SMifword,word) == 0) {
	  itemptr = (*tableptr)->next;
	  free ((*tableptr)->SMifword);
	  free (*tableptr);
	  *tableptr = itemptr;
   } 
   else 
	  for (itemptr = *tableptr; itemptr->next!=NULL; itemptr = itemptr->next)
		 if (strcmp(itemptr->next->SMifword,word) == 0) {
			itemptr2 = itemptr->next->next;
			free (itemptr->next->SMifword);
			free (itemptr->next);
			itemptr->next = itemptr2;
		 }
}


void delwordtable (SMif_wordtable* tableptr)
{  
   struct SMif_wordlistitem * itemptr, *itemptr2;
   for (itemptr = *tableptr; itemptr != NULL;) {
	  itemptr2 = itemptr->next;
	  free (itemptr->SMifword);
	  free (itemptr);
	  itemptr = itemptr2;
   }
   *tableptr = NULL;
}


SMif_wordtable copywordtable (SMif_wordtable table)
{
   SMif_wordtable newtable = NULL ;
   struct SMif_wordlistitem * itemptr, *itemptr2, *itemptr3;
  
   if (table == NULL) return NULL;
   for (itemptr = table; itemptr!=NULL; itemptr = itemptr->next) {
	  if (newtable == NULL) {
		 newtable = (SMif_wordtable) malloc (sizeof(struct SMif_wordlistitem));
		 newtable->SMifword = (char*)malloc (sizeof(char)*(strlen(
							   itemptr->SMifword)+1));
		 strcpy (newtable->SMifword, itemptr->SMifword);
		 newtable->next = NULL;
	  }
	  else {
		 itemptr2 = (SMif_wordtable) malloc (sizeof(struct SMif_wordlistitem));
		 itemptr2->SMifword = (char*)malloc (sizeof(char)*(strlen(
							   itemptr->SMifword)+1));
		 strcpy (itemptr2->SMifword, itemptr->SMifword);
		 itemptr2->next = newtable;
		 newtable = itemptr2;
	  }
   }
   return newtable;
}


/* find all intergers in a SMif_word */
void SMif_findintinword (char* word, struct SMif_intinwordinfo *infoptr) 
{
   int len, mm, nn, count;
   struct SMif_intinfoitem *tmpitem1 = NULL, *tmpitem2 = NULL;
   
   if (infoptr == NULL || word == NULL) return;
   len = strlen (word);
   if (infoptr->intinfo != NULL)
	  for (tmpitem1 = infoptr->intinfo; tmpitem1 != NULL;) {
		 tmpitem2 = tmpitem1->next;
		 free (tmpitem1);
		 tmpitem1 = tmpitem2;
	  }
   infoptr->intinfo = NULL;
   infoptr->count = 0;
   
   mm = 0;
   while (mm < len) {
	  if ( isdigit (word[mm]) || (word[mm] == '+' || word[mm] == '-') && 
		   mm != len-1 && isdigit(word[mm+1]) )
	  {
		 infoptr->count ++;
		 tmpitem1 = (struct SMif_intinfoitem*) malloc(sizeof(struct SMif_intinfoitem));
		 tmpitem1->pos = mm;
		 tmpitem1->next = NULL;
		 count = 1;
		 while (mm < len-1 && isdigit(word[mm+1])) {
			count ++;
			mm++;
		 }
		 tmpitem1->length = count;
		 if (infoptr->intinfo == NULL) 
			tmpitem2 = infoptr->intinfo = tmpitem1;
		 else {
			tmpitem2->next = tmpitem1;
			tmpitem2 = tmpitem1;
		 }
	  }
	  mm++;
   }
}


/* get pol structur */
void  SMif_getpolstruct(char* word, struct SMif_polstruct *polstructptr)
{
   int level, len, mm;
   int from;
   struct SMif_polinfoitem *tmpitem1 = NULL, *tail = NULL;
   
   if (polstructptr == NULL) return;
   
   if (polstructptr->polinfo != NULL)
	  for (tmpitem1 = polstructptr->polinfo; tmpitem1 != NULL;) {
		 tail = tmpitem1->next;
		 free (tmpitem1);
		 tmpitem1 = tail;
	  }
   polstructptr->polinfo = tmpitem1 = tail = NULL;
   polstructptr->maxlevel = level = 0;
   from = 0;
	  
   if (word == NULL) return;
   
   len = strlen (word);
   tmpitem1 = (struct SMif_polinfoitem*)
			  malloc  (sizeof (struct SMif_polinfoitem));
   tmpitem1->from = 0;
   if (word[0] == '-') tmpitem1->negorpos = NEGATIV;
   else  tmpitem1->negorpos = POSITIV;
   if (word[0] == '-' || word[0] == '+')
	  tmpitem1->from = 1;
   tmpitem1->to = len-1;         
   tmpitem1->locmaxlevel = 0;
   tmpitem1->next = NULL;
   polstructptr->polinfo = tail = tmpitem1;
   tmpitem1 = NULL;   
   
   for (mm = 0; mm < len; mm++) {
	  if (word[mm] == '(') {
		 level ++;
		 if (tail->locmaxlevel < level) tail->locmaxlevel = level;
	  } 
	  else if (word[mm] == ')') {
		 level --;
		 if (level < 0) {
			polstructptr->maxlevel = -1;
			return;
		 } 
	  }
	  else if ( level == 0 && (word[mm] == '+' || word[mm] == '-') && mm!=0) {
		 tail->to = mm - 1;
		 if (tail->to < tail->from && tail->from != 0) {
			polstructptr->maxlevel = -1;
			return;
		 }
		 if (tail->locmaxlevel > polstructptr->maxlevel)
			polstructptr->maxlevel = tail->locmaxlevel;
		 tmpitem1 = (struct SMif_polinfoitem*)
					 malloc  (sizeof (struct SMif_polinfoitem));
		 tmpitem1->from = mm+1;
		 tmpitem1->to = len-1;
		 if (word[mm] == '-') tmpitem1->negorpos = NEGATIV;
		 else tmpitem1->negorpos = POSITIV;
		 tmpitem1->locmaxlevel = 0;
		 tmpitem1->next = NULL;
		 tail->next = tmpitem1;
		 tail = tmpitem1;
		 tmpitem1 = NULL;
	  }
   }
   if (level == 0) {
	  tail->to = len-1;
	  if (tail->locmaxlevel > polstructptr->maxlevel)
		 polstructptr->maxlevel = tail->locmaxlevel;
   }
   else polstructptr->maxlevel = -1;		 
} 
