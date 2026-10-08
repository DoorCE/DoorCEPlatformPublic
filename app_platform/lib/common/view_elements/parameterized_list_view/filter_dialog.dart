import 'package:app_platform/common/view_elements/button.dart';
import 'package:app_platform/common/view_elements/parameterized_list_view/filter_definitions.dart';
import 'package:app_platform/common/view_elements/parameterized_list_view/page_state.dart';
import 'package:app_platform/common/view_elements/style.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

Future<QueryParams?> showFilterDialog<T>(
  BuildContext context,
  FilterSet<T> filterSet,
  QueryParams queryParams,
  [List<String>? selections]
) async {
  // create a mutable deep copy of the params
  final draft = QueryParams.draft(
    filters: Map<String, dynamic>.from(queryParams.filters.map((k, v) =>
      MapEntry(k, v is List ? List.from(v) : v)
    )),
    page: queryParams.page,
    searchQuery: queryParams.searchQuery,
  );

  final updatedDraft = await showDialog<QueryParams?>(
    context: context,
    builder: (BuildContext context) {
      return FilterDialog<T>(
        filterset: filterSet,
        queryParams: draft);
    }
  );

  if (updatedDraft != null) {
    // Convert draft -> immutable (deep unmodifiable) before storing in router
    final newImmutable = QueryParams(
      filters: updatedDraft.filters,
      page: updatedDraft.page,
      searchQuery: updatedDraft.searchQuery,
    );

    return newImmutable;
  }
  return updatedDraft; // null
}

class FilterDialog<T> extends StatefulWidget {
  final FilterSet<T> filterset;
  final QueryParams queryParams;

  const FilterDialog({
    super.key,
    required this.filterset,
    required this.queryParams,
  });

  @override
  State<FilterDialog<T>> createState() => _FilterDialogState<T>();
}

class _FilterDialogState<T> extends State<FilterDialog<T>> {
  void _clearFilters() {
    widget.queryParams.filters.clear();

    for (final filter in widget.filterset.filters.whereType<EnumFilter>()) {
      filter.controller.clearAll();
    }

    // Optional: keep keys with null values instead
    // for (final filter in widget.filterset.filters) {
    //   widget.queryParams.filters![filter.fieldName] = null;
    // }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: DoorColor.lightBlue,
      title: SingleChildScrollView(
        child: DoorText(
          AppLocalizations.of(context)!.filter,
          DoorTextStyle.subtitle,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final filter in widget.filterset.filters)
              filter.buildWidget(widget.queryParams),
          ],
        ),
      ),
      actions: [
        DoorButtonPlain(
          AppLocalizations.of(context)!.clearFilters,
          _clearFilters,
        ),
        DoorButtonPlain(
          AppLocalizations.of(context)!.cancel,
          () => Navigator.of(context).pop(null),
        ),
        DoorButtonPlain(
          AppLocalizations.of(context)!.apply,
          () => Navigator.of(context).pop(widget.queryParams),
        ),
      ],
    );
  }
}