package codigo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Principal {
    public static void main(String[] args) throws Exception {
        String ruta1 = "C:\\Users\\nebuR\\Documents\\NetBeansProjects\\AnalizadorLexico\\src\\codigo\\Lexer.flex";
        String ruta2 = "C:\\Users\\nebuR\\Documents\\NetBeansProjects\\AnalizadorLexico\\src\\codigo\\LexerCup.flex";
        String[] rutaS = {"-parser", "Sintax", "C:\\Users\\nebuR\\Documents\\NetBeansProjects\\AnalizadorLexico\\src\\codigo\\Sintax.cup"};
        generar(ruta1, ruta2, rutaS);
    }
 
    public static void generar(String ruta1, String ruta2, String[] rutaS) throws IOException, Exception {
        File archivo;
        
        // Generar el archivo Lexer.java a partir de Lexer.flex
        archivo = new File(ruta1);
        JFlex.Main.generate(archivo);
        
        // Generar el archivo LexerCup.java a partir de LexerCup.flex
        archivo = new File(ruta2);
        JFlex.Main.generate(archivo);
        
        // Ejecutar CUP para generar el parser
        java_cup.Main.main(rutaS);
        
        // Mover el archivo sym.java generado por CUP
        Path rutaSym = Paths.get("C:\\Users\\nebuR\\Documents\\NetBeansProjects\\AnalizadorLexico\\src\\codigo\\sym.java");
        if (Files.exists(rutaSym)) {
            Files.delete(rutaSym);
        }
        Files.move(
                Paths.get("sym.java"), 
                rutaSym
        );
        
        // Mover el archivo Sintax.java generado por CUP
        Path rutaSin = Paths.get("C:\\Users\\nebuR\\Documents\\NetBeansProjects\\AnalizadorLexico\\src\\codigo\\Sintax.java");
        if (Files.exists(rutaSin)) {
            Files.delete(rutaSin);
        }
        Files.move(
                Paths.get("Sintax.java"), 
                rutaSin
        );
    }
}
