--[[ NPC Capabilities | Copyright (c) 2023 Commenter25 | MIT License ]]

TOOL.Name = "#tool.npccaps.name"
TOOL.Version = "1.0.0"
TOOL.License = "MIT"
TOOL.Author = "Commenter25"
TOOL.Contact = "https://github.com/Commenter25/gmodstuffs"
TOOL.Purpose = "#tool.npccaps.desc"
TOOL.Category = "Developer"


if CLIENT then
	TOOL.Information = {
		{ name = "left" },
		{ name = "right" },
	}

	language.Add( "tool.npccaps.name", "NPC Capabilities" )
	language.Add( "tool.npccaps.desc", "Print an NPC's capabilities to console" )
	language.Add( "tool.npccaps.left", "Get readable capabilities list" )
	language.Add( "tool.npccaps.right", "Get raw bitflag" )
end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description = "#tool.npccaps.desc" } )
end

-- The list from https://wiki.facepunch.com/gmod/Enums/CAP
local caps = {
	[-2147483648] = "CAP_SIMPLE_RADIUS_DAMAGE",
	[1] = "CAP_MOVE_GROUND",
	[2] = "CAP_MOVE_JUMP",
	[4] = "CAP_MOVE_FLY",
	[8] = "CAP_MOVE_CLIMB",
	[16] = "CAP_MOVE_SWIM",
	[32] = "CAP_MOVE_CRAWL",
	[64] = "CAP_MOVE_SHOOT",
	[128] = "CAP_SKIP_NAV_GROUND_CHECK",
	[256] = "CAP_USE",
	[1024] = "CAP_AUTO_DOORS",
	[2048] = "CAP_OPEN_DOORS",
	[4096] = "CAP_TURN_HEAD",
	[8192] = "CAP_WEAPON_RANGE_ATTACK1",
	[16384] = "CAP_WEAPON_RANGE_ATTACK2",
	[32768] = "CAP_WEAPON_MELEE_ATTACK1",
	[65536] = "CAP_WEAPON_MELEE_ATTACK2",
	[131072] = "CAP_INNATE_RANGE_ATTACK1",
	[262144] = "CAP_INNATE_RANGE_ATTACK2",
	[524288] = "CAP_INNATE_MELEE_ATTACK1",
	[1048576] = "CAP_INNATE_MELEE_ATTACK2",
	[2097152] = "CAP_USE_WEAPONS",
	[16777216] = "CAP_USE_SHOT_REGULATOR",
	[8388608] = "CAP_ANIMATEDFACE",
	[33554432] = "CAP_FRIENDLY_DMG_IMMUNE",
	[67108864] = "CAP_SQUAD",
	[134217728] = "CAP_DUCK",
	[268435456] = "CAP_NO_HIT_PLAYER",
	[536870912] = "CAP_AIM_GUN",
	[1073741824] = "CAP_NO_HIT_SQUADMATES",
}

local function DoEntity( ent )
	if not IsValid( ent ) or not ent:IsNPC() then return false end

	print( "\n"..ent:GetClass() )

	local npccaps = ent:CapabilitiesGet()

	for k, v in pairs(caps) do
		if bit.band( npccaps, k ) == k then
			print(v)
		end
	end

	print("\n")
end

function TOOL:LeftClick( trace )
	return DoEntity( trace.Entity ) != false
end


function TOOL:RightClick( trace )
	local ent = trace.Entity

	if not IsValid( ent ) or not ent:IsNPC() then return false end

	print( ent:GetClass().." "..ent:CapabilitiesGet() )

	return true
end




-- In case it's useful (actually because i accidentally made it and may as well put it somewhere), here's a table the other way around
--[[
local revcaps = {
	["CAP_SIMPLE_RADIUS_DAMAGE"] = -2147483648,
	["CAP_MOVE_GROUND"] = 1,
	["CAP_MOVE_JUMP"] = 2,
	["CAP_MOVE_FLY"] = 4,
	["CAP_MOVE_CLIMB"] = 8,
	["CAP_MOVE_SWIM"] = 16,
	["CAP_MOVE_CRAWL"] = 32,
	["CAP_MOVE_SHOOT"] = 64,
	["CAP_SKIP_NAV_GROUND_CHECK"] = 128,
	["CAP_USE"] = 256,
	["CAP_AUTO_DOORS"] = 1024,
	["CAP_OPEN_DOORS"] = 2048,
	["CAP_TURN_HEAD"] = 4096,
	["CAP_WEAPON_RANGE_ATTACK1"] = 8192,
	["CAP_WEAPON_RANGE_ATTACK2"] = 16384,
	["CAP_WEAPON_MELEE_ATTACK1"] = 32768,
	["CAP_WEAPON_MELEE_ATTACK2"] = 65536,
	["CAP_INNATE_RANGE_ATTACK1"] = 131072,
	["CAP_INNATE_RANGE_ATTACK2"] = 262144,
	["CAP_INNATE_MELEE_ATTACK1"] = 524288,
	["CAP_INNATE_MELEE_ATTACK2"] = 1048576,
	["CAP_USE_WEAPONS"] = 2097152,
	["CAP_USE_SHOT_REGULATOR"] = 16777216,
	["CAP_ANIMATEDFACE"] = 8388608,
	["CAP_FRIENDLY_DMG_IMMUNE"] = 33554432,
	["CAP_SQUAD"] = 67108864,
	["CAP_DUCK"] = 134217728,
	["CAP_NO_HIT_PLAYER"] = 268435456,
	["CAP_AIM_GUN"] = 536870912,
	["CAP_NO_HIT_SQUADMATES"] = 1073741824,
}
]]
