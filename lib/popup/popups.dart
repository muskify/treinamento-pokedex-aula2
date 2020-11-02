import 'package:pokedex/popup/events.dart';
import 'package:pokedex/popup/responses.dart';
import 'package:pokedex/popup/triggerable_popup.dart';
import 'package:meta/meta.dart';

class TaskCreationMilestonePopup extends TriggerablePopup {
  final int num;

  TaskCreationMilestonePopup({@required this.num});

  String getPopupName() {
    return 'TaskMilestonePopup_$num';
  }

  String getTitleText() {
    return 'Você criou $num tarefas!';
  }

  String getBodyText() {
    return 'Parabéns!';
  }

  List<ResponseAction> getResponses() {
    List<ResponseAction> responses = [
      ResponseActionAcknowledge(),
    ];
    if (num >= 10)
      responses.add(ResponseActionVisitBlog());
    return responses;
  }

  static Future<TaskCreationMilestonePopup> handleEvent(
      final PopupEvent event) async {
    if (event.isOfType(TaskCreationMilestoneEvent)) {
      final TaskCreationMilestoneEvent eventCasted =
      event as TaskCreationMilestoneEvent;
      if (eventCasted.num == 5 || eventCasted.num == 10 || eventCasted.num == 20)
        return TaskCreationMilestonePopup(num: eventCasted.num);
    }

    return null;
  }
}
