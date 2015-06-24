local Mag = DBM:NewBossMod("Magtheridon", DBM_MAG_NAME, DBM_MAG_DESCRIPTION, DBM_MAGS_LAIR, DBMGUI_TAB_OTHER_BC, 3);

Mag.Version		= "1.1";
Mag.Author		= "LYQ";

--Mag:RegisterCombat("EMOTE", DBM_MAG_EMOTE_PULL);
Mag:RegisterCombat("COMBAT") -- LYQ: this seems to be necessary, because after wipes sometimes maggy does not do his emote on encounter start

Mag:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
    "CHAT_MSG_RAID_BOSS_WHISPER"
)

Mag:AddOption("WarnInfernal", true, DBM_MAG_OPTION_1);
Mag:AddOption("WarnHeal", true, DBM_MAG_OPTION_2);
Mag:AddOption("WarnNova", true, DBM_MAG_OPTION_3);

Mag:AddBarOption("Phase 2")
Mag:AddBarOption("Heal")
Mag:AddBarOption("Blast Nova")

function Mag:OnCombatStart(delay)
    self:SendSync("Combat")
    self:ScheduleMethod(120, "SendSync", "Phase2")
end

function Mag:OnEvent(event, arg1)
	if event == "SPELL_CAST_SUCCESS" then
		if arg1.spellId == 30511 and self.Options.WarnInfernal then
			self:Announce(DBM_MAG_WARN_INFERNAL, 2);
        elseif arg1.spellId == 30576 then
            -- Quake, last phase starting - delaying the Nova
            self:SendSync("Phase3")
		end
	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 30528 then
			if self.Options.WarnHeal then
				self:Announce(DBM_MAG_WARN_HEAL, 1);
			end
			self:StartStatusBarTimer(2, "Heal", "Interface\\Icons\\Spell_Shadow_ChillTouch");
		end
	elseif event == "CHAT_MSG_RAID_BOSS_WHISPER" then
		if arg1 == DBM_MAG_EMOTE_NOVA then
			if self.Options.WarnNova then
				self:Announce(DBM_MAG_WARN_NOVA_NOW, 3)
			end
			self:StartStatusBarTimer(67, "Blast Nova", "Interface\\Icons\\Spell_Fire_SealOfFire");
			self:ScheduleSelf(61, "NovaWarn");
		end
	elseif event == "Phase2Warn" and arg1 then
		self:Announce(string.format(DBM_MAG_PHASE2_WARN, arg1), 2);
	elseif event == "NovaWarn" and self.Options.WarnNova then
		self:Announce(DBM_MAG_WARN_NOVA_SOON, 2);
	end
end
    
function Mag:OnSync(msg)
    if msg == "Combat" then
        self:StartStatusBarTimer(120, "Phase 2", "Interface\\Icons\\INV_Weapon_Halberd16");
        self:ScheduleSelf(60, "Phase2Warn", 60);
        self:ScheduleSelf(90, "Phase2Warn", 30);
        self:ScheduleSelf(110, "Phase2Warn", 10);
    elseif msg == "Phase2" then
        self:StartStatusBarTimer(67, "Blast Nova", "Interface\\Icons\\Spell_Fire_SealOfFire");
        self:ScheduleSelf(61, "NovaWarn");
    elseif msg == "Phase3" then
        self:UnScheduleSelf("NovaWarn")
        local timeleft = self:GetStatusBarTimerTimeLeft("Blast Nova")
        self:EndStatusBarTimer("Blast Nova")
        self:StartStatusBarTimer(timeleft+9, "Blast Nova", "Interface\\Icons\\Spell_Fire_SealOfFire");
        self:ScheduleSelf(timeleft+3, "NovaWarn");
    end
end