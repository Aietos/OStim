ScriptName OsexIntegrationMCM Extends SKI_ConfigBase

; sex settings
Int SetEndOnOrgasm
Int SetActorSpeedControl
Int SetUndressIfNeed
Int SetsexExcitementMult
Int SetClipinglessFirstPerson
Int SetEndAfterActorHit
Int SetUseRumble
Int SetUseScreenShake

; clothes settings
Int SetAlwaysAnimateUndress
Int SetAlwaysUndressAtStart
Int SetonlyUndressChest
Int SetDropClothes
int SetAnimateRedress
Int SetStrongerUnequip

; bar settings
Int SetSubBar
Int SetDomBar
Int SetThirdBar
Int SetAutoHideBar

; orgasm settings
Int SetSlowMoOrgasms
Int SetOrgasmBoostsRel

; light settings
Int SetDomLightMode
Int SetSubLightMode
Int SetSubLightBrightness
Int SetDomLightBrightness
Int SetOnlyLightInDark

Int SetResetState
Int SetRebuildDatabase

Int SetKeymap
Int SetKeyUp
Int SetKeyDown
Int SetPullOut

Int SetThanks

String[] DomLightModeList
String[] SubLightModeList

String[] SubLightBrightList
String[] DomLightBrightList

Int SetEnableBeds
Int SetBedSearchDistance
Int SetBedReallignment
int SetBedAlgo

Int SetAIControl
Int SetControlToggle
Int SetAIChangeChance

Int SetForceAIIfAttacking
Int SetForceAIIfAttacked
Int SetForceAIInConsensualScenes

Int SetCustomTimescale

Int SetMisallignmentOption
Int SetFlipFix

Int SetUseFades
Int SetUseAutoFades

Int SetMute

Int SetUseFreeCam
Int SetFreeCamFOV
Int SetDefaultFOV
Int SetCameraSpeed
Int SetForceFirstPerson

Int SetUseCosaveWorkaround

OsexIntegrationMain Main

Event OnInit()
	Init()
EndEvent

Function Init()
	Parent.OnGameReload()
	Main = (Self as Quest) as OsexIntegrationMain

	DomLightModeList = new String[3]
	DomLightModeList[0] = "No light"
	DomLightModeList[1] = "Rear light"
	DomLightModeList[2] = "Face light"

	SubLightModeList = new String[3]
	SubLightModeList[0] = "No light"
	SubLightModeList[1] = "Rear light"
	SubLightModeList[2] = "Face light"

	SubLightBrightList = new String[2]
	SubLightBrightList[0] = "Dim"
	SubLightBrightList[1] = "Bright"

	DomLightBrightList = new String[2]
	DomLightBrightList[0] = "Dim"
	DomLightBrightList[1] = "Bright"
EndFunction

Event OnPageReset(String Page)
	{Called when a new page is selected, including the initial empty page}
	If (Page == "Configuration")
		If (!Main)
			Init()
			If (!Main.EndOnDomOrgasm)
				Main.Startup()
			EndIf
			Debug.MessageBox("Anomaly detected in install, please reinstall OStim if it does not start properly")
		EndIf

		UnloadCustomContent()
		SetInfoText(" ")
		Main.playTickBig()
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetThanks = AddTextOption("Thanks!", "")
		SetCursorPosition(1)
		AddTextOption("<font color='" + "#939292" +"'>" + "OStim Settings", "")
		SetCursorPosition(2)

		;=============================================================================================

		AddColoredHeader("Sex scenes")
		SetEndOnOrgasm = AddToggleOption("End sex after main actor orgasm", Main.EndOnDomOrgasm)
		SetActorSpeedControl = AddToggleOption("Actors control speed", Main.EnableActorSpeedControl)
		SetsexExcitementMult = AddSliderOption("Excitement multiplier", Main.SexExcitementMult, "{2} x")
		SetClipinglessFirstPerson = AddToggleOption("Clipping-less first person", Main.EnableImprovedCamSupport)
		SetCustomTimescale = AddSliderOption("Custom timescale", Main.CustomTimescale, "{0}")
		SetMisallignmentOption = AddToggleOption("Enable misalignment protection", Main.MisallignmentProtection)
		SetFlipFix = AddToggleOption("Enable flipped animation fix", Main.FixFlippedAnimations)
		SetUseFades = AddToggleOption("Fade out on intro/outro", Main.UseFades)
		SetEndAfterActorHit = AddToggleOption("End if attacked", Main.EndAfterActorHit)
		SetUseRumble = AddToggleOption("Use controller rumble", Main.UseRumble)
		SetUseScreenShake = AddToggleOption("Use extra screenshake", Main.UseScreenShake)
		SetForceFirstPerson = AddToggleOption("Force return to first person after scene", Main.ForceFirstPersonAfter)
		AddEmptyOption()

		AddColoredHeader("Beds")
		SetEnableBeds = AddToggleOption("Use beds", Main.UseBed)
		SetBedSearchDistance = AddSliderOption("Bed search radius", Main.BedSearchDistance, "{0} meters")
		SetBedReallignment = AddSliderOption("Bed reallignment", Main.BedReallignment, "{0} units")
		SetBedAlgo = AddToggleOption("Use alternate bed search method", Main.UseAlternateBedSearch)
		AddEmptyOption()

		AddColoredHeader("Excitement bars")
		SetDomBar = AddToggleOption("Main actor HUD bar", Main.EnableDomBar)
		SetSubBar = AddToggleOption("Second actor HUD bar", Main.EnableSubBar)
		SetThirdBar = AddToggleOption("Third actor HUD bar", Main.EnableThirdBar)
		SetAutoHideBar = AddToggleOption("Autohide bars", Main.AutoHideBars)
		AddEmptyOption()

		AddColoredHeader("System")
		SetResetState = AddTextOption("Reset thread state", "")
		SetRebuildDatabase = AddTextOption("Rebuild animation database", "")
		SetMute = AddToggleOption("Mute vanilla OSA sounds", Main.MuteOSA)
		;SetUseCosaveWorkaround = AddToggleOption("Fix keys & auto-mode", Main.useBrokenCosaveWorkaround)
		AddEmptyOption()

		;=============================================================================================

		SetCursorPosition(3)
		AddColoredHeader("Undressing")
		SetAlwaysUndressAtStart = AddToggleOption("Fully undress at start", Main.AlwaysUndressAtAnimStart)
		SetUndressIfneed = AddToggleOption("Remove clothes mid-scene", Main.AutoUndressIfNeeded)
		SetDropClothes = AddToggleOption("Toss clothes onto ground", Main.TossClothesOntoGround)
		SetStrongerUnequip = AddToggleOption("Use stronger unequip method", Main.UseStrongerUnequipMethod)
		SetAnimateRedress= AddToggleOption("Use animated redress", Main.FullyAnimateRedress)
		;SetAlwaysAnimateUndress = AddToggleOption("Use undress animation", Main.AlwaysAnimateUndress) Removed in 4.0, may be reimplemented but it was bugged
		;SetonlyUndressChest = AddToggleOption("Only undress chest piece", Main.OnlyUndressChest) REMOVED in 4.0
		AddEmptyOption()

		AddColoredHeader("AI Control")
		SetAIControl = AddToggleOption("Enable full-auto control", Main.UseAIControl)
		SetForceAIIfAttacking = AddToggleOption("Force full-auto control if player attacking", Main.UseAIPlayerAggressor)
		SetForceAIIfAttacked = AddToggleOption("Force full-auto control if player is attacked", Main.UseAIPlayerAggressed)
		SetForceAIInConsensualScenes = AddToggleOption("Force full-auto control in consensual scenes", Main.UseAINonAggressive)
		SetUseAutoFades = AddToggleOption("Fade out in between animation transitions", Main.UseAutoFades)
		SetAIChangeChance = AddSliderOption("AI Animation Change Chance", Main.AiSwitchChance, "{0}")
		AddEmptyOption()

		AddColoredHeader("FreeCam")
		SetUseFreeCam = AddToggleOption("Switch to freecam mode on start", Main.UseFreeCam)
		SetFreeCamFOV = AddSliderOption("Freecam FOV", Main.FreecamFOV, "{0}")
		SetDefaultFOV = AddSliderOption("Default FOV", Main.DefaultFOV, "{0}")
		SetCameraSpeed = AddSliderOption("Camera speed", Main.FreecamSpeed, "{0}")
		AddEmptyOption()

		AddColoredHeader("Keys")
		SetKeymap = AddKeyMapOption("Start sex with target", Main.KeyMap)
		SetKeyup = AddKeyMapOption("Increase speed", Main.SpeedUpKey)
		SetKeydown = AddKeyMapOption("Decrease speed", Main.SpeedDownKey)
		SetPullOut = AddKeyMapOption("Pull out", Main.PullOutKey)
		SetControlToggle = AddKeyMapOption("Switch control mode", Main.ControlToggleKey)
		AddEmptyOption()

		AddColoredHeader("Lights")
		SetDomLightMode = AddMenuOption("Main actor light mode", DomLightModeList[Main.DomLightPos])
		SetSubLightMode = AddMenuOption("Second actor light mode", SubLightModeList[Main.SubLightPos])
		SetDomLightBrightness = AddMenuOption("Main actor light brightness", DomLightBrightList[Main.DomLightBrightness])
		SetSubLightBrightness = AddMenuOption("Second actor light brightness", SubLightBrightList[Main.SubLightBrightness])
		SetOnlyLightInDark = AddToggleOption("Only use lights in darkness", Main.LowLightLevelLightsOnly)
		AddEmptyOption()
	ElseIf (Page == "")
		LoadCustomContent("Ostim/logo.dds", 184, 31)
		Main.PlayDing()
	ElseIf (Page == "About")
		UnloadCustomContent()
		Main.PlayTickBig()
		SetCursorFillMode(TOP_TO_BOTTOM)
		LoadCustomContent("Ostim/info.dds")
	EndIf
EndEvent

Event OnOptionSelect(Int Option)
	Main.PlayTickBig()
	If (Option == SetEndOnOrgasm)
		Main.EndOnDomOrgasm = !Main.EndOnDomOrgasm
		SetToggleOptionValue(SetEndOnOrgasm, Main.EndOnDomOrgasm)
	ElseIf (Option == SetResetState)
		Main.ResetState()
	ElseIf (Option == SetRebuildDatabase)
		Debug.MessageBox("Close all menus and watch the console until it is done")
		Main.GetODatabase().InitDatabase()
	ElseIf (Option == SetActorSpeedControl)
		Main.EnableActorSpeedControl = !Main.EnableActorSpeedControl
		SetToggleOptionValue(Option, Main.EnableActorSpeedControl)
	ElseIf (Option == SetEnableBeds)
		Main.UseBed = !Main.UseBed
		SetToggleOptionValue(Option, Main.UseBed)
	ElseIf (Option == SetUseRumble)
		Main.UseRumble = !Main.UseRumble
		SetToggleOptionValue(Option, Main.UseRumble)
	ElseIf (Option == SetStrongerUnequip)
		Main.UseStrongerUnequipMethod = !Main.UseStrongerUnequipMethod
		SetToggleOptionValue(Option, Main.UseStrongerUnequipMethod)
	ElseIf (Option == SetFlipFix)
		Main.FixFlippedAnimations = !Main.FixFlippedAnimations
		SetToggleOptionValue(Option, Main.FixFlippedAnimations)
	ElseIf (Option == SetUseScreenShake)
		Main.UseScreenShake = !Main.UseScreenShake
		SetToggleOptionValue(Option, Main.UseScreenShake)
	ElseIf (Option == SetForceAIInConsensualScenes)
		Main.UseAINonAggressive = !Main.UseAINonAggressive
		SetToggleOptionValue(Option, Main.UseAINonAggressive)
	ElseIf (Option == SetDropClothes)
		Main.TossClothesOntoGround = !Main.TossClothesOntoGround
		SetToggleOptionValue(Option, Main.TossClothesOntoGround)
	ElseIf (Option == SetForceAIIfAttacked)
		Main.UseAIPlayerAggressed = !Main.UseAIPlayerAggressed
		SetToggleOptionValue(Option, Main.UseAIPlayerAggressed)
	ElseIf (Option == SetForceFirstPerson)
		Main.ForceFirstPersonAfter = !Main.ForceFirstPersonAfter
		SetToggleOptionValue(Option, Main.ForceFirstPersonAfter)
	ElseIf (Option == SetUseAutoFades)
		Main.UseAutoFades = !Main.UseAutoFades
		SetToggleOptionValue(Option, Main.UseAutoFades)
	ElseIf (Option == SetMute)
		Main.MuteOSA = !Main.MuteOSA
		SetToggleOptionValue(Option, Main.MuteOSA)
	ElseIf (Option == SetEndAfterActorHit)
		Main.EndAfterActorHit = !Main.EndAfterActorHit
		SetToggleOptionValue(Option, Main.EndAfterActorHit)
	ElseIf (Option == SetUseFreeCam)
		Main.UseFreeCam = !Main.UseFreeCam
		SetToggleOptionValue(Option, Main.UseFreeCam)
	ElseIf (Option == SetUseCosaveWorkaround)
		Main.UseBrokenCosaveWorkaround = !Main.UseBrokenCosaveWorkaround
		SetToggleOptionValue(Option, Main.UseBrokenCosaveWorkaround)
	ElseIf (Option == SetForceAIIfAttacking)
		Main.UseAIPlayerAggressor = !Main.UseAIPlayerAggressor
		SetToggleOptionValue(Option, Main.UseAIPlayerAggressor)
	ElseIf (Option == SetUndressIfneed)
		Main.AutoUndressIfNeeded = !Main.AutoUndressIfNeeded
		SetToggleOptionValue(Option, Main.AutoUndressIfNeeded)
	ElseIf (Option == SetBedAlgo)
		Main.UseAlternateBedSearch = !Main.UseAlternateBedSearch
		SetToggleOptionValue(Option, Main.UseAlternateBedSearch)
	ElseIf (Option == SetClipinglessFirstPerson)
		Main.EnableImprovedCamSupport = !Main.EnableImprovedCamSupport
		SetToggleOptionValue(Option, Main.EnableImprovedCamSupport)
	ElseIf (Option == SetAlwaysUndressAtStart)
		Main.AlwaysUndressAtAnimStart = !Main.AlwaysUndressAtAnimStart
		SetToggleOptionValue(Option, Main.AlwaysUndressAtAnimStart)
	ElseIf (Option == SetAIControl)
		Main.UseAIControl = !Main.UseAIControl
		SetToggleOptionValue(Option, Main.UseAIControl)
	ElseIf (Option == SetAlwaysAnimateUndress)
		Main.AlwaysAnimateUndress = !Main.AlwaysAnimateUndress
		SetToggleOptionValue(Option, Main.AlwaysAnimateUndress)
	;ElseIf (Option == SetonlyUndressChest)
	;	Main.OnlyUndressChest = !Main.OnlyUndressChest
	;	SetToggleOptionValue(Option, Main.OnlyUndressChest)
	ElseIf (Option == SetDomBar)
		Main.EnableDomBar = !Main.EnableDomBar
		SetToggleOptionValue(Option, Main.EnableDomBar)
	ElseIf (Option == SetThirdBar)
		Main.EnableThirdBar = !Main.EnableThirdBar
		SetToggleOptionValue(Option, Main.EnableThirdBar)
	ElseIf (Option == SetAnimateRedress)
		Main.FullyAnimateRedress = !Main.FullyAnimateRedress
		SetToggleOptionValue(Option, Main.FullyAnimateRedress)
	ElseIf (Option == SetMisallignmentOption)
		Main.MisallignmentProtection = !Main.MisallignmentProtection
		SetToggleOptionValue(Option, Main.MisallignmentProtection)
	ElseIf (Option == SetSubBar)
		Main.EnableSubBar = !Main.EnableSubBar
		SetToggleOptionValue(Option, Main.EnableSubBar)
	ElseIf (Option == SetAutoHideBar)
		Main.AutoHideBars = !Main.AutoHideBars
		SetToggleOptionValue(Option, Main.AutoHideBars)
	ElseIf (Option == SetSlowMoOrgasms)
		Main.SlowMoOnOrgasm = !Main.SlowMoOnOrgasm
		SetToggleOptionValue(Option, Main.SlowMoOnOrgasm)
	ElseIf (Option == SetOrgasmBoostsRel)
		Main.OrgasmIncreasesRelationship = !Main.OrgasmIncreasesRelationship
		SetToggleOptionValue(Option, Main.OrgasmIncreasesRelationship)
	ElseIf (Option == SetUseFades)
		Main.UseFades = !Main.UseFades
		SetToggleOptionValue(Option, Main.UseFades)
	ElseIf (Option == SetOnlyLightInDark)
		Main.LowLightLevelLightsOnly = !Main.LowLightLevelLightsOnly
		SetToggleOptionValue(Option, Main.LowLightLevelLightsOnly)
	EndIf
EndEvent

Event OnOptionHighlight(Int Option)
	;Main.playTickSmall()
	If (Option == SetEndOnOrgasm)
		SetInfoText("End the Osex scene automatically when the dominant actor (usually the male) orgasms")
	ElseIf (Option == SetResetState)
		SetInfoText("Click this if you keep getting a Scene Already Running type error")
	ElseIf (Option == SetForceAIIfAttacked)
		SetInfoText("If using manual mode by default, this will force automatic mode to activate if the player is the victim in an aggressive scene")
	ElseIf (Option == SetForceAIIfAttacking)
		SetInfoText("If using manual mode by default, this will force automatic mode to activate if the player is the attacker in an aggressive scene")
	ElseIf (Option == SetForceAIInConsensualScenes)
		SetInfoText("If using manual mode by default, this will force automatic mode to activate in consensual scenes")
	ElseIf (Option == SetUseFades)
		SetInfoText("Fade the screen to black when a scene starts/ends")
	ElseIf (Option == SetUseCosaveWorkaround)
		SetInfoText("Some users appear to have a broken SKSE co-save setup\n This manifests itself as full-auto mode not working, and keys not saving\nThis will fix the symptoms of the issue if you have it, but not the core cause")
	ElseIf (Option == SetFreeCamFOV)
		SetInfoText("The field of view of the camera when in freecam mode\nThis is incompatible with Improved Camera")
	ElseIf (Option == SetUseRumble)
		SetInfoText("Rumble a controller on thrust, if a controller is being used")
	ElseIf (Option == SetStrongerUnequip)
		SetInfoText("Use an alternate unequip method that may catch more armor pieces, especially armor with auto-reequip scripts\nHowever, some armor it unequips may not be reequiped in redress\nHas no effect if drop clothes on to ground is enabled")
	ElseIf (Option == SetEndAfterActorHit)
		SetInfoText("End the scene after someone in the scene is hit\n Can misfire with certain other mods")
	ElseIf (Option == SetAnimateRedress)
		SetInfoText("Makes NPCs play redressing animations after a scene ends if they need to redress")
	ElseIf (Option == SetForceFirstPerson)
		SetInfoText("Return to first person after scene ends.\nFixes the hybrid-camera bug in Improved Camera")
	ElseIf (Option == SetCustomTimescale)
		SetInfoText("Changes the timescale during sex scenes, and reverts it back to what it was after the scene ends\nUseful if you don't want sex taking an entire day\n0 = this feature is disabled")
	ElseIf (Option == SetClipinglessFirstPerson)
		 SetInfoText("REQUIRES: Improved Camera, my custom ini settings file\nExperience first person without any clipping")
	ElseIf (Option == SetActorSpeedControl)
		SetInfoText("Let actors increase the scene speed on their own when their Excitement gets high enough \nThis feature is experimental, disable if Osex behaves strangely on it's own")
	ElseIf (Option == SetUndressIfNeed)
		SetInfoText("If actors' genitals are covered by clothes, this will auto-remove the clothes as soon as they need access to their genitals")
	ElseIf (Option == SetBedSearchDistance)
		SetInfoText("High values may increase animation start time")
	ElseIf (Option == SetBedAlgo)
		SetInfoText("Use a slower papyrus bed search method rather than a faster native one\n May find more beds but only enable if a bed is not detected")
	ElseIf (Option == SetUseAutoFades)
		SetInfoText("Fade to black in between animation transitions")
	ElseIf (Option == SetAIChangeChance)
		SetInfoText("Chance that characters will switch animations mid scene\nDoes not affect chance of a foreplay -> full sex transition")
	ElseIf (Option == SetFlipFix)
		SetInfoText("Fix some third party animations being flipped 180 degrees")
	ElseIf (Option == SetDropClothes)
		SetInfoText("Characters will drop clothes they take off onto the ground instead of storing them in their inventory\nCharacters will automatically pick them up when redressing")
	ElseIf (Option == SetAlwaysUndressAtStart)
		SetInfoText("Actors will always get undressed as a scene starts \nMods using this mod's API can force an undress to occur even if this isn't checked")
	ElseIf (Option == SetAlwaysAnimateUndress)
		SetInfoText("Always play Osex's undressing animations instead of just removing the clothes normally\nNote: that Auto-Remove clothes will never use Osex's undress animation\nFurther note: Mods using this mod's API can force an animation to occur even if this isn't checked")
	ElseIf (Option == SetonlyUndressChest)
		SetInfoText("Only remove the chest piece during undressing\nNote: due to bugginess with Osex, if using Undress Animation, only the chest piece is currently removed even with this not checked")
	ElseIf (Option == SetDomBar)
		SetInfoText("Enable the on-screen bar that tracks the dominant actor's Excitement\nActor's orgasm when their Excitement maxes out")
	ElseIf (Option == SetthirdBar)
				SetInfoText("Enable the on-screen bar that tracks the third actor's Excitement\nActor's orgasm when their Excitement maxes out")
	ElseIf (Option == SetSubBar)
		SetInfoText("Enable the on-screen bar that tracks the second actor's Excitement\nActor's orgasm when their Excitement maxes out")
	ElseIf (Option == SetMisallignmentOption)
		SetInfoText("Enable automatic misalignment detection\nYou may want to disable this if you want to do some custom realigning.")
	ElseIf (Option == SetEnableBeds)
		SetInfoText("Actors will find the nearest bed to have sex on")
	ElseIf (Option == SetAIControl)
		SetInfoText("If enabled, scenes will play out on their own without user input via procedural generation\nNote: If you have only used Manual mode briefly or not at all, and never became adept with using it, I STRONGLY recommend you give manual mode a fair chance before using this")
	ElseIf (Option == SetAutoHideBar)
		SetInfoText("Automatically hide the bars during sex when not interacting with the UI")
	ElseIf (Option == SetSlowMoOrgasms)
		SetInfoText("Add in a few seconds of slowmotion right when the player orgasms\nUnrelated to this Option, if sexlab is installed, cum effects and sound effects will be extracted and used from it as well\nA reinstall may be needed to detect sexlab if installed after this mod")
	ElseIf (Option == SetOrgasmBoostsRel)
		SetInfoText("Giving orgasms to actors you have a relationship rank of 0 with will increase them to rank 1, marking them as a friend\nThis may open up unique options in some mods")
	ElseIf (Option == SetDomLightMode)
		SetInfoText("Enable light on main actor at animation start")
	ElseIf (Option == SetMute)
		SetInfoText("Mute sounds coming from the OSA engine\nYou should probably only disable this if you have a soundpack installed")
	ElseIf (Option == SetSubLightMode)
		SetInfoText("Enable light on second actor at animation start")
	ElseIf (Option == SetCameraSpeed)
		SetInfoText("The speed of the freecam")
	ElseIf (Option == SetUseFreeCam)
		SetInfoText("Automatically switch to freecam when a scene starts")
	ElseIf (Option == SetDefaultFOV)
		SetInfoText("The field of view to return to when a scene ends when using free cam")
	ElseIf (Option == SetDomLightBrightness)
		SetInfoText("Set main actor's light's brightness")
	ElseIf (Option == SetSubLightBrightness)
		SetInfoText("Set second actor's light's brightness")
	ElseIf (Option == SetControlToggle)
		SetInfoText("Press during an animation: switch between manual and full-auto control for the duration of that animation \n Press outside of animation: switch between manual and full-auto control permanently")
	ElseIf (Option == SetOnlyLightInDark)
		SetInfoText("Only use actor lights when the scene takes place in a dark area")
	ElseIf (Option == SetRebuildDatabase)
		SetInfoText("This will rebuild OStim's internal animation database.\n You only need to click this if you have installed or uninstalled an animation pack MID-playthrough\n The animation database is automatically built at the start of a new playthrough")
	ElseIf (Option == SetsexExcitementMult)
		SetInfoText("Multiply all the pleasure/second received by actors by this amount\nThis effectively lets you choose how long you want sex to last\n3.0 = 3 times shorter, 0.1 = 10 times longer")
	ElseIf (Option == SetKeymap)
		SetInfoText("Press this while looking at an actor to start OStim.\nStarting OSex through OSA will result in normal OSex instead\nOStim is intended to be played with mods that integrate it into the game instead of using this option")
	ElseIf (Option == SetKeyUp)
		SetInfoText("Increase speed during OStim scene\nThe default key (numpad +) conflicts with many mods, may need to remap")
	ElseIf (Option == SetKeyDown)
		SetInfoText("Decrease speed during OStim scene\nThe default key (numpad -) conflicts with many mods, may need to remap")
	ElseIf (Option == SetUseScreenShake)
		SetInfoText("Use extra screenshake on thrust\n This is not compatible with Improved Camera's first person")
	ElseIf (Option == SetBedReallignment)
		SetInfoText("Move actors forward/back by this amount on a bed")
	ElseIf (Option == SetPullOut)
		SetInfoText("Only usable in manual mode\nWhen pressed during a sexual animation, causes your character to immediately cancel and \"pull out\" of the current animation")
	ElseIf (Option == SetThanks)
		SetInfoText("Thank you for downloading OStim\nLeave a comment and also share it with others online if you enjoy it, to help others find it")
	EndIf
EndEvent

Event OnOptionMenuOpen(Int Option)
	Main.PlayTickBig()
	If (Option == SetDomLightmode)
		SetMenuDialogOptions(DomLightModeList)
		;SetMenuDialogStartIndex(DifficultyIndex)
		;SetMenuDialogDefaultIndex(1)
	ElseIf (Option == SetSubLightMode)
		SetMenuDialogOptions(SubLightModeList)
	ElseIf (Option == SetDomLightBrightness)
		SetMenuDialogOptions(DomLightBrightList)
	ElseIf (Option == SetSubLightBrightness)
		SetMenuDialogOptions(SubLightBrightList)
	EndIf
EndEvent

Event OnOptionMenuAccept(Int Option, Int Index)
	Main.PlayTickBig()
	If (Option == SetDomLightMode)
		Main.DomLightPos = Index
		SetMenuOptionValue(SetDomLightMode, DomLightModeList[Index])
	ElseIf (Option == SetSubLightMode)
		Main.SubLightPos = Index
		SetMenuOptionValue(Option, SubLightModeList[Index])
	ElseIf (Option == SetDomLightBrightness)
		Main.DomLightBrightness = Index
		SetMenuOptionValue(Option, DomLightBrightList[Index])
	ElseIf (Option == SetSubLightBrightness)
		Main.SubLightBrightness = Index
		SetMenuOptionValue(Option, SubLightBrightList[Index])
	EndIf
EndEvent

Event OnOptionSliderOpen(Int Option)
	Main.PlayTickBig()
	If (Option == SetSexExcitementMult)
		SetSliderDialogStartValue(Main.SexExcitementMult)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.1, 3.0)
		SetSliderDialogInterval(0.1)
	ElseIf (Option == SetBedSearchDistance)
		SetSliderDialogStartValue(Main.BedSearchDistance)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(1, 30)
		SetSliderDialogInterval(1)
	ElseIf (Option == SetCustomTimescale)
		SetSliderDialogStartValue(Main.CustomTimescale)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0, 40)
		SetSliderDialogInterval(1)
	ElseIf (Option == SetFreeCamFOV)
		SetSliderDialogStartValue(Main.FreecamFOV)
		SetSliderDialogDefaultValue(45.0)
		SetSliderDialogRange(1, 120)
		SetSliderDialogInterval(1)
	ElseIf (Option == SetDefaultFOV)
		SetSliderDialogStartValue(Main.DefaultFOV)
		SetSliderDialogDefaultValue(85.0)
		SetSliderDialogRange(1, 120)
		SetSliderDialogInterval(1)
	ElseIf (Option == SetCameraSpeed)
		SetSliderDialogStartValue(Main.FreecamSpeed)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(1, 20)
		SetSliderDialogInterval(1)
	ElseIf (Option == SetBedReallignment)
		SetSliderDialogStartValue(Main.BedReallignment)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(-250, 250)
		SetSliderDialogInterval(1)
	ElseIf (Option == SetAIChangeChance)
		SetSliderDialogStartValue(Main.AiSwitchChance)
		SetSliderDialogDefaultValue(6.0)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndIf
EndEvent

Event OnOptionSliderAccept(Int Option, Float Value)
	Main.PlayTickBig()
	If (Option == SetSexExcitementMult)
		Main.SexExcitementMult = Value
		SetSliderOptionValue(SetsexExcitementMult, Value, "{2} x")
	ElseIf (Option == SetBedSearchDistance)
		Main.BedSearchDistance = (Value as Int)
		SetSliderOptionValue(Option, Value, "{0} meters")
	ElseIf (Option == SetCustomTimescale)
		Main.CustomTimescale = (Value as Int)
		SetSliderOptionValue(Option, Value, "{0}")
	ElseIf (Option == SetFreeCamFOV)
		Main.FreecamFOV = (Value as Int)
		SetSliderOptionValue(Option, Value, "{0}")
	ElseIf (Option == SetDefaultFOV)
		Main.DefaultFOV = (Value as Int)
		SetSliderOptionValue(Option, Value, "{0}")
	ElseIf (Option == SetCameraSpeed)
		Main.FreecamSpeed = (Value as Int)
		SetSliderOptionValue(Option, Value, "{0}")
	ElseIf (Option == SetBedReallignment)
		Main.BedReallignment = (Value as Int)
		SetSliderOptionValue(Option, Value, "{0} units")
	ElseIf (Option == SetAIChangeChance)
		Main.AiSwitchChance = (Value as Int)
		SetSliderOptionValue(Option, Value, "{0}")
	EndIf
EndEvent

Event OnOptionKeyMapChange(Int Option, Int KeyCode, String ConflictControl, String ConflictName)
	Main.PlayTickBig()
	If (Option == Setkeymap)
		Main.RemapStartKey(KeyCode)
		SetKeyMapOptionValue(Option, KeyCode)
	ElseIf (Option == SetKeyUp)
		Main.RemapSpeedUpKey(KeyCode)
		SetKeyMapOptionValue(Option, KeyCode)
	ElseIf (Option == SetKeyDown)
		Main.RemapSpeedDownKey(KeyCode)
		SetKeyMapOptionValue(Option, KeyCode)
	ElseIf (Option == SetPullOut)
		Main.RemapPulloutKey(KeyCode)
		SetKeyMapOptionValue(Option, KeyCode)
	ElseIf (Option == SetControlToggle)
		Main.RemapControlToggleKey(KeyCode)
		SetKeyMapOptionValue(Option, KeyCode)
	EndIf
EndEvent

Event OnGameReload()
	Parent.OnGameReload()
EndEvent

Bool Color1
Function AddColoredHeader(String In)
	String Blue = "#6699ff"
	String Pink = "#ff3389"
	String Color
	If Color1
		Color = Pink
		Color1 = False
	Else
		Color = Blue
		Color1 = True
	EndIf

	AddHeaderOption("<font color='" + Color +"'>" + In)
EndFunction
