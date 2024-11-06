package codigo;
import java_cup.runtime.Symbol;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char
%unicode
%ignorecase
%buffer 32768


digito = [0-9] 
numero2 = [0-9] +
NombreP = "<" [a-zA-Z]+([ ][a-zA-Z]+)* ">"
precio = {digito}+\.{digito}{2}
codigoP = {digito}{5}
articulo = \"[^\"]+\"
guion = \u002D
FIN_FORMULARIO = "FIN_FORMULARIO"

espacio=[ ,\t,\r,\n]+

%{
private Symbol symbol(int type, Object value){
    return new Symbol(type, yyline, yycolumn, value);
}

private Symbol symbol(int type){
    return new Symbol(type, yyline, yycolumn);
}

private void error(String message) {
    System.err.println("Error en línea " + (yyline + 1) + 
                     ", columna " + (yycolumn + 1) + ": " + message);
}
%}
%%

/* Espacios en blanco */
{espacio} {/*Ignore*/}

/* Comentarios */
( "//"(.)* ) {/*Ignore*/}

/* Nombre Cliente */
{NombreP} { return new Symbol(sym.NombreP, yychar, yyline, yytext()); }

/* Codigo Postal */
{codigoP} { return new Symbol(sym.CodigoP, yychar, yyline, yytext()); }

/* Nombre Articulo */
{articulo} { return new Symbol(sym.articulo, yychar, yyline, yytext()); }

/* Separador2 */
{guion} { return symbol(sym.separador2, yytext()); }

/* Paréntesis Abierto */
"(" { return new Symbol(sym.parA, yychar, yyline, yytext()); }

/* Numero2 */
{numero2} { return new Symbol(sym.numero2, yychar, yyline, yytext()); } 

/* Punto y Coma */
";" { return new Symbol(sym.PuntoyComa, yychar, yyline, yytext()); }

/* Paréntesis Cerrado */
")" { return new Symbol(sym.parC, yychar, yyline, yytext()); }

/* Precio Artículo */
{precio} { return new Symbol(sym.precio, yychar, yyline, yytext()); }

/*Fin del Formulario*/
{FIN_FORMULARIO} { return new Symbol(sym.FIN_FORMULARIO, yychar, yyline, yytext()); }