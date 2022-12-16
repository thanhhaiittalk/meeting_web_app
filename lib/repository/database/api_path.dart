class APIPath {
  static String userInfo(String? uid) => 'users/$uid';
  static String meetingInfo(String? uid, String meetingID) => 'users/$uid/meetings/$meetingID';
  static String users() => 'users';
  static String meetings(String? uid) => 'users/$uid/meetings';
}