## A continuación se presentará la tarea de Analizador Sintáctico

**Se realizaron los siguientes ejercicios:**
-  Ejercicio Tienda 7-09-2024

- Ejercicio Analizador Lexico GPS

- Ejercicio en CLase Analizador Lexico

---------------------
# 1. EJERCICIO TIENDA 7-09-2024

### Para los tokens del archivo FrmPrincipal.java:

	switch (token) {
            case NombreP:
                fila[0] = "Nombre Cliente";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case codigoP:
                fila[0] = "Codigo Postal";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case articulo:
                fila[0] = "Nombre Articulo";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case separador2:
                fila[0] = "Separador";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case parA:
                fila[0] = "Paréntesis Abierto";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case numero2:
                fila[0] = "Numero";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case PuntoyComa:
                fila[0] = "Punto y Coma";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case parC:
                fila[0] = "Paréntesis Cerrado";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case precio:
                fila[0] = "Precio";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case FIN_FORMULARIO:
                fila[0] = "Fin del Formulario";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case Error:
                fila[0] = "Error";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            default:
                fila[0] = "Desconocido";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
        }

		
		
----------------------
### Para el archivo de Lexer.Flex se colocó:
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

-------------

### Para el archivo de LexerCup.Flex se colocó:
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
---

### Para el archivo de Sintax.cup se colocó:

	// Terminales
	terminal NombreP, CodigoP, articulo, separador2, parA, numero2, PuntoyComa, parC, precio, Error, FIN_FORMULARIO;

	// No terminales
	non terminal FORMULARIO, LISTA_ARTICULOS, ARTICULO;


	start with FORMULARIO;


	// Reglas de gramática
	FORMULARIO ::= NombreP CodigoP LISTA_ARTICULOS FIN_FORMULARIO
					 {: System.out.println("Producción FORMULARIO alcanzada con NombreP y CodigoP."); :}
				  | Error;


	LISTA_ARTICULOS ::= ARTICULO LISTA_ARTICULOS
						{: System.out.println("Producción LISTA_ARTICULOS alcanzada con múltiples ARTICULOS."); :}
					  | ARTICULO;


	ARTICULO ::= articulo separador2 parA numero2 PuntoyComa numero2 parC separador2 numero2 separador2 precio
				 {: System.out.println("Producción ARTICULO alcanzada."); :};
			 
---

### Y por último, para los tokens en Tokens.java, se colocó:
	public enum Tokens {
	NombreP,
    codigoP,
    articulo,
    separador2,
    parA,
    numero2,
    PuntoyComa,
    parC,
    precio,
    FIN_FORMULARIO,
	Error
	}

# 2. Ejercicio Analizador Lexico GPS

### Para los tokens del archivo FrmPrincipal.java:

        switch (token) {
            case TRACKPOINT:
                fila[0] = "Inicio Trackpoint";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case latitud:
                fila[0] = "Latitud";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case igual:
                fila[0] = "Igual";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;    
            case numero:
                fila[0] = "Número";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case menorQue:
                fila[0] = "Abrir Ciclo";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break; 
            case mayorQue:
                fila[0] = "Cerrar Ciclo";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case longitud:
                fila[0] = "Longitud";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case tiempo:
                fila[0] = "Tiempo";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case fecha:
                fila[0] = "Fecha";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;

            case hora:
                fila[0] = "Hora";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case speed:
                fila[0] = "Velocidad";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case END_TRACKPOINT:
                fila[0] = "Fin Trackpoint";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
        }

----
### Para el archivo de Lexer.Flex se colocó:
	TRACKPOINT = "TRACKPOINT"
	latitud = "lat"
	igual = "="
	numero = [+-]?[0-9]+\.[0-9]+  
	longitud = "lon"
	tiempo = "time"
	fecha = [0-9]{4}-[0-9]{2}-[0-9]{2}T
	hora = [0-9]{2}:[0-9]{2}:[0-9]{2}Z
	speed = "speed"
	END_TRACKPOINT = "END_TRACKPOINT"
	
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
	 
	 {TRACKPOINT} {lexeme = yytext(); return TRACKPOINT;}

	/*Latitud*/
	{latitud} {lexeme = yytext(); return latitud; }

	/*Signo Igual*/
	{igual} {lexeme = yytext(); return igual;} 

	"<" {lexeme = yytext(); return menorQue;}

	">" {lexeme = yytext(); return mayorQue;}

	/*Numero*/
	{numero} {lexeme = yytext(); return numero;} 

	/*Longitud*/
	{longitud} {lexeme = yytext(); return longitud; }

	/*Tiempo*/
	{tiempo} {lexeme = yytext(); return tiempo; }

	/*Fecha*/
	{fecha} {lexeme = yytext(); return fecha; }

	/*Hora*/
	{hora} {lexeme = yytext(); return hora; }

	/*Speed*/
	{speed} {lexeme = yytext(); return speed; }

	/*Fin de GPS*/
	{END_TRACKPOINT} {lexeme = yytext(); return END_TRACKPOINT; }

---
### Para el archivo de LexerCup.Flex se colocó:
	TRACKPOINT = "TRACKPOINT"
	latitud = "lat"
	igual = "="
	numero = [+-]?[0-9]+\.[0-9]+  
	longitud = "lon"
	tiempo = "time"
	fecha = [0-9]{4}-[0-9]{2}-[0-9]{2}T
	hora = [0-9]{2}:[0-9]{2}:[0-9]{2}Z
	speed = "speed"
	END_TRACKPOINT = "END_TRACKPOINT"
	
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
	
	/*Inicio de GPS*/
	{TRACKPOINT} {return new Symbol(sym.TRACKPOINT, yychar, yyline, yytext());}

	/*Latitud*/
	{latitud} {return new Symbol(sym.latitud, yychar, yyline, yytext());}

	/*Signo Igual*/
	{igual} {return new Symbol(sym.igual, yychar, yyline, yytext());}

	"<" { return new Symbol(sym.menorQue, yychar, yyline, yytext()); }

	">" { return new Symbol(sym.mayorQue, yychar, yyline, yytext()); }

	/*Numero*/
	{numero} {return new Symbol(sym.numero, yychar, yyline, yytext());}

	/*Longitud*/
	{longitud} {return new Symbol(sym.longitud, yychar, yyline, yytext());}

	/*Tiempo*/
	{tiempo} {return new Symbol(sym.tiempo, yychar, yyline, yytext());}

	/*Fecha*/
	{fecha} {return new Symbol(sym.fecha, yychar, yyline, yytext());}

	/*Hora*/
	{hora} {return new Symbol(sym.hora, yychar, yyline, yytext());}

	/*Speed*/
	{speed} { return new Symbol(sym.speed, yychar, yyline, yytext()); }

	/*Fin de GPS*/
	{END_TRACKPOINT} {return new Symbol(sym.END_TRACKPOINT, yychar, yyline, yytext());}

---
### Para el archivo de Sintax.cup se colocó:
    // Terminales
    terminal TRACKPOINT, latitud, igual, numero, longitud, tiempo, fecha, hora, speed, END_TRACKPOINT, menorQue, mayorQue, Error;

    // No terminales
    non terminal START, GRUPO_TRACKPOINTS, GRUPO_TRACKPOINT, LATITUDE_LIST, LONGITUDE_LIST, LATITUDE, LONGITUDE, TIME, SPEED;


    start with START;

    // Reglas de producción 
    START ::= GRUPO_TRACKPOINTS;

    GRUPO_TRACKPOINTS ::= GRUPO_TRACKPOINTS GRUPO_TRACKPOINT
                    | GRUPO_TRACKPOINT;

    GRUPO_TRACKPOINT ::= 
    TRACKPOINT LATITUDE_LIST LONGITUDE_LIST TIME SPEED END_TRACKPOINT;

    // Para repetir latitud y longitud
    LATITUDE_LIST ::= LATITUDE_LIST LATITUDE
               | /* vacío */ ;

    LONGITUDE_LIST ::= LONGITUDE_LIST LONGITUDE
                | /* vacío */ ;

    // Reglas individuales
    LATITUDE ::= 
    latitud igual numero;

    LONGITUDE ::= 
    longitud igual numero;

    TIME ::= 
    	menorQue tiempo fecha hora mayorQue;

    SPEED ::= 
    	menorQue speed numero mayorQue;
---
### Y por último, para los tokens en Tokens.java, se colocó:
	public enum Tokens {
	TRACKPOINT,
    latitud,
    igual,
    mayorQue,
    menorQue,
    numero,
    longitud,
    tiempo,
    fecha,
    hora,
    speed,
    END_TRACKPOINT
	}
	
---

# 3. Ejercicio en CLase Analizador Lexico

### Para los tokens del archivo FrmPrincipal.java:
	switch (token) {
            case dias:
                fila[0] = "Dias de la Semana";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case evento:
                fila[0] = "Evento";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            case descanso:
                fila[0] = "Descanso";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;    

            case Error:
                fila[0] = "Error";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
            default:
                fila[0] = "Desconocido";
                fila[1] = lexer.lexeme;
                modelo.addRow(fila);
                break;
        }
----
### Para el archivo de Lexer.Flex se colocó:
	dias = ( "Lunes" | "Martes" | "Miércoles" | "Jueves" | "Viernes" | "Sábado" | "Domingo" )

	evento = [0-9]+

	descanso = Break


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
	 
	 /*Dias de la semana*/
	{dias} {lexeme = yytext(); return dias; }

	/*Eventos*/
	{evento} {lexeme = yytext(); return evento; }

	/*Descansos*/
	{descanso} {lexeme = yytext(); return descanso; }


	[^] {
    System.out.println("Carácter inválido encontrado: " + yytext());
    lexeme = yytext(); 
    return Error; 
	}
---
### Para el archivo de LexerCup.Flex se colocó:

	dias = ( "Lunes" | "Martes" | "Miércoles" | "Jueves" | "Viernes" | "Sábado" | "Domingo" )

	evento = [0-9]+

	descanso = Break


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
	
	/*Dias de la semana*/
	{dias} {return new Symbol(sym.dias, yychar, yyline, yytext()); }

	/*Eventos*/
	{evento} {return new Symbol(sym.evento, yychar, yyline, yytext()); }

	/*Descansos*/
	{descanso} {return new Symbol(sym.descanso, yychar, yyline, yytext()); }

	/* Error de analisis */
	 . {return new Symbol(sym.Error, yychar,yyline,yytext());}
	 
---
### Para el archivo de Sintax.cup se colocó:
	/* Terminales */
	terminal dias, evento, descanso, Error;

	/* No terminales */
	non terminal Programa, ListaDias, Dia, ListaEventos;


	start with Programa;

	/* Reglas de producción */

	/* 'Programa' consiste en una lista de días.*/

	Programa ::= ListaDias ;


	  /* 'ListaDias' representa uno o más días, permitiendo hacer una lista de días.*/

	ListaDias ::= Dia
				| Dia ListaDias ;


	  /* 'Dia' representa un día específico seguido de una lista de eventos o descansos.*/

	Dia ::= dias ListaEventos ;


	  /* 'ListaEventos' representa una secuencia de eventos o descansos.*/

	ListaEventos ::= evento ListaEventos
				   | descanso ListaEventos
				   | /* vacío */ ;
				   
---
### Y por último, para los tokens en Tokens.java, se colocó:
	public enum Tokens {
	 dias,
    evento,
    descanso,
    Error,
	}
