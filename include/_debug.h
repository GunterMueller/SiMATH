#ifdef __GNUC__
/* DEBUG_LFF prints line number, file name, and function name */
#ifndef DEBUG_LFF
#define DEBUG_LFF printf("*** DEBUG_LFF: line %i of `%s' in `%s':    ", __LINE__ + 1, __FILE__, __PRETTY_FUNCTION__)
#endif
#else
/* DEBUG_LFF prints line number and file name */
#ifndef DEBUG_LFF
#define DEBUG_LFF printf("*** DEBUG_LFF: line %i of `%s':    ", __LINE__ + 1, __FILE__)
#endif
#endif
