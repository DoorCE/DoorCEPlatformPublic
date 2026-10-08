import 'package:app_platform/common/view_elements/button.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:flutter/material.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';

class DoorTextFormFieldWithAddButton extends StatefulWidget {
  final List<String> items;
  final bool singleAdd;
  final bool enabled;
  final bool isRequired;
  final void Function(List<String>) onAdded;
  

  const DoorTextFormFieldWithAddButton({
    Key? key,
    required this.items,
    required this.onAdded,
    this.singleAdd = false,
    this.enabled = true,
    this.isRequired = false
  }) : super(key: key);

  @override
  _DoorTextFormFieldWithAddButtonState createState() => _DoorTextFormFieldWithAddButtonState();
}

class _DoorTextFormFieldWithAddButtonState extends State<DoorTextFormFieldWithAddButton> {
  final TextEditingController _controller = TextEditingController();
  late List<String> _itemList;

  @override
  void initState() {
    super.initState();
    _itemList = List.from(widget.items);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              DoorTextFormField(
                controller: _controller,
                enabled: widget.enabled,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return AppLocalizations.of(context)!.unsavedChanges;
                  }
                  if (widget.isRequired && _itemList.isEmpty) {
                    return AppLocalizations.of(context)!.fieldRequired;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),

        /// Add button
        Column(
          children: [
            const SizedBox(height: 4),
            DoorSimpleButtonIcon(
              enabled: widget.enabled,
              AppLocalizations.of(context)!.add,
              Icons.add_circle_outlined,
              () {
                final doc = _controller.text;
                if ((!widget.singleAdd || _itemList.isEmpty) && doc.isNotEmpty && !_itemList.contains(doc)) {
                  setState(() {
                    _itemList.add(doc);
                    _controller.clear();
                  });
                  widget.onAdded(_itemList);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}