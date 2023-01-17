package com.walcompany.files;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class FileText implements I_File {
    
    private File file;

    public FileText(File file) {
        this.file = file;
    }// no se va a usar
    
    public FileText (String fileSt){
        this.file=new File(fileSt);
    }

    @Override
    public void setText(String texto) {
        try (FileWriter out=new FileWriter(file)){
            out.write(texto);
        } catch (Exception e) {
            System.out.println(e);}
        //Try & Catch: Evita IOException
        //Closeable: abre y cierra el archivo automaticamente.
    }

    @Override
    public void appendText(String texto) {
        try (FileWriter out=new FileWriter(file,true)){
            out.write(texto);
        } catch (Exception e) {
            System.out.println(e);}
    }

    @Override
    public String getText() {
        //String texto="";
        StringBuilder sb=new StringBuilder();
        int caracter;
        try (FileReader in= new FileReader(file)){
            while ((caracter=in.read())!=-1){
                //texto+=(char)caracter;
                sb.append((char)caracter); //Sin el char devuleve numeros
            }
        } catch (Exception e) {
            System.out.println(e);}
        return sb.toString();
        //Try & Catch: Evita la FileNotfoundException
    }

    @Override
    public List<String> getAll() {
        List<String> list= new ArrayList();
        //String line;
        try (BufferedReader in= new BufferedReader(new FileReader(file))){
            //while((line=in.readLine())!=null){
            //    list.add(line);
            //}
            list=in.lines().collect(Collectors.toList());
            
        } catch (Exception e) {
            System.out.println(e);}
        return list;
        //BufferedRead, tiene el metodo readLine que permite leer lineas (String)
        // y no de a un caracter ( representado por un int),MÁS RAPIDO.
    }
    
}
