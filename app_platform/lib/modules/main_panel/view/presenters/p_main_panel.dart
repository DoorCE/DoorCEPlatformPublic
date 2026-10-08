import 'package:app_platform/dtos/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_panel.dart';

abstract class AbstractPresenter {

  final String routingNamePrefix;

  String getRoutingName() => routingNamePrefix;

  const AbstractPresenter(this.routingNamePrefix);

  pushWindow(BuildContext context, String iconUri,
      bool isMainMenu, Widget body, {notAuthenticated = false, XApp? app}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => context
              .read<VMainPanelFactory>()
              .get(context, iconUri, isMainMenu, body, notAuthenticated: notAuthenticated, app: app),
          settings: RouteSettings(
            name: getRoutingName(),
          )),
    );
  }

  popWindow(BuildContext context) => Navigator.pop(context);
}
