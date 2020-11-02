import 'package:meta/meta.dart';

/// Simple PopupEvent base class
/// for events that may trigger a popup
/// See events.dart for subclasses
class PopupEvent {
  bool isOfType(Type type) {
    return this.runtimeType == type;
  }
}

// Define event subclasses here

class TaskCreationMilestoneEvent extends PopupEvent {
  final int num;

  TaskCreationMilestoneEvent({@required this.num});
}
