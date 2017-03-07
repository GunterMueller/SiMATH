/*M
	Example for the use of the KANT-SIMATH interface.
	The input is an irreducible polynomial in x, the output is the
	class number of the algebraic number field, which is generated
	by the given polynomial.
	The I/O-functions are SIMATH standard, the computation of the
	class number is done by KANT functions.
	Warning! You need the computer algebra system KANT on your
	machine and you should have compiled the program SM
	appropriately (see the file site.h in $SM_HOME/header, $SM_HOME
	denotes the directory where you installed SIMATH).
	Please don't be angry about SIMATH when KANT crashes.
M*/
/*H
	Version 1	16.04.1993	Marc Conrad
H*/
/*cS
	this program uses: KtoS, StoK, kant_start, order_equation_create,
		order_maximal, order_classgroup_calc, order_delete
	Macros: getpi, list1, order_class_number
cS*/

#include <kant.h>
#include <_simath.h>

main()
{
    pol             p;		/* SIMATH types */
    int             cl;
    list            V;

    t_handle        k1, k2;	/* KANT types */
    order           o, max;

    init(p, cl, V);

    /*
     * "kant_start" is a KANT function. For a documentation of the functions
     * of KANT, please see the KANT manual.
     */

    kant_start();

    V = pmakevl("x");
    printf("Enter an irreducible polynomial with integral coefficients\n");
    printf("in the variable x (with a '#' as terminating symbol): \n");
    p = getpi(1, V);

    printf("Conversion SIMATH -> KANT ... \n");
    StoK(p, &k1, &k2, 16 + 1, 0);	/* conversion routine SIMATH -> KANT */

    printf("Using KANT ... \n");
    o = order_equation_create(structure_z, k2);
    max = order_maximal(o);
    order_class_group_calc(max);	/* calculation of class number       */
    k2 = order_class_number(max);	/* with KANT functions               */

    printf("Conversion KANT -> SIMATH ... \n");
    cl = KtoS(structure_z, k2, 0);	/* conversion routine KANT -> SIMATH */
    printf("The class number is = %i\n", cl);

    order_delete(&o);
    order_delete(&max);
}
