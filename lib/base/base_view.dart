import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier?> extends StatefulWidget {
  final Widget child;
  final T object;
  final Function(T modelInit)? onInit;
  final Function(T modelInit)? onDispose;

  const BaseWidget({Key? key, required this.child, required this.object, this.onInit, this.onDispose}) : super(key: key);

  @override
  State<BaseWidget<T>> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier?> extends State<BaseWidget<T>> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit!(widget.object);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!(widget.object);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => widget.object,
      child: widget.child,
    );
  }
}
