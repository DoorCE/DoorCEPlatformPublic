import 'package:app_platform/common/view_elements/door_dropdown.dart';
import 'package:app_platform/common/view_elements/parameterized_list_view/page_state.dart';
import 'package:app_platform/common/view_elements/style.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class FilterOption {
  final String label;
  final dynamic value;
  FilterOption({required this.label, required this.value});
}

abstract class FilterDefinition<TModel, TValue extends Object> {
  final String fieldName;
  final String label;
  final dynamic Function(TModel model) filterTarget; // object field value to be filtered

  FilterDefinition({
    required this.fieldName,
    required this.label,
    required this.filterTarget,
  });

  Widget buildWidget(QueryParams params);

  bool apply(TModel model, QueryParams params);
}

class EnumFilter<TModel, TValue extends Object> implements FilterDefinition<TModel, TValue> {
  final String fieldName;
  final String label;
  final List<FilterOption> filterOptions;
  
  final dynamic Function (TModel model) filterTarget; // object field value to be filtered

  final MultiSelectController<TValue> controller =
      MultiSelectController<TValue>();

  EnumFilter({
    required this.fieldName,
    required this.label,
    required this.filterOptions,
    required this.filterTarget,
  });

  List<DropdownItem<TValue>> _buildDropdownItems(QueryParams params) {
    return filterOptions.map((v) 
      => DropdownItem<TValue>(
        label: v.label, 
        value: v.value as TValue,
        selected: params.filters[fieldName]?.contains(v.value) ?? false, //whether this option is selected in the filter pop-up
        )).toList();
  }

  @override
  Widget buildWidget(QueryParams params) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Flexible(
              flex: 1,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                DoorText(label, DoorTextStyle.label),
                DoorMultiDropdown<TValue>(
                  controller: controller,
                  items: _buildDropdownItems(params),
                  onSelectionChange: (selectedValues) {
                    setState(() {
                      params.filters[fieldName] = selectedValues;
                    });
                  },
                ),
              ],
            ))
          ]
        );
      }
    );
  }

@override
  bool apply(
    TModel item,
    QueryParams params,
  ) {
    final List<dynamic>? query = params.filters[fieldName] ?? null;

    if (query == null || query.isEmpty) {
      return true;
    }

    var fieldValue = filterTarget(item);
    if (fieldValue == null) return false;

    if (fieldValue is List) {
      return fieldValue.any((v) => query.contains(v));
    }

    return query.contains(fieldValue);

    // TODO - toLowerCase?
  }
}

  class BoolFilter<TModel, TValue extends Object> implements FilterDefinition<TModel, TValue> {
    final String fieldName;
    final String label;
    final Object? Function(TModel model) filterTarget; // object field value to be filtered

  BoolFilter({
    required this.fieldName,
    required this.label,
    required this.filterTarget,
  });

  @override
  Widget buildWidget(QueryParams params) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DoorText(label, DoorTextStyle.label),
            Checkbox(
              tristate: true,
              activeColor: DoorColor.darkEmph,
              value: params.filters[fieldName],
              onChanged: (value) {
                  setState(() {
                      params.filters[fieldName] = value;
                  });
                },
            ),
          ],
        );
      }
    );
  }

  @override
  bool apply(TModel item, QueryParams params) {
    final bool? query = params.filters[fieldName] ?? null;

    if (query == null) {
      return true;
    }

    var fieldValue = filterTarget(item);

    return query == fieldValue;
  }
}

class FilterSet<T> {
  final List<FilterDefinition> filters;

  FilterSet(this.filters);

  bool apply(T item, QueryParams params) {
    return filters.every(
      (filter) => filter.apply(item, params),
    );
  }
}