/**
 * @noSelfInFile
 *
 * NOTE: Prevents unneeded self reference in rendered Lua.
 */

// PipeWrench API.
import { getPlayer } from '@asledgehammer/pipewrench';

// PipeWrench Events API.
import * as Events from '@asledgehammer/pipewrench-events';


// if isAllLiterature and not getSpecificPlayer(player): getTraits(): isIlliterate() then
//   ISInventoryPaneContextMenu.doLiteratureMenu(context, items, player)
// end


Events.onGameStart.addListener(() => {

});
