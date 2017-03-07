/*C
			calc_trig( fkeller, z )

	Quellbibliothek: srclib.simre
	Include- Datei: _calc.h
	list calc_trig( fkeller, z );  list fkeller; single z;
	X = calc_trig( fkeller, z );

	fkeller enthaelt eine Zahl aus Z, Q oder R. 
	z gibt an, welche der trigonometrischen oder hyperbolischen
	Funktionen benutzt wird. ( 1<=z<=16 )

	Laeuft calc_trig fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      25.01.1994      S.Schmitt/U.Schneiders
H*/

# include<_calc.h>

list calc_trig(fkeller, z)
list fkeller;
single z;
{	single k;
	obj n,g,d;
	void Fsin(), Fcos(), Ftan(), Fcot();
	void Fsinh(), Fcosh(), Ftanh(), Fcoth();
	void Fasin(), Facos(), Fatan(), Facot();
	void Fasinh(), Facosh(), Fatanh(), Facoth();

	init(n, g, d);
	bind(fkeller);

	k = lsecond(fkeller);
	if( k && k!=1 && k!=15 )
	{	mistake(304);
		return(ERROR);
	}
	n = lfirst(fkeller);
	if(!k) n = itofl(n);
	else if(k==1) n=rtofl(n);
        
        /*g = flPi();
	if(z==1 || z==2)
	{	if(flcomp(flabs(n),g)>0)
		{	d = flquot(flabs(n),g);	
			d = flsquot(d,2);
			d = flfloor(d);
			s = iprod(2,d);
			s = itofl(s);
			s = flprod(g,s);
			if(flsign(n)<0) n = flsum(n,s);
			else n = fldif(n,s);
			while(flcomp(flabs(n),g)>0) 
			{ 	if(flsign(n)<0) 
				{	n = flsum(n,g);
					n = flsum(n,g);
				}
				else
				{	n = fldif(n,g);
					n = fldif(n,g);
				}
			}
		}
	}
	else if(z==4)
	{	if(flsign(n)<0 || flcomp(n,g)>0)
		{	d = flquot(flabs(n),g);
			d = flfloor(d);
			s = itofl(d);
			s = flprod(g,s);
			if(flsign(n)<0) n = flsum(n,s);
			else n = fldif(n,s);
			while( flsign(n)<0 || flcomp(n,g)>0)
			{	if(flsign(n)<0) n = flsum(n,g);
				else n = fldif(n,g);
			}
		}
	}
	else if(z==3)
	{	d = flsquot(g,2);
		if(flcomp(flabs(n),d) > 0)
		{	s = flquot(flabs(n),g);
			s = flfloor(s);
			s = itofl(s);
			s = flprod(g,s);
			if(flsign(n) < 0) n = flsum(n,s);
			else n = fldif(n,s);
			while(flcomp(flabs(n),d)>0)
			{	if(flsign(n)<0) n = flsum(n,g);
				else n = fldif(n,g);
			}
		}
	} */


	if( z == 3 )  g = flPAFfu(Fcos, 1, n, 0);
	else if(z==4) g = flPAFfu(Fsin, 1, n, 0);
	else g = itofl(1);
	if(z==3 || z==4) d = flsexp(itofl(10),-DIGITS + 1);

	if( ( ( z == 3 || z == 4 ) && flcomp(flabs(g),d) <= 0 )
	    || ( z == 8 && !n )
	    || ( ( z==9 || z==10 ) && flcomp(flabs(n), g) > 0 )
	    || ( z == 14 && flcomp(n, g) < 0 )
	    || ( z == 15 && flcomp(flabs(n), g) >= 0 )
	    || ( z == 16 && flcomp(flabs(n), g) <= 0 ) )
	{	mistake(305);
		return(ERROR);
	}

	switch(z)	
	{	case 1: n = flPAFfu(Fsin, 1, n, 0);
			break;
		case 2: n = flPAFfu(Fcos, 1, n, 0);
			break;
		case 3: n = flPAFfu(Ftan, 1, n, 0);
			break;
		case 4: n = flPAFfu(Fcot, 1, n, 0);
			break;
		case 5: n = flPAFfu(Fsinh, 1, n, 0);
			break;
		case 6: n = flPAFfu(Fcosh, 1, n, 0);
			break;
		case 7: n = flPAFfu(Ftanh, 1, n, 0);
			break;
		case 8: n = flPAFfu(Fcoth, 1, n, 0);
			break;
		case 9: n = flPAFfu(Fasin, 1, n, 0);
			break;
		case 10:n = flPAFfu(Facos, 1, n, 0);
			break;
		case 11:n = flPAFfu(Fatan, 1, n, 0);
			break;
		case 12:n = flPAFfu(Facot, 1, n, 0);
			break;
		case 13:n=flPAFfu(Fasinh, 1, n, 0);
			break;
		case 14:n = flPAFfu(Facosh, 1, n, 0);
			break;
		case 15:n = flPAFfu(Fatanh, 1, n, 0);
			break;
		case 16:n = flPAFfu(Facoth, 1, n, 0);
			break;
	}
	n = list2(n,15);
	return(n);
}
