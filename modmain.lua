PrefabFiles = {
	"paperbox",
}
local assets=
{
    Asset("ATLAS", "images/inventoryimages/paperbox.xml"),
    Asset("IMAGE", "images/inventoryimages/paperbox.tex"),
}
AddMinimapAtlas("images/inventoryimages/paperbox.xml")

local myrecipe = AddRecipe("paperbox", -- name
{Ingredient("papyrus", 1)}, -- ingredients Add more like so , {Ingredient("boards", 1), Ingredient("rope", 2), Ingredient("twigs", 1), etc}
GLOBAL.RECIPETABS.FARM, -- tab ( FARM, WAR, DRESS etc)
GLOBAL.TECH.NONE, -- level (GLOBAL.TECH.NONE, GLOBAL.TECH.SCIENCE_ONE, etc)
"paperbox_placer", -- placer
0, -- min_spacing
nil, -- nounlock
nil, -- numtogive
nil, -- builder_tag
"images/inventoryimages/paperbox.xml", -- atlas
"paperbox.tex") -- image

GLOBAL.STRINGS.NAMES.PAPERBOX = "纸箱" --It's name in-game
GLOBAL.STRINGS.RECIPE_DESC.PAPERBOX = "一个快递包装箱，可用锤子无限循环使用。" --recipe description