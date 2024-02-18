/*

File: vehicle_lights.nut

Description: Adds two keys to toggle vehicle and vehicle taxi lights.

*/

vehicleTaxiLights <- BindKey(true, 0x31, 0, 0)  // 1 Key
vehicleLights <- BindKey(true, 0x32, 0, 0)      // 2 Key


function onKeyUp(player, key)
{
    if(key == vehicleTaxiLights) {
        if(player.Vehicle) player.Vehicle.TaxiLight = !player.Vehicle.TaxiLight;
    }
    if(key == vehicleLights) {
        if(player.Vehicle) player.Vehicle.Lights = !player.Vehicle.Lights;
    }
}