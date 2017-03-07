                               * * * * * * *
                               *     GF    *
                               * * * * * * *

        "Galois-field"
        SYNTAX: X = GF(Y)

        Y is an expression whose value is an element of Z, Q, Z/pZ
        (where p is the prime specified by "curgf" or "curgf2bit"), a 
        polynomial over Z, Q, Z/pZ, a matrix or a vector over these 
        structures, an elliptic curve in long Weierstrass normal form 
        or a point of an elliptic curve over Q or Z/2Z.
        Remark: If Y is a matrix or a vector, the characteristic 2 is
                not possible.

        X is assigned the expression corresponding to Y over the current
        Galois-field GF(p^n).

        GF(p^n) is specified by "curgf" or "curgf2bit".
        For additional information on working with the current Galois- 
        field, please type "? curgf" or "? curgf2bit".

        You can enter matrices, vectors, elliptic curves and points of
        elliptic curves in the following two ways:
        Type e.g.
                (1) X = GF({a1, ..., an}) or    
                (2) X = {a1, ..., GF(ai), ..., an}
        to enter a vector or
                (1) X = GF(EC(a1, a2, a3, a4, a6)) or  
                (2) X = EC(a1, a2, GF(a3), a4, a6)
        to enter an elliptic curve in general Weierstrass normal form.

        In case (2), the function GF must be used for at least one 
        parameter.

        Warning: If you want to enter an elliptic curve and one of its
                 coefficients is an element of GF(2^n)\(Z/2Z), you must 
                 use form (2). You have to write "GF(ai)" for all 
                 coefficients ai in GF(2^n)\(Z/2Z). Coefficients ai in 
                 Z/2Z may be entered either by "ai" or by "GF(ai)".
                 (The same holds for points on elliptic curves and their
                 coordinates.)

        Remark: The structures over GF(p^n) are displayed on the screen 
                in a similar way they are entered. Elements b of GF(p^n)
                are displayed as GF(b), where b is a univariate 
                polynomial in the variable specified by curgf or
                curgf2bit, e.g. 
                        GF(A + 100) * x^2 + GF(A + 10) * x + GF(A + 1)
                if 'A' is the specified variable.


        Example 1: (correct)

                GF(A + y + A^3 * z)


        Example 2: (correct)

                EC(1,0,GF(1/3*A^2),0,1)


        Example 3: (incorrect)

                GF(A/y)

_ERR_NR_262
