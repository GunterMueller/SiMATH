                               * * * * * * *
                               *    MOD    *
                               * * * * * * *

        "modular arithmetic"
        SYNTAX: X = MOD(A)

        A is an expression whose value is an element of Z or Q, a
        polynomial over Z or Q, a matrix or a vector over these
        structures, an elliptic curve over Q or a point of an elliptic 
        curve over Q.
        
        X is assigned the expression corresponding to A over Z/mZ where
        m is the current modulus ("? curmod").

        If A is an elliptic curve over Q or a point of an elliptic
        curve over Q, the modulus m must be a prime.
        Warning: If m > 2^30, the primality of m is not tested.

        You can enter matrices, vectors, elliptic curves and points of 
        elliptic curves in the following two ways: 
        Type e.g.
                (1) X = MOD({a1, ..., an}) or     
                (2) X = {a1, ..., MOD(ai), ..., an}
        to enter a vector or
                (1) X = MOD(EC(a1, a2, a3, a4, a6)) or   
                (2) X = EC(a1, a2, MOD(a3), a4, a6)
        to enter an elliptic curve in general Weierstrass normal form.

        In case (2), the function MOD must be used for at least one
        parameter.
        
        For additional information on working with the current modulus, 
        please type "? curmod".

        Remark: The structures over Z/mZ are displayed on the screen
                in a similar way they are entered. Elements b of Z/mZ 
                are displayed as MOD(b), e.g. 
                        MOD(100) * x^2 + MOD(10) * x + MOD(1).

        
        Example 1: (correct)

                MOD(x + y + 3 * z)


        Example 2: (correct)

                EC(1, MOD(3))


        Example 3: (incorrect)

                MOD(x/y)

_ERR_NR_157
