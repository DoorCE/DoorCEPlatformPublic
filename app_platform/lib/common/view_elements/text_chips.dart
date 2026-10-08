import 'package:app_platform/common/view_elements/style.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:app_platform/common/view_elements/text_add.dart';
import 'package:flutter/material.dart';

class DoorTextFormFieldWithChips extends StatefulWidget {
  final List<String> items;
  final bool enabled;
  final bool isRequired;
  final void Function(List<String>) onChipAddedOrRemoved;
  

  const DoorTextFormFieldWithChips({
    Key? key,
    required this.items,
    required this.onChipAddedOrRemoved,
    this.enabled = true,
    this.isRequired = false,
  }) : super(key: key);

  @override
  _DoorTextFormFieldWithChipsState createState() => _DoorTextFormFieldWithChipsState();
}

class _DoorTextFormFieldWithChipsState extends State<DoorTextFormFieldWithChips> {
  late List<String> _itemList;

  @override
  void initState() {
    super.initState();
    _itemList = List.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
  return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Left column with text field
        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoorTextFormFieldWithAddButton(
                items: _itemList,
                onAdded: (newList) {
                  setState(() {
                    _itemList = newList;
                  });
                  widget.onChipAddedOrRemoved(_itemList);
                },
                enabled: widget.enabled,
                isRequired: widget.isRequired,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),

        /// Display of existing chips
        Flexible(
          flex: 8,
          child: Column(
            children: [
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _itemList.map((item) {
                  return InputChip(
                    isEnabled: widget.enabled,
                    backgroundColor: DoorColor.lightEmph,
                    side: const BorderSide(color: DoorColor.darkEmph),
                    label: DoorText(item, DoorTextStyle.norm),
                    onDeleted: () {
                          setState(() {
                            _itemList.remove(item);
                          });
                          widget.onChipAddedOrRemoved(_itemList);
                        } 
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}