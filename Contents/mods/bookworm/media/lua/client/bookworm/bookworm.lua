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
      end
   end

   if isAllLiterature and not getSpecificPlayer(player):getTraits():isIlliterate() then
      ISInventoryPaneContextMenu.doLiteratureMenu(context, items, player)
   end
end

-- Init function
local function func_Init()
   Events.OnFillInventoryObjectContextMenu.Add(BOOKWORM.BuildReadMenu)
end

Events.OnGameStart.Add(func_Init)
