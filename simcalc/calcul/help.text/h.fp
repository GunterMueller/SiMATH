                               * * * * * * *
                               *    fp     *
                               * * * * * * *

        "finding point"
        SYNTAX: X = fp(E)

        E is an expression whose value is an elliptic curve over Z/pZ 
        (where p is a prime) or GF(2^n).

        X is assigned any projective point of E which is not the point 
        at infinity.


        Example 1: (correct)

                fp(EC(MOD(8), 9))


        Example 2: (correct)

                fp(EC(GF(3*A^2+A),0,1,0,3))
