using System;
using System.Text.RegularExpressions;

public static class IdentityErrorLocalizer
{
    public static string Translate(string error)
    {
        if (String.IsNullOrWhiteSpace(error))
        {
            return "No se pudo completar la operación. Inténtalo de nuevo.";
        }

        Match match = Regex.Match(error, @"Passwords must be at least (\d+) characters\.");
        if (match.Success)
        {
            return "La contraseña debe tener al menos " + match.Groups[1].Value + " caracteres.";
        }

        if (error.StartsWith("Passwords must have at least one non letter or digit character.", StringComparison.Ordinal))
        {
            return "La contraseña debe incluir al menos un carácter que no sea una letra ni un número.";
        }

        if (error.StartsWith("Passwords must have at least one digit", StringComparison.Ordinal))
        {
            return "La contraseña debe incluir al menos un número.";
        }

        if (error.StartsWith("Passwords must have at least one lowercase", StringComparison.Ordinal))
        {
            return "La contraseña debe incluir al menos una letra minúscula.";
        }

        if (error.StartsWith("Passwords must have at least one uppercase", StringComparison.Ordinal))
        {
            return "La contraseña debe incluir al menos una letra mayúscula.";
        }

        if (error.StartsWith("Name ", StringComparison.Ordinal) &&
            error.EndsWith(" is already taken.", StringComparison.Ordinal))
        {
            return "Ese nombre de usuario ya está en uso.";
        }

        if (error.StartsWith("User name ", StringComparison.Ordinal) &&
            error.EndsWith(" is invalid, can only contain letters or digits.", StringComparison.Ordinal))
        {
            return "El nombre de usuario solo puede contener letras y números.";
        }

        if (String.Equals(error, "Incorrect password.", StringComparison.Ordinal))
        {
            return "La contraseña actual es incorrecta.";
        }

        return "No se pudo completar la operación. Verifica los datos e inténtalo de nuevo.";
    }
}
