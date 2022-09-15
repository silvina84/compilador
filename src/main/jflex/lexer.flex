package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;

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
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
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
DISTINTO = "!="

WhiteSpace = {LineTerminator} | {Identation}
Identifier = {Letter} ({Letter}|{Digit})*
IntegerConstant = {Digit}+
StringConstant = {QuotationMark} ({Letter}|{Digit}|{Space}|{AllowedSymbols})* {QuotationMark}
Comment = {Div}{Mult} ({Letter}|{Digit}|{Space}|{AllowedSymbols})* {Mult}{Div}


%%


/* keywords */

<YYINITIAL> {
  /* identifiers */
  {Identifier}                             {
                                            if (new String("If").equals(yytext())) {
                                                return symbol(ParserSym.IF, yytext());
                                            }
                                            return symbol(ParserSym.IDENTIFIER, yytext()); }
  /* Constants */
  {IntegerConstant}                        { return symbol(ParserSym.INTEGER_CONSTANT, yytext()); }

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

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
}


/* error fallback */
[^]                              { throw new UnknownCharacterException(yytext()); }
