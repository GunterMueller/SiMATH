/*M
.SH NAME
 putecrp - put elliptic curve over rational numbers, point

.SH SYNOPSIS
.nf
 #include<_ec1.h>

 single putecrp( P );
 list P ;

.SH DESCRIPTION

 for P = ( x y z ) ,
 int x, y, z ,
 putecrp( ) writes the point P of an elliptic curve E/Q in
 the shape
      ( x/z^2 , y/z^3 ) , for z != 0 ,
      (  0 : 1 : 0 )    , else 
 to stdout and returns 0 or ERROR in case an error has
 occurred. 
M*/

/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putecrp       : 921130.941201
H*/
/*
	For the definition of putecrp please refer to the header file _ec1.h.
*/
