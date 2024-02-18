/*

File: spree.nut

Description: Killing Spree system.

*/

function onPlayerKill(killer, player, reason, bodypart) {
    if(playerData[killer.ID].spree % 5 == 0) {
        local spree_reward = playerData[killer.ID].spree * 100;
        Message(COLOR_BLUE + player.Name + COLOR_WHITE + " is on a killing spree of " + COLOR_BLUE + playerData[killer.ID].spree + COLOR_WHITE + "! " + COLOR_WHITE + "Reward: " + COLOR_BLUE + spree_reward + "$")
        killer.IncCash(spree_reward);
        killer.Health = 100;
        Announce("~o~Killing Spree!", killer, 5);
    }

    if(playerData[player.ID].spree >= 5) {
        Message(COLOR_BLUE + player.Name + "'s" + COLOR_WHITE + " killing spree of " + COLOR_BLUE + playerData[player.ID].spree + COLOR_WHITE + " has been ended by " + COLOR_BLUE + killer.Name);
    }

    playerData[player.ID].spree = 0;
}