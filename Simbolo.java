package lyc.compiler.main;

public class Simbolo {
    String nombre;
    String tipo;
    String valor;
    int longitud;

     public Simbolo(){
     }

    public Simbolo(String nombre, String tipo,String valor,int longitud) {
        this.nombre = nombre;
        this.tipo = tipo;
        this.valor = valor;
        this.longitud = longitud;
    }

    public void setNombre(string nombre){
         this.nombre=nombre;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public void setLongitud(int longitud) {
        this.longitud = longitud;
    }

    public String getNombre() {
        return nombre;
    }

    public String getTipo() {
        return tipo;
    }

    public String getValor() {
        return valor;
    }

    public int getLongitud() {
        return longitud;
    }
}
