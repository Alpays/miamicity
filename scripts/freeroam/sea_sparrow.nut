/*

File: sea_sparrow.nut

Description: Adds a sea sparrow that spawns at random locations.

*/

seaSparrow <- null;

seaSparrowSpawns <-
[
    [Vector(-705.74, 801, 23.91)],
    [Vector(-1090, -231, 22.96)],
    [Vector(-1174, -715, 22.70)],
    [Vector(-687, -1567, 12.43)],
    [Vector(-68.58, -1609, 12.03)],
    [Vector(279, -685, 9.9)],
    [Vector(-70, 1012, 10.1)]
]

function changeSeaSparrowLoc() {
    local r = random(0,(seaSparrowSpawns.len() - 1));
    local pos = seaSparrowSpawns[r][0];
    if(seaSparrow != null) {
        seaSparrow.SpawnPos = pos;
    }
}

function onScriptLoad() {
    local r = random(0,(seaSparrowSpawns.len() - 1));
    local pos = seaSparrowSpawns[r][0];
    seaSparrow = CreateVehicle( VEH_SEASPARROW, pos, 0.0, 1, 1 );
}

function onPlayerKill(killer, player, reason, bodypart) {
    if(killer.Vehicle) {
        if(killer.Vehicle.Model == VEH_SEASPARROW) {
            playerData[killer.ID].sparrowKills++;
            killer.Vehicle.Health += 100 * playerData[killer.ID].sparrowKills;
            MessagePlayer(COLOR_WHITE + "Sea Sparrow's health has been increased by" + COLOR_BLUE + 100 * playerData[killer.ID].sparrowKills, killer);
        }
    }
}

function onVehicleExplode(vehicle) {
    if(vehicle.ID == seaSparrow.ID) {
        changeSeaSparrowLoc();
    }
}

function onPlayerDeath(player, reason) {
    playerData[player.ID].sparrowKills = 0;
}

function onPlayerEnterVehicle(player, vehicle, door) {
    if(vehicle.ID == seaSparrow.ID) {
        if(door == 0) // Driver seat.
        {  
            Message(COLOR_BLUE + player.Name + COLOR_WHITE + " has collected the Sea Sparrow!")
        }
    }
}