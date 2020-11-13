grammar TGB;

options {
    language=Java;
}

@header {
    import java.util.HashMap;
}

@parser::members {
  @Override

  public void reportError(RecognitionException e) {

    //System.out.println("\nEXCECAO SINTATICA/SEMANTICA: " + e + "\n");

  }
  HashMap<String, Double> varMap = new HashMap<>(); 
int valor = 0;
String simb= " ";
String operador= " ";
String semi= " ";
String comando = " ";
 }

 
parse
  : prog EOF
  ;

 
prog:
   stat* ;
   

stat
:atribuicao
|teste
|relational_expression
|aritmetic_expression 
|iteracao
;


atribuicao returns [ double v ]:
VAR {simb = $VAR.text; System.out.println("Variavel " + simb + " detectada");}':='(e = aritmetic_expression {$v = $e.v;} {System.out.println("Resultado: " + $v);  varMap.put($VAR.text, $v);}) SEMI
;

teste
:(IF{comando = $IF.text; 
System.out.println("Comando " + comando + " detectado");} relational_expression 

THEN{comando = $THEN.text; 
	System.out.println("Comando " + comando + " detectado");} comando+) (ELSE{comando = $ELSE.text; System.out.println("Comando " + comando + " detectado");} comando+ (SEMI))
;



iteracao
: WHILE {comando = $WHILE.text; System.out.println("Comando " + comando + " detectado");}relational_expression DO{comando = $DO.text; System.out.println("Comando " + comando + " detectado");} comando+ SEMI
;


comando
: atribuicao
| teste
| iteracao
;

relational_expression
: VAR{simb = $VAR.text; System.out.println("Variavel " + simb + " detectada");} OPERADOR_RELACIONAL {operador = $OPERADOR_RELACIONAL.text; System.out.println("Operador relacional " + operador + " detectado");} aritmetic_expression
   
;


aritmetic_expression returns [ double v ]:
	e = value {$v = $e.v;} ('+' e = aritmetic_expression {$v += $e.v;} | '-' e = aritmetic_expression {$v -= $e.v;} | '*' e = aritmetic_expression {$v *= $e.v;} | '/' e = aritmetic_expression {$v /= $e.v;})	
    |	e = value {$v = $e.v;} 
    |	'(' e = aritmetic_expression {$v = $e.v;} ')'
    ;


DO: 'do';
ELSE: 'else';
IF: 'if';
RETURN: 'return';
WHILE: 'while';
THEN : 'then';


OPERADOR_RELACIONAL: '<' | '>' | '>=' | '<=' | '<>' | '=';
SEMI: ';';


value returns [ double v ]: 
 CONST  {$v = Double.parseDouble( $CONST.text);}
|VAR    {$v = varMap.getOrDefault($VAR.text, 0.0);} 

;

CONST : ('0'..'9')+ ;
VAR  : ('a'..'z')+ ;

WS  : (' '|'\n'|'\r')+ {skip();} ;


FallThrough
@after{
  throw new RuntimeException(String.format(
      "Caractere ilegal reconhecido na linha \%d, coluna \%d: '\%s'",
      getLine(), getCharPositionInLine(), getText()
)
  );
}
  :  .
  ;