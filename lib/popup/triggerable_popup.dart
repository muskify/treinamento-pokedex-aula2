import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/popup/responses.dart';

abstract class TriggerablePopup {
  ResponseAction userResponse;

  /// Default title widget
  /// By default, it's just some text
  Widget getTitle(BuildContext context) {
    return Text(
      getTitleText(),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 15,
      ),
    );
  }

  /// Default body widget
  /// By default, it's just some text
  Widget getBody(BuildContext context) {
    return Text(
      getBodyText(),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 15,
      ),
    );
  }

  /// Abstract interface
  /// Subclasses must provide this iff they don't override
  /// default getTitle/getBody builders
  String getTitleText();
  String getBodyText();

  /// Returns a full name for this popup
  /// This name must be unique for each event
  /// as this is the name that is stored in the database
  /// (popup events table)
  String getPopupName();

  /// Updates user response (by default we assume "ignored")
  /// This will be typically called from a widget/button
  /// related to a response (see getResponses())
  void setUserResponse(ResponseAction userResponse) {
    this.userResponse = userResponse;
  }

  /// Called when popup is done (or dismissed)
  Future<void> handlePopupDone() async {
    if (userResponse == null) userResponse = ResponseActionIgnore();
    userResponse.callback(this);
  }

  /// Returns a list of possible responses
  List<ResponseAction> getResponses();

  /// Generic builder
  /// Builds the popup dialog
  Widget build(BuildContext context) {
    // FIXME (TEMP UI)

    List<Widget> actionButtons = [];
    for (final action in getResponses()) {
      actionButtons.add(InkWell(
        onTap: () {
          setUserResponse(action);
          Navigator.of(context).pop();
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  action.getActionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {},
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTitle(context),
                        getBody(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...actionButtons
        ],
      ),
    );
  }
}
