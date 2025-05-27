class SigninEntity {

  final String? displayMessage;
  final String? message;
  final int? statusCode;
  final ResponseEntity? response;


  SigninEntity({
    required this.displayMessage,
    required this.message,
    required this.statusCode,
    required this.response,
  });

  factory SigninEntity.fromJson(Map<String, dynamic> json) {
    return SigninEntity(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      displayMessage: json['displayMessage'] as String?,
      response: json['response'] != null
          ? ResponseEntity.fromJson(json['response'])
          : null,
    );
  }

}


class ResponseEntity {
  final String? page;
  final String? token;
  final String? roleCode;
  final List<MenuEntity>? menu;
  final bool? isConsent;
  final bool? firstLogin;

  ResponseEntity({
    this.page,
    this.token,
    this.roleCode,
    this.menu,
    this.isConsent,
    this.firstLogin,
  });

  factory ResponseEntity.fromJson(Map<String, dynamic> json) {
    return ResponseEntity(
      page: json['page'] as String?,
      token: json['token'] as String?,
      roleCode: json['roleCode'] as String?,
      menu: (json['menu'] as List<dynamic>?)
          ?.map((menuItem) => MenuEntity.fromJson(menuItem))
          .toList(),
      isConsent: json['isConsent'] as bool?,
      firstLogin: json['firstLogin'] as bool?,
    );
  }
}

class MenuEntity {
  final String? menuCode;

  MenuEntity({this.menuCode});

  factory MenuEntity.fromJson(Map<String, dynamic> json) {
    return MenuEntity(
      menuCode: json['menuCode'] as String?,
    );
  }
}