/*

File: ammu_nation.nut

Description: Adds checkpoints to Ammu-Nation locations where weapons that can't be obtained by /wep command can be bought.

*/

ammuNations <-
[ 
    [Vector(-676.333, 1204.71, 11.10)], // Downtown ammu nation
    [Vector(364.518, 1057.24, 19.202)], // Vice Point Mall ammu nation
    [Vector(-62.78, -1481.37, 10.483)], // Ocean beach ammu nation
]

ammuNationCp <- array(3, null);

weapons <- // (weapon id, price, amount)
[
    [11, 2500, 1],
    [12, 5000, 10],
    [30, 9500, 7],
    [31, 6500, 600],
]

function onScriptLoad() {
    loadAmmuNations();
}

function loadAmmuNations()
{
    for(local i = 0; i < ammuNations.len(); ++i)
    {
        ammuNationCp[i] = CreateCheckpoint(null, 1, true, ammuNations[i][0], ARGB(255, 125, 255, 255), 1.8).ID;
        CreateMarker( 1, ammuNations[i][0], 1, RGBA(255, 255, 255, 255), 16 );
    }
}

function onCheckpointEntered( player, cp ) {
    for(local i = 0; i < ammuNationCp.len(); ++i) {
        if(cp.ID == ammuNationCp[i]) {
            onPlayerEnterAmmuNation(player);
            break;
        }
    }
}

function onPlayerEnterAmmuNation(player)
{
    playerData[player.ID].buymode = true;
    Announce("~g~Welcome to ~t~Vice City Ammu Nation! ~g~Use /buywep to purchase weapon.", player, 0);
}

function onCheckpointExited(player, checkpoint)
{
    playerData[player.ID].buymode = false;
}

function onPlayerCommand(player, cmd, args) {
    if(cmd.tolower() == "buywep") {
        if(playerData[player.ID].buymode)
        {
            if(!args)
            {
                local weplist = ""
                for(local i = 0; i < weapons.len(); ++i)
                {
                    weplist += GetWeaponName(weapons[i][0]) + " " + weapons[i][1] + "$ ";
                }
                Announce("", player, 0); // To clear "Welcome to Ammu Nation" announcement comes when entering ammu nation checkpoint
                Announce("~g~Weapons:" + weplist, player, 1);
            }
            else {
                for(local i = 0; i < weapons.len(); ++i)
                {
                    if(GetWeaponID(args) == weapons[i][0])
                    {
                        if(player.Cash >= weapons[i][1])
                        {
                            player.DecCash(weapons[i][1]);
                            player.GiveWeapon(weapons[i][0], weapons[i][2]);
                            MessagePlayer(COLOR_GREEN + "You've successfully purchased " + GetWeaponName(weapons[i][0]) + " with " + weapons[i][2] + " ammo for " + weapons[i][1] + "$", player);
                        }
                        else MessagePlayer(COLOR_RED + "You don't have enough money to buy this weapon!", player);
                        return 1;
                    }
                }
                if(GetWeaponName(GetWeaponID(args)) != "Unknown") MessagePlayer(COLOR_RED + "The weapon " + GetWeaponName(GetWeaponID(args)) + " is not available on ammu nation!", player);
                else MessagePlayer(COLOR_RED + "Incorrect weapon!", player);
            }
        }
        else MessagePlayer(COLOR_RED + "You have to be in Ammu Nation to use this command!", player);
    }
}