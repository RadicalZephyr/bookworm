/**
 * @noSelfInFile
 *
 * NOTE: Prevents unneeded self reference in rendered Lua.
 */

// PipeWrench API.
import { getPlayer, KahluaTable } from '@asledgehammer/pipewrench';

// PipeWrench Events API.
import * as Events from '@asledgehammer/pipewrench-events';


// if isAllLiterature and not getSpecificPlayer(player): getTraits(): isIlliterate() then
//   ISInventoryPaneContextMenu.doLiteratureMenu(context, items, player)
// end

export function buildReadMenu(player: number, context: KahluaTable, items: KahluaTable) {
    let isAllLiterature = true;
    let count = 0;
    for (const [_index, v] of items) {
        let testItem = v;
        if !v instanceof "InventoryItem" {
            testItem = v.items[1];
        }
        if testItem.getCategory() != "Literature" || testItem.canBeWrite() {
            isAllLiterature = false;
            return;
        }
        c += 1;
    }

}

Events.onGameStart.addListener(() => {
    Events.onFillInventoryObjectContextMenu.addListener(buildReadMenu)
});
