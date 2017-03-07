                               * * * * * * *
                               *     NF    *
                               * * * * * * *

        "number field"
        SYNTAX: X = NF(Y)

        Y is an expression whose value is an element of Z or Q, a
        polynomial over Z or Q, a matrix or a vector over these
        structures, an elliptic curve or a point of an elliptic curve
        over Q.

        X is assigned the expression corresponding to Y over the current
        number field K.

        K is specified by "curnf(P)", where P is a univariate
        irreducible polynomial of degree greater than 1 in the variable A.
        Then K = Q(al), where al is a root of P, is isomorphic to
        Q[A]/(P(A)). The elements of K can be considered as polynomials
        in A reduced modulo P.
        
        For additional information on working with the current number 
        field, please type "? curnf".

        You can enter matrices, vectors, elliptic curves and points of
        elliptic curves in the following two ways:
        Type e.g.
                (1) X = NF({a1, ..., an}) or    
                (2) X = {a1, ..., NF(ai), ..., an}
        to enter a vector or
                (1) X = NF(EC(a1, a2, a3, a4, a6)) or  
                (2) X = EC(a1, a2, NF(a3), a4, a6)
        to enter an elliptic curve in general Weierstrass normal form.

        In case (2), the function NF must be used for at least one 
        parameter.

        Warning: If you want to enter an elliptic curve and one of its
                 coefficients is an element of K\Q, you must use form (2).
                 You have to write "NF(ai)" for all coefficients ai in
                 K\Q. Coefficients ai in Q may be entered either by "ai"
                 or by "NF(ai)".
                 (The same holds for points on elliptic curves and their
                 coordinates.)

        Remark: The structures over K are displayed on the screen in a 
                similar way they are entered. Elements b of K are displayed 
                as NF(b), where b is a univariate polynomial in the variable
                specified by curnf, e.g. 
                        NF(A + 100) * x^2 + NF(A + 10) * x + NF(A + 1)
                if 'A' is the specified variable.


        Example 1: (correct)

                NF(x + y + A^3 * z)


        Example 2: (correct)

                EC(1, NF(1/3))


        Example 3: (incorrect)

                NF(x/y)

_ERR_NR_162
