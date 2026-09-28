using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Cartas
/// </summary>
[Serializable]
public class CartasDTO
{
    int idCarta;
    String name;
    String imagePath;
    

    public CartasDTO(int idCarta, String nombre, String imagePath, int weight)
    {
        this.idCarta = idCarta;
        this.name = nombre;
        this.imagePath = imagePath;
        this.Weight = weight;
    }

    public CartasDTO(int idCarta, String nombre, String imagePath, String statement, int weight)
        : this(idCarta, nombre, imagePath, weight)
    {
        Statement = statement;
    }

    public int ID
    {
        get
        { return idCarta; }
    }

    public String Name
    {
        get { return name; }
    }

    public String Path
    {
        get { return imagePath; }
    }

    public bool GuessedCorrectly
    {
        get;
        set;
    }
    public bool UsedSound
    {
        get;
        set;
    }
    public bool UsedImage
    {
        get;
        set;
    }

    public int Weight
    {
        get; private set;
    }

    public string Statement
    {
        get; set;
    }

    public Dictionary<string, int> Frases
    {
        get;set;
    }

}