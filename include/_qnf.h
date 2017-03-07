/* The following struct is used by ecrqnf1rank */  

#include <_PAFarith.h>

typedef struct {                                              
        single gen;             /* generator; D for K = Q(sqrt(D)) */
        single mod4;            /* D mod 4; either 2,3 or 1 */
        obj fununit;            /* fundamental unit; algebraic integer */
        single classnr;         /* class number */                
        single floorsqrt;       /* floor of sqrt(D) (ssqrt(D)) */
        Float w,w1;             /* w = sqrt(D)          if D = 2,3 (mod 4)
                                     = (1+sqrt(D))/2    if D = 1 (mod 4)
                                   w1 = -sqrt(D)        if D = 2,3 (mod 4)
                                      = (1-sqrt(D))/2   if D = 1 (mod 4) */
        Float rD_2;             /* root of D, possibly multiplied by 2:
                                   rD_2 = 2 * sqrt(D)   if D = 2,3 (mod 4)
                                        = sqrt(D)       if D = 1 (mod 4) */  
        Float d1;               /* corresponds to 4*(sqrt(3)/2)^2 = 3 in Q */
        Float d1inv;            /* corresponds to 1 / (4*(sqrt(3)/2)^2) in Q */
        single minprec;         /* intepsDGTS + reserveDGTS + number of decimal
                                                        places of floor(w) */
        obj pi,pib;             /* generators of the prime ideals dividing 2
                                   D = 5 (mod 8):    pi: no   pib: no
                                   D = 2,3 (mod 4):  pi: yes  pib: no
                                   D = 1 (mod 8):    pi: yes  pib: yes */
} rqnf;                                                                      
