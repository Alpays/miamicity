/*

File: game_settings.nut

Description: Sets the server rules.

*/

function onScriptLoad() {
    SetServerName("Miami City - Freeroam");
    SetGameModeName("MCF v1.0 (Squirrel)");

    SetCrouchEnabled(false);
    SetWallglitch(false);
    SetVehiclesForcedRespawnHeight(1000);
    SetTimeRate(1000);
    SetTaxiBoostJump(true);
    SetJoinMessages(false);
    SetDeathMessages( false);

}