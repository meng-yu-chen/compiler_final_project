%{
#include "grammar.tab.h"
%}

%%

"+"   	{return ADD;}
"-"   	{return SUB;}
"*"   	{return MUL;}
"/"   	{return DIV;}
"|"   	{return ABS;}

"("     {return FRONT;}
")"     {return BACK;}

"%"		{return MOD;}
"^"     {return POW;}
"!"     {return FAC;}

"{"     {return FGCD;}	/*最大公因數*/
"}"     {return BGCD;}
"<"     {return FLCW;}  /*最小公倍數*/
">"     {return BLCW;}
","     {return COMMA;}

"C"	{return COMBINATION;} /*組合*/
"P"	{return PERMUTATION;} /*排列*/

[0-9]+ 	{yylval=atoi(yytext);return NUMBER;}
\n  	{return EOL;}
[ \t] 	{/*空白忽略*/}
. 	{printf("非法字符 %c\n",*yytext);}

%%