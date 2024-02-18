/*

File: accounts_hook.nut

Description: Hooking VC-MP events for account script

*/

function onScriptLoad()
{
    accounts.onScriptLoad();
}

function onPlayerCommand(player, cmd, args) {
    switch(cmd.tolower()) {
        case "register":
            if(!playerData[player.ID].registered) {
                if(NumTok(args, " ") == 1) {
                    accounts.Register(player, args);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /register <password>", player);
            }
            else MessagePlayer(COLOR_RED + "This nickname is already registered!", player);
            break;
        case "login":
            if(playerData[player.ID].registered) {
                if(args) {
                    accounts.Login(player, args);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /login <password>", player);
            }
            else MessagePlayer(COLOR_RED + "This nickname is not registered!", player);
            break;
        case "changepass":
            if(playerData[player.ID].logged) {
                if(args && NumTok(args, " ") == 1)
                {
                    local pass = args;
                    accounts.ChangePass(player, pass);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /changepass <new password>", player);
            }
            else MessagePlayer(COLOR_RED + "You need to be logged-in to use this command!", player);
            break;
        case "autologin":
            if(playerData[player.ID].logged)
            {
                accounts.ToggleAutoLogin(player);
            } else MessagePlayer(COLOR_RED + "You need to be logged-in to use this command!", player);
            break;
        case "stats":
            local p = playerData;
            local id = player.ID;
            MessagePlayer(COLOR_BLUE + "Your stats: Kills: " + p[id].kills + " Deaths: " + p[id].deaths + " Top spree: " + p[id].topSpree + " Headshots: " + p[id].headshots, player);
            break;
    }
}

function onPlayerRequestSpawn(player) {
    if(playerData[player.ID].registered) {
        if(!playerData[player.ID].logged) {
            MessagePlayer(COLOR_RED + "This nick is registered use /login <password> to spawn!", player);
            return false;
        }
    }
    return true;
}

function onPlayerChat(player, text) {
    if(playerData[player.ID].registered) {
        if(!playerData[player.ID].logged) {
            MessagePlayer(COLOR_RED + "This nick is registered use /login <password> to chat!", player);
            return false;
        }
    }
    return true;
}

function onPlayerKill(killer, player, r, b) {
    playerData[killer.ID].kills++;
    playerData[player.ID].deaths++;
    playerData[killer.ID].spree++;

    if(b == 6) // Headshot
    {
        playerData[killer.ID].headshots++;
    }

    if(playerData[killer.ID].spree > playerData[killer.ID].topSpree) playerData[killer.ID].topSpree = playerData[killer.ID].spree;
}

function onPlayerDeath(player, reason) {
    playerData[player.ID].deaths++;
}