-------------
-- HEADERS --
-------------

local color_schemes = require('color-schemes')
local choices = require("choices")

pcgraphics = "__palettecleanser__/graphics"

-- READ MAIN COLOR SCHEME SETTING
if settings.startup["palette-cleanser-color-scheme"].value == choices.color_scheme.deuteranopia then
    active_scheme = color_schemes["deuteranopia"]
elseif settings.startup["palette-cleanser-color-scheme"].value == choices.color_scheme.custom then
    active_scheme = color_schemes["custom"]
end



--------------
-- OVERLAYS --
--------------

-- TECH GUI
if settings.startup["palette-cleanser-technology-gui"] then
    -- Forked __core__/graphics/gui-new.png, edited the technology gui palette,
    --   and saved as custom png.  Be conservative with png optimization here;
    --   this file affects ALL GUI elements in the game.
    --   Tech GUI palette: {x = 296, y = 136} to {x = 414, y = 220}
--    data.raw["gui-style"].default.default_tileset = pcgraphics.."/gui-new.png"
    -- If this causes any conflicts in the future, we could rework this section
    --   to use greyscale Tech GUI squares {x, 204} with tint added.
end

-- TURRETS AND GRENADES
if settings.startup["palette-cleanser-enable-turret-range"].value then
    -- Grenade radius in both world and map view
    data.raw["utility-constants"].default.capsule_range_visualization_color = active_scheme.grenade_range_tint
    -- Turret radius in world view
    data.raw["utility-constants"].default.turret_range_visualization_color = active_scheme.turret_range_world_color
    -- Turret radius in map view
    data.raw["utility-constants"].default.chart.turret_range_color = active_scheme.turret_range_chart_color
    -- Artillery radius (map view only)
    data.raw["utility-constants"].default.chart.artillery_range_color = active_scheme.artillery_range_chart_color
end

-- ROBOPORTS
if settings.startup["palette-cleanser-enable-roboport-area"].value then
    data.raw["utility-sprites"].default.logistic_radius_visualization.filename = pcgraphics.."/overlay/visualization-logistic-radius.png"
    data.raw["utility-sprites"].default.logistic_radius_visualization.tint = active_scheme.roboport_logistic_range_color
    data.raw["utility-sprites"].default.construction_radius_visualization.filename = pcgraphics.."/overlay/visualization-construction-radius.png"
    data.raw["utility-sprites"].default.construction_radius_visualization.tint = active_scheme.roboport_construction_range_color
end

-- POLLUTION
-- Disabled but maintained in case someone requests it
-- if settings.startup["palette-cleanser-enable-pollution-cloud"].value then
--     -- Pollution overlay might be okay in 0.17 since they increased color
--     --   contrast; leaving commented code here for reference in case it's
--     --   requested
--     data.raw["utility-sprites"].default.pollution_visualization.filename = pcgraphics.."/pollution-visualization.png"
--     data.raw["utility-sprites"].default.pollution_visualization.tint = active_scheme.pollution_cloud_color
-- end

-- ELECTRIC POLES AND MINING DRILLS
if settings.startup["palette-cleanser-enable-electric-pole-drill"].value then
    data.raw['electric-pole']['small-electric-pole'].radius_visualisation_picture.filename = pcgraphics.."/overlay/electric-pole-radius-visualization.png"
    data.raw['electric-pole']['small-electric-pole'].radius_visualisation_picture.tint = active_scheme.elec_pole_small_area_color
    data.raw['electric-pole']['medium-electric-pole'].radius_visualisation_picture.filename = pcgraphics.."/overlay/electric-pole-radius-visualization.png"
    data.raw['electric-pole']['medium-electric-pole'].radius_visualisation_picture.tint = active_scheme.elec_pole_medium_area_color
    data.raw['electric-pole']['big-electric-pole'].radius_visualisation_picture.filename = pcgraphics.."/overlay/electric-pole-radius-visualization.png"
    data.raw['electric-pole']['big-electric-pole'].radius_visualisation_picture.tint = active_scheme.elec_pole_big_area_color
    data.raw['electric-pole']['substation'].radius_visualisation_picture.filename = pcgraphics.."/overlay/electric-pole-radius-visualization.png"
    data.raw['electric-pole']['substation'].radius_visualisation_picture.tint = active_scheme.elec_pole_substation_area_color
    -- Mining Drill area overlay currently shifts off-center when specifying a
    --   PNG file.  Needs further debugging.  For now, the tint effectively
    --   enhances mining drill area contrast.
    -- data.raw['mining-drill']['electric-mining-drill'].radius_visualisation_picture.filename = pcgraphics.."/electric-mining-drill-radius-visualization.png"
    data.raw['mining-drill']['electric-mining-drill'].radius_visualisation_picture.tint = active_scheme.mining_drill_area_color
end

-- MAP RESOURCE COLORS AND TERRAIN COLORS
if settings.startup["palette-cleanser-enable-resources-terrain"].value then
    data.raw["resource"]["crude-oil"].map_color = active_scheme.crude_oil_chart_color
    data.raw["resource"]["iron-ore"].map_color = active_scheme.iron_ore_chart_color
    data.raw["resource"]["copper-ore"].map_color = active_scheme.copper_ore_chart_color
    data.raw["resource"]["stone"].map_color = active_scheme.stone_chart_color
    data.raw.tile["sand-1"].map_color = active_scheme.sand_1_chart_color
    data.raw.tile["sand-2"].map_color = active_scheme.sand_2_chart_color
    data.raw.tile["sand-3"].map_color = active_scheme.sand_3_chart_color
    data.raw["cliff"]["cliff"].map_color = active_scheme.cliff_chart_color
    data.raw["utility-constants"].default.chart.default_color_by_type["tree"] = active_scheme.tree_chart_color
end



---------------------
-- ITEMS & RECIPES --
---------------------

-- FLUIDS
if settings.startup["palette-cleanser-enable-fluids"].value then
    -- Invert and/or adjust some fluid colors so they're easier to identify in
    --   pipes and tanks
    data.raw["fluid"]["petroleum-gas"].base_color = active_scheme.petroleum_gas_base_color
    data.raw["fluid"]["petroleum-gas"].flow_color = active_scheme.petroleum_gas_flow_color
    data.raw["fluid"]["light-oil"].base_color = active_scheme.light_oil_base_color
    data.raw["fluid"]["light-oil"].flow_color = active_scheme.light_oil_flow_color
    data.raw["fluid"]["sulfuric-acid"].base_color = active_scheme.sulfuric_acid_base_color
    data.raw["fluid"]["sulfuric-acid"].flow_color = active_scheme.sulfuric_acid_flow_color
    data.raw["fluid"]["lubricant"].base_color = active_scheme.lubricant_base_color
    data.raw["fluid"]["lubricant"].flow_color = active_scheme.lubricant_flow_color

    -- Create dynamically tinted prototype icons for light oil, using the
    --   method described here:
    --   (https://forums.factorio.com/viewtopic.php?t=60558)
    -- Note: Barrelling icons are adjusted in data-updates.lua

    data.raw["fluid"]["light-oil"].icon_size = 32
    data.raw["fluid"]["light-oil"].icons = {
        {
            icon = pcgraphics.."/icons/generic-fluid.png",
            icon_size = 32,
            tint = active_scheme.light_oil_base_color
        },

    }
    data.raw["recipe"]["heavy-oil-cracking"].icon_size = 32
    data.raw["recipe"]["heavy-oil-cracking"].icons = {
        {
            -- Use a blank base for your icon to prevent scaling problems in
            --   crafting menu, but don't make it blank - make it a small ~16px
            --   white oval with 1% alpha.  Otherwise the icon won't have that
            --   nice dark alt-mode background on assembling machines and
            --   chemical plants.
            --   (https://forums.factorio.com/viewtopic.php?f=48&t=69221&start=20#p450447)

            icon = pcgraphics.."/icons/AlmostBlank32.png",
            icon_size = 32,
        },
        {
            icon = data.raw["fluid"]["heavy-oil"].icon,
            icon_size = 32,
            scale = 0.75,
            shift = {0,-4}
        },
        {
            icon = pcgraphics.."/icons/generic-fluid.png",
            icon_size = 32,
            tint = active_scheme.light_oil_base_color,
            scale = 0.5,
            shift = {-10,8}
        },
        {
            icon = pcgraphics.."/icons/generic-fluid.png",
            icon_size = 32,
            tint = active_scheme.light_oil_base_color,
            scale = 0.5,
            shift = {10,8}
        }
    }
    data.raw["recipe"]["light-oil-cracking"].icon_size = 32
    data.raw["recipe"]["light-oil-cracking"].icons = {
        {
            icon = pcgraphics.."/icons/AlmostBlank32.png",
            icon_size = 32,
        },
        {
            icon = pcgraphics.."/icons/generic-fluid.png",
            icon_size = 32,
            tint = active_scheme.light_oil_base_color,
            scale = 0.75,
            shift = {0,-4}
        },
        {
            icon = data.raw["fluid"]["petroleum-gas"].icon,
            icon_size = 32,
            scale = 0.4375,
            shift = {-9,11}
        },
        {
            icon = data.raw["fluid"]["petroleum-gas"].icon,
            icon_size = 32,
            scale = 0.4375,
            shift = {9,11}
        }
    }
    data.raw["recipe"]["solid-fuel-from-light-oil"].icon_size = 32
    data.raw["recipe"]["solid-fuel-from-light-oil"].icons = {
        {
            icon = data.raw["item"]["solid-fuel"].icon,
            icon_size = 32,
        },
        {
            icon = pcgraphics.."/icons/generic-fluid.png",
            icon_size = 32,
            tint = active_scheme.light_oil_base_color,
            scale = 0.75,
            shift = {9,5}
        }
    }

end

-- AMMO
if settings.startup["palette-cleanser-enable-ammo"].value then
    data.raw["ammo"]["explosive-cannon-shell"].icon = pcgraphics.."/icons/explosive-cannon-shell.png"
    data.raw["ammo"]["explosive-cannon-shell"].icon_size = 32
    data.raw["ammo"]["explosive-uranium-cannon-shell"].icon = pcgraphics.."/icons/explosive-uranium-cannon-shell.png"
    data.raw["ammo"]["explosive-uranium-cannon-shell"].icon_size = 32
end

-- CIRCUITS
if settings.startup["palette-cleanser-enable-circuits"].value then
    data.raw["item"]["electronic-circuit"].icon = pcgraphics.."/icons/electronic-circuit.png"
    data.raw["item"]["electronic-circuit"].icon_size = 32
    data.raw["item"]["advanced-circuit"].icon = pcgraphics.."/icons/advanced-circuit.png"
    data.raw["item"]["advanced-circuit"].icon_size = 32
    data.raw["item"]["processing-unit"].icon = pcgraphics.."/icons/processing-unit.png"
    data.raw["item"]["processing-unit"].icon_size = 32
end

-- LOGISTICS
if settings.startup["palette-cleanser-enable-logistics"].value then
   data.raw["item"]["active-provider-chest"].icon = pcgraphics.."/icons/logistic-chest-active-provider.png"
   data.raw["item"]["active-provider-chest"].icon_size = 32
  data.raw["logistic-container"]["active-provider-chest"].icon = pcgraphics.."/icons/logistic-chest-active-provider.png"
    data.raw["logistic-container"]["active-provider-chest"].icon_size = 32
    data.raw["logistic-container"]["active-provider-chest"].animation.layers[1].filename =pcgraphics.."/entity/logistic-chest/hr-logistic-chest-active-provider.png"

    data.raw["item"]["requester-chest"].icon = pcgraphics.."/icons/logistic-chest-requester.png"
    data.raw["item"]["requester-chest"].icon_size = 32
    data.raw["logistic-container"]["requester-chest"].icon = pcgraphics.."/icons/logistic-chest-requester.png"
    data.raw["logistic-container"]["requester-chest"].icon_size = 32
    data.raw["logistic-container"]["requester-chest"].animation.layers[1].filename =pcgraphics.."/entity/logistic-chest/hr-logistic-chest-requester.png"

    data.raw["item"]["bulk-inserter"].icon = pcgraphics.."/icons/stack-inserter.png"
    data.raw["item"]["bulk-inserter"].icon_size = 32
    data.raw["inserter"]["bulk-inserter"].icon = pcgraphics.."/icons/stack-inserter.png"
    data.raw["inserter"]["bulk-inserter"].icon_size = 32
    data.raw["inserter"]["bulk-inserter"].hand_base_picture.filename =pcgraphics.."/entity/stack-inserter/hr-stack-inserter-hand-base.png"
    data.raw["inserter"]["bulk-inserter"].hand_closed_picture.filename =pcgraphics.."/entity/stack-inserter/hr-stack-inserter-hand-closed.png"
    data.raw["inserter"]["bulk-inserter"].hand_open_picture.filename =pcgraphics.."/entity/stack-inserter/hr-stack-inserter-hand-open.png"
    data.raw["inserter"]["bulk-inserter"].platform_picture.sheet.filename =pcgraphics.."/entity/stack-inserter/hr-stack-inserter-platform.png"

end

-- WIRES

local bhighlight = false
if settings.startup["palette-cleanser-preserve-wire-color-highlight"].value then
    -- Preserve wire colors during highlight, at the cost of highlight contrast
    bhighlight = true
else
    bhighlight = false
end

if settings.startup["palette-cleanser-enable-thick-wires"].value then
    -- Use thicker shadows
    data.raw["utility-sprites"].default.wire_shadow.filename = pcgraphics.."/entity/signal-wire/hr-wire-shadow-thick.png"

    -- Change copper wire color/thickness
    data.raw["utility-sprites"].default.copper_wire.filename = pcgraphics.."/entity/signal-wire/hr-copper-wire-thick.png"

    if settings.startup["palette-cleanser-signal-wire-mode"].value == choices.wire_mode.redblue then
        -- use thicker wires, and replace green with blue
        data.raw["item"]["green-wire"].icon = pcgraphics.."/icons/blue-wire.png"
        data.raw["item"]["green-wire"].icon_size = 32

        -- swap signal channel indicators in info panels
        data.raw["gui-style"].default.green_circuit_network_content_slot.default_graphical_set.position = {221, 36}

        data.raw["utility-sprites"].default.red_wire.filename = pcgraphics.."/entity/signal-wire/hr-red-wire-thick.png"
        if bhighlight then
            data.raw["utility-sprites"].default.red_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-red-wire-highlight-thick.png"
        else
            data.raw["utility-sprites"].default.red_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-wire-highlight-thick.png"
        end

        data.raw["utility-sprites"].default.green_wire.filename = pcgraphics.."/entity/signal-wire/hr-blue-wire-thick.png"
        if bhighlight then
            data.raw["utility-sprites"].default.green_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-blue-wire-highlight-thick.png"
        else
            data.raw["utility-sprites"].default.green_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-wire-highlight-thick.png"
        end

    elseif settings.startup["palette-cleanser-signal-wire-mode"].value == choices.wire_mode.bluegreen then
        -- use thicker wires, and replace red with blue
        data.raw["item"]["red-wire"].icon = pcgraphics.."/icons/blue-wire.png"
        data.raw["item"]["red-wire"].icon_size = 32

        -- swap signal channel indicators in info panels
        data.raw["gui-style"].default.red_circuit_network_content_slot.default_graphical_set.position = {221, 36}

        data.raw["utility-sprites"].default.red_wire.filename = pcgraphics.."/entity/signal-wire/hr-blue-wire-thick.png"
        if bhighlight then
            data.raw["utility-sprites"].default.red_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-blue-wire-highlight-thick.png"
        else
            data.raw["utility-sprites"].default.red_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-wire-highlight-thick.png"
        end

        data.raw["utility-sprites"].default.green_wire.filename = pcgraphics.."/entity/signal-wire/hr-green-wire-thick.png"
        if bhighlight then
            data.raw["utility-sprites"].default.green_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-green-wire-highlight-thick.png"
        else
            data.raw["utility-sprites"].default.green_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-wire-highlight-thick.png"
        end

    else -- redgreen
        -- use thicker wires but don't change colors
        data.raw["utility-sprites"].default.red_wire.filename = pcgraphics.."/entity/signal-wire/hr-red-wire-thick.png"
        if bhighlight then
            data.raw["utility-sprites"].default.red_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-red-wire-highlight-thick.png"
        else
            data.raw["utility-sprites"].default.red_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-wire-highlight-thick.png"
        end

        data.raw["utility-sprites"].default.green_wire.filename = pcgraphics.."/entity/signal-wire/hr-green-wire-thick.png"
        if bhighlight then
            data.raw["utility-sprites"].default.green_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-green-wire-highlight-thick.png"
        else
            data.raw["utility-sprites"].default.green_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-wire-highlight-thick.png"
        end

    end
else -- don't use thicker wires
    if settings.startup["palette-cleanser-signal-wire-mode"].value == choices.wire_mode.redblue then
        -- replace green with blue
        data.raw["item"]["green-wire"].icon = pcgraphics.."/icons/blue-wire.png"
        data.raw["item"]["green-wire"].icon_size = 32

        -- swap signal channel indicators in info panels
        data.raw["gui-style"].default.green_circuit_network_content_slot.default_graphical_set.position = {221, 36}

        if bhighlight then
            data.raw["utility-sprites"].default.red_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-red-wire-highlight.png"
        end

        data.raw["utility-sprites"].default.green_wire.filename = pcgraphics.."/entity/signal-wire/hr-blue-wire.png"
        if bhighlight then
            data.raw["utility-sprites"].default.green_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-blue-wire-highlight.png"
        end

    elseif settings.startup["palette-cleanser-signal-wire-mode"].value == choices.wire_mode.bluegreen then
        -- replace red with blue
        data.raw["item"]["red-wire"].icon = pcgraphics.."/icons/blue-wire.png"
        data.raw["item"]["red-wire"].icon_size = 32

        -- swap signal channel indicators in info panels
        data.raw["gui-style"].default.red_circuit_network_content_slot.default_graphical_set.position = {221, 36}

        data.raw["utility-sprites"].default.red_wire.filename = pcgraphics.."/entity/signal-wire/hr-blue-wire.png"
        if bhighlight then
            data.raw["utility-sprites"].default.red_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-blue-wire-highlight.png"
        end

        if bhighlight then
            data.raw["utility-sprites"].default.green_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-green-wire-highlight.png"
        end

    else -- redgreen
        -- don't change colors or thickness

        if bhighlight then
            data.raw["utility-sprites"].default.red_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-red-wire-highlight.png"
            data.raw["utility-sprites"].default.green_wire_highlight.filename = pcgraphics.."/entity/signal-wire/hr-green-wire-highlight.png"
        end

    end
end


--------------------
-- EVENT LISTENER --
--------------------

-- Listen for hotkey; run on_event function in control.lua to force map rechart
data:extend(
	{
		{
			type = "custom-input",
			name = "palette-cleanser-force-map-rechart",
			key_sequence = "CONTROL + M",
			consuming = "none"
		},
	}
)
