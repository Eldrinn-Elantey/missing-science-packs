local util = require("util")

local ROOT_NAME = "msp_root"
local PANEL_NAME = "msp_panel"
local LABEL_NAME = "msp_label"

-- Offsets that place the row inside the padding added to the research bar in data.lua.
local PANEL_WIDTH = 256
local PANEL_TOP = 46
local REMOTE_VIEW_EXTRA_TOP = 40
local REMOTE_VIEW_RIGHT_MARGIN = 12

local UPDATE_INTERVAL = 60

local function cache_lab_inputs()
  storage.lab_inputs = {}
  for name, prototype in pairs(prototypes.get_entity_filtered({{filter = "type", type = "lab"}})) do
    storage.lab_inputs[name] = util.list_to_map(prototype.lab_inputs or {})
  end
end

local function register_lab(event)
  local entity = event.entity or event.destination
  if entity and entity.valid and entity.type == "lab" then
    storage.labs[entity.unit_number] = entity
  end
end

local function register_all_labs()
  storage.labs = {}
  for _, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered({type = "lab"})) do
      storage.labs[entity.unit_number] = entity
    end
  end
end

local function destroy_all_guis()
  for _, player in pairs(game.players) do
    local root = player.gui.screen[ROOT_NAME]
    if root then root.destroy() end
  end
end

local function lab_can_research(lab_name, ingredients)
  local inputs = storage.lab_inputs[lab_name]
  if not inputs then return false end
  for _, ingredient in ipairs(ingredients) do
    if not inputs[ingredient.name] then return false end
  end
  return true
end

local function count_missing_packs(force, ingredients)
  local counts = {}
  local force_index = force.index
  local missing_status = defines.entity_status.missing_science_packs

  for unit_number, lab in pairs(storage.labs) do
    if not lab.valid then
      storage.labs[unit_number] = nil
    elseif lab.force.index == force_index
      and lab.status == missing_status
      and lab_can_research(lab.name, ingredients) then
      local inventory = lab.get_inventory(defines.inventory.lab_input)
      -- Empty labs are usually unsupplied on purpose, so they would only add noise.
      if inventory and not inventory.is_empty() then
        local present = {}
        for _, item in ipairs(inventory.get_contents()) do
          present[item.name] = true
        end
        for _, ingredient in ipairs(ingredients) do
          if not present[ingredient.name] then
            counts[ingredient.name] = (counts[ingredient.name] or 0) + 1
          end
        end
      end
    end
  end

  return counts
end

local function build_caption(force)
  local research = force.current_research
  if not research then return "" end

  local ingredients = research.research_unit_ingredients
  local counts = count_missing_packs(force, ingredients)
  local parts = {}
  for _, ingredient in ipairs(ingredients) do
    local count = counts[ingredient.name]
    if count then
      parts[#parts + 1] = string.format("[img=item/%s]%d", ingredient.name, count)
    end
  end
  return table.concat(parts, " ")
end

local function resize_root(player)
  local root = player.gui.screen[ROOT_NAME]
  if not root then return end
  root.style.width = player.display_resolution.width / player.display_scale
  root.style.height = player.display_resolution.height / player.display_scale
end

local function get_or_create_panel(player)
  local root = player.gui.screen[ROOT_NAME]
  if not root then
    root = player.gui.screen.add({
      type = "frame",
      name = ROOT_NAME,
      style = "msp_root_frame",
      direction = "horizontal",
      ignored_by_interaction = true,
    })
    local panel = root.add({
      type = "frame",
      name = PANEL_NAME,
      style = "msp_panel_frame",
      direction = "horizontal",
    })
    panel.add({type = "label", name = LABEL_NAME})
    resize_root(player)
  end

  -- Styles are reapplied on every update so panels saved by an older layout pick up the new one.
  local panel = root[PANEL_NAME]
  panel.style.width = PANEL_WIDTH
  panel.style.margin = 0
  panel.style.padding = 8
  panel.style.left_padding = 9
  local remote = player.controller_type == defines.controllers.remote
  panel.style.top_padding = remote and PANEL_TOP + REMOTE_VIEW_EXTRA_TOP or PANEL_TOP
  panel.style.right_margin = remote and REMOTE_VIEW_RIGHT_MARGIN or 0

  return panel
end

local function update_all_players()
  if script.level.is_simulation then return end

  local captions = {}
  for _, player in pairs(game.connected_players) do
    local force_index = player.force.index
    if not captions[force_index] then
      captions[force_index] = build_caption(player.force)
    end
    local caption = captions[force_index]
    local panel = get_or_create_panel(player)
    panel[LABEL_NAME].caption = caption
    panel.visible = caption ~= ""
  end
end

local function on_display_changed(event)
  local player = game.get_player(event.player_index)
  if player then resize_root(player) end
end

script.on_init(function()
  cache_lab_inputs()
  register_all_labs()
end)

script.on_configuration_changed(function()
  cache_lab_inputs()
  register_all_labs()
  destroy_all_guis()
end)

local lab_filter = {{filter = "type", type = "lab"}}
for _, event in ipairs({
  defines.events.on_built_entity,
  defines.events.on_robot_built_entity,
  defines.events.on_space_platform_built_entity,
  defines.events.script_raised_built,
  defines.events.script_raised_revive,
  defines.events.on_entity_cloned,
}) do
  script.on_event(event, register_lab, lab_filter)
end

for _, event in ipairs({
  defines.events.on_research_started,
  defines.events.on_research_finished,
  defines.events.on_research_cancelled,
  defines.events.on_player_controller_changed,
}) do
  script.on_event(event, update_all_players)
end

script.on_event(defines.events.on_player_display_resolution_changed, on_display_changed)
script.on_event(defines.events.on_player_display_scale_changed, on_display_changed)

script.on_nth_tick(UPDATE_INTERVAL, update_all_players)
