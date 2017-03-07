#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#define READBUFFER_SIZE ( 16 * 1024 )
#define UNNEST_INPUTBUFFER_SIZE ( 64 * 1024 )
#define UNNEST_OUTPUTBUFFER_SIZE ( 64 * 1024 )
#define UNNEST_VARBUFFER_SIZE ( 64 * 1024 )
#define BLOCKBUFFER_SIZE ( 128 * 1024 )

#define JAM 100
#define NOTYPE 101

int xx_isblank(char c) { 
    if( c == ' ' || c == '\t' ) { return 1; } 
    return 0; 
    } 

typedef unsigned int _uint;

typedef struct _tree_struct tree_struct;

struct _tree_struct
{
	char vartype;
	_uint varnum;
	char *s;
	_uint l;

	tree_struct *next, *child; 
};

char *typeprefix, *varprefix;

tree_struct *new_tree_node( void )
{
	tree_struct *retval;

	retval = ( tree_struct * )malloc( sizeof( tree_struct ) );
	retval->varnum = 0;
	retval->next = retval->child = NULL;

	return retval;
}

tree_struct *make_expr_tree( char *p1, char *p2 )
{
	char *p;
	tree_struct **pretval, *retval, *pt;
	_uint pc;

	retval = NULL; pretval = &retval;

	while( p1 < p2 )
	{
		p = strstr( p1, "@@" );
		if( !p || p >= p2 )
			p = p2;

		if( p > p1 )
		{
			*pretval = pt = new_tree_node();
			pt->vartype = JAM;
			pt->s = p1;
			pt->l = p - p1;

			pretval = &( pt->next );
		}

		if( p < p2 )
		{
			*pretval = pt = new_tree_node();

			if( p[ 2 ] == '@' )
			{
				pt->vartype = 0;
				p1 = p + 3;
			}
			else if( isdigit( p[ 2 ] ) )
			{
				pt->vartype = 10 * ( p[ 2 ] - '0' ) + p[ 3 ] - '0';
				p1 = p + 4;
			}
			else
			{
				pt->vartype = NOTYPE;
				p1 = p + 2;
			}

			p = strchr( p1, '(' );
			pt->s = p1;
			pt->l = p - p1;

			p1 = ++p;
			pc = 1;
			while( p < p2 )
			{
				switch( *p )
				{
					case '(':
						pc++;
						break;
					case ')':
						pc--;
						break;
				}
				if( ! pc )
					break;
				else
					p++;
			}

			pt->child = make_expr_tree( p1, p );
			pretval = &( pt->next );
		}

		p1 = p + 1;					
	}

	return retval;
}

void free_expr_tree( tree_struct *p )
{
	if( p )
	{
		free_expr_tree( p->child );
		free_expr_tree( p->next );
		free( p );
	}
}

_uint next_varnum( char vartype, _uint *resvar, _uint *maxvar )
{
	_uint retval = ++resvar[ vartype ];

	if(  retval > maxvar[ vartype ] )
		maxvar[ vartype ]++;
		
	return retval;
}

void tree_2_str_cat( tree_struct *p, char *buffer )
{
	tree_struct *i;

	if( p )
		switch( p->vartype )
		{
			case JAM:
				strncat( buffer + strlen( buffer ), p->s, p->l );
				break;
			case NOTYPE:
				strncat( buffer + strlen( buffer ), p->s, p->l );
				strcat( buffer, "(" );
				for( i = p->child; i; i = i->next )
					tree_2_str_cat( i, buffer );
				strcat( buffer, ")" );
				break;
			default:
				sprintf( buffer + strlen( buffer ), "%s%d_%d",
					varprefix, p->vartype, p->varnum
				);
			
		}		
}

void tree_2_str( tree_struct *p, char *buffer )
{
	buffer[ 0 ] = '\0';
	tree_2_str_cat( p, buffer );
}

void unnest_precode( tree_struct *p, char *s, _uint *resvar, _uint *maxvar, char mode, char *blank )
{
	_uint resvar_save[ 100 ];
	char save_vartype, *pblank;

	memcpy( resvar_save, resvar, 100 * sizeof( _uint ) );

	for( ; p; p = p->next )
	{
		if( p->vartype == JAM )
			continue;

		unnest_precode( p->child, s, resvar, maxvar, p->vartype != NOTYPE, blank );
		if( p->vartype <= 99 )
		{
			p->varnum = next_varnum( p->vartype, resvar, maxvar );

			for( pblank = blank; xx_isblank( *pblank ); pblank++ )
			{
				s[ strlen( s ) + 1 ] = '\0';
				s[ strlen( s ) ] = *pblank;
			}
			tree_2_str_cat( p, s );
			strcat( s, " = " );
			save_vartype = p->vartype;
			p->vartype = NOTYPE;
			tree_2_str_cat( p, s );
			p->vartype = save_vartype;
			strcat( s, ";\n" );
		}
	}

	if( mode )
		memcpy( resvar, resvar_save, 100 * sizeof( _uint ) );
}

void unnest_code( tree_struct *p, char *buffer )
{
	for( ; p; p = p->next )
		tree_2_str_cat( p, buffer ); 
}

char *unnest( char *s, _uint *maxvar )
{
	static char retval[ UNNEST_OUTPUTBUFFER_SIZE ];
	_uint resvar[ 100 ];
	tree_struct *p;

	memset( resvar, 0, 100 * sizeof( _uint ) );
	retval[ 0 ] = '\0';
	
	p = make_expr_tree( s, s + strlen( s ) );	
	unnest_precode( p, retval, resvar, maxvar, 0, s );
	unnest_code( p, retval );

	free_expr_tree( p );

	return retval;
}

_uint last_length( char *s )
{
	_uint retval;

	for( retval = 0; *s; s++ )
		retval = *s == '\n' ? 0 : retval + 1;

	return retval;
}

char *unnest_vars( _uint *maxvar )
{
	static char retval[ UNNEST_VARBUFFER_SIZE ];
	_uint i, j, lasttype;

	retval[ 0 ] = '\0';

	lasttype = NOTYPE;
	for( i = 0; i <= 99; i++ )
		if( maxvar[ i ] )
			lasttype = i;

	if( lasttype == NOTYPE )
		return retval;

	strcpy( retval, "\n" );

	for( i = 0; i <= 99; i++ )
	{
		if( ! maxvar[ i ] )
			continue;

		if( i )
			sprintf( retval + strlen( retval ), "%s%d", typeprefix, i );
		else
			strcat( retval, "int" );
			
		for( j = 1; j <= maxvar[ i ]; j++ )
		{
			if( last_length( retval ) >= 80 )
				strcat( retval, "\n" );
			sprintf( retval + strlen( retval ), " %s%d_%d%s",
				varprefix, i, j,
				j == maxvar[ i ] ? ";\n" : ","
			);
		}
	}

	strcat( retval, "\ninit(" );

	for( i = 0; i <= 99; i++ )
		for( j = 1; j <= maxvar[ i ]; j++ )
		{
			if( last_length( retval ) >= 80 )
				strcat( retval, " );\ninit(" );
			sprintf( retval + strlen( retval ), " %s%d_%d%s",
				varprefix, i, j,
				i == lasttype && j == maxvar[ i ] ?
				" );\n\n"  : ","
			);
		}

	return retval;
}

void main( int argc, char **argv )
{
	FILE *f1, *f2;
	char 	block_on, expr_on,
		readbuffer[ READBUFFER_SIZE ],
		unnestbuffer[ UNNEST_INPUTBUFFER_SIZE ],
		blockbuffer[ BLOCKBUFFER_SIZE ],
		*bb = "@@{{@@", *eb = "@@}}@@",
		*be = "@@{@@", *ee = "@@}@@", *eebe = "@@}{@@"; 
	_uint maxvar[ 100 ], i;

	typeprefix = strdup( "___temptype" );
	varprefix = strdup( "___tempvar" );
	f1 = stdin;
	f2 = stdout;

	for( i = 1; i < argc; i++ )
	{
		if( ! strcmp( argv[ i ], "-typeprefix" ) )
			typeprefix = strdup( argv[ ++i ] );
		else if( ! strcmp( argv[ i ], "-varprefix" ) )
			varprefix = strdup( argv[ ++i ] );
		else if( f1 == stdin )
			f1 = fopen( argv[ i ], "rt" );
		else if( f2 == stdout )
			f2 = fopen( argv[ i ], "wt" );	
	}

	if( ! f1 )
		f1 = stdin;
	if( ! f2 )
		f2 = stdout;

	block_on = expr_on = 0;
	while( fgets( readbuffer, READBUFFER_SIZE, f1 ) )
	{
		if( ! strncmp( readbuffer, bb, strlen( bb ) ) )
		{
			memset( maxvar, 0, 100 * sizeof( _uint ) );
			blockbuffer[ 0 ] = '\0';
			block_on = 1;
		}
		else if( ! strncmp( readbuffer, eb, strlen( eb ) ) )
		{
			fputs( unnest_vars( maxvar ), f2 );
			fputs( blockbuffer, f2 );
			block_on = 0;
		}
		else if( ! strncmp( readbuffer, be, strlen( be ) ) )
		{
			expr_on = 1;
			unnestbuffer[ 0 ] = '\0';
		}
		else if( ! strncmp( readbuffer, ee, strlen( ee ) ) )
		{
			expr_on = 0;
			strcat( blockbuffer, unnest( unnestbuffer, maxvar ) );
		}
		else if( ! strncmp( readbuffer, eebe, strlen( eebe ) ) )
		{
			strcat( blockbuffer, unnest( unnestbuffer, maxvar ) );
			unnestbuffer[ 0 ] = '\0';
		}
		else if( expr_on )
			strcat( unnestbuffer, readbuffer );
		else if( block_on )
			strcat( blockbuffer, readbuffer );
		else
			fputs( readbuffer, f2 );
	}

	free( typeprefix ); free( varprefix );

	if( f1 != stdin )
		fclose( f1 );
	if( f2 != stdout )
		fclose( f2 );
}
