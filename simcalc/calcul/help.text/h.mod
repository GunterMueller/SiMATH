                               * * * * * * *
                               *    mod    *
                               * * * * * * *
        "modulo"
        SYNTAX: X = A mod B
        
        The following cases are possible:

        1) B is an expression whose value is a positive integer or a
           polynomial over Z or Q.
           A is an expression whose value is an element of Z or Q, a
           polynomial over Z or Q or a matrix or a vector over these
           structures.

        2) B is an expression whose value is a polynomial over Z/pZ,
           (where p is a prime) or GF(p^n).
           A is an expression whose value is a polynomial over Z/pZ or
           GF(p^n), a matrix or a vector over polynomials over Z/pZ or
           GF(p^n) (where p is a prime).
           Warning: If p > 2^30, the primality of p is not tested.
           
        3) B is an expression whose value is a polynomial over a
           number field.
           A is an expression whose value is a polynomial over a
           number field, a matrix or a vector over polynomials over 
           a number field.

        X is assigned A modulo B. 

        Warning: "mod" has the same priority as '*', '/', ':'.


        Example 1: (incorrect)

                12343546567124214 mod (2^12 - 64*65)
                
_ERR_NR_245


        Example 2: (correct)

                (5*2) mod (7*3)


        Example 3: (correct)

                (NF(A) * x + x^2) mod (NF(x))


        Example 4: (correct)

                3^4 mod 5^2


        Example 5: (incorrect)

                (12 * 6589 - 456) mod (2/3)
                
_ERR_NR_245


        Example 6: (correct)

                 (5*x*y^2 + 6*y + 7*x + 1) mod 3


        Example 7: (incorrect)

                x/y mod 5
                
_ERR_NR_246


        Example 8: (correct)

                (x^2 + x + y) mod (x^2)


        Example 9: (correct)

                {{23123, 898} {9*x, y}} mod 3


        Example 10: (correct)

                {1/7*x, 123, y*x, x + 1} mod x

