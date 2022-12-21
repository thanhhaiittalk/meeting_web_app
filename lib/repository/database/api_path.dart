class APIPath {
  static String userInfo(String? uid) => 'users/$uid';
  static String meetingInfo(String? meetingID) => 'meetings/$meetingID';
  static String users() => 'users';
  static String meetings(String? uid) => 'meetings';
}