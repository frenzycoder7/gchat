// ignore_for_file: non_constant_identifier_names

class ApiEndpoints {
  static String SOCKET_URL = 'https://socket.getyoursquad.in';
  static String BASEURL = 'https://api.getyoursquad.in/api/v1/';
  static String CHAT_SERVER = 'https://chats.getyoursquad.in/api/v1/';

  static String LOGIN = '${BASEURL}auth/login';
  static String SIGNUP = '${BASEURL}auth/register';
  static String VALIDATE_TOKEN = '${BASEURL}auth/validate-profile';
  static String FETCH_PLAYERS_UNAUTHORIZED =
      '${BASEURL}player/get/unauthorized';
  static String FETCH_PLAYERS = '${BASEURL}player/get';
  static String RESEND_VERIFICATION_MAIL = '${BASEURL}auth/resend-verify';
  static String CREATE_POST = '${BASEURL}player/';
  static String GET_PERSONAL_POST = '${BASEURL}player/personal-post';
  static String UPDATE_PERSONAL_POST = '${BASEURL}player/update';
  static String DELETE_PROFILE = '${BASEURL}player';
  static String FETCH_PLAYER_DETAILS = '${BASEURL}player/get-post'; //?id=1
  static String PRESIGNED_IMAGE_URL = '${BASEURL}player/presigned-url';

  static String FETCH_CONVERSATIONS = '${CHAT_SERVER}conversation';
  static String FETCH_CONVERSATION_MESSAGES =
      '${CHAT_SERVER}conversation/chats'; //?cid=1&page=1
}

class MatchServerEndpoints {
  static String MATCH_SERVER =
      'https://match.getyoursquad.in/api/v1/'; //'http://172.20.10.3:7003/api/v1/';

  static String FETCH_COINS = '${MATCH_SERVER}balance/fetch';
  static String ADD_COINS = '${MATCH_SERVER}balance/add-coin';
  static String FETCH_KEY = '${MATCH_SERVER}rozarpay-key';
  static String CANCEL_TRANSACTION =
      '${MATCH_SERVER}balance/cancel-transaction';
  static String FETCH_TRANSACTIONS = '${MATCH_SERVER}transactions/fetch';
  static String FETCH_PERSONAL_MATCHES = '${MATCH_SERVER}match/fetch-personal';
  static String FETCH_PUBLIC_MATCHES = '${MATCH_SERVER}match/public';
}
