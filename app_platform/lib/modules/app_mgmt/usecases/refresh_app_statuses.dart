import 'package:app_platform/common/utils/exception_handler.dart';
import 'package:app_platform/common/view_elements/snack_message.dart';
import 'package:app_platform/common/view_elements/wait_message.dart';
import 'package:app_platform/dtos/app.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';
import 'package:app_platform/modules/app_mgmt/usecases/show_app_management.dart';
import 'package:flutter/material.dart';

abstract interface class IUCRefreshAppStatuses {
  Future<void> refreshApps(BuildContext context);
}

class UCRefreshAppStatuses extends UCAppManagement with ExceptionHandler implements IUCRefreshAppStatuses {
  
  UCRefreshAppStatuses(super.pMainMenu, super._authAPI, super._agentAPI, super.appAPI);

  @override
  Future<void> refreshApps(BuildContext context) async {
    await tryForApiExceptions(context, () async {
      WaitMessage().show(context);
      List<XApp> apps = await this.appAPI.getAppList();
      pMainMenu.refreshResources(apps);
      SnackMessage().show(context, false, text: AppLocalizations.of(context)!.appStatusesRefreshed);
      WaitMessage().dismiss();
    });
  }
}