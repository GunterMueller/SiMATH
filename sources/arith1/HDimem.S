/* DOC_SKIP */

/*M
.SH NAME
HDimem - Heidelberg arithmetic package: memory management

.SH SYNOPSIS
(Internal)

.SH DESCRIPTION
This file contains some internal functions of the so-called Heidelberg arithmetic package. Please mind the compatibility notice and the original copyright in the file HDiadd.S!
M*/

/*H
	Version  1      17.03.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2	26.08.1993      neue Version (MC)
   DATE HDimem        : 930531.931130
H*/                                                             

#include<_HDarith.h>   
                         
/* Integer Version 2.0, RD, 18.1.93	imem.c	*/



char * Imalloc(i)
	int i;
{	return (char *) malloc(i);
}

void Ifree(u)
	char * u;
{	free(u);
}

#define MEMLISTMAX 20
#define MEMLISTMIN 2

typedef union uMemEl {
        union uMemEl *next;
        DigitType mem;
} MemEl, *pMemEl;

typedef struct sMemList {
        pMemEl free;
        int size;
} tMemList;

static tMemList MemList[MEMLISTMAX];
static BOOLEAN MemListInit=FALSE;

#ifdef I_STATISTICS
static long	Ivec_used[MEMLISTMAX];
static long	Ivec_allocated[MEMLISTMAX];
static long	Ivec_freed[MEMLISTMAX];
#endif

DigitType * newDigitVec(maxl)
        int *maxl;
{       register int i; 
        register pMemEl u;
        register int a, ml;
        if (!MemListInit) {
                int j=2;
		MemListInit=TRUE;
                for (i=1; i<MEMLISTMAX; i++) {
                        MemList[i].size=j;
			MemList[i].free=NULL;
                        j<<=1;
#ifdef I_STATISTICS
			Ivec_used[i]=0;
			Ivec_allocated[i]=0;
			Ivec_freed[i]=0;
#endif
                }
	}
        a= *maxl;
        i=MEMLISTMIN;
	if (a) {
	    a--;
	    a>>=i;
	    while(a) {
                a>>=1;
                i++;
	    }
	    if (i>=MEMLISTMAX){
#ifdef I_STATISTICS
		IprintStatistics();
#endif
		Ierror("newDigitVec: exceeded MEMLISTMAX\n");
	    }
	}
        ml=MemList[i].size;
        *maxl=ml;
        u=MemList[i].free;
        if (u) {
                MemList[i].free=u->next;
#ifdef I_STATISTICS
		Ivec_used[i]++;
#endif
                return (DigitType *)u;
        } else {
                u=(pMemEl)malloc(ml*sizeof(DigitType));
		if (!u) {
		    int j;
		    for (j=1; j<MEMLISTMAX; j++) {
			while (u=MemList[j].free) {
			    MemList[j].free=u->next;
			    free((char *)u);
#ifdef I_STATISTICS
			    Ivec_freed[j]++;
#endif
			}
		    }
		    u=(pMemEl)malloc(ml*sizeof(DigitType));
		    if(!u) {
#ifdef I_STATISTICS
			IprintStatistics();
#endif
			Ierror("newDigitVec: memory full\n");
		    }
		}
#ifdef I_STATISTICS
		Ivec_used[i]++;
		Ivec_allocated[i]++;
#endif
                return (DigitType *)u;
}       }               /* newDigitVec */

void delDigitVec(u, maxl)
        DigitType * u; register int maxl;
{       register int i;
	register pMemEl v;
	v=(pMemEl) u;
        i=MEMLISTMIN;
	maxl--;
	maxl>>=i;
	while(maxl) {
                maxl>>=1;
                i++;
        }
        v->next=MemList[i].free;
        MemList[i].free=v;
#ifdef I_STATISTICS
	Ivec_used[i]--;
#endif
}		/* delDigitVec */

/*************************************/

static Integer * Ifreelist=NULL;

#ifdef I_STATISTICS
static long	Ihead_used=0;
static long	Ihead_allocated=0;
#endif

Integer * _newInteger()
{       register Integer * u;
	if (Ifreelist) {
		u=Ifreelist;
		Ifreelist=(Integer *)(u->vec);
#ifdef I_STATISTICS
		Ihead_used++;
#endif
		return u;
	} else {
		u=(Integer *) malloc(sizeof(Integer));
		if (!u) {
#ifdef I_STATISTICS
			IprintStatistics();
#endif
			Ierror("_newInteger: memory full\n");
		}
#ifdef I_STATISTICS
		Ihead_used++;
		Ihead_allocated++;
#endif
		return u;
	}
}		/* _newInteger */

void _delInteger(u)
	register Integer *u;
{	u->vec = (DigitType *) Ifreelist;
	Ifreelist=u;
#ifdef I_STATISTICS
		Ihead_used--;
#endif
}		/* _delInteger */

#ifdef I_STATISTICS
void IprintStatistics(_VOID_)
{	int i;
	fprintf(stderr,"\nInteger memory management statistics:\n");
	fprintf(stderr,"Integer structs: %ld allocated, %ld used.\n",
		Ihead_used, Ihead_allocated);
	fprintf(stderr,
	    " size(DigitTypes)  size(bytes)   allocated    used       freed\n");
	for (i=1; i<MEMLISTMAX; i++) {
		fprintf(stderr, "%10d  %10d  %10ld  %10ld  %10ld\n",
			MemList[i].size, MemList[i].size*sizeof(DigitType),
			Ivec_allocated[i], Ivec_used[i], Ivec_freed[i]);
	}
}
#else
void IprintStatistics(_VOID_)
{
}
#endif


