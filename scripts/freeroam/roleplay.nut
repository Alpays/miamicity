/*

File: roleplay.nut

Description: Adds /me command.

*/

function onPlayerCommand(player, cmd, arg)
{
    switch(cmd.tolower()) 
    {
        case "me":
            if(!arg) return;
            Message(COLOR_GRAY + "* " + player.Name + " " + arg);
    }
} 