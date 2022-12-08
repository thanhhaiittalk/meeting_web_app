enum LoginStatus {
  /// The login was successful and the user is now logged in.
  loggedIn,

  /// The user cancelled the login flow, usually by closing the 
  /// login dialog.
  cancelledByUser,

  /// The login completed with an error and the user couldn't log
  /// in for some reason.
  error,
}

class AuthResult{
  LoginStatus loginStatus;
  String? accessToken;
  String? errMessage;

  AuthResult(this.loginStatus,this.accessToken,{this.errMessage});
}


abstract class AuthLogin{
  AuthLogin.internal();
  Future<AuthResult>login();
  Future<void>logout();
}
