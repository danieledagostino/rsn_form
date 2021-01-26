class Hub {
  int key;
  String name;
  String url;

  Hub(this.key, this.name, this.url);

  Map<String, dynamic> toMap() {
    return {'key': key, 'name': name, 'url': url};
  }

  Hub.fromMap(Map<String, dynamic> map) {
    this.key = map['key'];
    this.name = map['name'];
    this.url = map['url'];
  }

  @override
  String toString() {
    return "[key: $key, name: $name, url: $url]";
  }
}
