import 'package:app_platform/common/consts/routing_prefixes.dart';
import 'package:app_platform/dtos/app.dart';
import 'package:app_platform/modules/app_mgmt/view/run_app.dart';
import 'package:app_platform/modules/main_panel/view/presenters/p_main_panel.dart';
import 'package:app_platform/modules/app_mgmt/view/viewmodel/m_run_app.dart';
import 'package:flutter/material.dart';

abstract interface class IPRunAppWindow {
  show(
      BuildContext context,
      XApp app,
      String datasetUri,
      String? refreshToken);
  close(BuildContext context);
}

class PRunAppWindow extends AbstractPresenter
    implements IPRunAppWindow {
  final VRunAppWindowFactory _vEditAppWindowFactory;
  GlobalKey<VRunAppWindowState>? _viewKey;
  late MRunAppWindow _model;
  PRunAppWindow(this._vEditAppWindowFactory) : super(RoutingPrefixes.runApp);

  @override
  close(BuildContext context) => popWindow(context);

  @override
  show(BuildContext context, XApp app, String datasetUri, String? refreshToken) {
    _model = MRunAppWindow(app, datasetUri, refreshToken);

    _viewKey = GlobalKey<VRunAppWindowState>();

    pushWindow(
        context,
        "",
        false,
        _vEditAppWindowFactory.get(_viewKey, _model),
        app: app);// for app bar
  }

  @override
  String getRoutingName(){
    var identifier = _model.app.identifier;

    if (null == identifier || identifier.isEmpty) {
      throw Exception("App identifier is required for routing to run app window");
    }

    return "${super.getRoutingName()}${identifier.isNotEmpty ? ':$identifier' : ''}";
  }
}