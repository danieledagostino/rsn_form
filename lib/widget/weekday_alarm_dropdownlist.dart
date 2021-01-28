import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/dao/i_app_conf_dao.dart';
import 'package:rsn_form/model/app_conf.dart';

class WeekdayAlarmDropdownlist extends StatelessWidget {
  ValueNotifier<String> selectedValue = ValueNotifier<String>('');
  bool alarmUpdate = false;
  Map<String, int> _days = {
    'Monday': DateTime.monday,
    'Tuesday': DateTime.tuesday,
    'Wednesday': DateTime.wednesday,
    'Thursday': DateTime.thursday,
    'Friday': DateTime.friday,
    'Saturday': DateTime.saturday,
    'Sunday': DateTime.sunday
  };

  List<Widget> _getList() {
    List<Widget> list = List<Widget>();
    list.add(Text(
      'On what day do you want to receive your feedback form reminder?',
      maxLines: 3,
    ));

    _days.forEach((k, v) {
      list.add(ValueListenableBuilder(
          valueListenable: selectedValue,
          builder: (BuildContext context, String newSelect, Widget child) {
            Text text;
            if (v.toString() == selectedValue.value) {
              text = Text(k, style: TextStyle(fontWeight: FontWeight.bold));
            } else {
              text = Text(k);
            }
            return RadioListTile(
                title: text,
                groupValue: newSelect,
                onChanged: (v) => update(v),
                value: v.toString());
          }));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AppConf>>(
        future: GetIt.I.get<IAppConfDao>().findByKey('alarmDay'),
        builder: (BuildContext context, AsyncSnapshot<List<AppConf>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              selectedValue.value = snapshot.data[0].value.toString();
            } else {
              selectedValue.value = DateTime.friday.toString();
            }

            List<Widget> list = _getList();
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: list);
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
        });
  }

  void update(String newValue) {
    selectedValue.value = newValue;
    alarmUpdate = true;
    GetIt.I
        .get<IAppConfDao>()
        .insertOrUpdate(AppConf('alarmDay', int.parse(newValue)));
  }
}
