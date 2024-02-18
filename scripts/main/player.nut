/*

File: player.nut

Description: Player class to store variables that are defined in the script.

*/

class Player {
    // accounts.nut
    kills = 0;
    deaths = 0;
    topSpree = 0;
    adminLevel = 0;
    headshots = 0;

    registered = false;
    logged = false;

    /* car1 and car2 values store the vehicle model, currentCar stores ID of the current car spawned by the player*/
    car1 = 0;
    car2 = 0;
    currentCar = null;

    // hospitals.nut

    healPos = null;
    healTimer = null;

    // properties.nut
    propEnter = null;
    worldTimer = null;

    // ammu_nation.nut
    buymode = false;

    // mod_shops.nut
    modshop = false;
    modshopEnter = null;
    carColor = null;
    carSecondaryColor = null;

    // spree.nut
    spree = 0;
    // spawnweps.nut
    spawnweps = null;

    // diepos.nut
    diePos = null;
    spawnOnDeath = true;

    // sea_sparrow.nut
    sparrowKills = 0;

    constructor() {
        spawnweps = array(5, null);
        spawnweps.insert(0, WEP_M60); 
        spawnweps.insert(1, WEP_M4); 
        spawnweps.insert(2, WEP_UZI); 
        spawnweps.insert(3, WEP_STUBBY); 
        spawnweps.insert(3, WEP_PYTHON); 
    }
}

playerData <- array ( GetMaxPlayers(), null );

function onPlayerJoin(player) {
    Message(COLOR_YELLOW + player.Name + COLOR_WHITE + " has joined the game.");
    playerData[player.ID] = Player();
    accounts.onPlayerJoin(player);
    bans.onPlayerJoin(player);
}

function onPlayerPart(player, reason) {
    Message(COLOR_RED + player.Name + COLOR_WHITE + " has left the game.");
    accounts.onPlayerPart(player);
    if(playerData[player.ID].worldTimer) playerData[player.ID].worldTimer.Delete();
    if(playerData[player.ID].currentCar) playerData[player.ID].currentCar.Delete();
    if(playerData[player.ID].healTimer)  playerData[player.ID].healTimer.Delete();
    playerData[player.ID] = null;
}