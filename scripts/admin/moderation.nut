/*

File: moderation.nut

Description: Basic commands to moderate the server.

*/

function onPlayerCommand(player, cmd, text)
{
    local adminlevel = playerData[player.ID].adminLevel;
    if(adminlevel >= 1)
    {
        switch(cmd.tolower())
        {
            case "weather":
            case "setweather": 
            {
                if(text && IsNum(text))
                {
                    local weather = text.tointeger();
                    if(weather >= 0 && weather <= 6) // IDs above 6 are corrupt weathers
                    {
                        SetWeather(weather);
                        Message(COLOR_BLUE + "Admin " + COLOR_WHITE + player.Name + COLOR_BLUE + " has set weather to [" + COLOR_WHITE + weather + COLOR_BLUE + "]");
                    }
                    else MessagePlayer(COLOR_RED + "Invalid weather id.", player);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /setweather <weather id>", player);
                break;
            }
            case "time":
            case "settime":
            {
                if(text && IsNum(GetTok(text, " ", 1)))
                {
                    local hour = GetTok(text, " ", 1).tointeger();
                    if(NumTok(text, " ") != 2) 
                    {
                        SetHour(hour);
                        SetMinute(0);
                        Message(COLOR_BLUE + "Admin " + COLOR_WHITE + player.Name + COLOR_BLUE + " set time to " + COLOR_WHITE + hour + ":00");
                    }
                    else if(IsNum(GetTok(text, " ", 2))) {
                        local minute = GetTok(text, " ", 2).tointeger();
                        SetHour(hour);
                        SetMinute(minute);
                        Message(COLOR_BLUE + "Admin " + COLOR_WHITE + player.Name + COLOR_BLUE + " set time to " + COLOR_WHITE + hour + ":" + minute);
                    }
                    else MessagePlayer(COLOR_RED + "Correct usage: /settime <hour> [<minute>]", player);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /settime <hour> [<minute>]", player);
                break;
            }

            case "kick":
            {
                if(text && NumTok(text, " ") >= 2) 
                {
                    local targetplr = FindPlayer(GetTok(text, " ", 1));
                    local reason = GetTok(text, " ", 2 NumTok(text, " "));
                    if(targetplr)
                    {
                        Message(COLOR_BLUE + "Admin " + COLOR_WHITE + player.Name + COLOR_BLUE + " kicked " + COLOR_WHITE + targetplr.Name + COLOR_BLUE + " reason: " + COLOR_WHITE + reason);
                        targetplr.Kick(player.Name);
                    } else MessagePlayer(COLOR_RED + "Player not found!", player)
                } else MessagePlayer(COLOR_RED + "Correct usage: /kick <player> <reason>", player)
                break;
            }

        }
    }
}