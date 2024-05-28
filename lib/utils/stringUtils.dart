class StringUtils {
  static const String MATCH_NOTIFCATION =
      'Create Your First Match! Add a Game and Start Scoring Goals.';
  static const String PLAYER_NOTIFICATION =
      'Complete Your Team! Add Players Now and Get Ready for the Game.';
  static const String OPEN_CAMERA = 'Open Camera';
  static const String SELECT_FROM_GALLERY = 'Select from Gallery';
  static const String OKAY = 'Okay';
  static const String DELETE = 'Delete';
  static const String DELETE_CONFIRMATION = 'Are you sure you want to delete?';
  static const String CANCEL = 'Cancel';
  static const String PROGRESS = 'In Progress';
  static const String FULL_TIME = 'Full Time';
  static const String NOT_STARTED = 'Not Started';
  static const String LIVE = 'Live';
  static const String PAUSED = 'Paused';
  static const String TEAM = 'Team';
  static const String KICK_OFF = 'Kick Off';
  static const String RESUME = 'Resume';
  static const String PAUSE = 'Pause';
  static const String IN_PROGRESS_STATUS = 'IN_PROGRESS';
  static const String COMPLETED_STATUS = 'COMPLETED';
  static const String PLEASE_ENTER = 'please enter';
  static const String TAG_ALREADY_ENTERED = 'Tag already entered';
  static const String ENTER_TAGS = 'Enter Tags...';

  /************************************ API Endpoints *****************************/
  static const String POST_METHOD = 'POST';
  static const String GET_METHOD = 'GET';
  static const String DELETE_METHOD = 'DELETE';
  static const String PUT_METHOD = 'PUT';

  static const String BASE_URL_STAGING = "localhost:8080";

  static const String sendOtp = '/api/auth/sendotp';
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String matchList = '/api/match/list';
  static const String createMatch = '/api/match/create';
  static const String getScoreTypes = '/api/match/scoretypes';
  static const String addPublicMatches = '/api/match/addPublicMatches';
  static const String getPlayerList = '/api/player/list';
  static const String getPlayerPositions = '/api/player/positions';
  static const String addPlayer = '/api/player/create';
  static const String editPlayer = '/api/player/edit';
  static const String deletePlayer = '/api/player/delete';
  static const String getTags = '/api/player/tags';
  static const String getTeams = '/api/team/list';
  static const String createTeams = '/api/team/create';
  static const String editTeams = '/api/team/edit';
  static const String deleteTeams = '/api/team/delete';
  static const String editUser = '/api/user/';
}
