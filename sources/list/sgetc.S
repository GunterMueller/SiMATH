/*M
.SH NAME
sgetc - string get character

.SH SYNOPSIS
.nf
#include<_list.h>

single sgetc(ps)  
char **ps;
   
.SH DESCRIPTION
sgetc reads a character from the string *ps and returns it. After that, *p points to the character behind the last character read. In case of an error, sgetc returns ERROR. 

M*/
                    
/*H
	Version 1	15.06.1993	Marc Conrad
   DATE sgetc         : 931130
H*/
#include<_list.h>

char sgetc(ps)
	char **ps;
{
	char c;

	c = **ps;
	(*ps) += 1;

	return (c);
}
