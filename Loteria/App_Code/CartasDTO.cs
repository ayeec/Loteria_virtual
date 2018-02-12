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
    String statement;

    public CartasDTO(int idCarta, String nombre, String imagePath, String statement, int weight)
    {
        this.idCarta = idCarta;
        this.name = nombre;
        this.imagePath = imagePath;
        this.statement = statement;
        this.Weight = weight;
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

    public String Statement
    {
        get { return statement; }
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
        get;
    }

}