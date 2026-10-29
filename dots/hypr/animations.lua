-- Frost-Phoenix appearance settings

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 1,

        col = {
            active_border = {
                colors = {
                    "rgba(98971Aff)",
                    "rgba(CC241Dff)",
                },
                angle = 45,
            },
            inactive_border = "rgba(00000000)",
        },
    },

    decoration = {
        rounding = 0,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 20,
            render_power = 3,
            offset = { 0, 2 },
            color = "rgba(00000055)",
        },

        blur = {
            enabled = true,
            size = 3,
            noise = 0,
            passes = 2,
            contrast = 1.4,
            brightness = 1,
            xray = true,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Animation curves

hl.curve("fluent_decel", {
    type = "bezier",
    points = { { 0, 0.2 }, { 0.4, 1 } },
})

hl.curve("easeOutCirc", {
    type = "bezier",
    points = { { 0, 0.55 }, { 0.45, 1 } },
})

hl.curve("easeOutCubic", {
    type = "bezier",
    points = { { 0.33, 1 }, { 0.68, 1 } },
})

hl.curve("fade_curve", {
    type = "bezier",
    points = { { 0, 0.55 }, { 0.45, 1 } },
})

-- Window animations

hl.animation({
    leaf = "windowsIn",
    enabled = false,
})

hl.animation({
    leaf = "windowsOut",
    enabled = false,
})

hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 2,
    bezier = "fluent_decel",
    style = "slide",
})

-- Fade animations

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 3,
    bezier = "fade_curve",
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 3,
    bezier = "fade_curve",
})

hl.animation({
    leaf = "fadeSwitch",
    enabled = false,
})

hl.animation({
    leaf = "fadeShadow",
    enabled = true,
    speed = 10,
    bezier = "easeOutCirc",
})

hl.animation({
    leaf = "fadeDim",
    enabled = true,
    speed = 4,
    bezier = "fluent_decel",
})

-- Workspace animations

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4,
    bezier = "easeOutCubic",
    style = "fade",
})
