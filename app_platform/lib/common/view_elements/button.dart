import 'dart:typed_data';

import 'package:app_platform/common/view_elements/style.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:flutter/material.dart';

enum DoorButtonStyle { main, emph, norm }

class DoorButtonPlain extends StatelessWidget {
  final String _text;
  final Function()? _onPressed;
  final bool enabled;

  const DoorButtonPlain(this._text, this._onPressed, {this.enabled = true, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: enabled ? _onPressed : null,
        style: ElevatedButton.styleFrom(backgroundColor: DoorColor.darkEmph),
        child: DoorText(_text, DoorTextStyle.reverse));
  }
}

class DoorSimpleButtonIcon extends StatelessWidget {
  final String _tooltip;
  final IconData _icon;
  final Function()? _onPressed;
  final bool enabled;

  const DoorSimpleButtonIcon(this._tooltip, this._icon, this._onPressed,
      {this.enabled = true, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      disabledColor: DoorColor.grey,
      tooltip: _tooltip,
      icon: Icon(_icon, color: DoorColor.black, weight: 10, size: 20),
      onPressed: this.enabled ? _onPressed : null,
    );
  }
}

class DoorSimpleButtonImageFile extends StatelessWidget {
  final String? _tooltip;
  final Uint8List _iconFile;
  final Function() _onPressed;

  const DoorSimpleButtonImageFile(this._tooltip, this._iconFile, this._onPressed,
      {super.key});

  @override
  Widget build(BuildContext context) {
    Image icon = Image.memory(_iconFile, height: 32);
    return IconButton(
      tooltip: _tooltip,
      icon: icon,
      onPressed: _onPressed,
    );
  }
}

class DoorButtonText extends StatelessWidget {
  final String _text;
  final Function() _onPressed;
  final bool isActive;

  const DoorButtonText(this._text, this._onPressed, this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressed,
      child: DoorText(
        _text,
        isActive ? DoorTextStyle.centerHighlight : DoorTextStyle.center,
      ),
    );
  }
}

class DoorButtonIcon extends StatelessWidget {
  final String _text;
  final IconData _icon;
  final Function() _onPressed;
  final bool enabled;

  const DoorButtonIcon(this._text, this._icon, this._onPressed, {this.enabled = true, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(_icon, color: DoorColor.reverse),
        label: DoorText(_text, DoorTextStyle.reverse),
        onPressed: this.enabled ? _onPressed : null,
        style: ElevatedButton.styleFrom(backgroundColor: DoorColor.darkEmph));
  }
}

class DoorButtonColumn extends StatelessWidget {
  final List<(String, IconData, Function(), bool)> _buttons;

  const DoorButtonColumn(this._buttons, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>.empty(growable: true);

    for (var i = 0; i < _buttons.length; i++) {
      widgets
          .add(DoorButtonIcon(_buttons[i].$1, _buttons[i].$2, _buttons[i].$3, enabled: _buttons[i].$4));
      if (i != _buttons.length - 1) {
        widgets.add(const SizedBox(height: 3));
      }
    }
    return IntrinsicWidth(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: widgets));
  }
}

class DoorButtonRow extends StatelessWidget {
  final List<(String, IconData, Function())> _buttons;

  const DoorButtonRow(this._buttons, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>.empty(growable: true);

    for (var i = 0; i < _buttons.length; i++) {
      widgets
          .add(DoorButtonIcon(_buttons[i].$1, _buttons[i].$2, _buttons[i].$3));
      if (i != _buttons.length - 1) {
        widgets.add(const SizedBox(width: 3));
      }
    }
    return Row(children: widgets);
  }
}

class DoorButtonCard extends StatelessWidget {
  final String _text;
  final Function()? _onPressed;
  final String leftRight;
  final bool? isSelected;

  const DoorButtonCard(
      this._text, this._onPressed, this.leftRight, this.isSelected,
      {super.key});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius;
    if (leftRight == 'left') {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        bottomLeft: Radius.circular(8.0),
      );
    } else if (leftRight == 'right') {
      borderRadius = const BorderRadius.only(
        topRight: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
      );
    } else {
      // middle or any other value: no rounded corners
      borderRadius = BorderRadius.zero;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: isSelected == true
              ? const BorderSide(width: 3, color: Colors.grey)
              : BorderSide.none,
          left: isSelected == true ? BorderSide.none : BorderSide.none,
          right: isSelected == true
              ? const BorderSide(width: 2, color: Colors.grey)
              : BorderSide.none,
          bottom: isSelected == true
              ? BorderSide.none
              : const BorderSide(width: 3, color: Colors.grey),
        ),
        color: isSelected == true ? DoorColor.lightBlue : DoorColor.darkEmph,
        borderRadius: borderRadius,
        boxShadow: [
          if (isSelected == true)
            const BoxShadow(
              color: Colors.black,
            ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 5,
            spreadRadius: -5.0,
          ),
          if (isSelected != true)
            const BoxShadow(
              color: Colors.white,
            ),
          const BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            spreadRadius: -5.0,
          ),
        ],
      ),
      child: TextButton(
        onPressed: _onPressed,
        style: TextButton.styleFrom(
          backgroundColor: DoorColor.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: DoorText(_text, DoorTextStyle.emph),
      ),
    );
  }
}

class DoorButtonTextRow extends StatelessWidget {
  final List<(String, Function(), bool)> _buttons;

  const DoorButtonTextRow(this._buttons, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>.empty(growable: true);

    for (var i = 0; i < _buttons.length; i++) {
      widgets
          .add(DoorButtonText(_buttons[i].$1, _buttons[i].$2, _buttons[i].$3));
      if (i != _buttons.length - 1) {
        widgets.add(const SizedBox(width: 3));
      }
    }
    return Wrap(children: widgets);
  }
}

class DoorSimpleButtonIconRow extends StatelessWidget {
  final List<(String, IconData, Function()?)> _buttons;

  const DoorSimpleButtonIconRow(this._buttons, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>.empty(growable: true);

    for (var i = 0; i < _buttons.length; i++) {
      widgets.add(
          DoorSimpleButtonIcon(_buttons[i].$1, _buttons[i].$2,_buttons[i].$3, enabled: (null != _buttons[i].$3)));
      if (i != _buttons.length - 1) {
        widgets.add(const SizedBox(width: 3));
      }
    }
    return Wrap(children: widgets);
  }
}

class DoorButtonLoading extends StatefulWidget {
  final String _text;
  final Function()? _onPressed;
  final bool isLoading;
  final bool enabled;

  const DoorButtonLoading(this._text, this._onPressed,{this.isLoading = false, this.enabled=true, super.key});

  @override
  _DoorButtonLoadingState createState() => _DoorButtonLoadingState();
}

class _DoorButtonLoadingState extends State<DoorButtonLoading> {
  bool isLoading = false;

  _onPressed () async {
    if (isLoading) return;
    setState(() => isLoading = true);
    try {
      await widget._onPressed!();
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (true == widget.enabled)
      return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: DoorColor.darkEmph),
          child: isLoading
            ? CircularProgressIndicator(color: DoorColor.reverse)
            : DoorText(widget._text, DoorTextStyle.reverse),
          onPressed: _onPressed
        );
    return ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: DoorColor.darkEmph),
            child: isLoading
              ? CircularProgressIndicator(color: DoorColor.reverse)
              : DoorText(widget._text, DoorTextStyle.reverse),
            onPressed: null
          );
  }
}

class DoorSegmentedButton extends StatefulWidget {
  final List<String> options;
  final String initialSelection;
  final Function(String) onSelectionChanged;

  const DoorSegmentedButton({
    required this.options,
    required this.initialSelection,
    required this.onSelectionChanged,
    super.key,
  });

  @override
  _DoorSegmentedButtonState createState() => _DoorSegmentedButtonState();
}

class _DoorSegmentedButtonState extends State<DoorSegmentedButton> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(DoorColor.lightBlue),
        overlayColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue.withAlpha(30);
          }
          return null;
        }),
        shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
        elevation: WidgetStateProperty.all<double>(0),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(color: DoorColor.greyBlur),
          ),
        ),
      ),
      segments: widget.options.map((option) {
        bool isSelected = option == selectedOption;
        return ButtonSegment(
          value: option,
          label: Container(
            decoration: BoxDecoration(
              boxShadow: [
                if (isSelected)
                  const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    spreadRadius: 1.0,
                  )
                else
                  const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    spreadRadius: 1.0,
                  )
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(option),
          ),
        );
      }).toList(),
      selected: {selectedOption},
      onSelectionChanged: (newSelection) {
        setState(() {
          selectedOption = newSelection.first;
        });
        widget.onSelectionChanged(selectedOption);
      },
    );
  }
}
