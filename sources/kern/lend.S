/*c
			lend( )

	"list-system end"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h
	!!! wird nur vom System benutzt !!!
	Meldungsblock, der am Ende eines Programmablaufes auf
	stdout gegeben wird
c*/
/*H
	Version 1      	31.07.1986      R. Boeffgen
	Version 2      	09.02.1987      Ausgabe von ST_SIZE und STOCK_SZ. RB
	Version 3      	30.06.1987      Zeit-Fehler korrigiert. RB
	Version 4      	17.08.1987      gehoert ab jetzt zur srclib.kern. MAR
	Version 5      	28.12.1987      an Blockstruktur des SPACE 
					angepasst. PS
	Version 6      	07.12.1989      einheitl. Version fuer MX2(+), SUN und
					Apollo. PS
	Version 7      	17.07.1991      STOCK_SZ ausgeblendet. PS
	Version 8	16.12.1992	englische Meldungen. PS
	Version 9	27.04.1996	HZ is defined in the SIMATH header
					_list.h. MP
        Version 10      18.02.1999      The output of "GC time" and "total 
                                        CPU time" is now realized using 
                                        sprintf(). CG
   DATE lend          : 890501.900101.910715.930115.960601
H*/

# include <_list.h>   
# undef printf
lend ( )
{
    struct tms buffer;
    char s[32];    

    /* 1. Zeile */
   /* sprintf(s, "%.2f", 1.*GC_TIME/HZ);*/
    printf( "\n\n***   # GCs: %-8d GC time: %.2f s \t# collected cells: %-9d \t***\n",
	GC_COUNT,  1.*GC_TIME/HZ,  GC_CC);

    /* 2. Zeile */
    printf( "***   # blocks: %-5d block size: %-5d # free cells:      %-9d \t***\n",
	BL_NR,  BL_SIZE,  llength(AVAIL) );

    /* 3. Zeile */
    times( &buffer );
   /* sprintf(s, "%.2f", 1.*buffer.tms_utime/HZ);*/
    printf( "***   total CPU time: %.2f s \t\t\t\t\t\t***\n", 1.*buffer.tms_utime/HZ );
}
