-------------
-- HEADERS --
-------------

local color_schemes = require('color-schemes')
local choices = require("choices")

-- READ MAIN COLOR SCHEME SETTING
if settings.startup["palette-cleanser-color-scheme"].value == choices.color_scheme.deuteranopia then
    active_scheme = color_schemes["deuteranopia"]
elseif settings.startup["palette-cleanser-color-scheme"].value == choices.color_scheme.custom then
    active_scheme = color_schemes["custom"]
end



---------------------
-- ITEMS & RECIPES --
---------------------

-- FLUIDS: barrelling recipe icons
if settings.startup["palette-cleanser-enable-fluids"].value then
    -- Fix barrel recipes to use our light-oil tint
    -- They're created in base data-updates.lua so we have to fix them here, too.
    data.raw["recipe"]["light-oil-barrel"].icon_size = 32
    data.raw["recipe"]["light-oil-barrel"].icons = {
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
            icon_size = 32
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
            icon_size = 32,
            tint = active_scheme.light_oil_base_color
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
            icon_size = 32,
            tint = active_scheme.light_oil_flow_color
        },
        {
            icon = "__palettecleanser__/graphics/icons/generic-fluid.png",
            icon_size = 32,
            tint = active_scheme.light_oil_base_color,
            scale = 0.5,
            shift = {4, -8}
        }
    }
    data.raw["recipe"]["empty-light-oil-barrel"].icon_size = 32
    data.raw["recipe"]["empty-light-oil-barrel"].icons = {
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png",
            icon_size = 32
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png",
            icon_size = 32,
            tint = active_scheme.light_oil_base_color
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png",
            icon_size = 32,
            tint = active_scheme.light_oil_flow_color
        },
        {
            icon = "__palettecleanser__/graphics/icons/generic-fluid.png",
            icon_size = 32,
            tint = active_scheme.light_oil_base_color,
            scale = 0.5,
            shift = {7, 8}
        }
    }
    data.raw["item"]["light-oil-barrel"].icons = {
        {
            icon = data.raw["item"]["barrel"].icon
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",
            tint = active_scheme.light_oil_base_color
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png",
            tint = active_scheme.light_oil_flow_color
        }
      }

end

