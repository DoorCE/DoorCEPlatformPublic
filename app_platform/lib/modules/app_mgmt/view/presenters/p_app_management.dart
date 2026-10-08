import 'package:app_platform/dtos/app.dart';
import 'package:app_platform/modules/main_panel/view/presenters/p_main_panel.dart';
import 'package:app_platform/modules/app_mgmt/view/app_management_window.dart';
import 'package:app_platform/modules/app_mgmt/view/viewmodel/m_app_management.dart';
import 'package:flutter/material.dart';

abstract interface class IPAppManagement{
  //Widget firstShow(BuildContext context);
  show(BuildContext context, List<XApp> apps);
  showAuthFailed(BuildContext context);
  void refreshResources(List<XApp> newResourceList);
}

class PAppManagement extends AbstractPresenter implements IPAppManagement{
  final VAppManagementFactory _vMainMenuFactory;
  PAppManagement(this._vMainMenuFactory) : super("/");
  GlobalKey<VAppManagementWindowState>? _viewKey;
  late MAppManagement _model;
  
  //@override
  //Widget firstShow(BuildContext context) {
  //  return _vMainMenuFactory.get();
  //}

  @override
  show(BuildContext context, List<XApp> apps) {
    _model = MAppManagement(apps);

    _viewKey = GlobalKey<VAppManagementWindowState>();
    pushWindow(context, 'images/options.png', true,
                          _vMainMenuFactory.get(_viewKey, _model));
  }

  @override
  void refreshResources(List<XApp> newResourceList) {
    _model.refreshResourceList(newResourceList);
    _viewKey!.currentState?.refresh();
  }


  @override
  showAuthFailed(BuildContext context) { 
    pushWindow(context, 'images/options.png', true,
                          _vMainMenuFactory.getAuthFailed(context), notAuthenticated:  true);
  }
}