/*C
			gf2elred( a, Gm )    (MACRO)

	"Galois-field with characteristic 2 element reduction"
	Quellbibliothek: srclib.arith2
	Include-Datei:   _arith2.h
	gf2el gf2elred(a, Gm); obj Gm; gf2el a;
	b = gf2elred( a, Gm );
	Gm ist ein irreduzibles, normiertes Polynom in einer Variablen 
	ueber Z/2Z vom Grad m in der speziellen Bitdarstellung (vgl.
	udpm2tosb). Gm kann als ein erzeugendes Polynom fuer GF(2^m)
	interpretiert werden. 
	a wird als Element aus GF(2^n) (m<n) dargestellt als Polynom in 
	einer Variablen ueber Z/2Z vom Grad < n in spezieller 
	Bit-Notation.
	b ist die Darstellung von a als Element aus GF(2^m).
C*/
/*H
	Version  1      19.05.1993      S.Schmitt
	Version  2      14.03.1996      S.Schmitt (Gn aus Aufruf weg, also 
						gf2eltoudpm2 -> gf2etudpm2 )
H*/
 
# define gf2elred(a,Gm)  udpm2togf2el(Gm,gf2etudpm2(a)) 
