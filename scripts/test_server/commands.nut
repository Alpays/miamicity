/*

File commands.nut

Description: Basic commands for script test server.

*/

function onPlayerCommand(player, cmd, text)
{
    cmd = cmd.tolower();
    if(cmd == "exec") {
        if(text)
        {
            try
            {
                local script = compilestring( text );
                script();
            }
            catch(e)
            {
                MessagePlayer(COLOR_RED + "Error: " + COLOR_WHITE + e, player);
            }
        }
        else MessagePlayer(COLOR_RED + "Correct usage: /exec <code>", player);
    }
    else if(cmd == "s") {    
        MessagePlayer(COLOR_BLUE + "Your Position: X: " + player.Pos.x + " Y: " + player.Pos.y + " Z: " + player.Pos.z + " Angle: " + player.Angle, player);         
    }
    else if(cmd == "v") {
        CreateVehicle( text.tointeger(), player.Pos, 1, 1, 1);
    }
}