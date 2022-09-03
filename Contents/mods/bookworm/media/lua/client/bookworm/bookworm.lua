local BOOKWORM = {}

BOOKWORM.BuildReadMenu = function(player, context, items)
   local isAllLiterature = true;
   for i,v in ipairs(items) do
      testItem = v;
      if not instanceof(v, "InventoryItem") then
         if #v.items == 2 then
            editItem = v.items[1];
         end
         testItem = v.items[1];
      else
         editItem = v
      end
      if testItem:getCategory() ~= "Literature" or testItem:canBeWrite() then
         isAllLiterature = false;
         return
      end
   end

   if isAllLiterature and not getSpecificPlayer(player):getTraits():isIlliterate() then
      BOOKWORM.doLiteratureMenu(context, items, player)
   end
end

BOOKWORM.doLiteratureMenu = function(context, items, player)
   local readOption = context:addOption(getText("ContextMenu_Read"), items, BOOKWORM.onLiteratureItems, player);
   if getSpecificPlayer(player):isAsleep() then
      readOption.notAvailable = true;
      local tooltip = ISInventoryPaneContextMenu.addToolTip();
      tooltip.description = getText("ContextMenu_NoOptionSleeping");
      readOption.toolTip = tooltip;
   end
end

BOOKWORM.onLiteratureItems = function(items, player)
   items = ISInventoryPane.getActualItems(items)
   for i,k in ipairs(items) do
      ISInventoryPaneContextMenu.readItem(k, player)
   end
end

-- Init function
local function func_Init()
   Events.OnFillInventoryObjectContextMenu.Add(BOOKWORM.BuildReadMenu)
end

Events.OnGameStart.Add(func_Init)
