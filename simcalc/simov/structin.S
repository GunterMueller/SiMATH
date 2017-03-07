/*C
			structin( typ )

	"structure initialization".
	structin(typ); single typ;
	structin( typ );

	Variablennamen, die nicht benutzt werden duerfen, werden
	im Variablenspeicher abgelegt und mit dem Vermerk typ
	versehen.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      02.06.1987      H.Stroeher/M.Mang
H*/
/*cS
	structin ruft auf:
Sc*/

#include <_calc.h>

structin (typ)
single typ;
{
	/*** Deklarationen und Vorbesetzungen ***/

	single n;

	/*** Speicherverwaltung fuer nicht benutzbare
	     Variablennamen ***/

	varlist[1].varname = "gcd";
	varlist[2].varname = "lcm";
	varlist[3].varname = "mod";
	varlist[4].varname = "log2";
	varlist[5].varname = "sgn";
	varlist[6].varname = "sqrt";
	varlist[7].varname = "fact";
	varlist[8].varname = "help";
	varlist[9].varname = "func";
	varlist[10].varname = "ifunc";
	varlist[11].varname = "rfunc";
	varlist[12].varname = "log";
	varlist[13].varname = "stat";
	varlist[14].varname = "tofl";
	varlist[15].varname = "vardel";
	varlist[16].varname = "jacsym";
	varlist[17].varname = "phi";
	varlist[18].varname = "pfunc";
	varlist[19].varname = "resul";
	varlist[20].varname = "disc";
	varlist[21].varname = "subst";
	varlist[22].varname = "sysvar";
	varlist[23].varname = "pfact";
	varlist[24].varname = "sort";
	varlist[25].varname = "deriv";
	varlist[26].varname = "prfunc";
	varlist[27].varname = "mex";
	varlist[28].varname = "aval";
	varlist[29].varname = "mval";
	varlist[30].varname = "binom";
	varlist[31].varname = "integr";
	varlist[32].varname = "det";
	varlist[33].varname = "transp";
	varlist[34].varname = "chpol";
	varlist[35].varname = "mfunc";
	varlist[36].varname = "floor";
	varlist[37].varname = "elform";
	varlist[38].varname = "linequ";
	varlist[39].varname = "scalar";
	varlist[40].varname = "herm";
	varlist[41].varname = "vfunc";
	varlist[42].varname = "eival";
	varlist[43].varname = "elsubst";
	varlist[44].varname = "sfp";
	varlist[45].varname = "ow";
	varlist[46].varname = "fopen";
	varlist[47].varname = "fclose";
	varlist[48].varname = "fread";
	varlist[49].varname = "EC";
	varlist[50].varname = "PT";
	varlist[51].varname = "O";
	varlist[52].varname = "curec";
	varlist[53].varname = "jinv";
	varlist[54].varname = "swnf";
	varlist[55].varname = "bitrans";
	varlist[56].varname = "isptec";
	varlist[57].varname = "tavb2";
	varlist[58].varname = "tavb4";
	varlist[59].varname = "tavb6";
	varlist[60].varname = "tavb8";
	varlist[61].varname = "tavc4";
	varlist[62].varname = "tavc6";
	varlist[63].varname = "prtoaf";
	varlist[64].varname = "aftopr";
	varlist[65].varname = "basismwg";
	varlist[66].varname = "discec";
	varlist[67].varname = "cond";
	varlist[68].varname = "minim";
	varlist[69].varname = "taalg";
	varlist[70].varname = "ecfunc";
	varlist[71].varname = "file";
	varlist[72].varname = "coef";
	varlist[73].varname = "chcoef";
	varlist[74].varname = "pgen";
	varlist[75].varname = "chinrem";
	varlist[76].varname = "intcoef";
	varlist[77].varname = "red";
	varlist[78].varname = "np";
	varlist[79].varname = "root";
	varlist[80].varname = "ecinf";
	varlist[81].varname = "exp";
	varlist[82].varname = "ln";
	varlist[83].varname = "num";
	varlist[84].varname = "denom";
	varlist[85].varname = "flfunc";
	varlist[86].varname = "tors";
	varlist[87].varname = "modfunc";
	varlist[88].varname = "nffunc";
	varlist[89].varname = "MOD";
	varlist[90].varname = "NF";
	varlist[91].varname = "curmod";
	varlist[92].varname = "curnf";
	varlist[93].varname = "nftopol";
	varlist[94].varname = "discnf";
	varlist[95].varname = "norm";
	varlist[96].varname = "trace";
	varlist[97].varname = "intbas";
	varlist[98].varname = "declaw";
	varlist[99].varname = "unit";
	varlist[100].varname = "puto";
	varlist[101].varname = "putbits";
	varlist[102].varname = "nthei";
	varlist[103].varname = "mtoi";
	varlist[104].varname = "isprime";
	varlist[105].varname = "pconstr";
	varlist[106].varname = "Pi";
	varlist[107].varname = "sgnfeq";
	varlist[108].varname = "rper";
	varlist[109].varname = "rk";
	varlist[110].varname = "derivL";
	varlist[111].varname = "reg";
	varlist[112].varname = "ordtsg";
	varlist[113].varname = "curgf";
	varlist[114].varname = "GF";
	varlist[115].varname = "gftopol";
	varlist[116].varname = "fp";
	varlist[117].varname = "gffunc";
	varlist[118].varname = "npfe";
	varlist[119].varname = "quit";
	varlist[120].varname = "exit";
	varlist[121].varname = "openf";
	varlist[122].varname = "logon";
	varlist[123].varname = "logoff";
	varlist[124].varname = "loglist";
	varlist[125].varname = "staton";
	varlist[126].varname = "statoff";
	varlist[127].varname = "owon";
	varlist[128].varname = "owoff";
	varlist[129].varname = "ecgnp";
	varlist[130].varname = "if";
	varlist[131].varname = "while";
	varlist[132].varname = "dowhile";
	varlist[133].varname = "forstep";
	varlist[134].varname = "forprime";
	varlist[135].varname = "for";
	varlist[136].varname = "break";
	varlist[137].varname = "progfunc";
	varlist[138].varname = "continue";
	varlist[139].varname = "i";
	varlist[140].varname = "I";
	varlist[141].varname = "conjug";
	varlist[142].varname = "imag";
	varlist[143].varname = "real";
	varlist[144].varname = "cper";
	varlist[145].varname = "cfunc";
	varlist[146].varname = "sin";
	varlist[147].varname = "cos";
	varlist[148].varname = "tan";
	varlist[149].varname = "cot";
	varlist[150].varname = "sinh";
	varlist[151].varname = "cosh";
	varlist[152].varname = "tanh";
	varlist[153].varname = "coth";
	varlist[154].varname = "arcsin";
	varlist[155].varname = "arccos";
	varlist[156].varname = "arctan";
	varlist[157].varname = "arccot";
	varlist[158].varname = "arsinh";
	varlist[159].varname = "arcosh";
	varlist[160].varname = "artanh";
	varlist[161].varname = "arcoth";	
	varlist[162].varname = "log10";
	varlist[163].varname = "print";
	varlist[164].varname = "decl";
	varlist[165].varname = "local";
	varlist[166].varname = "return";
	varlist[167].varname = "proot";
	varlist[168].varname = "irpgen";
	varlist[169].varname = "froot";
	varlist[170].varname = "minor";
	varlist[171].varname = "dmconstr";
	varlist[172].varname = "ntpair";
	varlist[173].varname = "whei";
	varlist[174].varname = "egcd";
	varlist[175].varname = "relcln";
    	varlist[176].varname = "sum";
	varlist[177].varname = "prod";
	varlist[178].varname = "ord";
	varlist[179].varname = "faintp";
	varlist[180].varname = "zmconstr";
	varlist[181].varname = "zvconstr";
	varlist[182].varname = "mcoef";
	varlist[183].varname = "vcoef";
	varlist[184].varname = "areptsli";
	varlist[185].varname = "eccoef";
	varlist[186].varname = "ptcoef";
	varlist[187].varname = "fltoi";
	varlist[188].varname = "nfon";
	varlist[189].varname = "nfoff";
	varlist[190].varname = "avon";
	varlist[191].varname = "avoff";
	varlist[192].varname = "avfunc";
	varlist[193].varname = "GF2bit";
	varlist[194].varname = "curgf2bit";
	varlist[195].varname = "putGF2bit";
	varlist[196].varname = "getb";
	varlist[197].varname = "gethex";
	varlist[198].varname = "getoct";
	varlist[199].varname = "putb";
	varlist[200].varname = "puthex";
	varlist[201].varname = "putoct";
	varlist[202].varname = "mam2";
	varlist[203].varname = "rkbsd";
	varlist[204].varname = "rk2d";
	varlist[205].varname = "cont";
	varlist[206].varname = "prim";
	varlist[207].varname = "pripgen";
	varlist[208].varname = "deg";
	varlist[209].varname = "rkg2d";
	varlist[210].varname = "elog";
	varlist[211].varname = "fload";
	varlist[212].varname = "ppconstr";
	varlist[213].varname = "max";
	varlist[214].varname = "min";
	varlist[215].varname = "helpfunc";
	varlist[216].varname = "f1root";
	varlist[217].varname = "ecnpscf";
	varlist[218].varname = "ceil";
	varlist[219].varname = "isqrt";
	varlist[220].varname = "ispprime";
	varlist[221].varname = "ppon";
	varlist[222].varname = "ppoff";
	varlist[223].varname = "classnum";
	varlist[224].varname = "pp";
	for ( n=1; n< MXNUM; n++ ) varlist[n].typ = typ;

	/** Typ fuer Funktionen, die nur in der 
	    SIEMENS-Version existieren.		**/

	varlist[129].typ = 3;
	varlist[216].typ = 3;
	varlist[217].typ = 3;
}
