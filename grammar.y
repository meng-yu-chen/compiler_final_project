%{
#include <stdio.h>
#include <math.h>
%}

%token NUMBER
%token ADD SUB MUL DIV 
%token MOD  
%token ABS
%token POW
%token FAC
%token FRONT BACK
%token COMMA
%token FGCD BGCD
%token FLCW BLCW
%token COMBINATION
%token PERMUTATION
%token EOL

%%

calclist:/*註解*/
  |calclist exp EOL{printf ("=%d\n",$2);}
  ;

exp:factor {$$ = $1;}
  |exp ADD factor{$$=$1+$3;}
  |exp SUB factor{$$=$1-$3;}
  ;

factor:term {$$=$1;}
  |factor MUL term{$$=$1*$3;}
  |factor DIV term{$$=$1/$3;}
  |factor MOD term{$$=$1%$3;}
  |FGCD NUMBER COMMA NUMBER BGCD{$$=gcd($2, $4);}
  |FLCW NUMBER COMMA NUMBER BLCW{$$=lcw($2, $4);}
  |COMBINATION FRONT NUMBER COMMA NUMBER BACK{$$=combination($3, $5);}
  |PERMUTATION FRONT NUMBER COMMA NUMBER BACK{$$=permutation($3, $5);}
  ;

term:pow_num {$$=$1;}
  |term POW pow_num{$$=pow($1, $3);}
  ;

pow_num:pos_neg {$$=$1;}	/*階層可以為負*/
  |NUMBER FAC{$$=fac($1);}
  ;

pos_neg:last {$$=$1;}
  |FRONT exp BACK{$$=$2;}
  |FRONT SUB exp BACK{$$=-$3;}
  ;

/*最後的判斷*/
last:NUMBER {$$=$1;}	/*負的要用括號包起來，避免誤判*/
  |ABS pos_neg {$$=$2>=0?$2:-$2;}
  ;

%%

fac(int n){	/*階乘*/
  int i;
  int totalSum = 1;
  for(i = 1; i <= n; i++)
    totalSum *= i;
  return totalSum ;
}

int gcd(int a, int b){	/*計算最大公因數*/
  int tmp = a;
  a = (a > b) ? a : b;
  b = (a == b) ? tmp : b;

  int rem;
  while(b != 0){
    rem = a % b;
    a = b;
    b = rem;
  }
  return a;
}

int lcw(int a, int b){	/*計算最小公倍數*/
  int tmp = a;
  a = (a > b) ? a : b;
  b = (a == b) ? tmp : b;

  int res=gcd(a,b);
  if(res==1)
    return a*b;
  int i=b;
  while(i>0){
    if(i%b==0 && i%a==0){
      return i;
    }
    i++;
  }
  
}

int permutation(int n, int k) {
    if (n<k)
	return -1;
    return combination(n,k)*fac(k);
}

int combination(int n, int k) {
    if(n<k||k<0)
	return -1;
    if(n==k||k==0)
	return 1;
    return combination(n-1,k)+combination(n-1,k-1);
}

main(int argc,char **argv){
	yyparse();
}

yyerror(char *s){
 fprintf(stderr,"error:%s\n",s);
}


