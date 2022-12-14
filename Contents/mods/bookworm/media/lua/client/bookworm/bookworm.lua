local BOOKWORM = {}

BOOKWORM.BuildReadMenu = function(player, context, items)
   local isAllLiterature = true;
   local testItem = nil;
   local c = 0;
   for i,v in ipairs(items) do
      testItem = v;
      if not instanceof(v, "InventoryItem") then
         testItem = v.items[1];
      end
      if testItem:getCategory() ~= "Literature" or testItem:canBeWrite() then
         isAllLiterature = false;
         return
      end
      c = c + 1;
   end

   if c > 1 and isAllLiterature and not getSpecificPlayer(player):getTraits():isIlliterate() then
      BOOKWORM.doLiteratureMenu(context, items, player)
   end
end

BOOKWORM.doLiteratureMenu = function(context, items, player)
   local name = getText("ContextMenu_Read");
   local readOption = context:getOptionFromName(name);
   if readOption then
      -- If there's an existing read option replace the onSelect function
      readOption.onSelect = BOOKWORM.onLiteratureItems;
   else
      readOption = context:insertOptionAfter(getText("ContextMenu_Equip_Secondary"), name, items, BOOKWORM.onLiteratureItems, player);

      if getSpecificPlayer(player):isAsleep() then
         readOption.notAvailable = true;
         local tooltip = ISInventoryPaneContextMenu.addToolTip();
         tooltip.description = getText("ContextMenu_NoOptionSleeping");
         readOption.toolTip = tooltip;
      end
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
