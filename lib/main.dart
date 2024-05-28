import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:score_keeper/di/bindings.dart';
import 'package:score_keeper/screens/addMatch/view/addMatchView.dart';
import 'package:score_keeper/screens/addPlayer/view/addPlayerView.dart';
import 'package:score_keeper/screens/enterEmail/view/enterEmailView.dart';
import 'package:score_keeper/screens/home/view/homeView.dart';
import 'package:score_keeper/screens/introScreens/view/introScreenView.dart';
import 'package:score_keeper/screens/matchDetails/view/matchDetailsView.dart';
import 'package:score_keeper/screens/matchesTabs/view/matchesTabView.dart';
import 'package:score_keeper/screens/noConnection/views/noConnectionView.dart';
import 'package:score_keeper/screens/playerDetails/view/playerDetailsView.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/playerList/view/playerListView.dart';
import 'package:score_keeper/screens/profile/views/profileView.dart';
import 'package:score_keeper/screens/publicMatchDetails/views/publicMatchDetailsView.dart';
import 'package:score_keeper/screens/shareDetails/views/shareDetailsView.dart';
import 'package:score_keeper/screens/splash/view/splashView.dart';
import 'package:score_keeper/screens/teamList/view/teamListView.dart';
import 'package:score_keeper/screens/teamMatches/view/teamMatchesView.dart';
import 'package:score_keeper/screens/teamPlayerList/view/teamPlayerListView.dart';
import 'package:score_keeper/screens/userDetails/view/userDetailsView.dart';
import 'package:score_keeper/screens/verifyEmail/view/verifyEmailView.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:logging/logging.dart';
import 'package:score_keeper/utils/firebaseDynamicLinkUtils.dart';
import 'package:score_keeper/utils/firebaseMessagingUtils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  await FirebaseMessagingUtils.initNotifications();
  await FirebaseDynamicLinkUtils.initDynamicLinks();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: CustomColors.background,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: CustomColors.appBarColor,
        ),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      initialRoute: SplashView.routeName,
      getPages: [
        GetPage(
          name: SplashView.routeName,
          page: () => const SplashView(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: EnterEmailView.routeName,
          page: () => EnterEmailView(),
          binding: EnterEmailBinding(),
        ),
        GetPage(
          name: VerifyEmail.routeName,
          page: () => VerifyEmail(),
          binding: VerifyEmailBinding(),
        ),
        GetPage(
          name: PlayerListView.routeName,
          page: () => PlayerListView(),
        ),
        GetPage(
          name: MatchesTabView.routeName,
          page: () => const MatchesTabView(),
        ),
        GetPage(
          name: MatchDetailsView.routeName,
          page: () => MatchDetailsView(),
          binding: MatchDetailsBinding(),
        ),
        GetPage(
          name: HomeView.routeName,
          page: () => HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: TeamListView.routeName,
          page: () => TeamListView(),
        ),
        GetPage(
          name: AddMatchView.routeName,
          page: () => AddMatchView(),
          binding: AddMatchBinding(),
        ),
        GetPage(
          name: AddPlayerView.routeName,
          page: () => AddPlayerView(),
          binding: AddPlayerBinding(),
        ),
        GetPage(
          name: PlayerDetailsView.routeName,
          page: () => PlayerDetailsView(),
          binding: PlayerDetailsBinding(),
        ),
        GetPage(
          name: IntroScreenView.routeName,
          page: () => const IntroScreenView(),
          binding: IntroViewBindings(),
        ),
        GetPage(
          name: TeamPlayerListView.routeName,
          page: () => TeamPlayerListView(),
          binding: TeamPlayerListBinding(),
        ),
        GetPage(
          name: TeamMatchesView.routeName,
          page: () => TeamMatchesView(),
          binding: TeamMatchesViewBinding(),
        ),
        GetPage(
          name: ShareDetailsView.routeName,
          page: () => ShareDetailsView(),
          binding: ShareDetailsBinding(),
        ),
        GetPage(
          name: ProfileView.routeName,
          page: () => ProfileView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: PublicMatchDetailsView.routeName,
          page: () => PublicMatchDetailsView(),
          binding: PublicMatchDetailsBindings(),
        ),
        GetPage(
          name: NoConnectionView.routeName,
          page: () => NoConnectionView(),
        ),
        GetPage(
          name: UserDetailsView.routeName,
          page: () => UserDetailsView(),
          binding: UserDetailsBindings(),
        ),
      ],
    );
  }
}
