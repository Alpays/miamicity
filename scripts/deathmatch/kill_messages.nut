/*

File: kill_messages.nut

Description: Custom kill messages.

*/

function getKillMessage(weapon)
{
    switch(getWeaponType(weapon))
    {
        case "Fist":       return "fisted";
        case "Sniper":     return "sniped";
        default:           return "killed";
    }
}

function onPlayerKill(killer, player, reason, bodypart) {
    Message(COLOR_BLUE + killer.Name + COLOR_WHITE + " " + getKillMessage(reason) + " " + COLOR_BLUE + player.Name + COLOR_WHITE + " (" + GetWeaponName(reason) + ") (" + getBodypartName(bodypart) + ")" );

    switch(reason) {

    }
    Announce("~t~Wasted!", player, 5);
}

function onPlayerDeath(player, reason) 
{
    Announce("~t~Wasted!", player, 5);
}