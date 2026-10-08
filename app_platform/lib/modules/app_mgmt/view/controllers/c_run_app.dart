import 'package:app_platform/modules/app_mgmt/usecases/show_app_management.dart';
import 'package:app_platform/modules/app_mgmt/view/viewmodel/m_run_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CRunAppWindow {
  final MRunAppWindow? _model;
  
  const CRunAppWindow(this._model);

  homeSelected(BuildContext context) {
    context.read<IUCAppManagement>().startSelected(context);
  }
}