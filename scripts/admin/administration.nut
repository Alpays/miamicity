function onPlayerCommand(player, cmd, text)
{
    local adminlevel = playerData[player.ID].adminLevel;
    switch(cmd.tolower())
    {
        case "togglecrouch":
        {
            if(adminlevel >= 2)
            {
                if(GetCrouchEnabled())
                {
                    SetCrouchEnabled(false);
                    Message(COLOR_BLUE + "Admin: " + COLOR_WHITE + player.Name + COLOR_BLUE + " disabled crouching!");
                }
                else
                {
                    SetCrouchEnabled(true);
                    Message(COLOR_BLUE + "Admin: " + COLOR_WHITE + player.Name + COLOR_BLUE + " enabled crouching!");
                }
            }
            break;
        }
    }
}