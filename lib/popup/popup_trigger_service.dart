import 'package:flutter/material.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/popup/popups.dart';
import 'package:pokedex/popup/triggerable_popup.dart';
import 'package:pokedex/popup/events.dart';

class PopupTriggerService {
  Future<void> showPopup(TriggerablePopup popup) async {
    final context = MyApp.navigatorKey.currentState.overlay.context;
    await showDialog(
      context: context,
      builder: popup.build,
    );

    popup.handlePopupDone();
  }

  /// Event handler
  Future<void> handleEvent(final PopupEvent event) async {
    if (await considerPopupClass(TaskCreationMilestonePopup.handleEvent, event))
      return;

    // TODO: more types
    // if (await considerPopupClass(???.handleEvent, event)) return;
  }

  /// Attempts to get a popup of specific class
  Future<bool> considerPopupClass(
      Function handler, final PopupEvent event) async {
    TriggerablePopup popup;
    popup = await handler(event);
    if (popup != null) {
      await showPopup(popup);
      return true;
    }

    return false;
  }
}
