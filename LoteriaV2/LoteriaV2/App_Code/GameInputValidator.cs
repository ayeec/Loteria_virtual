using System;

public static class GameInputValidator
{
    public static bool TryGetBoardSettings(
        string sizeValue, string hardValue, out int size, out bool isHard)
    {
        isHard = false;
        return Int32.TryParse(sizeValue, out size) &&
            size >= 2 && size <= 5 &&
            Boolean.TryParse(hardValue, out isHard);
    }

    public static bool IsValidFixedBoardSettings(string sizeValue, string hardValue)
    {
        int size;
        bool isHard;
        return TryGetBoardSettings(sizeValue, hardValue, out size, out isHard) && size <= 3;
    }

    public static bool IsValidGameResult(
        int boardSize, int correct, int incorrect, int played, int totalSound)
    {
        if (boardSize < 2 || boardSize > 5)
        {
            return false;
        }

        int boardTotal = boardSize * boardSize;
        return played >= 2 && played <= boardTotal &&
            correct >= 0 && incorrect >= 0 &&
            correct <= played && incorrect <= played &&
            correct + incorrect == played &&
            totalSound >= 0 && totalSound <= played * 100;
    }

    public static bool TryGetRewardScore(
        string correctValue, string totalValue, out int correct, out int total)
    {
        correct = 0;
        total = 0;
        if (!Int32.TryParse(correctValue, out correct) ||
            !Int32.TryParse(totalValue, out total))
        {
            return false;
        }

        bool allowedBoardTotal = total == 4 || total == 9 || total == 16 || total == 25;
        return allowedBoardTotal && correct >= 0 && correct <= total;
    }
}
