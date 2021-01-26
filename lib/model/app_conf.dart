import 'package:rsn_form/model/hub.dart';

class AppConf {
  String key;
  dynamic value;

  AppConf(this.key, this.value);

  Map<String, dynamic> toMap() {
    if (value is Hub) {
      Hub h = value as Hub;
      return {'key': key, 'value': h.toMap()};
    } else {
      return {'key': key, 'value': value};
    }
  }

  AppConf.fromMap(Map<String, dynamic> map) {
    this.key = map['key'];
    if (this.key == 'ownHub') {
      this.value = Hub.fromMap(map['value']);
    } else {
      this.value = map['value'];
    }
  }

  @override
  String toString() {
    return "[key: $key, value: $value]";
  }
}
