import 'package:pokedex/popup/triggerable_popup.dart';
import 'package:url_launcher/url_launcher.dart';

/// Abstract base class
/// for events that may trigger a popup
abstract class ResponseAction {
  /// Returns a name that unique identifies this response action
  String getName();

  /// Returns user-friendly action text
  String getActionText();

  /// Called by TriggerablePopup.handlePopupDone
  /// popup object is passed as it may be useful
  /// to determine specific action to be taken
  Future<void> callback(TriggerablePopup popup);
}

// Define response subclasses here

class ResponseActionIgnore implements ResponseAction {
  String getName() {
    return 'ignore';
  }

  String getActionText() {
    return '';
  }

  Future<void> callback(TriggerablePopup popup) async {
    // NOP
  }
}

class ResponseActionAcknowledge implements ResponseAction {
  String getName() {
    return 'acknowledge';
  }

  String getActionText() {
    return 'OK';
  }

  Future<void> callback(TriggerablePopup popup) async {
    // NOP
  }
}

class ResponseActionVisitBlog implements ResponseAction {
  String getName() {
    return 'visit_blog';
  }

  String getActionText() {
    return 'Visit our blog';
  }

  Future<void> callback(TriggerablePopup popup) async {
    final url = 'https://blog.muskify.app';
    if (await canLaunch(url)) await launch(url);
  }
}
