import 'package:get/get.dart';
import 'package:score_keeper/di/services/auth/authService.dart';
import 'package:score_keeper/di/services/match/matchService.dart';
import 'package:score_keeper/di/services/players/playerService.dart';
import 'package:score_keeper/di/services/teams/teamMultipartServices.dart';
import 'package:score_keeper/di/services/teams/teamService.dart';
import 'package:score_keeper/di/services/user/userService.dart';
import 'package:score_keeper/screens/addMatch/controllers/addMatchController.dart';
import 'package:score_keeper/screens/addPlayer/controllers/addPlayerController.dart';
import 'package:score_keeper/screens/enterEmail/controllers/enterEmailController.dart';
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/introScreens/controllers/introController.dart';
import 'package:score_keeper/screens/matchDetails/controllers/matchDetailsController.dart';
import 'package:score_keeper/screens/matchesTabs/controllers/matchesTabController.dart';
import 'package:score_keeper/screens/playerDetails/controllers/playerDetailsController.dart';
import 'package:score_keeper/screens/playerList/controllers/playerListController.dart';
import 'package:score_keeper/screens/profile/controllers/profileController.dart';
import 'package:score_keeper/screens/publicMatchDetails/controllers/publicMatchDetailsController.dart';
import 'package:score_keeper/screens/shareDetails/controllers/shareDetailsController.dart';
import 'package:score_keeper/screens/splash/controllers/splashController.dart';
import 'package:score_keeper/screens/teamList/controllers/teamListController.dart';
import 'package:score_keeper/screens/teamMatches/controllers/teamMatchesController.dart';
import 'package:score_keeper/screens/teamPlayerList/controllers/teamPlayerListController.dart';
import 'package:score_keeper/screens/userDetails/controller/userDetailsController.dart';
import 'package:score_keeper/screens/verifyEmail/controllers/verifyEmailController.dart';
import 'package:score_keeper/utils/connectionListenerController.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ConnectionListenerController>(ConnectionListenerController());
    Get.put<AuthService>(AuthService.create());
    Get.put<TeamService>(TeamService.create());
    Get.put<TeamMultipartServices>(TeamMultipartServices.create());
    Get.put<MatchService>(MatchService.create());
    Get.put<PlayerService>(PlayerService.create());
    Get.put<UserService>(UserService.create());
  }
}

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}

class EnterEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EnterEmailController>(EnterEmailController());
  }
}

class VerifyEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<VerifyEmailController>(VerifyEmailController());
  }
}

class MatchDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MatchDetailsController>(MatchDetailsController());
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MatchesTabController>(MatchesTabController());
    Get.put<HomeController>(HomeController());
    Get.put<PlayerListController>(PlayerListController());
    Get.put<TeamListController>(TeamListController());
  }
}

class TeamListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TeamListController>(TeamListController());
  }
}

class AddMatchBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddMatchController>(AddMatchController());
  }
}

class AddPlayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddPlayerController>(AddPlayerController());
  }
}

class PlayerDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PlayerDetailsController>(PlayerDetailsController());
  }
}

class TeamPlayerListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TeamPlayerListController());
  }
}

class MatchesTabBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MatchesTabController());
  }
}

class TeamMatchesViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TeamMatchesController());
  }
}

class ShareDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ShareDetailsController());
  }
}

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}

class PublicMatchDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PublicMatchDetailsController());
  }
}

class IntroViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(IntroController());
  }
}

class UserDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserDetailsController());
  }
}