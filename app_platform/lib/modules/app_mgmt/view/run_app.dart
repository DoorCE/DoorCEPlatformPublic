import 'package:app_platform/common/view_elements/style.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:app_platform/dtos/app.dart';
import 'package:app_platform/common/view_elements/embedded_iframe.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';
import 'package:app_platform/modules/app_mgmt/view/controllers/c_run_app.dart';
import 'package:app_platform/modules/app_mgmt/view/viewmodel/m_run_app.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class VRunAppWindow extends StatefulWidget {
  final CRunAppWindow _cUpsertServicesWindow;
  final MRunAppWindow _model;
  const VRunAppWindow(GlobalKey? key, this._cUpsertServicesWindow, this._model)
      : super(key: key);

  @override
  State<VRunAppWindow> createState() => VRunAppWindowState();
}

class VRunAppWindowState extends State<VRunAppWindow> {

  @override
  Widget build(BuildContext context) {
    XApp app = widget._model.app;
    return Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBreadcrumb(app.title),
              _buildApp()
            ],
          ),
        );
  }

  Widget _buildBreadcrumb(String title) {
    return Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => widget._cUpsertServicesWindow.homeSelected(context),
            child: DoorText(AppLocalizations.of(context)!.appList,
                DoorTextStyle.breadcrumbActive),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(Icons.chevron_right, color: DoorColor.grey),
        ),
        DoorText(title, DoorTextStyle.breadcrumb),
      ],
    );
  }

  Widget _buildApp() {
    const baseUrl = String.fromEnvironment('UDAS_APPREPO_URL', defaultValue: 'http://localhost:60101');

    String appUrl = '$baseUrl${widget._model.app.identifier}/';

    //Logger.root.info("[VRunAppWindow] building IFrame...\nBase URL: $baseUrl\nApp identifier: ${widget._model.app.identifier}\nApp URL: $appUrl\nRefresh token: ${widget._model.refreshToken}\nDataset URI: ${widget._model.datasetUri}");

    return Expanded(
      child: IframeEmbed(widget._model.refreshToken!, widget._model.datasetUri, appUrl)
      );
  }
}

class VRunAppWindowFactory {
  const VRunAppWindowFactory();
  VRunAppWindow get(key, model) {
    return VRunAppWindow(key, new CRunAppWindow(model), model);
  }
}
