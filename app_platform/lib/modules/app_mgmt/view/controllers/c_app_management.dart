import 'package:app_platform/modules/app_mgmt/usecases/refresh_app_statuses.dart';
import 'package:app_platform/modules/app_mgmt/usecases/show_run_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CAppManagement {
  const CAppManagement();

  editAppSelected(BuildContext context, String appUri, [String? sourceDatasetId=null]) {
    context.read<IUCRunEditApp>().showRunAppSelected(context, appUri, sourceDatasetId);
  }

  refreshAppStatuses(BuildContext context) async {
    await context.read<IUCRefreshAppStatuses>().refreshApps(context);
  }
}
