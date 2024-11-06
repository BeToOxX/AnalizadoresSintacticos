package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
%unicode


digito = [0-9] 
numero2 = [0-9]+          
precio = [0-9]+\.[0-9]{2}
NombreP = "<" [a-zA-Z]+([ ][a-zA-Z]+)* ">"
codigoP = [0-9]{5}  
articulo = \"[^\"]+\"
guion = \u002D
FIN_FORMULARIO = "FIN_FORMULARIO"
espacio=[ ,\t,\r,\n]+

%{
public String lexeme;

private void error(String message) {
    System.out.println("Error léxico en línea " + (yyline + 1) + 
                     ", columna " + (yycolumn + 1) + ": " + message);
}
%}
%%

/* Espacios en blanco */
{espacio} {/* Ignore */}

/* Comentarios */
( "//"(.)* ) {/*Ignore*/}

 "//".* {/*Ignore*/}

 /* Nombre Cliente */
{NombreP} { lexeme = yytext(); System.out.println("Token emitido: NombreP, Texto: " + yytext()); return NombreP; }

/* Codigo Postal */
{codigoP} { lexeme = yytext(); System.out.println("Token emitido: CodigoP, Texto: " + yytext()); return codigoP; }

/* Nombre Articulo */
{articulo} {lexeme = yytext(); return articulo; }

/* Separador2 */
{guion} { lexeme = yytext(); System.out.println("Token emitido: separador2, Texto: " + yytext()); return separador2; }

/* Parentesis abierto */
"(" {lexeme = yytext(); return parA;}

/* Numero2 */
{numero2} { lexeme = yytext(); System.out.println("Token emitido: numero2, Texto: " + yytext()); return numero2; }

/* Punto y Coma */
";" {lexeme = yytext(); return PuntoyComa;}

/* Parentesis cerrado */
")" {lexeme = yytext(); return parC;}

/* Precio Articulo */
{precio} { lexeme = yytext(); System.out.println("Token emitido: precio, Texto: " + yytext()); return precio; }

/*Final del formulario*/
{FIN_FORMULARIO} { lexeme = yytext(); return FIN_FORMULARIO; }




