import 'package:flutter/material.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';

class WaitMessage {
  static final WaitMessage _singleton = WaitMessage._internal();
  late BuildContext _context;
  bool isDisplayed = false;

  factory WaitMessage() {
    return _singleton;
  }

  WaitMessage._internal();

  show(BuildContext context) {
    if(isDisplayed) {
      return;
    }
    String text = AppLocalizations.of(context)!.loading;
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _context = context;
          isDisplayed = true;
          return PopScope(
            canPop: false,
            child: SimpleDialog(
              backgroundColor: Colors.white,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(text),
                      )
                    ],
                  ),
                )
              ] ,
            ),
          );
        }
    );
  }

  dismiss() {
    if(isDisplayed) {
      Navigator.of(_context).pop();
      isDisplayed = false;
    }
  }
}