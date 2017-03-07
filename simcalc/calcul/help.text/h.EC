                               * * * * * * *
                               *     EC    *
                               * * * * * * *

        "elliptic curves"
        SYNTAX: X = EC(a1, a2, a3, a4, a6)
                X = EC(a, b)

        a1, ..., a6 or a, b are expressions whose values are elements
        of Z, Q, Z/pZ (where p is a prime), GF(2^n) or a number field.
        Remark: The short Weierstrass normal form is in characteristic
                2 not possible.

        X is assigned the elliptic curve in general Weierstrass normal form
                y^2 + a1 x y + a3 y = x^3 + a2 x^2 + a4 x + a6
        or in short Weierstrass normal form
                y^2 = x^3 + a x + b.

        Remark: Elliptic curves are displayed on the screen in the same
                way they are entered, i.e. 
                EC(a1, a2, a3, a4, a6) or EC(a, b).

        Warning: If p > 2^30, the primality of p is not tested.

        Example 1: (correct)

                EC(4, 0)


        Example 2: (incorrect)

                EC(0, 0)

_ERR_NR_106


        Example 3: (correct)

                EC(5/4, 0, 1, 0, 0)


        Example 4: (correct)

                EC(NF(A), NF(A + 1), 3, 1, 2)


        Example 5: (correct)

                EC(MOD(7), 2)


        Example 6: (correct

                EC(GF(3*A+1), 0, 2, GF(A^2), 3)


        Example 7: (incorrect)

                EC(x, y)

_ERR_NR_107
