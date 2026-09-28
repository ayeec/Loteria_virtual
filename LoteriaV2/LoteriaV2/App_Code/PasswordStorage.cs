using System;
using Microsoft.AspNet.Identity;

public static class PasswordStorage
{
    private const string HashPrefix = "aspnet-identity-v2:";
    private static readonly PasswordHasher Hasher = new PasswordHasher();

    public static string HashPassword(string password)
    {
        if (String.IsNullOrEmpty(password))
        {
            throw new ArgumentException("A password is required.", "password");
        }

        return HashPrefix + Hasher.HashPassword(password);
    }

    public static bool VerifyPassword(string storedPassword, string suppliedPassword, out bool needsUpgrade)
    {
        needsUpgrade = false;

        if (String.IsNullOrEmpty(storedPassword) || suppliedPassword == null)
        {
            return false;
        }

        if (storedPassword.StartsWith(HashPrefix, StringComparison.Ordinal))
        {
            try
            {
                PasswordVerificationResult result = Hasher.VerifyHashedPassword(
                    storedPassword.Substring(HashPrefix.Length), suppliedPassword);
                return result != PasswordVerificationResult.Failed;
            }
            catch (FormatException)
            {
                return false;
            }
            catch (ArgumentException)
            {
                return false;
            }
        }

        needsUpgrade = String.Equals(storedPassword, suppliedPassword, StringComparison.Ordinal);
        return needsUpgrade;
    }
}
