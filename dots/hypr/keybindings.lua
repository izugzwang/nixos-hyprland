-- Ana Tuş (Windows Tuşu)
local mainMod = "SUPER"

-- Uygulama Kısayolları (Doğrudan NixOS paketlerinle çalışır)
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"), { description = "Open the terminal" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave --enable-blink-features=MiddleClickAutoscroll --ozone-platform=wayland"), { description = "Open the browser" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"), { description = "Open the filemanager" })
hl.bind(mainMod .. " + CTRL + RETURN", hl.dsp.exec_cmd("rofi -show drun"), { description = "Open application launcher" })
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun"), { description = "Open application launcher (Alternatif)" })

-- Çalışma Alanları (Workspaces 1-10) - Lua for döngüsü!
for i = 1, 10 do
    local key = (i % 10) -- 10. workspace'i 0 tuşuna bağlar
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }), { description = "Focus workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
end

-- Pencere Yönetimi
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Kill active window" })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"), { description = "Force kill active window" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Toggle Fullscreen" })
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Toggle Maximize Window" })
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle Floating" })
hl.bind(mainMod .. " + ALT + T", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.pin())
end, { description = "Toggle floating + pinned" })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split" })
hl.bind(mainMod .. " + K", hl.dsp.layout("swapsplit"), { description = "Swapsplit" })
hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { description = "Toggle window group" })

-- Odak Değiştirme (Yön Tuşları)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }), { description = "Move focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }), { description = "Move focus up" })
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }), { description = "Move focus down" })

-- Fare ile Pencere Taşıma ve Boyutlandırma
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with the mouse" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with the mouse" })

-- Klavye ile Pencere Boyutlandırma (SUPER + SHIFT + Yön)
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true, description = "Increase window width" })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true, description = "Reduce window width" })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true, description = "Increase window height" })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true, description = "Reduce window height" })

-- Pencere Yer Değiştirme (SUPER + ALT + Yön)
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "l" }), { description = "Swap tiled window left" })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }), { description = "Swap tiled window right" })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "u" }), { description = "Swap tiled window up" })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "d" }), { description = "Swap tiled window down" })

-- Ekran Görüntüsü (Grim + Slurp ile doğrudan panoya kopyalar)
hl.bind(mainMod .. " + PRINT",   hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'), { description = "Area screenshot to clipboard" })
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd('entry=$(cliphist list | rofi -dmenu -p Clipboard -display-columns 2) && [ -n "$entry" ] && printf "%s\\n" "$entry" | cliphist decode | wl-copy'), { description = "Clipboard history" })
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'), { description = "Area screenshot to clipboard" })
hl.bind(mainMod .. " + ALT + F", hl.dsp.exec_cmd("grim - | wl-copy"), { description = "Fullscreen screenshot to clipboard" })

-- Waybar ve Sistem Yenileme
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("pkill waybar; waybar &"), { description = "Reload Waybar" })
hl.bind(mainMod .. " + CTRL + B",  hl.dsp.exec_cmd("pkill waybar || waybar &"), { description = "Toggle Waybar" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload hyprland config" })

-- Özel Çalışma Alanı (Scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"), { description = "Toggle scratchpad" })
hl.bind(mainMod .. " + SHIFT + S", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.move({ workspace = "special:scratchpad" }))
end, { description = "Move window to scratchpad" })

-- Fare Tekerleği ile Workspace Geçişi (Throttled)
hl.config({
    binds = {
        pass_mouse_when_bound = false,
        scroll_event_delay = 1,
    },
})

local scroll_locked = false
local function throttled_scroll(dispatcher)
    return function()
        if scroll_locked then return end
        scroll_locked = true
        hl.dispatch(dispatcher)
        hl.timer(function()
            scroll_locked = false
        end, { timeout = 200, type = "oneshot" })
    end
end

hl.bind(mainMod .. " + mouse_down", throttled_scroll(hl.dsp.focus({ workspace = "e+1" })), { description = "Next workspace" })
hl.bind(mainMod .. " + mouse_up",   throttled_scroll(hl.dsp.focus({ workspace = "e-1" })), { description = "Previous workspace" })

-- Laptop Multimedya ve Parlaklık Tuşları
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
