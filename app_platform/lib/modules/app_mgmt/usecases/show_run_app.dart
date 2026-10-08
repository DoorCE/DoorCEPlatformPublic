import 'package:app_platform/common/utils/exception_handler.dart';
import 'package:app_platform/common/view_elements/dataset_dialog.dart';
import 'package:app_platform/common/view_elements/snack_message.dart';
import 'package:app_platform/dtos/app.dart';
import 'package:app_platform/common/view_elements/wait_message.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';
import 'package:app_platform/modules/app_mgmt/view/presenters/p_run_app.dart';
import 'package:app_platform/services/app_mgmt.dart';
import 'package:app_platform/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

abstract interface class IUCRunEditApp {
  showRunAppSelected(BuildContext context, String appUri, String? sourceDatasetId);
  closeSelected(BuildContext context);
}

class UCRunEditApp with ExceptionHandler implements IUCRunEditApp {
  final IPRunAppWindow _pEditAppWindow;
  final AppManagementAPI _appManagement;
  final AuthAPI _authAPI;

  const UCRunEditApp(this._pEditAppWindow, this._appManagement, this._authAPI);

  @override
  showRunAppSelected(BuildContext context, String appUri, String? sourceDatasetId) async {
    await tryForApiExceptions(context, () async {

      WaitMessage().show(context);
      XApp app = await _appManagement.getApp(appUri);

      if (app.isEnabled == false) {
        throw Exception(AppLocalizations.of(context)!.appNotEnabled);
      }

      String? refreshToken = await _authAPI.getRefreshToken();

      // get new refresh token for platform
      await _authAPI.refresh();
      Logger.root.info("New platform refresh token: ${await _authAPI.getRefreshToken()}");
      Logger.root.info("[showRunAppSelected] Source dataset id in url: $sourceDatasetId");

      String? datasetId;
      if (sourceDatasetId == null && app.sourceResourceUris.length > 1) {
        datasetId = await showChoiceDialog(context, app.sourceResourceUris, app.sourceResourceTitles);
      } else {
        datasetId = sourceDatasetId ?? app.sourceResourceUris.firstOrNull;
      }

      Logger.root.info("[showRunAppSelected] Source dataset id (after choice dialog): $sourceDatasetId");

      WaitMessage().dismiss();

      if (null == datasetId || datasetId.isEmpty) {
        return;
      } else if (!app.sourceResourceUris.contains(datasetId)) {
        Logger.root.info("[showRunAppSelected] App source resource uris: ${app.sourceResourceUris}");
        throw Exception("Invalid datasetId: $datasetId for app: ${app.identifier}");
      }

      _pEditAppWindow.show(context, app, datasetId, refreshToken);
    }
    );
  }
  

  @override
  closeSelected(BuildContext context) {
    _pEditAppWindow.close(context);
  }
}