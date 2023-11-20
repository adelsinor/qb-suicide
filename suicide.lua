if Config.DisableSuicide then return end

local QBCore = exports["qb-core"]:GetCoreObject()
local LoadAnimDict = QBCore.Functions.RequestAnimDict
local suicided = false

local suicideWeapons = {
	[`weapon_pistol`] = true,
	[`weapon_pistol_mk2`] = true,
	[`weapon_combatpistol`] = true,
	[`weapon_appistol`] = true,
	[`weapon_pistol50`] = true,
	[`weapon_snspistol`] = true,
	[`weapon_snspistol_mk2`] = true,
	[`weapon_revolver`] = true,
	[`weapon_revolver_mk2`] = true,
	[`weapon_heavypistol`] = true,
	[`weapon_vintagepistol`] = true,
	[`weapon_marksmanpistol`] = true,
	[`weapon_microsmg`] = true,
	[`weapon_machinepistol`] = true
}

RegisterCommand("suicide", function()
	if suicided then
		QBCore.Functions.Notify("How many times do you want to suicide?", "error")
		return
	end
	-- weapdraw controls this..
	if LocalPlayer.state.canFire == false then return end

	local ped = PlayerPedId()
	local weapon = GetSelectedPedWeapon(ped)
	if not suicideWeapons[weapon] or GetAmmoInPedWeapon(ped, weapon) <= 0 then
		QBCore.Functions.Notify("You need a pistol with ammo to do this!", "error")
		return
	end

	suicided = true -- once every restart
	LoadAnimDict("mp_suicide")
	TaskPlayAnim(ped, "mp_suicide", "pistol", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
	Wait(700)
	ClearPedTasksImmediately(ped)
	SetPedShootsAtCoord(ped, 0.0, 0.0, 0.0, 0)
	SetEntityHealth(ped, 0)
	QBCore.Functions.Notify("What a shame! You killed yourself.", "error")
end, false)
