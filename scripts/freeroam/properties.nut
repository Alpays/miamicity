/*

File: properties.nut

Description: Adds purchasable properties.

Property types.

0 <- Apartment 3C
/addprop command doesn't take a 'property type' argument as there is only one now.

*/

const APARTMENT_3C = 0;

function onScriptLoad()
{
    properties.db = ConnectSQL("properties.db");

    QuerySQL(properties.db, "CREATE TABLE IF NOT EXISTS properties(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, owner TEXT, shared TEXT, type INTEGER DEFAULT 0, x FLOAT, y FLOAT, z FLOAT, price INTEGER DEFAULT 500000)");

    CreateObject(311, 0, 26, -1329, 13.2, 255);

    tvCp <- CreateCheckpoint( null, 0, true, Vector(28.43, -1324.98, 13.08), ARGB(255, 255, 0, 0), 1).ID;

    loadProperties();
}

function loadProperties()
{
    local propcount = 0;
    local q = QuerySQL( properties.db, "SELECT * FROM properties");
    if(q) {
        while(GetSQLColumnData(q, 0)) {

            local x = GetSQLColumnData(q, 5);
            local y = GetSQLColumnData(q, 6);
            local z = GetSQLColumnData(q, 7);
            CreatePickup(407, Vector(x,y,z));
            GetSQLNextRow(q);
            ++propcount;
        }
        FreeSQLQuery(q);
    }
    if(propcount > 0)
    {
        print(propcount + " properties have been loaded from property database.");
    }
    else print("No properties were found in the database.");    
}

function onPickupPickedUp(player, pickup)
{
    switch(pickup.Model)
    {
        case 407: // Property pick up
        {
            local q = QuerySQL(properties.db, "SELECT * FROM properties WHERE id='"+(pickup.ID + 1)+"'")
            if(q) {
                local id = GetSQLColumnData(q, 0);
                local propName = GetSQLColumnData(q, 1);
                local owner = GetSQLColumnData(q, 2);
                local shared = GetSQLColumnData(q, 3);
                local hType = GetSQLColumnData(q, 4);
                local price = GetSQLColumnData(q, 8);
                if(owner.tolower() == player.Name.tolower() || shared.tolower() == player.Name.tolower())
                {
                    onPlayerEnterProp(player, hType, pickup.ID + 1);
                }
                else {
                    MessagePlayer(COLOR_BLUE + "Property ID: " + COLOR_WHITE + id + COLOR_BLUE + " Name: " + COLOR_WHITE + propName + COLOR_BLUE + " Owner: " + COLOR_WHITE + owner + COLOR_BLUE + " Shared to: " + COLOR_WHITE + shared + COLOR_BLUE + " Price: " + COLOR_WHITE + price, player);
                }
                FreeSQLQuery(q);
            }
            break;
        }
    }
}


function onPlayerEnterProp(player, pType, pID)
{
    playerData[player.ID].propEnter = player.Pos;
    switch(pType) {
        case APARTMENT_3C:
            player.Pos = Vector(23.94, -1324, 13.0008);
            break;
    }
    player.World = pID + 100;
}

function onPlayerCommand(player, cmd, text) {
    switch(cmd.tolower())
    {
        case "exitprop": 
        {
            if(playerData[player.ID].propEnter != null) {
                onPlayerExitProp(player);
            }
            else MessagePlayer(COLOR_RED + "You are not in a property!", player);      
            break;  
        }
        case "buyprop":
        case "buyproperty":
        {
            if(text && IsNum(GetTok(text, " ", 1)))
            {
                local id = GetTok(text, " ", 1).tointeger();
                local q = QuerySQL(properties.db, "SELECT * FROM properties WHERE id='"+id+"'");
                if(q) 
                {
                    local name = GetSQLColumnData(q, 1);
                    local owner = GetSQLColumnData(q, 2);
                    local price = GetSQLColumnData(q, 8);
                    if(owner == "-")
                    {
                        if(player.Cash >= price)
                        {
                            player.DecCash(price);
                            QuerySQL(properties.db, "UPDATE properties SET owner='"+player.Name+"' WHERE id='"+id+"'");
                            MessagePlayer(COLOR_BLUE + "Successfully bought property " + COLOR_WHITE + name + "!", player);
                        }
                        else MessagePlayer(COLOR_RED + "You don't have enough money to buy this property!", player);
                    }
                    else MessagePlayer(COLOR_RED + "This property is already bought by " + owner + "!", player);
                    FreeSQLQuery(q);
                }
                else MessagePlayer(COLOR_RED + "No property exists with such id!", player);
            }
            else MessagePlayer(COLOR_RED + "Correct usage: /buyprop <property id>", player);
            break;
        }
        case "shareproperty":
        case "shareprop":
        {
            if(text && NumTok(text, " ") == 2)
            {
                local propId = GetTok(text, " ", 1);
                local playerName = GetTok(text, " ", 2);
                if(IsNum(propId))
                {
                    propId = GetTok(text, " ", 1).tointeger();
                    local q = QuerySQL(properties.db, "SELECT * FROM properties WHERE id='"+propId+"'");
                    if(q)
                    {
                        local owner = GetSQLColumnData(q, 2);
                        if(owner.tolower() == player.Name.tolower())
                        {
                            QuerySQL(properties.db, "UPDATE properties SET shared='"+playerName+"' WHERE id='"+propId+"'");
                            MessagePlayer(COLOR_BLUE + "You are now sharing your property with " + COLOR_WHITE + playerName + "!", player);
                        }
                        else MessagePlayer(COLOR_RED + "Property with this id doesn't belong to you!", player);
                        FreeSQLQuery(q);
                    }
                    else MessagePlayer(COLOR_RED + "Property with such id doesn't exists!", player);
                }
                else MessagePlayer(COLOR_RED + "Correct usage: /shareprop <property id> <player name>", player);
            }
            else MessagePlayer(COLOR_RED + "Correct usage: /shareprop <property id> <player name>",player)
            break;
        }
    }
}

function onPlayerExitProp(player)
{
    player.Pos = playerData[player.ID].propEnter;
    playerData[player.ID].worldTimer = NewTimer("SetPlayerWorld", 3 * 1000, 1, player.ID, 1);
    playerData[player.ID].propEnter = null;
}

function findSeaSparrow()
{
    for(local i = 0; i < 1000; ++i)
    {
        if(FindVehicle(i))
        {
            if(FindVehicle(i).Model == VEH_SEASPARROW)
            {
                return FindVehicle(i).Pos;
            }
        }
    }
    return 0;
}

function onCheckpointEntered(player, cp)
{
    if(cp.ID == tvCp)
    {
        local seaSparrowLoc = findSeaSparrow();
        if(seaSparrowLoc)
        {
            MessagePlayer(COLOR_BLUE + "A Sea sparrow is last seen at " + COLOR_WHITE + GetDistrictName(seaSparrowLoc.x, seaSparrowLoc.y), player);
        }
    }
}