import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';

class ContentsWidget extends StatelessWidget {
  const ContentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ContentsPane()],
    );
  }
}

class ContentsPane extends StatefulWidget {
  const ContentsPane({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentPaneState();
}

class _ContentPaneState extends State<ContentsPane> {

  List<Contents> getFridgeWidgets(Map<String, String> fridgeEntry) {
    return fridgeEntry.map((key, value) { return MapEntry(key, Contents(key,value)); } ).values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, model, child) {
      return Column(children: getFridgeWidgets(model.fridgeEntry),);
    });
  }
}

class Contents extends StatelessWidget {
  final String item;
  final String weight;

  const Contents(this.item, this.weight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(item), const Spacer(), Text(weight)],
    );
  }
}
