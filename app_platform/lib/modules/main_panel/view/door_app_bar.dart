import 'package:app_platform/common/utils/app_version.dart';
import 'package:app_platform/common/view_elements/button.dart';
import 'package:app_platform/common/view_elements/style.dart';
import 'package:app_platform/common/view_elements/text.dart';
import 'package:app_platform/dtos/app.dart';
import 'package:app_platform/dtos/user_account.dart';
import 'package:app_platform/modules/app_mgmt/usecases/show_app_management.dart';
import 'package:app_platform/modules/app_mgmt/view/controllers/c_app_management.dart';
import 'package:flutter/material.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

abstract interface class IAppBarFactory {
  AppBar get(BuildContext context, XUserAccount? userAccount, [XApp? currentApp]);
}

class VDoorAppBarFactory implements IAppBarFactory {
  final CAppManagement _cMainMenu;

  const VDoorAppBarFactory(this._cMainMenu);

  @override
  AppBar get(BuildContext context, XUserAccount? userAccount, [XApp? currentApp]) =>
      AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight + 80,
        flexibleSpace: Column(
          children: [
            _buildHeader(context),
            _buildActions(context, userAccount, currentApp),
          ],
        ),
      );

  Widget _buildHeader(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rightPadding = screenWidth > 600 ? 200 : screenWidth * 0.1;

    return Expanded(
      flex: 7,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/header_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset('images/doorce_logo.png'),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 200, right: rightPadding),
                child: DoorText(
                  AppLocalizations.of(context)!.platformName,
                  DoorTextStyle.title,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DoorText(
                  AppVersion.version,
                  DoorTextStyle.label,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildActions(BuildContext context, XUserAccount? userAccount, [XApp? currentApp]) {

    // Home icon
    Widget homeIcon = DoorSimpleButtonIcon(
      AppLocalizations.of(context)!.main, Icons.home,
      () => context.read<IUCAppManagement>().startSelected(context),
    );

    // Menu items
    Widget menuItems = currentApp == null ? Container() :
      DoorButtonTextRow([
      (
        currentApp.title,
        () => _cMainMenu.editAppSelected(context, currentApp.identifier),
        true
      ),
    ]);

    // Utility icons
    Widget utilityIcons = DoorSimpleButtonIconRow([
      // TODO - uncomment when user account settings are implemented
      // (AppLocalizations.of(context)!.settings, Icons.settings, () {}),
      (AppLocalizations.of(context)!.logout + (null != userAccount ? ": " + userAccount.userId : ""),
        Icons.logout, () => context.read<IUCAppManagement>().logoutSelected(context)),
    ]);

    return  Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: DoorColor.darkEmph,
          border: Border(
            top: BorderSide(color: DoorColor.black, width: 2),
            bottom: BorderSide(color: DoorColor.black, width: 2),
          ),
        ),
        child: Row(
          children: null != userAccount 
            ? [homeIcon, Expanded(child: menuItems), utilityIcons] 
            : []
        )
    );
  }
}
