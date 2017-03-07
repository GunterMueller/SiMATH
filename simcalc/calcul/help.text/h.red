                               * * * * * * *
                               *    red    *
                               * * * * * * *

        "reduction"
        SYNTAX: X = red(p, E)

        p is an expression whose value is a prime.
        E is an expression whose value is an elliptic curve over 
        Q where the denominators of the coefficients of E must be
        coprime to p. E must be minimal at p and must have
        good reduction at p.

        X is assigned the elliptic curve EC(p) which is derived from
        E by reduction mod p.
        
        Warning: If p > 2^30, the primality of p is not tested.


        Example 1: (correct)

                red(3, EC(8, 9))


        Example 2: (incorrect)

                red(3, EC(3, 9, 27, 81, 3^6))

_ERR_NR_143             


        Example 3: (incorrect)

                red(10, EC(4, 2, 0, 1, 3))
                
_ERR_NR_046


        Example 4: (incorrect)

                red(2, EC(8, 9))

_ERR_NR_145


        Example 5: (incorrect)

                red(7, EC(1/7, 0))

_ERR_NR_204             
