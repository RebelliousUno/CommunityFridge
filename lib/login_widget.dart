import 'package:flutter/material.dart';

import 'app_model.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  void updateSessionID(String sessionId) {
    setState(() {
      AppModel.setSessionId(sessionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (AppModel.getSessionId()?.isNotEmpty ?? false) {
      return LoggedInWidget(updateSessionID);
    } else {
      return NotLoggedInWidget(updateSessionID);
    }
  }
}

class LoggedInWidget extends StatefulWidget {
  void Function(String sessionId) _updateSessionId;

  LoggedInWidget(this._updateSessionId);

  @override
  State<LoggedInWidget> createState() => _LoggedInWidget();
  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
}

class _LoggedInWidget extends State<LoggedInWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(children: [Text('Logged In ${AppModel.getSessionId()}'),ElevatedButton(
    style: widget.style,
    child: const Text('Log Out'),
    onPressed: () {
    widget._updateSessionId("");
    },
    )]);
  }
}

class NotLoggedInWidget extends StatefulWidget {
  void Function(String sessionId) _updateSessionId;

  NotLoggedInWidget(this._updateSessionId);

  @override
  State<NotLoggedInWidget> createState() => _NotLoggedInWidget();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
}

class _NotLoggedInWidget extends State<NotLoggedInWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: widget.style,
      child: const Text('Log In'),
      onPressed: () {
        widget._updateSessionId("asklhdlkah");
      },
    );
  }
}
