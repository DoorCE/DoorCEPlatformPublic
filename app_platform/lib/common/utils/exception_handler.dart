import 'package:app_platform/common/view_elements/snack_message.dart';
import 'package:app_platform/common/view_elements/wait_message.dart';
import 'package:app_platform/modules/app_mgmt/usecases/show_app_management.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';

mixin ExceptionHandler {
  Future<void> tryForApiExceptions(BuildContext context, Future<void> Function() action) async {
    try {
      await action();
    } on AuthenticationException {
      WaitMessage().dismiss();
      SnackMessage().show(context, true, text: AppLocalizations.of(context)!.reloginRequired);
      context.read<IUCAppManagement>().startSelected(context);
    } catch (e, stack) {
      WaitMessage().dismiss();
      SnackMessage().show(context, true, text: 'Error: $e');
      //TODO: dedicated error pages
      context.read<IUCAppManagement>().startSelected(context);
      Logger.root.severe(e);
      Logger.root.severe(stack);
    }
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}