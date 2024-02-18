/*

File: diepos.nut

Description: Allows players to spawn where they die for a more quick paced deathmatch.

*/

function onPlayerKill(killer, player, r, b)
{
    playerData[player.ID].diePos = player.Pos;
}

function onPlayerSpawn(player)
{
    if(playerData[player.ID].spawnOnDeath && playerData[player.ID].diePos != null)
    {
        player.Pos = playerData[player.ID].diePos;
    }
}

function onPlayerCommand(player, cmd, text)
{
    switch(cmd.tolower())
    {
        case "diepos":
        {
            if(playerData[player.ID].spawnOnDeath)
            {
                playerData[player.ID].spawnOnDeath = false;
                MessagePlayer(COLOR_BLUE + "Diepos disabled. You will not spawn where you die.", player);
            }
            else {
                playerData[player.ID].spawnOnDeath = true;
                MessagePlayer(COLOR_BLUE + "Diepos enabled. You will spawn where you die.", player);
            }
        }
    }
}

function onPlayerDeath(player, reason)
{
    playerData[player.ID].diePos = null;
}