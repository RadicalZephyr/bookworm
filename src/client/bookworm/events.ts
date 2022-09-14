/**
 * @noSelfInFile
 *
 * NOTE: Prevents unneeded self reference in rendered Lua.
 */

// PipeWrench API.
import { KahluaTable, InventoryItem, getSpecificPlayer, getText, ISInventoryPane, ISInventoryPaneContextMenu } from '@asledgehammer/pipewrench';

// PipeWrench Events API.
import * as Events from '@asledgehammer/pipewrench-events';


export function buildReadMenu(player: number, context: KahluaTable, items: KahluaTable) {
    let isAllLiterature = true;
    let count = 0;
    for (const [_index, v] of items) {
        let testItem = v;
        if (!(v instanceof InventoryItem)) {
            testItem = v.items[1];
        }
        if (testItem.getCategory() != "Literature" || testItem.canBeWrite()) {
            isAllLiterature = false;
            return;
        }
        count += 1;
    }

    let traits: any = getSpecificPlayer(player).getTraits();
    if (count > 1 && isAllLiterature && !traits.isIlliterate()) {
        doLiteratureMenu(player, context, items);
    }
}

export function doLiteratureMenu(player: number, context: KahluaTable, items: KahluaTable) {
    let name = getText("ContextMenu_Read");
    let readOption = context.getOptionFromName(name);

    if (readOption) {
        readOption.onSelect = onLiteratureItems;
    } else {
        readOption = context.insertOptionAfter(getText("ContextMenu_Equip_Secondary"), name, items, onLiteratureItems, player);

        if (getSpecificPlayer(player).isAsleep()) {
            readOption.notAvailable = true;
            let tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_NoOptionSleeping");
            readOption.toolTip = tooltip;
        }
    }
}

export function onLiteratureItems(items: KahluaTable, player: number) {
    items = ISInventoryPane.getActualItems(items);
    for (const [_index, k] of items) {
        ISInventoryPaneContextMenu.readItem(k, player);
    }
}

Events.onGameStart.addListener(() => {
    Events.onFillInventoryObjectContextMenu.addListener(buildReadMenu)
});
