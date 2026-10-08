import 'package:app_platform/common/types/app_status.dart';
import 'package:app_platform/common/view_elements/parameterized_list_view/filter_definitions.dart';
import 'package:app_platform/common/view_elements/parameterized_list_view/page_state.dart';
import 'package:app_platform/common/view_elements/parameterized_list_view/parameterized_list_view.dart';
import 'package:app_platform/common/view_elements/style.dart';
import 'package:app_platform/dtos/app.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MAppManagement {
  late List<XApp> apps;

  MAppManagement(this.apps);

  String getAppTitle(BuildContext context, XApp resource) {
    return resource.title;
  }

  String getAppDescription(BuildContext context, XApp resource) {
    return resource.description;
  }

  String getAppAttributesSummary(BuildContext context, XApp app) {
    String locale = Localizations.localeOf(context).languageCode;
    Map<String, String> datasetTitle = app.activeResourceTitle;
    String displayTitle = datasetTitle[locale] ?? datasetTitle["en"] ?? datasetTitle.values.first;
    return "${AppLocalizations.of(context)!.dataset}: ${displayTitle} | ${AppLocalizations.of(context)!.template}: ${app.templateTitle}";
  }

// -------------------------------------------------------------------------------------------------------- FILTERING --------------------------------------------------------------------------------------------

  ParameterizedListController<XApp> setController(BuildContext context) {
    return ParameterizedListController<XApp>(
      querySet: apps,
      filterSet: getFilterSet(context),
      queryParams: QueryParams(filters: {}));
      // queryParams: state!.getByType<T>() ?? (throw Exception("PageState is null — cannot get query params for type $T")));
  }

  FilterSet<XApp> getFilterSet(BuildContext context) {
    List<FilterDefinition> filters = [];

    filters = generateAppFilters(context);

    return FilterSet<XApp>(filters);
  }

// -------------------------------------------------------------------------------------------------------- APPS --------------------------------------------------------------------------------------------

  int getAppListLength() {
    return apps.length;
  }

  XApp getApp(int index) {
    return apps[index];
  }

  bool canRunApp(XApp app) {
    return app.isEnabled && app.status == AppStatus.Ready;
  }

  Color getStatusColor(AppStatus status) {
    switch (status) {
      case AppStatus.Created:
        return DoorColor.grey;
      case AppStatus.InProcessing:
        return DoorColor.cyan;
      case AppStatus.Ready:
        return DoorColor.darkEmph;
      case AppStatus.HasErrors:
        return DoorColor.red;
    }
  }

  void refreshResourceList(List<XApp> newResourceList) {
      apps = newResourceList;
  }

  List<FilterDefinition> generateAppFilters(BuildContext context) {
    List<FilterOption> typeOptions = AppStatus.values.map((v) 
          => FilterOption(
              label: v.getText(context),
              value: v.index)).toList();
    
    return [
      EnumFilter<XApp, int>(
        fieldName: "status", 
        label: AppLocalizations.of(context)!.statusField, 
        filterOptions: typeOptions,
        filterTarget: (XApp item) => item.status.index),
      
      BoolFilter<XApp, bool>(
        fieldName: "isEnabled", 
        label: AppLocalizations.of(context)!.enabled,
        filterTarget: (item) => canRunApp(item)
        ),
    ];
  }
}