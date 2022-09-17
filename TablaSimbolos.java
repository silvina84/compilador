package lyc.compiler.main;
import java.util.*;
import java.util.Vector;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;

public class TablaSimbolos {
        Vector tabla= new Vector();
        int long;
        string lexema;

       public TablaSimbolos(){
        }

       public void guardar_TS(String tipo, String nombre){
       lexema = "_"; //Armamos el lexema agregandole el guion bajo al principio
       String nom = lexema + s.nombre;
       Simbolo s =TablaSimbolos.buscar(nom); // buscamos si ya existe en la tabla
       if(s == null){                //si no existe lo agregamos
       s= new Simbolo(nombre,tipo);
       tabla.addElement(s);
       }

       //Si el lexema es una constante, entonces tambien seteo el  campo "valor" en la ts.
        Simbolo e=null;
       for(int i=0; i<tabla.size(); i++){
           e=(Simbolo)elementAt(i);
              if(e.getNombre().equals(nombre))
              {
                if(tipo.equals("cte_entera")| tipo.equals("cte_real")| tipo.equals("cte_string")){
                   e.setValor(nombre);
                   tabla.set(i,e);
                   break;
                }
              }
       }

       //Si se trata de una constante string, entonces contar las cantidad de caracteres y set en ts.
        Simbolo e=null;
              for(int i=0; i<tabla.size(); i++){
                  e=(Simbolo)elementAt(i);
                     if(e.getNombre().equals(nombre))
                     {
                       if(tipo.equals("cte_string")){
                         e.setLongitud(nombre.length());
                       }
                     }
              }
        }




public Simbolo buscar(String nombre, String tipo){
 Simbolo e=null;
int i=0;
 while(i<tabla.size()){
 e=(Simbolo) tabla.elementAt(i);
   if(e.getNombre().equals(nombre)) break;

  e=null;
  i++;
  }
 return e;
}


}

public int escribir_ts(){

try {
            String ruta = "archivo_tabla_de_simbolos.txt";
            File file = new File(ruta);
            // Si el archivo no existe es creado
            if (!file.exists()) {
                file.createNewFile();
            }
            FileWriter fw = new FileWriter(file);
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write("Nombre "+ "\t  "+ "Tipo "+ "\t  "+ "valor " + " \t   "+ "Longitud "+ "\n");
             for(int i=0; i<tabla.size(); i++){
                  bw.write(tabla.elementAt(i) + "\t");
             }
            bw.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
}
