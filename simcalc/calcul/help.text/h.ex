                               * * * * * * *
                               *     ^     *
                               * * * * * * *

        "exponentiation"

        "^" is the operator for the exponentiation b^e.

        b must be an expression whose value is an element of Z, Q,
        R, C or Z/mZ, GF(p^n), an algebraic number, a polynomial over 
        Z, Q, Z/mZ, GF(p^n),a number field, R or C, a rational function
        or a square matrix over these structures, if possible.

        e must be an expression whose value is a single precision
        number, a rational number with single precision numerator 
        and denominator or a floating point number.

        If b is an element of Z, Q or R, e may be an integer, a 
        rational number or a real number; if e is a real number, b
        must be nonnegative.
        If b is an element of C, e must be an integer or a rational 
        number of the form (s/2^t).
        If b is an element of Z/mZ, e must be a rational number of
        the form (s/2^t). If the modulus m is greater than 2^30, m
        must be a prime, but this primality is not tested.
        If b is an element of Z/mZ, e can be an arbitrarily large 
        integer.
        If b is an element of GF(p^n), an algebraic number, a polynomial
        over Z or Q or a rational function, e must be an integer.
        If b is a polynomial over Z/mZ, GF(p^n), a number field, R or C,
        e must be a nonnegative integer.
        If b is a matrix, e must be an integer; if e is negative, 
        the matrix b must be invertible.


        Example 1: (correct)

                (2 * gcd(2, 3 * 12) -4)^(1/3 + 2 * lcm(1234,4563))


        Example 2: (correct)

                (1/7) ^ (-1/8)


        Example 3: (correct)

                2.3 ^ (-10)


        Example 4: (correct)

                NF(A-2) ^ (-3)


        Example 5: (correct)

                MOD(5) ^ (1/8)


        Example 6: (incorrect)

                (2*gcd(2,3*12)-4)^-123456789015
                
_ERR_NR_237


        Example 7: (incorrect)

                2^((2^31)/(3^10))

_ERR_NR_238


        Example 8: (correct)
                
                (x*y*z + y - x -1)^(-10)


        Example 9: (correct)
                
                {{1/x, 2/(x + 1)} {x/(y^3 + y + 1/2), -3}}^2


        Example 10: (incorrect)

                {{1, 2} {2, 4}}^-5

_ERR_NR_076
