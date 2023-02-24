--local WeakAuras = WeakAuras
local txtPath = "Interface\\AddOns\\WeakAurasStopMotion\\Textures\\"
WeakAuras.StopMotion.texture_types.Basic = {
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\stopmotion"] = "Example",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\circle"] = "Circle",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\checkmark"] = "Check Mark",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\redx"] = "Red X",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\leftarc"] = "Left Arc",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\rightarc"] = "Right Arc",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\fireball"] = "Fireball",
}

WeakAuras.StopMotion.texture_data = {
  ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\circle"] = {
     ["count"] = 256,
     ["rows"] = 16,
     ["columns"] = 16
  },
}

WeakAuras.StopMotion.texture_types.Runes = {
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\AURARUNE8"] = "Spike-Ringed Aura Rune",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\legionv"] = "Legion V",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\legionw"] = "Legion W",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\legionf"] = "Legion F",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\legionword"] = "Legion Word"
}

WeakAuras.StopMotion.texture_types.Kaitan = {
  ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\CellRing"] = "CellRing",
  ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Gadget"] = "Gadget",
  ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Radar"] = "Radar",
  ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\RadarComplex"] = "RadarComplex",
  ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Saber"] = "Saber",
  ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Waveform"] = "Waveform",
}

WeakAuras.StopMotion.texture_types.Shaman = {
  [txtPath.."Shaman\\l_bolt_90"] = "Lightning Bolt",
  [txtPath.."Shaman\\l_chain_90"] = "Chain",
  [txtPath.."Shaman\\flameshock_90"] = "Flame Shock",
  [txtPath.."Shaman\\lavaburst_90"] = "Lava",
  [txtPath.."Shaman\\feral_spirit_90"] = "Feral Spirits",
  [txtPath.."Shaman\\ghost_entropy_90"] = "Ghost",
  [txtPath.."Shaman\\shaman_rage_90"] = "Shaman Rage",
  [txtPath.."Shaman\\glovers_90"] = "Glovers",
  [txtPath.."Shaman\\speed_flask_90"] = "Potion of speed",
  [txtPath.."Shaman\\l_shield_90"] = "Lightning shield",
  [txtPath.."Shaman\\str_totem_90"] = "Earthbind totem",
  [txtPath.."Shaman\\fire_nova_90"] = "Fire nova",
  [txtPath.."Shaman\\stormstrike_90"] = "Stormstrike",
  [txtPath.."Shaman\\lava_lash_90"] = "Lava lash",
  [txtPath.."Shaman\\spirit_wolf_90"] = "Spirit wolf",
  [txtPath.."Shaman\\vulc_totem_90"] = "Vulcano Totem",
  [txtPath.."Shaman\\water_shield_90"] = "Water shield",
}

WeakAuras.StopMotion.texture_types.Warrior = {
  [txtPath.."Warrior\\mortal_90"] = "Mortal strike",
  [txtPath.."Warrior\\over_90"] = "Overpower",
  [txtPath.."Warrior\\execute_90"] = "Execute",
  [txtPath.."Warrior\\execute2_90"] = "Execute 2",
  [txtPath.."Warrior\\charge_90"] = "Charge",
  [txtPath.."Warrior\\slice_90"] = "Slice",
  [txtPath.."Warrior\\rend_90"] = "Rend",
  [txtPath.."Warrior\\bstorm_90"] = "Bladestorm",
  [txtPath.."Warrior\\whirl_90"] = "Whirlwind",
}

WeakAuras.StopMotion.texture_types.Priest = {
  [txtPath.."Priest\\dispersion_90"] = "Dispersion",
  [txtPath.."Priest\\dplague_90"] = "Dplague",
  [txtPath.."Priest\\invis_90"] = "Invis",
  [txtPath.."Priest\\mindshear_90"] = "Mindshear",
  [txtPath.."Priest\\sfiend_90"] = "Sfiend",
  [txtPath.."Priest\\siphomana_90"] = "Siphomana",
  [txtPath.."Priest\\stoicism_90"] = "Stoicism",
  [txtPath.."Priest\\nyaloth_90"] = "Nyaloth",
}

WeakAuras.StopMotion.texture_types.Race = {
  [txtPath.."Race\\LEredar"] = "LEredar",
}
