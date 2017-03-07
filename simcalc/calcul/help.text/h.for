                               * * * * * * *
                               *    for    *
                               * * * * * * *

        "for-loop"
        SYNTAX: for(x=l, u, seq)
                for(x=l;, u, seq)
                for(l, u, seq)
                for(l;, u, seq)


        seq is executed while x (or the system variable @ in the third 
        and fourth case) runs from l to u in steps of 1.
        for(x=l, u, seq) has the same effect as forstep(x=l, u, 1, seq)
        (see "? forstep").

        l and u are expressions whose values are integers, rational 
        or real numbers, l <= u.
        Remark: If u is an expression containing x (or @), u is 
                evaluated once at the beginning and remains fixed.
        If you type "x=l" or "l", resp., the new value of x or @, resp.,
        is displayed in every step. To avoid this, terminate this
        expression by ';' like in the second and fourth case.
   
        seq is a sequence of several expressions, separated by '_' or 
        ';'. If an expression ends with '_', its output is displayed,
        if it ends with ';', its output is suppressed. 
        Remark: The last expression of seq must not be terminated by 
                '_' and need not be terminated by ';'. If you want its 
                output to be suppressed, terminate it by ';'.
                To avoid the output of unnecessary results during the 
                computation, please use ';'.
        At the end of the outermost loop, the values of all variables 
        used during the computation are displayed.

        Endless loops are not recognized. Type "CTRL/C" to interrupt 
        the loop. In that case, the value of all variables are 
        displayed.

        The overwrite protection mechanism is automatically disabled
        in a loop. At the end of the loop, it is restored.
  
        If an error occurs, the reader is asked, if the loop should be
        continued. If the answer is positive, the actual loop is continued, 
        else the loop is left.

        "break" and "continue" may be used (see "? break","? continue").


        Example 1: (correct)

                for(a=0,sqrt(17),b=exp(a))


        Example 2: (correct)

                for(t=1;,10,r=[t]_t=t+0.5;)


        Example 3: (incorrect)

                for(a=5,0,b=2*a)

_ERR_NR_034_for_
