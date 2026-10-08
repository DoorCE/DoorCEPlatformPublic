import 'package:app_platform/common/view_elements/style.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:flutter/material.dart';

class DoorCheckboxChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final String? tooltip;

  const DoorCheckboxChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: FilterChip(
        label: DoorText(label, DoorTextStyle.norm),
        selected: selected,
        onSelected: onSelected,
        showCheckmark: true,
        avatar: null,
        // Outlined when unselected:
        side: BorderSide(
          color: DoorColor.darkEmph,
          width: 2.0
        ),
        backgroundColor: DoorColor.reverse, // Unselected fill
        selectedColor: DoorColor.lightEmph, // Selected fill
        checkmarkColor: DoorColor.greyBlur,
      ),
    );
  }
}