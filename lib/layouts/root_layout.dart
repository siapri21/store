import 'package:flutter/material.dart';
import 'package:store/widgets/shared/drawer_widget.dart';
import 'package:store/widgets/shared/widget_appbar.dart';

class RootLayout extends StatelessWidget {
  final Widget screen;
  const RootLayout({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppbar(),
      drawer:  WidgetDrawer(),
      body: SingleChildScrollView(child: screen),
    );
  }
}
