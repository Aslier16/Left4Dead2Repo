local Aslier_localPlayer = null;
local Aslier_localPlayerWeapon = null;
local Aslier_bulletCounterInit = false;
function Aslier_getLocalPlayer(){
    local p = null;
    while(p = Entities.FindByClassname(p, "player")){
        if (p.GetSurvivorSlot() == 0){
            Aslier_localPlayer = p;
            Aslier_bulletCounterInit = true;
            break;
        }
    }
}
function Aslier_updateBulletCounter(){
    if (!Aslier_bulletCounterInit){
        Aslier_getLocalPlayer();
    }
    if (Aslier_localPlayer != null){
        Aslier_localPlayerWeapon = Aslier_localPlayer.GetActiveWeapon();
        if (Aslier_localPlayerWeapon != null){
            // printl("子弹数量: " + Aslier_localPlayerWeapon.Clip1());
            Convars.SetValue("cl_buy_favorite_quiet", Aslier_localPlayerWeapon.Clip1())
        }
    }
    EntFire("worldspawn", "RunScriptCode", "g_ModeScript.Aslier_updateBulletCounter()", 0.2);
}

Aslier_bulletCounter <- {};
Aslier_bulletCounter.OnGameEvent_round_start_post_nav <- function(event)
{
    EntFire("worldspawn", "RunScriptCode", "g_ModeScript.Aslier_updateBulletCounter()");
}
__CollectGameEventCallbacks(Aslier_bulletCounter);