import 'package:flutter/material.dart';

class FatherWidget extends StatefulWidget {
  final TextEditingController formKey;
  final TextEditingController formVAlue;

  const FatherWidget({Key key, this.formKey, this.formValue) : super(key: key);

  @override
  _FatherWidgetState createState() => _FatherWidgetState();
}

class _FatherWidgetState extends State<FatherWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Last notification: $_notification');
  }
}
