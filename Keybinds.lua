ui.add_sliderint("X", 0, engine.get_screen_width())
ui.add_sliderint("Y", 0, engine.get_screen_height())
ui.add_colorpicker("Color")

local font = render.setup_font("Verdana", 12, fontflags.noantialiasing)

local allBinds = {
    { name = "Double Tap", active = keybinds.double_tap, alpha = 0, y = 0 },
    { name = "Hide Shots", active = keybinds.hide_shots, alpha = 0, y = 0 },
    { name = "Anti-aim inverter", active = keybinds.flip_desync, alpha = 0, y = 0 },
    { name = "Slow walk", active = keybinds.slowwalk, alpha = 0, y = 0 },
    { name = "Thirdperson", active = keybinds.thirdperson, alpha = 0, y = 0 },
    { name = "Minimum damage", active = keybinds.damage_override, alpha = 0, y = 0 },
    { name = "Automatic peek", active = keybinds.automatic_peek, alpha = 0, y = 0 },
    { name = "Force body aim", active = keybinds.body_aim, alpha = 0, y = 0 },
    { name = "Force safe points", active = keybinds.safe_points, alpha = 0, y = 0 },
}

local function modeToString(mode)
    return mode and "[Toggled]" or "[Holding]"
end

cheat.RegisterCallback("on_paint", function()
    
    -- Variables
    local bindPosition = { ui.get_int("X"), ui.get_int("Y") }
    local bindSize = { 165, 21 }
    local bindOffset = 0
    local color = ui.get_color("Color")

    render.rect_filled(bindPosition[1], bindPosition[2], bindSize[1], bindSize[2], color.new(0,0,0,170))
    render.rect_filled(bindPosition[1], bindPosition[2], bindSize[1], 1, color.new(color:r(),color:g(),color:b(), 255))

    render.text(font, bindPosition[1] + bindSize[1]/2 - render.get_text_width(font, "Keybinds")/2, bindPosition[2] + 4, color.new(255,255,255, 255), "Keybinds")

    for i = 1, #allBinds do
        local bindMode = ui.get_keybind_mode(allBinds[i].active)
        render.text(font, bindPosition[1] + 4, bindPosition[2] + 25 + allBinds[i].y - 15, color.new(255,255,255, allBinds[i].alpha), allBinds[i].name, true)
        render.text(font, bindPosition[1] + bindSize[1] - render.get_text_width(font, modeToString(bindMode)) - 4, bindPosition[2] + 25 + allBinds[i].y - 15, color.new(255,255,255, allBinds[i].alpha), modeToString(bindMode), true)   

        if ui.get_keybind_state(allBinds[i].active) then
            allBinds[i].alpha = animate.lerp(allBinds[i].alpha, 255, 0.1)
            bindOffset = bindOffset + 15
            allBinds[i].y = animate.lerp(allBinds[i].y, bindOffset, 0.1)
        else
            allBinds[i].alpha = animate.lerp(allBinds[i].alpha, 0, 0.1)
        end
    end

end)



