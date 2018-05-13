using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Usuario_Jugador
/// </summary>
public class Usuario_Jugador
{
    public Usuario_Jugador(int idUsuario, string nameUsuario, char role, int idJugador, string nameJugador)
    {
        IDusuario = idUsuario;
        NameUsuario = nameUsuario;
        Role = role;
        IDJugador = idJugador;
        NameJugador = nameJugador;
    }

    public Usuario_Jugador(int idUsuario, string nameUsuario, char role)
    {
        IDusuario = idUsuario;
        NameUsuario = nameUsuario;
        Role = role;
    }

    public int IDusuario
    {
        get;
    }

    public int IDJugador
    {
        get;
    }

    public string NameUsuario
    {
        get;
    }

    public string NameJugador
    {
        get;
    }

    public char Role
    {
        get;
    }
}