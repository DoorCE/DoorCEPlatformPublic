import 'package:app_platform/dtos/user_account.dart';
import 'package:app_platform/modules/main_panel/view/door_app_bar.dart';
import 'package:flutter/material.dart';

class VMainPanel extends StatelessWidget {
  final Widget _body;
  final AppBar _appBar;
  const VMainPanel(this._appBar, this._body, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }
}

class VMainPanelFactory {
  const VMainPanelFactory(this._appBarFactory);
  final IAppBarFactory _appBarFactory;
  static late XUserAccount? userAccount;
  VMainPanel get(context, icon, isMainMenu, body, {notAuthenticated = false, app}) => VMainPanel(
        _appBarFactory.get(context, notAuthenticated ? null : userAccount, app),
        body,
      );
}
