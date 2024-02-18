/*

File: ban_commands.nut

Description: /ban, /tempban, /unban, /unbanip commands (Requires Admin level 2 by default.)

*/

function onPlayerCommand(player, cmd, args)
{
    local adminlevel = playerData[player.ID].adminLevel;
    switch(cmd.tolower()) 
    {
        case "ban":
            if(adminlevel >= 2) {
                if(args && NumTok(args, " " >= 2)) 
                {
                    local target = FindPlayer(GetTok(args, " ", 1));
                    local reason = GetTok(args, " ", 2 NumTok(args, " "));
                    if(target) {
                        bans.Ban(target.Name, player.Name, reason);
                    }
                    else MessagePlayer(COLOR_RED + "Player not found!", player);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /ban <player> <reason>", player);
            }
            break;
        case "tempban":
            if(adminlevel >= 2) {
                if(args && NumTok(args, " " ) >= 3)
                {
                    local target = FindPlayer(GetTok(args, " ", 1));
                    if(target)
                    {
                        local reason = GetTok(args, " ", 3 NumTok(args, " "))
                        if(!bans.TempBan(target.Name, player.Name, GetTok(args, " ", 2), reason))
                        {
                            MessagePlayer(COLOR_RED + "Invalid duration provided.", player);
                        }
                    }
                    else MessagePlayer(COLOR_RED + "Player not found!", player);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /tempban <player> <duration> <reason>", player);                     
            }
            break;
        case "unban":
            if(adminlevel >= 2) {
                if(args && NumTok(args, " ") > 0)
                {
                    local bannedplr = GetTok(args, " ", 1);
                    if(bans.IsBanned(bannedplr))
                    {
                        bans.Unban(bannedplr);
                        MessagePlayer(COLOR_BLUE + "Player " + COLOR_WHITE + bannedplr + COLOR_BLUE + " should now be unbanned.", player);
                    }
                    else MessagePlayer(COLOR_RED + "Player " + COLOR_WHITE + bannedplr + COLOR_RED + " is not banned!", player);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /unban <player name>", player);                
            }
            break;
        case "unbanip":
            if(adminlevel >= 2) {
                if(args && NumTok(args, " ") > 0)
                {
                    local ip = GetTok(args, " ", 1);
                    if(bans.IsBannedIP(ip))
                    {
                        bans.UnbanIP(ip);
                        MessagePlayer(COLOR_BLUE + "Ip Adress " + COLOR_WHITE + ip + COLOR_BLUE + " should now be unbanned.", player);
                    }
                    else MessagePlayer(COLOR_RED + "Ip Adress " + COLOR_WHITE + ip + COLOR_RED + " is not banned!", player);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /unbanip <ip adress>", player);
            }
    }
}