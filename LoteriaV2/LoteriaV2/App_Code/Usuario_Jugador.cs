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
        get; private set;
    }

    public int IDJugador
    {
        get; private set;
    }

    public string NameUsuario
    {
        get; private set;
    }

    public string NameJugador
    {
        get; private set;
    }

    public char Role
    {
        get; private set;
    }
}