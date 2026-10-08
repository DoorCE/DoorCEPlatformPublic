import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('hr'),
    Locale('it'),
    Locale('pl'),
    Locale('sk'),
    Locale('sl')
  ];

  /// No description provided for @platformName.
  ///
  /// In en, this message translates to:
  /// **'UDAS App Platform'**
  String get platformName;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get main;

  /// No description provided for @mainMenu.
  ///
  /// In en, this message translates to:
  /// **'Main Menu'**
  String get mainMenu;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @invalidIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Invalid Identifier'**
  String get invalidIdentifier;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @identifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get identifier;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'* Required'**
  String get fieldRequired;

  /// No description provided for @formError.
  ///
  /// In en, this message translates to:
  /// **'Errors in the form - check above'**
  String get formError;

  /// No description provided for @unsavedChanges.
  ///
  /// In en, this message translates to:
  /// **'Unsaved changes'**
  String get unsavedChanges;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @addIcon.
  ///
  /// In en, this message translates to:
  /// **'Add Icon'**
  String get addIcon;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @fromList.
  ///
  /// In en, this message translates to:
  /// **'From list'**
  String get fromList;

  /// No description provided for @own.
  ///
  /// In en, this message translates to:
  /// **'Own'**
  String get own;

  /// No description provided for @iconName.
  ///
  /// In en, this message translates to:
  /// **'Icon name'**
  String get iconName;

  /// No description provided for @selectIcon.
  ///
  /// In en, this message translates to:
  /// **'Icon selection'**
  String get selectIcon;

  /// No description provided for @wrongName.
  ///
  /// In en, this message translates to:
  /// **'Incorrect name or it already exists'**
  String get wrongName;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectFile;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview:'**
  String get preview;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @toDelete.
  ///
  /// In en, this message translates to:
  /// **'Deleting - are you sure?'**
  String get toDelete;

  /// No description provided for @toPublish.
  ///
  /// In en, this message translates to:
  /// **'Will be published - are you sure?'**
  String get toPublish;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @noRolesAssigned.
  ///
  /// In en, this message translates to:
  /// **'No roles assigned'**
  String get noRolesAssigned;

  /// No description provided for @clickToExpand.
  ///
  /// In en, this message translates to:
  /// **'Click to expand'**
  String get clickToExpand;

  /// No description provided for @selectRolesForEditors.
  ///
  /// In en, this message translates to:
  /// **'Select roles for all editors'**
  String get selectRolesForEditors;

  /// No description provided for @removeAgent.
  ///
  /// In en, this message translates to:
  /// **'Remove agent'**
  String get removeAgent;

  /// No description provided for @removeEditor.
  ///
  /// In en, this message translates to:
  /// **'Remove editor'**
  String get removeEditor;

  /// No description provided for @ownershipEditorError.
  ///
  /// In en, this message translates to:
  /// **'Select at least 1 Ownership Editor'**
  String get ownershipEditorError;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @unnamed.
  ///
  /// In en, this message translates to:
  /// **'Unnamed'**
  String get unnamed;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @noItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsFound;

  /// No description provided for @showing.
  ///
  /// In en, this message translates to:
  /// **'Showing'**
  String get showing;

  /// No description provided for @outOf.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get outOf;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get deleted;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @quantitative.
  ///
  /// In en, this message translates to:
  /// **'Quantitative'**
  String get quantitative;

  /// No description provided for @qualitative.
  ///
  /// In en, this message translates to:
  /// **'Qualitative'**
  String get qualitative;

  /// No description provided for @geospatial.
  ///
  /// In en, this message translates to:
  /// **'Geospatial'**
  String get geospatial;

  /// No description provided for @timeSeries.
  ///
  /// In en, this message translates to:
  /// **'TimeSeries'**
  String get timeSeries;

  /// No description provided for @textual.
  ///
  /// In en, this message translates to:
  /// **'Textual'**
  String get textual;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'available'**
  String get available;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'unavailable'**
  String get unavailable;

  /// No description provided for @defective.
  ///
  /// In en, this message translates to:
  /// **'Defective'**
  String get defective;

  /// No description provided for @public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get public;

  /// No description provided for @confidential.
  ///
  /// In en, this message translates to:
  /// **'Confidential'**
  String get confidential;

  /// No description provided for @nonPublic.
  ///
  /// In en, this message translates to:
  /// **'NonPublic'**
  String get nonPublic;

  /// No description provided for @restricted.
  ///
  /// In en, this message translates to:
  /// **'Restricted'**
  String get restricted;

  /// No description provided for @sensitive.
  ///
  /// In en, this message translates to:
  /// **'Sensitive'**
  String get sensitive;

  /// No description provided for @provisional.
  ///
  /// In en, this message translates to:
  /// **'Provisional'**
  String get provisional;

  /// No description provided for @distributionEditor.
  ///
  /// In en, this message translates to:
  /// **'Distribution Editor'**
  String get distributionEditor;

  /// No description provided for @metadataEditor.
  ///
  /// In en, this message translates to:
  /// **'Metadata Editor'**
  String get metadataEditor;

  /// No description provided for @ownershipEditor.
  ///
  /// In en, this message translates to:
  /// **'Ownership Editor'**
  String get ownershipEditor;

  /// No description provided for @agentManager.
  ///
  /// In en, this message translates to:
  /// **'Agent Manager'**
  String get agentManager;

  /// No description provided for @metadataManager.
  ///
  /// In en, this message translates to:
  /// **'Metadata Manager'**
  String get metadataManager;

  /// No description provided for @distributionManager.
  ///
  /// In en, this message translates to:
  /// **'Distribution Manager'**
  String get distributionManager;

  /// No description provided for @ownershipManager.
  ///
  /// In en, this message translates to:
  /// **'Ownership Manager'**
  String get ownershipManager;

  /// No description provided for @agentAdmin.
  ///
  /// In en, this message translates to:
  /// **'Agent Admin'**
  String get agentAdmin;

  /// No description provided for @dataAdmin.
  ///
  /// In en, this message translates to:
  /// **'Data Admin'**
  String get dataAdmin;

  /// No description provided for @schemaCreator.
  ///
  /// In en, this message translates to:
  /// **'Schema Creator'**
  String get schemaCreator;

  /// No description provided for @authKeycloakError.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed'**
  String get authKeycloakError;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to edit this resource'**
  String get authError;

  /// No description provided for @authBackendError.
  ///
  /// In en, this message translates to:
  /// **'User account does not exist or server not available'**
  String get authBackendError;

  /// No description provided for @reloginRequired.
  ///
  /// In en, this message translates to:
  /// **'Session timed out - login required'**
  String get reloginRequired;

  /// No description provided for @appList.
  ///
  /// In en, this message translates to:
  /// **'App List'**
  String get appList;

  /// No description provided for @selectDataset.
  ///
  /// In en, this message translates to:
  /// **'Select dataset'**
  String get selectDataset;

  /// No description provided for @saveAndRun.
  ///
  /// In en, this message translates to:
  /// **'Save and run'**
  String get saveAndRun;

  /// No description provided for @runApp.
  ///
  /// In en, this message translates to:
  /// **'Run App'**
  String get runApp;

  /// No description provided for @dataset.
  ///
  /// In en, this message translates to:
  /// **'Dataset'**
  String get dataset;

  /// No description provided for @template.
  ///
  /// In en, this message translates to:
  /// **'Template'**
  String get template;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @inProcessing.
  ///
  /// In en, this message translates to:
  /// **'In processing'**
  String get inProcessing;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get ready;

  /// No description provided for @hasErrors.
  ///
  /// In en, this message translates to:
  /// **'Has errors'**
  String get hasErrors;

  /// No description provided for @appStatusesRefreshed.
  ///
  /// In en, this message translates to:
  /// **'App statuses refreshed'**
  String get appStatusesRefreshed;

  /// No description provided for @refreshAppStatuses.
  ///
  /// In en, this message translates to:
  /// **'Refresh app statuses'**
  String get refreshAppStatuses;

  /// No description provided for @statusField.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusField;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @appNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'App is not enabled!'**
  String get appNotEnabled;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @unvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email (e.g. abc@gmail.com)'**
  String get unvalidEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @unvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get unvalidPassword;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Email or Password is incorrect'**
  String get loginFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'hr',
        'it',
        'pl',
        'sk',
        'sl'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'hr':
      return AppLocalizationsHr();
    case 'it':
      return AppLocalizationsIt();
    case 'pl':
      return AppLocalizationsPl();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
