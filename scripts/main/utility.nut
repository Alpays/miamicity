/*

File: utility.nut

Description: File to add extra functions that vc-mp squirrel servers don't have by default.

*/

COLOR_RED       <- "[#FF3333]";
COLOR_BLACK     <- "[#000000]";
COLOR_YELLOW    <- "[#FFFF00]";
COLOR_GREEN     <- "[#00FF00]";
COLOR_BLUE      <- "[#00FFFF]";
COLOR_ORANGE    <- "[#FF8000]";
COLOR_PINK      <- "[#FF99FF]";
COLOR_PURPLE    <- "[#CC00CC]";
COLOR_WHITE     <- "[#FFFFFF]";
COLOR_GRAY      <- "[#C0C0C0]";

function getWeaponType(weapon)
{
    switch(weapon)
    {
        case 0:
            return "Fist";
        case 1: case 2: case 3: 
        case 4: case 5: case 6: case 7:
        case 8: case 9: case 10: case 11:
            return "Melee";
        case 12: case 13: case 14: case 15:
            return "Grenade";
        case 17: case 18:
            return "Pistol";
        case 19: case 20: case 21:
            return "Shotgun";
        case 22: case 23: case 24: case 25:
            return "Submachine";
        case 26: case 27: 
            return "Rifle";
        case 28: case 29: 
            return "Sniper";
        case 30: case 31: case 32: case 33:
            return "Heavy";
        default:
            return "Unknown";
    }
}

function getBodypartName(bodypart)
{
    switch(bodypart)
    {
        case 0: return "Body";
        case 1: return "Torso";
        case 2: return "Left Arm";
        case 3: return "Right Arm";
        case 4: return "Left Leg";
        case 5: return "Right Leg";
        case 6: return "Head";
        default: return "Unknown";
    }
}

function getPartReason(reason) {
    switch(reason){
    case 0:
        return "Timeout";
    case 1:
        return "Disconnect";
    case 2:
        return "Kicked";
    case 3:
        return "Crashed";
    }
}

function CPlayer::IncCash(amount)
{
    if(Cash <= 99999999)
        Cash+=amount;
}

function CPlayer::DecCash(amount)
{
    if(Cash - amount < 0) Cash = 0;
    else Cash = Cash - amount;
}

function NumTok(string, separator) 
{ 
    local tokenized = split(string, separator); return tokenized.len(); 
}

function GetTok(string, separator, n, ...)
{
    if(string != null) {
        local m = vargv.len() > 0 ? vargv[0] : n,
        tokenized = split(string, separator),
        text = "";
        if (n > tokenized.len() || n < 1) return null;
        for (; n <= m; n++)
        {
            text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
        }
        return text;
    }
}

function random(min, max) {
    if ( min < max )
        return rand() % (max - min + 1) + min.tointeger();
    else if ( min > max )
        return rand() % (min - max + 1) + max.tointeger();
    else if ( min == max )
        return min.tointeger();
}

function SetPlayerWorld(playerID, world)
{
    local player = FindPlayer(playerID);
    if(player) 
    {
        player.World = world;
    }
}

function healPlayer(playerid)
{
    local player = FindPlayer(playerid);
    if(player)
    {
        local x = player.Pos.x, y = player.Pos.y
        if(x == playerData[player.ID].healPos.x && y == playerData[player.ID].healPos.y) 
        {
            player.Health = 100;
            player.DecCash(250);
            MessagePlayer(COLOR_GREEN + "Successfully healed for " + COLOR_WHITE + "$250!", player);
        }
        else MessagePlayer(COLOR_RED + "You have to stand still to heal!", player);
    }
    playerData[player.ID].healTimer = null;
}