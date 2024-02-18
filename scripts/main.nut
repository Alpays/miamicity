/*

File: main.nut

Description: File which loads all the scripts.


Credits:
Alpays -- Creator of the gamemode and NoCrouch plugin.
dracc -- His modular scripting concept that i used while making the script
without it, this wouldn't be possible.
[LCK]rww -- His yacht map posted on vc-mp forums.

Plugins Used:

hashing04rel64 - To hash players' password.
NoCrouch - To prevent c glitch.

*/


// Main Script

dofile("scripts/module.nut")

dofile("scripts/main/player.nut");
dofile("scripts/main/utility.nut");
dofile("scripts/main/accounts.nut");
dofile("scripts/main/accounts_autosave.nut");
dofile("scripts/main/g_variables.nut");
scripts_load("main/accounts_hook.nut");

dofile("scripts/main/bans.nut");
scripts_load("main/bans_hook.nut");

// Freeroam scripts

scripts_load("freeroam/vehicles.nut");
scripts_load("freeroam/game_settings.nut");
scripts_load("freeroam/interiors.nut");
scripts_load("freeroam/ammu_nation.nut");
scripts_load("freeroam/mod_shops.nut");
scripts_load("freeroam/properties.nut");
scripts_load("freeroam/vehicle_lights.nut");
scripts_load("freeroam/sea_sparrow.nut");
scripts_load("freeroam/classes.nut");
scripts_load("freeroam/roleplay.nut");
scripts_load("freeroam/guide.nut");
scripts_load("freeroam/personal_vehicle.nut");
scripts_load("freeroam/hospitals.nut");

// Free for All deathmatch scripts.

scripts_load("deathmatch/ffa.nut");
scripts_load("deathmatch/weapon.nut");
scripts_load("deathmatch/spree.nut");
scripts_load("deathmatch/kill_reward.nut");
scripts_load("deathmatch/kill_messages.nut");
scripts_load("deathmatch/disable_fpv.nut");
scripts_load("deathmatch/diepos.nut");

// Administrator commands.
scripts_load("admin/add_vehicle.nut");
scripts_load("admin/ban_commands.nut");
scripts_load("admin/moderation.nut");
scripts_load("admin/administration.nut");
scripts_load("admin/add_property.nut");

// Custom maps
scripts_load("maps/rww_yacth.map");
scripts_load("maps/remove_gate.map");

// Test server scripts. (Comment if you are not doing script tests)

scripts_load("test_server/commands.nut");
scripts_load("test_server/login_admin.nut");