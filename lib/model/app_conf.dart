class AppConf {
  String key;
  dynamic value;

  AppConf(this.key, this.value);

  Map<String, dynamic> toMap() {
    return {'key': key, 'value': value};
  }

  AppConf.fromMap(Map<String, dynamic> map) {
    this.key = map['key'];
    this.value = map['value'];
  }

  @override
  String toString() {
    return "[key: $key, value: $value]";
  }
}
