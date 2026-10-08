import 'package:app_platform/common/consts/routing_prefixes.dart';
import 'package:app_platform/modules/app_mgmt/usecases/refresh_app_statuses.dart';
import 'package:app_platform/modules/app_mgmt/usecases/show_run_app.dart';
import 'package:app_platform/modules/main_panel/view/door_app_bar.dart';
import 'package:app_platform/modules/app_mgmt/view/run_app.dart';
import 'package:app_platform/modules/main_panel/view/main_panel.dart';
import 'package:app_platform/modules/app_mgmt/usecases/show_app_management.dart';
import 'package:app_platform/modules/app_mgmt/view/app_management_window.dart';
import 'package:app_platform/modules/app_mgmt/view/presenters/p_run_app.dart';
import 'package:app_platform/modules/app_mgmt/view/presenters/p_app_management.dart';
import 'package:app_platform/modules/app_mgmt/view/controllers/c_app_management.dart';
import 'package:app_platform/modules/main_panel/view/controllers/c_door_drawer.dart';
import 'package:app_platform/common/view_elements/snack_message.dart';
import 'package:app_platform/services/agent_mgmt_api.dart';
import 'package:app_platform/services/app_mgmt.dart';
import 'package:app_platform/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:app_platform/locales/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';

void main() {
  final logLevelStr = const String.fromEnvironment('DEBUG', defaultValue: 'FALSE').toUpperCase();
  Logger.root.level = logLevelStr == "TRUE" ? Level.ALL : Level.CONFIG;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: UDAS-Platform: ${record.message}');
  });
  MultiProvider provider = setupDependencies();
  runApp(provider);
}

MultiProvider setupDependencies() {
  List<SingleChildWidget> providerList = List<SingleChildWidget>.empty(growable: true);

  // NEW PROVIDER FOR SERVICES
  providerList.add(Provider<AuthAPI>(create: (context) => KeycloakAuthService()));
  providerList.add(Provider<AgentManagementAPI>(create: (context) => AgentManagement(context.read())));
  providerList.add(Provider<AppManagementAPI>(create: (context) => AppManagement(context.read())));

  // View widgets with Controllers and Presenters
  providerList.add(Provider(create: (context) => const CAppManagement()));
  providerList.add(Provider(create: (context) => const CDoorDrawer()));
  providerList.add(Provider<IAppBarFactory>(create: (context) => VDoorAppBarFactory(context.read())));
  providerList.add(Provider(create: (context) => VMainPanelFactory(context.read())));
  providerList.add(Provider(create: (context) => VRunAppWindowFactory()));

  providerList.add(Provider(create: (context) => VAppManagementFactory()));
  providerList.add(Provider<IPAppManagement>(create: (context) => PAppManagement(context.read())));
  providerList.add(Provider<IPRunAppWindow>(create: (context) => PRunAppWindow(context.read())));
  
  // Use Cases
  providerList.add(Provider<IUCAppManagement>(create: (context) => UCAppManagement(context.read(), context.read(), context.read(), context.read())));
  providerList.add(Provider<IUCRunEditApp>(create: (context) =>
    UCRunEditApp(context.read(), context.read(), context.read())));
  providerList.add(Provider<IUCRefreshAppStatuses>(create: (context) => UCRefreshAppStatuses(context.read(), context.read(), context.read(), context.read())));

  return MultiProvider(providers: providerList, child: const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Logger.root.info("[MainApp build] starting the main app");
    return MaterialApp(
      initialRoute: '/',
      onGenerateInitialRoutes: (initialRoute) => [MainRouter.route(RouteSettings(name: initialRoute))!],
      onGenerateRoute: MainRouter.route,
      title: 'UDAS Application Platform',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
} 

class MainRouter{
  static Route<dynamic>? route (RouteSettings routeSettings) {
    Logger.root.fine('[Main router route] routing to: ${routeSettings.name}');
    int firstColonIndex = routeSettings.name?.indexOf(':') ?? -1;
    String? routingPrefix = -1 != firstColonIndex ? routeSettings.name?.substring(
      0, firstColonIndex) : routeSettings.name;
    List<String> routingParams = -1 != firstColonIndex ? routeSettings.name!.substring(routingPrefix!.length + 1).split(':') : [];

    Widget routeWidget;
    String param0, param1;
    
    try{
    switch (routingPrefix ?? '') {
      case RoutingPrefixes.runApp:
        Logger.root.fine('Routing to run app with query: ${routingParams.elementAtOrNull(0)}');
        routeWidget = _UseCaseWidget((context) => context
            .read<IUCRunEditApp>().showRunAppSelected(context, routingParams.elementAtOrNull(0) ?? "", routingParams.elementAtOrNull(1) ?? null));
        break;
      default:
        Logger.root.fine('Routing to main menu...');
        routeWidget = _UseCaseWidget((context) => context.read<IUCAppManagement>().startSelected(context));
        break;
    }
    } catch (e) {
      Logger.root.severe('Error during routing: $e');
      routeWidget = _UseCaseWidget((context) => context.read<IUCAppManagement>().startSelected(context));
    }

    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (context) => routeWidget,
    );
  }
}

// Helper widget to trigger use case logic once
class _UseCaseWidget extends StatefulWidget {
  final void Function(BuildContext) useCaseCall;
  const _UseCaseWidget(this.useCaseCall, {Key? key}) : super(key: key);

  @override
  State<_UseCaseWidget> createState() => _UseCaseWidgetState();
}

class _UseCaseWidgetState extends State<_UseCaseWidget> {
  late Future<void> _callFirst;

  @override
  void initState() {
    super.initState();
    _callFirst = _initAsync();
  }

  Future<void> _initAsync() async {
    bool wasAuthenticated = AuthStatus.authenticated == 
        await context.read<IUCAppManagement>().checkTokenAndSetAccount(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        Logger.root.fine("[UCWidget postFrameCallback] widget unmounted, skipping");
        return;
      }
      // final currentContext = navigatorKey.currentContext; // make sure to use the current context 
      // if (currentContext == null) return;
      if (wasAuthenticated && null == VMainPanelFactory.userAccount) {
        Logger.root.fine("[UCWidget postFrameCallback] auth backend error");
        SnackMessage().show(context, true, text: AppLocalizations.of(context)!.authBackendError);
      } else {
        Logger.root.fine("[UCWidget postFrameCallback] use case call");
        // TODO - differentiate between authenticated user and not authenticated user
        widget.useCaseCall(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Logger.root.fine("[UCWidget builder] rendering the loading screen");
    return FutureBuilder(
      future: _callFirst,
      builder: (context, snapshot) => Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset('images/doorce_loading.png'),
          ),
        ),
      ),
    );
  }
}