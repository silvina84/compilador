package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;
import java.lang.Math;

%%

%public
%class Lexer
%unicode
%cup
%line
%column
%throws CompilerException
%eofval{
  return symbol(ParserSym.EOF);
%eofval}


%{
  TablaSimbolos t;
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }

  public void validar_rango_entero(String str)
  {
   int num = Integer.parseInt(str);
   if(num<=-32768|| num>=32767)
    {
        System.out.println("Entero fuera de rango\n");
    }
  }

  public void validar_rango_real(String str)
  {
  	float num = Float.valueOf(str);
                    if((num< Math.pow(3.40282,-38)) || (num > Math.pow(3.40282,38))) {
  	              System.out.println("Real fuera de rango\n");
  	}
  }

  public void controlar_cant_caracteres(String str)
  {
    if(str.length()>40)
    {
        System.out.println("\n Error.  El string tiene más de 40 caracteres\n");
    }
  }
%}


LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Identation =  [ \t\f]

Space = " "
Plus = "+"
Mult = "*"
Sub = "-"
Div = "/"
Assig = "="
OpenBracket = "("
CloseBracket = ")"
QuotationMark = \"
AllowedSymbols = {Plus} | {Mult} | {Sub} | {Div} | {Assig} | {OpenBracket} | {CloseBracket}
Letter = [a-zA-Z]
Digit = [0-9]
COMA = ","
PUNTO_COMA = ";"
OPERACION_TIPO = ":"
CORCH_ABIERTO = "["
CORCH_CERRADO = "]"
LLAVE_ABIERTA = "{"
LLAVE_CERRADA = "}"
MENOR_IG = "<="
MENOR = "<"
MAYOR_IG = ">="
MAYOR = ">"
IGUAL = "=="
AND = "&"
OR = "||"
NOT "not"
DISTINTO = "!="
If = "If"
While = "While"
Else = "Else"
read = "read"
write = "write"
Int = "Int"
Float = "Float"
String = "String"
init = "init"
AllEqual = "AllEqual"
Do = "Do"
Case = "Case"
Default = "Default"
EndDo = "EndDo"

WhiteSpace = {LineTerminator} | {Identation}
Identifier = {Letter} ({Letter}|{Digit})*
IntegerConstant = {Digit}+
RealConstant =  ({Digit})*"."({Digit})*
StringConstant = {QuotationMark} ({Letter}|{Digit}|{Space}|{AllowedSymbols})* {QuotationMark}
Comment = {Div}{Mult} ({Letter}|{Digit}|{Space}|{AllowedSymbols})* {Mult}{Div}


%%


/* keywords */

<YYINITIAL> {
  /* reserverd words */
  {If}                                      { return symbol(ParserSym.IF); }
  {While}                                   { return symbol(ParserSym.WHILE); }
  {Else}                                    { return symbol(ParserSym.ELSE); }
  {read}                                    { return symbol(ParserSym.READ); }
  {write}                                   { return symbol(ParserSym.WRITE); }
  {Int}                                     { return symbol(ParserSym.INT); }
  {Float}                                   { return symbol(ParserSym.FLOAT); }
  {String}                                  { return symbol(ParserSym.STRING); }
  {init}                                    { return symbol(ParserSym.INIT); }
  {AllEqual}                                { return symbol(ParserSym.ALLEQUAL); }
  {Do}                                      { return symbol(ParserSym.DO); }
  {Case}                                    { return symbol(ParserSym.CASE); }
  {Default}                                 { return symbol(ParserSym.DEFAULT); }
  {EndDo}                                   { return symbol(ParserSym.ENDDO); }
  /* identifiers */
  {Identifier}                               {t.guardar_TS("ID",yytext());return symbol(ParserSym.IDENTIFIER, yytext()); }
  /* Constants */
  {IntegerConstant}                         { validar_rango_entero(yytext()); t.guardar_TS("Cte_Entera",yytext()); return symbol(ParserSym.INTEGER_CONSTANT, yytext()); }
  {RealConstant}                            { validar_rango_real(yytext()); t.guardar_TS("Cte_Real",yytext()); return symbol(ParserSym.REAL_CONSTANT, yytext()); }
  {StringConstant}                          { controlar_cant_caracteres(yytext()); t.guardar_TS("Cte_String",yytext()); return symbol(ParserSym.STRING_CONSTANT, yytext()); }

  /* operators */
  {Plus}                                    { return symbol(ParserSym.PLUS); }
  {Sub}                                     { return symbol(ParserSym.SUB); }
  {Mult}                                    { return symbol(ParserSym.MULT); }
  {Div}                                     { return symbol(ParserSym.DIV); }
  {Assig}                                   { return symbol(ParserSym.ASSIG); }
  {OpenBracket}                             { return symbol(ParserSym.OPEN_BRACKET); }
  {CloseBracket}                            { return symbol(ParserSym.CLOSE_BRACKET); }
  {Comment}                                 { return symbol(ParserSym.EOF); }
  {COMA}                                    { return symbol(ParserSym.COMA); }
  {PUNTO_COMA}                              { return symbol(ParserSym.PUNTO_COMA); }
  {OPERACION_TIPO}                          { return symbol(ParserSym.OPERACION_TIPO); }
  {CORCH_ABIERTO}                           { return symbol(ParserSym.CORCH_ABIERTO); }
  {CORCH_CERRADO}                           { return symbol(ParserSym.CORCH_CERRADO); }
  {LLAVE_ABIERTA}                           { return symbol(ParserSym.LLAVE_ABIERTA); }
  {LLAVE_CERRADA}                           { return symbol(ParserSym.LLAVE_CERRADA); }
  {MENOR_IG}                                { return symbol(ParserSym.MENOR_IG); }
  {MAYOR_IG}                                { return symbol(ParserSym.MAYOR_IG); }
  {MAYOR}                                   { return symbol(ParserSym.MAYOR); }
  {IGUAL}                                   { return symbol(ParserSym.IGUAL); }
  {DISTINTO}                                { return symbol(ParserSym.DISTINTO); }
  {AND}                                     { return symbol(ParserSym.AND); }
  {OR}                                      { return symbol(ParserSym.OR); }
  {NOT}                                     { return symbol(ParserSym.NOT); }


  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
}


/* error fallback */
[^]                              { throw new UnknownCharacterException(yytext()); }
