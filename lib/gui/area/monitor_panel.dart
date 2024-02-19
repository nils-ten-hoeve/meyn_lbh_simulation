import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meyn_lbh_simulation/domain/area/name.dart';
import 'package:meyn_lbh_simulation/domain/area/object_details.dart';
import 'package:meyn_lbh_simulation/domain/area/player.dart';
import 'package:meyn_lbh_simulation/gui/area/command.dart';
import 'package:meyn_lbh_simulation/gui/style.dart';
import 'package:user_command/user_command.dart';

class MonitorPanel extends StatefulWidget {
  const MonitorPanel({super.key});

  @override
  State<MonitorPanel> createState() => _MonitorPanelState();
}

class _MonitorPanelState extends State<MonitorPanel> implements UpdateListener {
  Player get player => GetIt.instance<Player>();

  @override
  void initState() {
    player.addUpdateListener(this);
    super.initState();
  }

  @override
  void dispose() {
    player.removeUpdateListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var objects = player.objectsToMonitor.toList();
    return ListView.separated(
      padding: const EdgeInsets.all(6),
      itemCount: objects.length,
      itemBuilder: (context, index) => MonitorTile(objects[index]),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 6),
    );
  }

  @override
  void onUpdate() {
    setState(() {
      // updates tiles
    });
  }
}

class MonitorTile extends StatelessWidget {
  final Object objectToMonitor;
  const MonitorTile(this.objectToMonitor, {super.key});

  @override
  Widget build(BuildContext context) {
    var name = _name();
    return ListTile(
      onTap: () {
        if (objectToMonitor is HasCommands) {
          CommandPopupMenu(
            context,
            (objectToMonitor as HasCommands).commands,
            title: name,
          );
        }
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      tileColor:
          LiveBirdsHandlingStyle.of(context).machineColor.withOpacity(0.2),
      title: Text(name),
      subtitle: _createSubTitle(),
    );
  }

  String _name() {
    if (objectToMonitor is HasName) {
      return (objectToMonitor as HasName).name;
    } else {
      return objectToMonitor
          .toString()
          .replaceAll(RegExp(r'Instance of '), '')
          .replaceAll(RegExp('\n.*'), '')
          .replaceAll(RegExp('\''), '');
    }
  }

  Widget? _createSubTitle() => objectToMonitor is HasObjectDetails
      ? Text((objectToMonitor as HasObjectDetails)
          .objectDetails
          .propertiesToString(0))
      : null;
}
