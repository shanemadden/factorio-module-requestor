local module_to_insert_functions = {
  ["speed-module-requestor"] = function(event)
    local player = game.players[event.player_index]
    if global[event.player_index] and global[event.player_index][event.item] then
      if global[event.player_index][event.item] == 3 then
        return "speed-module-3"
      elseif global[event.player_index][event.item] == 2 then
        return "speed-module-2"
      elseif global[event.player_index][event.item] == 1 then
        return "speed-module"
      end
    else
      if player.force.technologies["speed-module-3"].researched then
        return "speed-module-3"
      elseif player.force.technologies["speed-module-2"].researched then
        return "speed-module-2"
      elseif player.force.technologies["speed-module"].researched then
        return "speed-module"
      end
    end
  end,
  ["efficiency-module-requestor"] = function(event)
    local player = game.players[event.player_index]
    if global[event.player_index] and global[event.player_index][event.item] then
      if global[event.player_index][event.item] == 3 then
        return "effectivity-module-3"
      elseif global[event.player_index][event.item] == 2 then
        return "effectivity-module-2"
      elseif global[event.player_index][event.item] == 1 then
        return "effectivity-module"
      end
    else
      if player.force.technologies["effectivity-module-3"].researched then
        return "effectivity-module-3"
      elseif player.force.technologies["effectivity-module-2"].researched then
        return "effectivity-module-2"
      elseif player.force.technologies["effectivity-module"].researched then
        return "effectivity-module"
      end
    end
  end,
  ["productivity-module-requestor"] = function(event)
    local player = game.players[event.player_index]
    if global[event.player_index] and global[event.player_index][event.item] then
      if global[event.player_index][event.item] == 3 then
        return "productivity-module-3"
      elseif global[event.player_index][event.item] == 2 then
        return "productivity-module-2"
      elseif global[event.player_index][event.item] == 1 then
        return "productivity-module"
      end
    else
      if player.force.technologies["productivity-module-3"].researched then
        return "productivity-module-3"
      elseif player.force.technologies["productivity-module-2"].researched then
        return "productivity-module-2"
      elseif player.force.technologies["productivity-module"].researched then
        return "productivity-module"
      end
    end
  end,
  ["custom-module-requestor"] = function(event)
    if global[event.player_index] then
      return global[event.player_index].custom
    end
  end,
}

local function fill_selected_entities(event)
  local module_to_insert = module_to_insert_functions[event.item](event)
  if not module_to_insert then
    return
  end
  local player = game.players[event.player_index]
  for _, entity in pairs(event.entities) do
    local module_inventory = entity.get_module_inventory()
    if module_inventory then
      local count = 0
      for i = 1, entity.prototype.module_inventory_size do
        local stack = module_inventory[i]
        if not stack.valid_for_read then
          if stack.can_set_stack({ name = module_to_insert, count = 1 }) then
            count = count + 1
          end
        end
      end
      if count > 0 then
        local existing_request = entity.surface.find_entity("item-request-proxy", entity.position)
        if existing_request then
          existing_request.destroy()
        end
        entity.surface.create_entity({
          name = "item-request-proxy",
          position = entity.position,
          force = entity.force,
          target = entity,
          modules = { [module_to_insert] = count },
        })
        entity.last_user = player
      end
    end
  end
end

local function on_player_selected_area(event)
  if module_to_insert_functions[event.item] then
    fill_selected_entities(event)
  end
end
script.on_event(defines.events.on_player_selected_area, on_player_selected_area)

local function on_player_alt_selected_area(event)
  if module_to_insert_functions[event.item] then
    local player = game.players[event.player_index]
    for _, entity in pairs(event.entities) do
      local module_inventory = entity.get_module_inventory()
      if module_inventory then
        local existing_request = entity.surface.find_entity("item-request-proxy", entity.position)
        if existing_request then
          existing_request.destroy()
        end
        for item_name, item_count in pairs(module_inventory.get_contents()) do
          local removed_count = module_inventory.remove({ name = item_name, count = item_count })
          entity.surface.spill_item_stack(entity.position, { name = item_name, count = removed_count }, nil, entity.force)
        end
        entity.last_user = player
      end
    end
  end
end
script.on_event(defines.events.on_player_alt_selected_area, on_player_alt_selected_area)

local draw_gui_functions = {
  ["speed-module-requestor"] = function(event)
    local player = game.players[event.player_index]
    local frame = player.gui.center.add({
      name = "module_requestor_config",
      type = "frame",
      direction = "vertical",
    })
    if not global.open_item then
      global.open_item = {}
    end
    global.open_item[event.player_index] = event.item.name
    local config_flow = frame.add({
      name = "module_requestor_config_flow",
      type = "flow",
      direction = "vertical",
    })
    local module_select_dropdown = config_flow.add({
      name = "module_requestor_module_select_dropdown",
      type = "drop-down",
      items = {
        {"module-requestor.best-available"},
        "[item=speed-module]",
        "[item=speed-module-2]",
        "[item=speed-module-3]",
      },
      selected_index = 1,
    })
    if global[event.player_index] and global[event.player_index][event.item.name] then
      module_select_dropdown.selected_index = global[event.player_index][event.item.name] + 1
    end
    player.opened = frame
  end,
  ["efficiency-module-requestor"] = function(event)
    local player = game.players[event.player_index]
    local frame = player.gui.center.add({
      name = "module_requestor_config",
      type = "frame",
      direction = "vertical",
    })
    if not global.open_item then
      global.open_item = {}
    end
    global.open_item[event.player_index] = event.item.name
    local config_flow = frame.add({
      name = "module_requestor_config_flow",
      type = "flow",
      direction = "vertical",
    })
    local module_select_dropdown = config_flow.add({
      name = "module_requestor_module_select_dropdown",
      type = "drop-down",
      items = {
        {"module-requestor.best-available"},
        "[item=effectivity-module]",
        "[item=effectivity-module-2]",
        "[item=effectivity-module-3]",
      },
      selected_index = 1,
    })
    if global[event.player_index] and global[event.player_index][event.item.name] then
      module_select_dropdown.selected_index = global[event.player_index][event.item.name] + 1
    end
    player.opened = frame
  end,
  ["productivity-module-requestor"] = function(event)
    local player = game.players[event.player_index]
    local frame = player.gui.center.add({
      name = "module_requestor_config",
      type = "frame",
      direction = "vertical",
    })
    if not global.open_item then
      global.open_item = {}
    end
    global.open_item[event.player_index] = event.item.name
    local config_flow = frame.add({
      name = "module_requestor_config_flow",
      type = "flow",
      direction = "vertical",
    })
    local module_select_dropdown = config_flow.add({
      name = "module_requestor_module_select_dropdown",
      type = "drop-down",
      items = {
        {"module-requestor.best-available"},
        "[item=productivity-module]",
        "[item=productivity-module-2]",
        "[item=productivity-module-3]",
      },
      selected_index = 1,
    })
    if global[event.player_index] and global[event.player_index][event.item.name] then
      module_select_dropdown.selected_index = global[event.player_index][event.item.name] + 1
    end
    player.opened = frame
  end,
  ["custom-module-requestor"] = function(event)
    local player = game.players[event.player_index]
    local frame = player.gui.center.add({
      name = "module_requestor_config",
      type = "frame",
      direction = "vertical",
    })
    local config_flow = frame.add({
      name = "module_requestor_config_flow",
      type = "flow",
      direction = "vertical",
    })
    local choose_elem = config_flow.add({
      type = "choose-elem-button",
      name = "module_requestor_config_choose_button",
      style = "slot_button",
      elem_type = "item",
      tooltip = {"module-requestor.choose-module-tooltip"},
    })
    if global[event.player_index] and global[event.player_index].custom then
      choose_elem.elem_value = global[event.player_index].custom
    end
    player.opened = frame
  end,
}
local function on_mod_item_opened(event)
  if draw_gui_functions[event.item.name] then
    draw_gui_functions[event.item.name](event)
  end
end
script.on_event(defines.events.on_mod_item_opened, on_mod_item_opened)

local function on_gui_closed(event)
  local player = game.players[event.player_index]
  local frame = player.gui.center.module_requestor_config
  if frame then
    frame.destroy()
    if not global.open_item then
      global.open_item = {}
    end
    global.open_item[event.player_index] = nil
  end
end
script.on_event(defines.events.on_gui_closed, on_gui_closed)

local function on_gui_selection_state_changed(event)
  if event.element.name == "module_requestor_module_select_dropdown" then
    local player = game.players[event.player_index]
    if not global[event.player_index] then
      global[event.player_index] = {}
    end
    if event.element.selected_index == 1 then
      global[event.player_index][global.open_item[event.player_index]] = nil
    else
      global[event.player_index][global.open_item[event.player_index]] = event.element.selected_index - 1
    end
  end
end
script.on_event(defines.events.on_gui_selection_state_changed, on_gui_selection_state_changed)

local function on_gui_elem_changed(event)
  if event.element.name == "module_requestor_config_choose_button" then
    local player = game.players[event.player_index]
    if not global[event.player_index] then
      global[event.player_index] = {}
    end
    if event.element.elem_value then
      if game.item_prototypes[event.element.elem_value].type ~= "module" then
        player.print({"module-requestor.not-a-module"})
        event.element.elem_value = nil
      else
        global[event.player_index].custom = event.element.elem_value
      end
    else
      global[event.player_index].custom = nil
    end
  end
end
script.on_event(defines.events.on_gui_elem_changed, on_gui_elem_changed)
