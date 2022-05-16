import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T object;
  final Widget child;
  final Function(T onInit) onInit;
  final Function(T onDispose) onDispose;

  const BaseWidget({Key? key, required this.child, required this.object, required this.onInit, required this.onDispose}) : super(key: key);

  @override
  State<BaseWidget> createState() => _BaseWidgetState(this.object, this.child, this.onInit, this.onDispose);
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget> {
  final T _object;
  final Widget _child;
  final Function(T onInit) _onInit;
  final Function(T onInit) _onDispose;

  _BaseWidgetState(this._object, this._child, this._onInit, this._onDispose);

  @override
  void initState() {
    _onInit(_object);
    super.initState();
  }

  @override
  void dispose() {
    _onDispose(_object);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _object,
      child: _child,
    );
  }
}
