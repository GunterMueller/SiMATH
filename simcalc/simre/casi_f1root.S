/*C
			casi_f1root( fkeller )

	"calculator univariate polynomial over Galois-field with single 
	 characteristic finding one root"
	Include- Datei: _calc.h
	gfel casi_f1root( fkeller )   list fkeller;
	N = casi_f1root( fkeller );

	fkeller ist eine Liste, bestehend entweder aus einem Polynom
	ueber Z/pZ, einem Polynom ueber GF(p^n) oder aus einer Primzahl p
	und einem Polynom ueber Z. 
	casi_f1root sucht eine Nullstelle des Polynoms in Z/pZ bzw. in
	GF(p^n).
	Laeuft casi_f1root fehlerhaft ab, so ist  N = ERROR.
C*/
/*H
	Version  1	14.11.1998	S.Schmitt
H*/

#include <_calc.h>

list casi_f1root( fkeller )
list fkeller;
{
# ifdef ___CASI

	single k;
	list P,Q,N,V;
	int p;

	init(P,Q,N,V,p);
	bind(fkeller);

	/*** Ueberpruefung der Eingaben. ***/
                                                                                
        if( llength(fkeller)!=1 && llength(fkeller)!=2 )
        {       mistake( 3 );
                return( ERROR );
        }

	/** Primzahl + Polynom **/

	if(llength(fkeller)==2)
	{	P = lfirst(fkeller);
		if(llength(P)!=2 || lsecond(P)!=2)
		{	mistake(321);
			return(ERROR);
		}
		P = lfirst(P);
		if(llength(P)!=2 || llength(lfirst(P))!=1)
                {       mistake(321);
                        return(ERROR);
                }
		V = lfirst(P);
                Q=lsecond(P);
                fkeller=lsecond(fkeller);
		p=lfirst(fkeller);                                              
                if(lsecond(fkeller) || (isatom(p) && issprime(p,&N)<1 ))       
                {       mistake(328);
                        return(ERROR);
                }
                P=pitopmi(1,Q,p);
                k=0;
        }
                                                                                
        /*** nur Polynom ***/
                                                                                
        else
	{	fkeller = lfirst(fkeller);
		k = lsecond(fkeller);
		P = lfirst(fkeller);
        	if((k!=32 && k!=18) || llength(P)!=2 || llength(lfirst(P))!=1)
        	{       mistake(321);                                           
                	return(ERROR);                                          
        	}                                                               
		V = lfirst(P);
        	P=lsecond(P);
		if(k==18)                                                       
                {       if(!pzsch)                                              
                        {       mistake(328);                                   
                                return(ERROR);                                  
                        }                                                       
                        p=lfirst(varlist[modsch].varwert);                      
                        k=17;                                                   
                }                                                               
                else if(k==32)                                                  
                {       Q=lfirst(varlist[gfsch].varwert);                       
                        k=31;                                                   
                } 
	}
		

	/** Rechnung **/

	if(!k || k==17) N = upmif1r(p,P);
	else if(gfchar==2)  N=upgf2f1r(Q,P);                              
        else  N=upgfsf1r(gfchar,Q,P);                                 

	/*** Ausgabe fuer Z/pZ bzw. GF(p^n) falls keine Nullstelle              
                gefunden wurde ***/                                             
	
	if(N==_0 && !assch)
	{	printf(" The polynomial ");                                     
		if(!k) putpi(1,Q,V);
                else if(k==17) putpm(1,P,V);                                    
                else if(gfchar==2) putpgf2(1,Q,P,V,VGF);                        
                else putpgfs(1,P,V,VGF);                                        
                printf(" has no roots in");
		if(k<31)                                                        
                {       printf(" Z/");                                          
                        puti(p);                                                
                        printf("Z.\n");                                         
                }                                                               
                else                                                            
                {       printf(" GF(");                                         
                        puti(gfchar);                                           
                        if(gfchar==2) p=lfirst(Q);                              
                        else p=lfirst(lfirst(Q));                               
                        printf("^%i).\n",p);                                    
                }                                                               
		if(ps)                                                          
                {       fprintf(datei,"out: The polynomial ");                  
                        if(!k) fputpi(1,Q,V,datei);                             
                        else if(k==17) fputpm(1,P,V,datei);                     
                        else if(gfchar==2) fputpgf2(1,Q,P,V,VGF,datei);         
                        else fputpgfs(1,P,V,VGF,datei);                         
                        fprintf(datei," has no roots in");                      
                        if(k<31)                                                
                        {       fprintf(datei," Z/");                           
                                fputi(p,datei);                                 
                                fprintf(datei,"Z.\n");                          
                        }                                                       
                        else                                                    
                        {       fprintf(datei," GF(");                          
                                fputi(gfchar,datei);                            
                                fprintf(datei,"^%i).\n",p);                     
                        }                                                       
                }                                                               
                return(ERROR-1); 
	}
	else if(N==_0) return(ERROR-1);

	N = list2(N,k);
	return(N);	

# else
	mistake(5);
	return(ERROR);
# endif
}
