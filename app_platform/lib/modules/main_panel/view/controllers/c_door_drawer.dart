import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_platform/modules/app_mgmt/usecases/show_app_management.dart';

class CDoorDrawer {
  const CDoorDrawer();

  homeSelected(BuildContext context) {
    context.read<IUCAppManagement>().startSelected(context);
  }
}
