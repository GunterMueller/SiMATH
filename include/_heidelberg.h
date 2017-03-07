 /*
  * This file renames all the functions used in the Heidelberg arithmetic
  * package by appending the string "HD_" to the functions. This avoids
  * conflicts with other packages such as LiDIA.
  */

#ifndef _H_HEIDELBERG
#define _H_HEIDELBERG

 /*
  * These are the functions LiDIA complained about.
  */

#define DigitVecKaratsubaM	HD_DigitVecKaratsubaM
#define IasImuD			HD_IasImuD
#define IasImuI			HD_IasImuI
#define Ieven			HD_Ieven
#define ImuasD			HD_ImuasD
#define ImuasI			HD_ImuasI

 /*
  * LiDIA did not complain about the following functions but we renamed them
  * anyway.
  */

#define DigitAdd		HD_DigitAdd
#define DigitDiv		HD_DigitDiv
#define DigitMult		HD_DigitMult
#define DigitMultAdd		HD_DigitMultAdd
#define DigitSub		HD_DigitSub
#define DigitVecAdd		HD_DigitVecAdd
#define DigitVecCadd		HD_DigitVecCadd
#define DigitVecCsub		HD_DigitVecCsub
#define DigitVecCsubto		HD_DigitVecCsubto
#define DigitVecDiv		HD_DigitVecDiv
#define DigitVecEq		HD_DigitVecEq
#define DigitVecGt		HD_DigitVecGt
#define DigitVecMult		HD_DigitVecMult
#define DigitVecMultAdd		HD_DigitVecMultAdd
#define DigitVecMultSub		HD_DigitVecMultSub
#define DigitVecSr1		HD_DigitVecSr1
#define DigitVecSri		HD_DigitVecSri
#define DigitVecSub		HD_DigitVecSub
#define Ias0			HD_Ias0
#define Ias1			HD_Ias1
#define IasI			HD_IasI
#define IasIdiD			HD_IasIdiD
#define IasIdiI			HD_IasIdiI
#define IasImiI			HD_IasImiI
#define IasIplI			HD_IasIplI
#define IasIreI			HD_IasIreI
#define IasIslint		HD_IasIslint
#define IasIsrint		HD_IasIsrint
#define Iasint			HD_Iasint
#define Ibgcd			HD_Ibgcd
#define Ibxgcd			HD_Ibxgcd
#define Idec			HD_Idec
#define Idgcd			HD_Idgcd
#define IdiasD			HD_IdiasD
#define IdiasI			HD_IdiasI
#define Idiv			HD_Idiv
#define Idxgcd			HD_Idxgcd
#define Ieq0			HD_Ieq0
#define Ieq1			HD_Ieq1
#define IeqI			HD_IeqI
#define Ierror			HD_Ierror
#define Ifree			HD_Ifree
#define Ige0			HD_Ige0
#define IgeI			HD_IgeI
#define Igt0			HD_Igt0
#define IgtI			HD_IgtI
#define Iinc			HD_Iinc
#define Iisint			HD_Iisint
#define Iislong			HD_Iislong
#define Iisuint			HD_Iisuint
#define Iisulong		HD_Iisulong
#define Ile0			HD_Ile0
#define IleI			HD_IleI
#define Ilog			HD_Ilog
#define Ilt0			HD_Ilt0
#define IltI			HD_IltI
#define Imalloc			HD_Imalloc
#define ImiasI			HD_ImiasI
#define IneI			HD_IneI
#define Ineg			HD_Ineg
#define IplasI			HD_IplasI
#define IprintStatistics	HD_IprintStatistics
#define IreasI			HD_IreasI
#define Ireduce			HD_Ireduce
#define Islasint		HD_Islasint
#define Israsint		HD_Israsint
#define Itoa			HD_Itoa
#define Isr1			HD_Isr1
#define _delInteger		HD__delInteger
#define _newInteger		HD__newInteger
#define atoI			HD_atoI
#define cI			HD_cI
#define cIasI			HD_cIasI
#define cIasint			HD_cIasint
#define cIaslong		HD_cIaslong
#define cIasuint		HD_cIasuint
#define cIasulong		HD_cIasulong
#define cImaxlength		HD_cImaxlength
#define dI			HD_dI
#define ddI			HD_ddI
#define delDigitVec		HD_delDigitVec
#define fprintI			HD_fprintI
#define fscanI			HD_fscanI
#define intasI			HD_intasI
#define intlog			HD_intlog
#define longasI			HD_longasI
#define ncI			HD_ncI
#define ncIasI			HD_ncIasI
#define ncIasint		HD_ncIasint
#define ncImaxlength		HD_ncImaxlength
#define newDigitVec		HD_newDigitVec
#define rIdata1			HD_rIdata1
#define rIdata2			HD_rIdata2
#define uIasIdiD		HD_uIasIdiD
#define uIdiasD			HD_uIdiasD
#define uIdiv			HD_uIdiv
#define uintasI			HD_uintasI
#define ulongasI		HD_ulongasI
#define vecaddDigitType		HD_vecaddDigitType
#define wIdata1			HD_wIdata1
#define wIdata2			HD_wIdata2

#endif
