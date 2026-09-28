using System;

internal static class ValidationTests
{
    private static int assertions;

    private static void Assert(bool condition, string message)
    {
        assertions++;
        if (!condition)
        {
            throw new InvalidOperationException(message);
        }
    }

    private static void Main()
    {
        int size;
        bool hard;
        Assert(GameInputValidator.TryGetBoardSettings("2", "false", out size, out hard) &&
            size == 2 && !hard, "The minimum board size should be accepted.");
        Assert(GameInputValidator.TryGetBoardSettings("5", "true", out size, out hard) &&
            size == 5 && hard, "The maximum board size should be accepted.");
        Assert(!GameInputValidator.TryGetBoardSettings("1", "false", out size, out hard),
            "A board smaller than the minimum should be rejected.");
        Assert(!GameInputValidator.TryGetBoardSettings("6", "true", out size, out hard),
            "A board larger than the maximum should be rejected.");
        Assert(!GameInputValidator.TryGetBoardSettings("2", "sometimes", out size, out hard),
            "An invalid difficulty value should be rejected.");
        Assert(GameInputValidator.IsValidFixedBoardSettings("3", "false"),
            "The fixed board's maximum size should be accepted.");
        Assert(!GameInputValidator.IsValidFixedBoardSettings("4", "false"),
            "The fixed board should reject sizes above its nine-card limit.");

        Assert(GameInputValidator.IsValidGameResult(2, 1, 1, 2, 200),
            "A valid completed game should be accepted.");
        Assert(!GameInputValidator.IsValidGameResult(2, 2, 1, 2, 0),
            "Scores above cards played should be rejected.");
        Assert(!GameInputValidator.IsValidGameResult(2, 1, 0, 2, 0),
            "Inconsistent correct and incorrect totals should be rejected.");
        Assert(!GameInputValidator.IsValidGameResult(2, 1, 1, 3, 0),
            "More played cards than the board contains should be rejected.");
        Assert(!GameInputValidator.IsValidGameResult(2, 1, 1, 2, -1),
            "Negative sound counts should be rejected.");
        Assert(!GameInputValidator.IsValidGameResult(2, 1, 1, 2, 201),
            "Excessive sound counts should be rejected.");

        int correct;
        int total;
        Assert(GameInputValidator.TryGetRewardScore("4", "4", out correct, out total) &&
            correct == 4 && total == 4, "A valid reward score should be accepted.");
        Assert(GameInputValidator.TryGetRewardScore("0", "25", out correct, out total),
            "A valid zero score on a supported board should be accepted.");
        Assert(!GameInputValidator.TryGetRewardScore("5", "4", out correct, out total),
            "Correct answers above the board size should be rejected.");
        Assert(!GameInputValidator.TryGetRewardScore("1", "0", out correct, out total),
            "A zero question total should be rejected.");
        Assert(!GameInputValidator.TryGetRewardScore("not-a-number", "4", out correct, out total),
            "Non-numeric reward inputs should be rejected.");

        Assert(SessionAuthorization.IsAdmin(1, 'A'), "An administrator should pass the admin gate.");
        Assert(!SessionAuthorization.IsAdmin(1, 'J'), "A player should not pass the admin gate.");
        Assert(!SessionAuthorization.IsAdmin(0, 'A'), "A zero user ID should not be authenticated.");
        Assert(!SessionAuthorization.IsAuthenticated("1", 'A'),
            "A string session ID should not be authenticated.");
        Assert(SessionAuthorization.IsPlayer(1, 2, 'J'), "A player should pass the player gate.");
        Assert(!SessionAuthorization.IsPlayer(1, 2, 'A'),
            "An administrator should not pass the player gate.");
        Assert(!SessionAuthorization.IsPlayer(1, 0, 'J'),
            "A player without a positive player ID should be rejected.");
        Assert(!SessionAuthorization.IsPlayer(null, 2, 'J'),
            "A player session without a user ID should be rejected.");

        Assert(IdentityErrorLocalizer.Translate("Passwords must be at least 6 characters.") ==
            "La contraseña debe tener al menos 6 caracteres.",
            "Password policy errors should be displayed in Spanish.");
        Assert(IdentityErrorLocalizer.Translate("Name test is already taken.") ==
            "Ese nombre de usuario ya está en uso.",
            "Duplicate account errors should be displayed in Spanish.");
        Assert(IdentityErrorLocalizer.Translate("Incorrect password.") ==
            "La contraseña actual es incorrecta.",
            "Current-password errors should be displayed in Spanish.");
        Assert(IdentityErrorLocalizer.Translate("Unexpected framework error").Contains("No se pudo"),
            "Unexpected identity errors should use the Spanish fallback.");

        Console.WriteLine("Passed {0} validation and authorization assertions.", assertions);
    }
}
