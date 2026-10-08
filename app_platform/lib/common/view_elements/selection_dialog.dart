import 'package:app_platform/common/view_elements/button.dart';
import 'package:app_platform/common/view_elements/style.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:flutter/material.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';

Future<int> showSelectionDialog(BuildContext context, String titleText, String contentText, List<String> selections) async {
  int selection = 1;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: DoorColor.lightBlue,
          title: SingleChildScrollView(child: DoorText(titleText, DoorTextStyle.subtitle)),
          content: SingleChildScrollView(child: DoorText(contentText, DoorTextStyle.center)),
          actions: [...selections.map((s) => 
            DoorButtonPlain(s, () {
              selection = selections.indexOf(s);
              Navigator.of(context).pop();
            })),
          ],
        );
      });
  return selection;
}

Future<int> showDeleteDialog(BuildContext context, String itemName) async {
  List<String> items = [AppLocalizations.of(context)!.yes, AppLocalizations.of(context)!.no];
  int response = await showSelectionDialog(context, itemName, AppLocalizations.of(context)!.toDelete, items);
  return response;
}

Future<int> showPublishDialog(BuildContext context, String itemName) async {
  List<String> items = [AppLocalizations.of(context)!.yes, AppLocalizations.of(context)!.no];
  int response = await showSelectionDialog(context, itemName, AppLocalizations.of(context)!.toPublish, items);
  return response;
}