/*

File: guide.nut

Description: Adds a rule and command list to help the players.

*/

cmdlist <- "/rules /register /login /changepass /autologin /stats /heal /wep /spawnwep /buywep (Ammu-Nation only) /buycar1 /buycar2 /getcar1 /getcar2 /sellcar1 /sellcar2 /buyprop /shareprop /exitprop /me /diepos ";
modCmdList <- "/setweather /settime /kick ";
adminCmdList <- "/ban /tempban /unban /unbanip /togglecrouch "
managerCmdList <- "/addvehicle /addprop";

ruleList <- "Advertising, death evading, stats padding, ban evading, using vpn, game modifications/hacks, spawn killing and exploiting script bugs.";

function onPlayerCommand(player, cmd, text)
{
    switch(cmd.tolower())
    {
        case "cmds":
        case "commands":
        case "cmd":
        {
            switch(playerData[player.ID].adminLevel) // 1 = Moderator, 2 = Admin, 3 = Manager
            {
                case 0:
                    MessagePlayer(COLOR_BLUE + "List of player commands: " + COLOR_WHITE + cmdlist, player);
                    break;
                case 1:
                    MessagePlayer(COLOR_BLUE + "List of player and moderator commands: " + COLOR_WHITE + cmdlist + modCmdList, player);
                    break;
                case 2:
                    MessagePlayer(COLOR_BLUE + "List of player and admin commands: " + COLOR_WHITE + cmdlist + modCmdList + adminCmdList, player);
                    break;
                case 3:
                    MessagePlayer(COLOR_BLUE + "List of commands: " + COLOR_WHITE + cmdlist + modCmdList + adminCmdList + managerCmdList, player);
                    break;
            }
            break;
        }
        case "rules":
        {
            MessagePlayer(COLOR_BLUE + "Following is not allowed: " + COLOR_WHITE + ruleList, player);
            break;
        }
    }
}