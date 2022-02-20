import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, appModel, child) {
      if (appModel.sessionId?.isNotEmpty ?? false) {
        return LoggedInWidget();
      } else {
        return NotLoggedInWidget();
      }
    });
  }
}

class LoggedInWidget extends StatefulWidget {
  LoggedInWidget({Key? key}) : super(key: key);

  @override
  State<LoggedInWidget> createState() => _LoggedInWidget();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
}

class _LoggedInWidget extends State<LoggedInWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, appModel, child) {
      return Row(children: [
        Text('Logged In ${appModel.sessionId}'),
        ElevatedButton(
          style: widget.style,
          child: const Text('Log Out'),
          onPressed: () {
            appModel.sessionId = "";
          },
        )
      ]);
    });
  }
}

class NotLoggedInWidget extends StatefulWidget {
  NotLoggedInWidget({Key? key}) : super(key: key);

  @override
  State<NotLoggedInWidget> createState() => _NotLoggedInWidget();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
}

class _NotLoggedInWidget extends State<NotLoggedInWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, appModel, child) {
      return ElevatedButton(
        style: widget.style,
        child: const Text('Log In'),
        onPressed: () {
          appModel.sessionId = "asklhdlkah";
        },
      );
    });
  }
}
