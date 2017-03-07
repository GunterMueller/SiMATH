/*C
			gccpr( )

	"garbage collector: compressing"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h      
	single gccpr();
	s = gccpr();
	Fuer jede Variable x, die im STACK durch init(),
	bind(), globinit() oder globbind() eingebunden 
	wurde und auf eine Liste zeigt, wird diese Liste 
	an den Anfang des SPACE kopiert. x erhaelt als 
	neuen Wert einen Zeiger auf diese Liste.       
	s ist die Anzahl der gebundenen Variablen. 
	Warnungen:  
	1)  Nicht gebundene Variablen, die vor dem Aufruf 
	    von gcpr() auf eine (gebundene) Liste
	    zeigten, haben nach gcpr() im allgemeinen keinen 
	    sinnvollen Wert mehr.                   
	2)  Zeigen verschiedene im STACK gebundenen Variablen 
	    auf die gleiche Liste, wird fuer jede dieser 
	    Variablen eine neue Liste erzeugt, was im extremen 
	    Fall zur Vergroesserung des Speicherbedarfs fuehren
	    kann.
	siehe auch gcfree().  
C*/
/*H
	Version 1  	08.03.1993	Marc Conrad
   DATE gccpr         : 930531
H*/
#include<_list.h>    

single gccpr()
{
	single i;

	i = ST_INDEX;
	while (i--) {
		gc();
		if (!isatom(**(STACK + i))) {
			**(STACK + i) = lcopy(**(STACK + i));
		}
	}            
	return( ST_INDEX );
}
