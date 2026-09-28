public static class SessionAuthorization
{
    public static bool IsAuthenticated(object userId, char role)
    {
        return userId is int && (int)userId > 0 && (role == 'A' || role == 'J');
    }

    public static bool IsAdmin(object userId, char role)
    {
        return IsAuthenticated(userId, role) && role == 'A';
    }

    public static bool IsPlayer(object userId, object playerId, char role)
    {
        return IsAuthenticated(userId, role) && role == 'J' &&
            playerId is int && (int)playerId > 0;
    }
}
