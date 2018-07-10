local speed_item = {
  type = "selection-tool",
  name = "speed-module-requestor",
  subgroup = "tool",
  order = "za[speed-module-requestor]",
  icons = {
    {
      icon = "__module-requestor__/graphics/icons/speed-module-requestor.png",
      icon_size = 32,
    }
  },
  flags = {"goes-to-quickbar"},
  stack_size = 1,
  stackable = false,
  selection_color = { r = 0.183, g = 0.902, b = 0.964, a = 1 },
  alt_selection_color = { r = 1, g = 0, b = 0, a = 1 },
  selection_mode = { "buildable-type", "matches-force" },
  alt_selection_mode = { "buildable-type", "matches-force" },
  selection_cursor_box_type = "entity",
  alt_selection_cursor_box_type = "entity",
  can_be_mod_opened = true,
}

local speed_recipe = {
  type = "recipe",
  name = "speed-module-requestor",
  enabled = false,
  ingredients = {
    {'electronic-circuit', 20},
    {'speed-module', 5},
  },
  result = "speed-module-requestor",
}

local efficiency_item = {
  type = "selection-tool",
  name = "efficiency-module-requestor",
  subgroup = "tool",
  order = "zb[efficiency-module-requestor]",
  icons = {
    {
      icon = "__module-requestor__/graphics/icons/efficiency-module-requestor.png",
      icon_size = 32,
    }
  },
  flags = {"goes-to-quickbar"},
  stack_size = 1,
  stackable = false,
  selection_color = { r = 0.39, g = 0.875, b = 0.184, a = 1 },
  alt_selection_color = { r = 1, g = 0, b = 0, a = 1 },
  selection_mode = { "buildable-type", "matches-force" },
  alt_selection_mode = { "buildable-type", "matches-force" },
  selection_cursor_box_type = "entity",
  alt_selection_cursor_box_type = "entity",
  can_be_mod_opened = true,
}

local efficiency_recipe = {
  type = "recipe",
  name = "efficiency-module-requestor",
  enabled = false,
  ingredients = {
    {'electronic-circuit', 20},
    {'effectivity-module', 5},
  },
  result = "efficiency-module-requestor",
}

local productivity_item = {
  type = "selection-tool",
  name = "productivity-module-requestor",
  subgroup = "tool",
  order = "zc[productivity-module-requestor]",
  icons = {
    {
      icon = "__module-requestor__/graphics/icons/productivity-module-requestor.png",
      icon_size = 32,
    }
  },
  flags = {"goes-to-quickbar"},
  stack_size = 1,
  stackable = false,
  selection_color = { r = 0.985, g = 0.758, b = 0.078, a = 1 },
  alt_selection_color = { r = 1, g = 0, b = 0, a = 1 },
  selection_mode = { "buildable-type", "matches-force" },
  alt_selection_mode = { "buildable-type", "matches-force" },
  selection_cursor_box_type = "entity",
  alt_selection_cursor_box_type = "entity",
  can_be_mod_opened = true,
}

local productivity_recipe = {
  type = "recipe",
  name = "productivity-module-requestor",
  enabled = false,
  ingredients = {
    {'electronic-circuit', 20},
    {'productivity-module', 5},
  },
  result = "productivity-module-requestor",
}

local custom_item = {
  type = "selection-tool",
  name = "custom-module-requestor",
  subgroup = "tool",
  order = "zd[custom-module-requestor]",
  icons = {
    {
      icon = "__module-requestor__/graphics/icons/custom-module-requestor.png",
      icon_size = 32,
    }
  },
  flags = {"goes-to-quickbar"},
  stack_size = 1,
  stackable = false,
  selection_color = { r = 0.5, g = 0.5, b = 0.5, a = 1 },
  alt_selection_color = { r = 1, g = 0, b = 0, a = 1 },
  selection_mode = { "buildable-type", "matches-force" },
  alt_selection_mode = { "buildable-type", "matches-force" },
  selection_cursor_box_type = "entity",
  alt_selection_cursor_box_type = "entity",
  can_be_mod_opened = true,
}

local custom_recipe = {
  type = "recipe",
  name = "custom-module-requestor",
  enabled = false,
  ingredients = {
    {'electronic-circuit', 20},
    {'advanced-circuit', 20},
  },
  result = "custom-module-requestor",
}

local tech =  {
  type = "technology",
  name = "module-requestor",
  icon_size = 128,
  icon = "__base__/graphics/technology/module.png",
  prerequisites = {"modules","construction-robotics"},
  unit = {
    count = 200,
    ingredients = {
      {"science-pack-1", 1},
      {"science-pack-2", 1},
    },
    time = 30,
  },
  effects = {
    {
      type = "unlock-recipe",
      recipe = "speed-module-requestor",
    },
    {
      type = "unlock-recipe",
      recipe = "efficiency-module-requestor",
    },
    {
      type = "unlock-recipe",
      recipe = "productivity-module-requestor",
    },
    {
      type = "unlock-recipe",
      recipe = "custom-module-requestor",
    },
  },
  order = "i-a-z",
}

data:extend({speed_item, speed_recipe, efficiency_item, efficiency_recipe, productivity_item, productivity_recipe, custom_item, custom_recipe, tech})
