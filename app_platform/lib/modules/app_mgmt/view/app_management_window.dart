import 'package:app_platform/common/view_elements/button.dart';
import 'package:app_platform/common/view_elements/parameterized_list_view/filter_dialog.dart';
import 'package:app_platform/common/view_elements/parameterized_list_view/page_state.dart';
import 'package:app_platform/common/view_elements/parameterized_list_view/parameterized_list_view.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:app_platform/dtos/app.dart';
import 'package:app_platform/modules/app_mgmt/view/controllers/c_app_management.dart';
import 'package:app_platform/modules/app_mgmt/view/viewmodel/m_app_management.dart';
import 'package:flutter/material.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';

class VAppManagementWindow extends StatefulWidget {
  final MAppManagement _model;
  final CAppManagement _cMainMenu;
  const VAppManagementWindow(GlobalKey? key, this._cMainMenu, this._model)
      : super(key: key);

  @override
  State<VAppManagementWindow> createState() => VAppManagementWindowState();
}

class VAppManagementWindowState extends State<VAppManagementWindow> {
  late ParameterizedListController<XApp> _appController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refresh() {
    setState(() {
    // Sync controllers with updated model data
    _appController.updateQuerySet(widget._model.apps);
    });
  }

  void setFilters(ParameterizedListController controller) async {
    QueryParams? result = await showFilterDialog(context, controller.filterSet,
      controller.queryParams);
    if (result != null) {
      controller.setParams(result);
      refresh();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _appController = widget._model.setController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 12, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumb(context),
          const SizedBox(height: 25),
          Expanded(child:appPage(context))
          ],
      ),
    );
  }

  Widget _buildBreadcrumb(BuildContext context) {
    return Row(
      children: [
        DoorText(AppLocalizations.of(context)!.appList,
            DoorTextStyle.breadcrumb),
      ],
    );
  }

  Widget appPage(BuildContext context) {
    Widget rightButtons;

    return Column(
      spacing: 12,
      children: [
        Row(
          children: [
            const Spacer(),
            //const Spacer(),
            DoorSimpleButtonIcon(
              AppLocalizations.of(context)!.refreshAppStatuses,
              Icons.refresh, 
              () => widget._cMainMenu.refreshAppStatuses(context)
            ),
            DoorSimpleButtonIcon(
                AppLocalizations.of(context)!.filter,
                _appController.areFiltersApplied() ? Icons.filter_alt : Icons.filter_alt_outlined,
                () {
                  setFilters(_appController);
                }),
            //const SizedBox(width: 50),
          ],
        ),
        Expanded(child: ParameterizedListView<XApp>(
            controller: _appController,
            itemBuilder: (context, app, index) {
              rightButtons = Center(
                child: DoorButtonColumn([
                  (
                    AppLocalizations.of(context)!.runApp,
                    Icons.remove_red_eye_sharp,
                    () => widget._cMainMenu
                        .editAppSelected(context, app.identifier),
                    widget._model.canRunApp(app)
                  )
                ]),
              );
              return Column(
                children: [
                  Row(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset("images/dataset.png")
                      ),
                      Expanded(
                        child: Column(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DoorText(
                                app.title,
                                DoorTextStyle.main,
                              ),
                              Chip(
                              backgroundColor: widget._model.getStatusColor(app.status).withOpacity(0.15),
                              side: BorderSide(color: widget._model.getStatusColor(app.status)),
                              elevation: 4,
                              label: DoorText(
                                app.status.getText(context),
                                DoorTextStyle.emph,
                              ),
                            ),
                              DoorText(
                                widget._model.getAppAttributesSummary(context, app),
                                DoorTextStyle.emph,
                              ),
                              DoorText(
                                app.description,
                                DoorTextStyle.norm,
                              )]
                              //+ widget._model.getDatasetSeriesTitles(context, app).map((m) => 
                              //Chip(
                              //  backgroundColor: DoorColor.lightEmph,
                              //  side:
                              //      const BorderSide(color: DoorColor.darkEmph),
                              //  elevation: 4,
                              //  label: DoorText(
                              //    m,
                              //    DoorTextStyle.emph,
                              //  ))
                              //).toList()
                          ),),
                          const Spacer(),
                      rightButtons,
                    ],
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class VAppManagementFactory {
  const VAppManagementFactory();
  VAppManagementWindow get(key, model) {
    return VAppManagementWindow(key, new CAppManagement(), model);
  }
  Widget getAuthFailed(context) => new Center(
    child: DoorText(
      AppLocalizations.of(context)!.authKeycloakError,
      DoorTextStyle.titleBlack,
    ),
  );
}
