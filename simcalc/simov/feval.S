/*C
			feval( zkstr, fkeller )

	"function evaluation".
	obj feval(zkstr,fkeller); char *zkstr; list fkeller;
	a = feval( zkstr, fkeller );

	fkeller ist eine Liste bestehend aus einem oder mehreren Objekten
	und deren zugehoerigen Kennungen.
	Der in der Zeichenkette zkstr abgelegte Funktionsaufruf
	wird mit den in fkeller stehenden Objekten durchgefuehrt,
	und das Ergebnis wird mit zugehoeriger Kennung a zugewiesen.
	Laeuft feval fehlerhaft ab, so ist  a  = -BASIS.

	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      01.06.1987      H.Stroeher/M.Mang
	Version  2      30.06.1988      C.Hollinger/U.Schneiders
	Version  3      03.12.1990      U.Schneiders
	Version  3.1    27.01.1992      U.Schneiders
	Version  3.2    03.03.1992      U.Schneiders ( mod, nf, gf )
H*/

#include <_calc.h>

obj feval( zkstr, fkeller )
char *zkstr;
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	single r;
	obj  V,a;
	init( V,a );
	bind( fkeller );

	/*** Erkennung des Funktionsaufrufes und Ausfuehrung ***/

	if( flerr() )
	{       FL_EPS = smax( flinit( DIGITS ), 5 );
		mistake( 28 );
		return( ERROR );
	}

	while ( 1 ) {
		if ( !strcmp( zkstr, "gcd" ) ) {
			a = calc_ggt( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "lcm" ) ) {
			a = calc_kgv( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "log2" ) ) {
			a = calc_log2( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "sgn" ) ) {
			a = calc_sgn( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "sqrt" ) ) {
			a = calc_sqrt( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "fact" ) ) {
			a = calc_fakt( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "tofl" ) ) {
			a = calc_tofl( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "fltoi" ) ) {
			a = calc_fltoi( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "jacsym" ) ) {
			a = calc_jacsym( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "phi" ) ) {
			a = calc_iphi( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "disc" ) ) {
			a = calc_disk( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "resul" ) ) {
			a = calc_resul( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "pfact" ) ) {
			a = calc_pfakt( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "sort" ) ) {
			a = calc_sort( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "deriv" ) ) {
			a = calc_deriv( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "prfunc" ) ) {
			a = calc_stfkt( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "mex" ) ) {
			a = calc_mex( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "aval" ) ) {
			a = calc_aval( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "mval" ) ) {
			a = calc_mval( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "binom" ) ) {
			a = calc_binom( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "integr" ) ) {
			a = calc_integr( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "det" ) ) {
			a = calc_det( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "transp" ) ) {
			a = calc_transp( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "chpol" ) ) {
			a = calc_chpol( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "floor" ) ) {
			a = calc_floor( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "elform" ) ) {
			a = calc_elform( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "linequ" ) ) {
			a = calc_linequ( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "scalar" ) )
		{       a = calc_skalar( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "herm" ) )
		{       a = calc_herm( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "eival" ) )
		{       a = calc_eival( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "elsubst" ) )
		{       a = calc_elsubst( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "sfp" ) )
		{       a = calc_sfp( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "coef" ) )
		{       a = calc_coef( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "chcoef" ) )
		{       a = calc_chcoef( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "EC" ) )
		{       a = calc_ec( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "PT" ) )
		{       a = calc_pec( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "curec" ) )
		{       a = calc_actec( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "discec" ) )
		{       a = calc_discec( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "jinv" ) )
		{       a = calc_jinv( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "isptec" ) )
		{       a = calc_isptec( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "swnf" ) )
		{       a = calc_swnf( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "prtoaf" ) )
		{       a = calc_prtoaf( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "aftopr" ) )
		{       a = calc_aftopr( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "basismwg" ) )
		{       a = calc_basmwg( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "bitrans" ) )
		{       a = calc_bitrans( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "tavb2" ) )
		{       a = calc_tav( fkeller, 2 );
			break;
		}
		if ( !strcmp( zkstr, "tavb4" ) )
		{       a = calc_tav( fkeller, 4 );
			break;
		}
		if ( !strcmp( zkstr, "tavb6" ) )
		{       a = calc_tav( fkeller, 6 );
			break;
		}
		if ( !strcmp( zkstr, "tavb8" ) )
		{       a = calc_tav( fkeller, 8 );
			break;
		}
		if ( !strcmp( zkstr, "tavc4" ) )
		{       a = calc_tav( fkeller, 14 );
			break;
		}
		if ( !strcmp( zkstr, "tavc6" ) )
		{       a = calc_tav( fkeller, 16 );
			break;
		}
		if ( !strcmp( zkstr, "taalg" ) )
		{       a = calc_taalg( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "minim" ) )
		{       a = calc_minim( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "cond" ) )
		{       a = calc_cond( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "pgen" ) )
		{       a = calc_pgen( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "chinrem" ) )
		{       a = calc_chinrem( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "intcoef" ) )
		{       a = calc_intcoef( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "red" ) )
		{       a = calc_red( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "np" ) )
		{
# ifdef ___CASI
			a = casi_np( fkeller );
# else
			a = calc_np( fkeller );
# endif
			break;
		}
		if ( !strcmp( zkstr, "ecinf" ) )
		{       a = calc_ecinf( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "root" ) )
		{       a = calc_root( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "ln" ) )
		{       a = calc_ln( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "exp" ) )
		{       a = calc_expo( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "num" ) )
		{       a = calc_num( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "denom" ) )
		{       a = calc_denom( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "tors" ) )
		{       a = calc_tors( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "MOD" ) )
		{       a = calc_m( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "NF" ) )
		{       a = calc_nf( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "GF" ) )
		{       a = calc_gf( fkeller );
			break;
	        }      
		if ( !strcmp( zkstr, "curmod" ) )
		{       a = calc_actmod( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "curnf" ) )
		{       a = calc_actnf( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "nftopol" ) )
		{       a = calc_nftopol( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "discnf" ) )
		{       a = calc_discnf();
			break;
		}
		if ( !strcmp( zkstr, "norm" ) )
		{       a = calc_norm( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "trace" ) )
		{       a = calc_trace( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "intbas" ) )
		{       a = calc_intbas();
			break;
		}
		if ( !strcmp( zkstr, "declaw" ) )
		{       a = calc_declaw( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "unit" ) )
		{       a = calc_unit();
			break;
		}
		if ( !strcmp( zkstr, "puto" ) )
		{       a = calc_puto( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "putbits" ) )
		{       a = calc_putbits( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "nthei" ) )
		{       a = calc_nthei( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "mtoi" ) )
		{       a = calc_mtoi( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "isprime" ) )
		{       a = calc_isprime( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "pconstr" ) )
		{       a = calc_pconstr( fkeller );
			break;
		}
		if( !strcmp( zkstr, "sgnfeq" ) )
		{	a = calc_sgnfeq( fkeller );
			break;
		}
		if( !strcmp( zkstr, "rper" ) )
		{	a = calc_rper( fkeller );
			break;
		}
		if( !strcmp( zkstr, "rk" ) )
		{	a = calc_rk( fkeller );
			break;
		}
		if( !strcmp( zkstr, "derivL" ) )
		{	a = calc_derivL( fkeller );
			break;
		}
		if( !strcmp( zkstr, "reg" ) )
		{	a = calc_reg( fkeller );
			break;
		}
		if( !strcmp( zkstr, "ordtsg" ) )
		{	a = calc_ordtsg(fkeller);
			break;
		}
		if( !strcmp( zkstr, "curgf" ) )
		{	a = calc_curgf(fkeller);
			break;
		}
		if( !strcmp( zkstr, "gftopol" ) )
		{	a = calc_gftopol(fkeller);
			break;
		}
		if( !strcmp( zkstr, "fp" ) )
		{	a = calc_fp(fkeller);
			break;
		}
		if( !strcmp( zkstr, "npfe" ) )
		{	a = calc_npfe(fkeller);
			break;
		}
		if( !strcmp( zkstr, "ecgnp" ) )
		{	a = calc_ecgnp(fkeller);
			break;
		}
		if( !strcmp( zkstr, "conjug" ) )
		{	a = calc_conjug(fkeller);
			break;
		}
		if( !strcmp( zkstr, "imag" ) )
		{	a = calc_imag(fkeller);
			break;
		}
		if( !strcmp( zkstr, "real" ) )
		{	a = calc_real(fkeller);
			break;
		}
		if( !strcmp( zkstr, "cper" ) )
		{	a = calc_cper(fkeller);
			break;
		}
		if( !strcmp( zkstr, "sin" ) )
		{	a = calc_trig(fkeller, 1);
			break;
		}
		if( !strcmp( zkstr, "cos" ) )
		{	a = calc_trig(fkeller, 2);
			break;
		}
		if( !strcmp( zkstr, "tan" ) )
		{	a = calc_trig(fkeller, 3);
			break;
		}
		if( !strcmp( zkstr, "cot" ) )
		{	a = calc_trig(fkeller, 4);
			break;
		}
		if( !strcmp( zkstr, "sinh" ) )
		{	a = calc_trig(fkeller, 5);
			break;
		}
		if( !strcmp( zkstr, "cosh" ) )
		{	a = calc_trig(fkeller, 6);
			break;
		}
		if( !strcmp( zkstr, "tanh" ) )
		{	a = calc_trig(fkeller, 7);
			break;
		}
		if( !strcmp( zkstr, "coth" ) )
		{	a = calc_trig(fkeller, 8);
			break;
		}
		if( !strcmp( zkstr, "arcsin" ) )
		{	a = calc_trig(fkeller, 9);
			break;
		}
		if( !strcmp( zkstr, "arccos" ) )
		{	a = calc_trig(fkeller, 10);
			break;
		}
		if( !strcmp( zkstr, "arctan" ) )
		{	a = calc_trig(fkeller, 11);
			break;
		}
		if( !strcmp( zkstr, "arccot" ) )
		{	a = calc_trig(fkeller, 12);
			break;
		}
		if( !strcmp( zkstr, "arsinh" ) )
		{	a = calc_trig(fkeller, 13);
			break;
		}
		if( !strcmp( zkstr, "arcosh" ) )
		{	a = calc_trig(fkeller, 14);
			break;
		}
		if( !strcmp( zkstr, "artanh" ) )
		{	a = calc_trig(fkeller, 15);
			break;
		}
		if( !strcmp( zkstr, "arcoth" ) )
		{	a = calc_trig(fkeller, 16);
			break;
		}
		if( !strcmp( zkstr, "log10" ) )
		{	a = calc_log10( fkeller );
			break;
		}
		if(!strcmp( zkstr, "return"))
		{	breaksch = (-1);
			strcpy(localvar[anzloc].varname,"#");
			localvar[anzloc].varwert=localvar[anzloc-1].varwert +1;
			localvar[anzloc-1].varwert=fkeller;
			strcpy(localvar[anzloc-1].varname,"$");
			anzloc++;
			return(ERROR-1);
			break;
		}
		if(!strcmp( zkstr, "proot" ) )
		{	a = calc_proot( fkeller );
			break;
		}
		if(!strcmp( zkstr, "irpgen"))
		{
# ifdef ___CASI
			a = casi_irpgen( fkeller );
# else
			a = calc_irpgen( fkeller );
# endif
			break;
		}
		if(!strcmp(zkstr, "froot"))
		{	a=calc_froot(fkeller);
			if(a == ERROR-1) return(ERROR-1);
			break;
		}
		if(!strcmp(zkstr,"minor"))
		{	a=calc_minor(fkeller);
			break;
		}
		if(!strcmp(zkstr,"dmconstr"))
		{	a=calc_dmcon(fkeller);
			break;
		}
		if(!strcmp(zkstr,"ntpair"))
		{	a=calc_ntpair(fkeller);
			break;
		}
		if(!strcmp(zkstr,"whei"))
		{	a=calc_whei(fkeller);
			break;
		}
		if(!strcmp(zkstr,"egcd"))
		{	a=calc_egcd(fkeller);
			break;
		}
		if(!strcmp(zkstr,"relcln"))
		{	a=calc_relcln(fkeller);
			break;
		}
		if(!strcmp(zkstr,"ord"))
		{	a=calc_ord(fkeller);
			if(a == ERROR-1) return(ERROR-1);
			break;
		}
		if(!strcmp(zkstr,"faintp"))
		{	a=calc_faintp(fkeller);
			break;
		}
		if(!strcmp(zkstr,"zmconstr"))
		{	a=calc_zmcon(fkeller);
			break;
		}
		if(!strcmp(zkstr,"zvconstr"))
		{	a=calc_zvcon(fkeller);
			break;
		}
		if(!strcmp(zkstr,"mcoef"))
		{	a=calc_mcoef(fkeller);
			break;
		}
		if(!strcmp(zkstr,"vcoef"))
		{	a=calc_vcoef(fkeller);
			break;
		}	
		if(!strcmp(zkstr,"areptsli"))
		{	a=calc_arepli(fkeller);
			break;
		}
		if(!strcmp(zkstr,"eccoef"))
		{	a=calc_eccoef(fkeller);
			break;
		}
		if(!strcmp(zkstr,"ptcoef"))
		{	a=calc_ptcoef(fkeller);
			break;
		}
		if( !strcmp( zkstr, "GF2bit" ) )
		{	a = calc_GF2bit(fkeller);
			break;
		}
		if( !strcmp( zkstr, "curgf2bit" ) )
		{	a = calc_cgf2b(fkeller);
			break;
		}
		if( !strcmp( zkstr, "putGF2bit" ) )
		{	a = calc_putGF2b(fkeller);
			break;
		}
		if( !strcmp( zkstr, "getb" ) )
		{	a = list2(fkeller,0);
			break;
		}
		if( !strcmp( zkstr, "gethex" ) )
		{	a = list2(fkeller,0);
			break;
		}
		if( !strcmp( zkstr, "getoct" ) )
		{	a = list2(fkeller,0);
			break;
		}
		if( !strcmp( zkstr, "putb" ) )
		{	a = calc_putb(fkeller);
			break;
		}
		if( !strcmp( zkstr, "puthex" ) )
		{	a = calc_puthex(fkeller);
			break;
		}
		if( !strcmp( zkstr, "putoct" ) )
		{	a = calc_putoct(fkeller);
			break;
		}
		if( !strcmp( zkstr, "mam2" ) )
		{	a = calc_mam2(fkeller);
			break;
		}
		if( !strcmp( zkstr, "rkbsd" ) )
		{	a = calc_rkbsd(fkeller);
			break;
		}
		if( !strcmp( zkstr, "rk2d" ) )
		{	a = calc_rk2d(fkeller);
			break;
		}
		if( !strcmp( zkstr, "cont" ) )
		{	a = calc_cont(fkeller);
			break;
		}
		if( !strcmp( zkstr, "prim" ) )
		{	a = calc_prim(fkeller);
			break;
		}
		if( !strcmp( zkstr, "pripgen" ) )
		{	a = calc_ppcon(fkeller);
			break;
		}
		if( !strcmp( zkstr, "deg" ) )
		{	a = calc_deg(fkeller);
			break;
		}
		if( !strcmp( zkstr, "rkg2d" ) )
		{	a = calc_rkg2d(fkeller);
			break;
		}
		if( !strcmp( zkstr, "elog" ) )
		{	a = calc_elog(fkeller);
			break;
		}
		if ( !strcmp( zkstr, "ppconstr" ) )
		{       a = calc_ippcon( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "max" ) )
		{       a = calc_max( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "min" ) )
		{       a = calc_min( fkeller );
			break;
		}
		if( !strcmp( zkstr, "f1root" ) )
		{	a = casi_f1root(fkeller);
			if(a == ERROR-1) return(ERROR-1);
			break;
		}
		if( !strcmp( zkstr, "ecnpscf" ) )
		{	a = casi_ecnpscf(fkeller);
			if(a == ERROR-1) return(ERROR-1);
			break;
		}
		if ( !strcmp( zkstr, "ceil" ) )
		{       a = calc_ceil( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "isqrt" ) )
		{       a = calc_isqrt( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "ispprime" ) )
		{       a = calc_ispprime( fkeller );
			break;
		}
		if ( !strcmp( zkstr, "classnum" ) )
		{       a = calc_clnum( fkeller );
			break;
		}
	}
	if( a == -BASIS ) return( -BASIS );
	switch(lsecond(a))
	{	case 15:a = lfirst( a );
			a = fltofl( a );
			a = list2( a, 15 );
			break;
		case 37:a=lfirst(a);
			a=ctoc(a);
			a=list2(a,37);
			break;
		case 38:a=lfirst(a);
			V=lfirst(a);
			r=llength(V);
			a=lsecond(a);
			a=pfltopfl(r,a);
			a=list2(V,a);
			a=list2(a,38);
			break;
		case 39:a=lfirst(a);	
			V=lsecond(a);
			r=llength(V);
			a=lsecond(a);
			a=pctopc(r,a);
			a=list2(V,a);
			a=list2(a,39);
			break;
		default:break;
	}
	a = kenntest( a );
	return( a );
}
