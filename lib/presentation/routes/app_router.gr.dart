// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;
import 'package:recon/presentation/pages/auth/forgetpassword_page.dart' as _i5;
import 'package:recon/presentation/pages/auth/login_page.dart' as _i8;
import 'package:recon/presentation/pages/auth/onboard_page.dart' as _i11;
import 'package:recon/presentation/pages/auth/signin_page.dart' as _i13;
import 'package:recon/presentation/pages/auth/termscondition_page.dart' as _i16;
import 'package:recon/presentation/pages/games/memory_match_game_page.dart'
    as _i10;
import 'package:recon/presentation/pages/games/snake_game_page.dart' as _i14;
import 'package:recon/presentation/pages/games/tap_the_target_game_page.dart'
    as _i15;
import 'package:recon/presentation/pages/games/wordle_game_page.dart' as _i17;
import 'package:recon/presentation/pages/home/home_page.dart' as _i6;
import 'package:recon/presentation/pages/tools/base32_page.dart' as _i1;
import 'package:recon/presentation/pages/tools/datepicker_page.dart' as _i2;
import 'package:recon/presentation/pages/tools/flushbar_page.dart' as _i4;
import 'package:recon/presentation/pages/tools/maintool_page.dart' as _i9;
import 'package:recon/presentation/pages/tools/settings_page.dart' as _i12;
import 'package:recon/presentation/pages/transaction/detail_transaction_page.dart'
    as _i3;
import 'package:recon/presentation/pages/tools/lazy_page.dart' as _i7;

/// generated route for
/// [_i1.Base32Page]
class Base32Route extends _i18.PageRouteInfo<void> {
  const Base32Route({List<_i18.PageRouteInfo>? children})
    : super(Base32Route.name, initialChildren: children);

  static const String name = 'Base32Route';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i1.Base32Page();
    },
  );
}

/// generated route for
/// [_i2.DatePickerPage]
class DatePickerRoute extends _i18.PageRouteInfo<void> {
  const DatePickerRoute({List<_i18.PageRouteInfo>? children})
    : super(DatePickerRoute.name, initialChildren: children);

  static const String name = 'DatePickerRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i2.DatePickerPage();
    },
  );
}

/// generated route for
/// [_i3.DetailTransactionPage]
class DetailTransactionRoute extends _i18.PageRouteInfo<void> {
  const DetailTransactionRoute({List<_i18.PageRouteInfo>? children})
    : super(DetailTransactionRoute.name, initialChildren: children);

  static const String name = 'DetailTransactionRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i3.DetailTransactionPage();
    },
  );
}

/// generated route for
/// [_i4.FlushbarPage]
class FlushbarRoute extends _i18.PageRouteInfo<void> {
  const FlushbarRoute({List<_i18.PageRouteInfo>? children})
    : super(FlushbarRoute.name, initialChildren: children);

  static const String name = 'FlushbarRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i4.FlushbarPage();
    },
  );
}

/// generated route for
/// [_i5.ForgetpasswordPage]
class ForgetpasswordRoute extends _i18.PageRouteInfo<void> {
  const ForgetpasswordRoute({List<_i18.PageRouteInfo>? children})
    : super(ForgetpasswordRoute.name, initialChildren: children);

  static const String name = 'ForgetpasswordRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.ForgetpasswordPage();
    },
  );
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomePage();
    },
  );
}

/// generated route for
/// [_i7.LazyPage]
class LazyRoute extends _i18.PageRouteInfo<void> {
  const LazyRoute({List<_i18.PageRouteInfo>? children})
    : super(LazyRoute.name, initialChildren: children);

  static const String name = 'LazyRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i7.LazyPage();
    },
  );
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i8.LoginPage();
    },
  );
}

/// generated route for
/// [_i9.MaintoolPage]
class MaintoolRoute extends _i18.PageRouteInfo<MaintoolRouteArgs> {
  MaintoolRoute({
    _i19.Key? key,
    required String username,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         MaintoolRoute.name,
         args: MaintoolRouteArgs(key: key, username: username),
         initialChildren: children,
       );

  static const String name = 'MaintoolRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MaintoolRouteArgs>();
      return _i9.MaintoolPage(key: args.key, username: args.username);
    },
  );
}

class MaintoolRouteArgs {
  const MaintoolRouteArgs({this.key, required this.username});

  final _i19.Key? key;

  final String username;

  @override
  String toString() {
    return 'MaintoolRouteArgs{key: $key, username: $username}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MaintoolRouteArgs) return false;
    return key == other.key && username == other.username;
  }

  @override
  int get hashCode => key.hashCode ^ username.hashCode;
}

/// generated route for
/// [_i10.MemoryMatchGamePage]
class MemoryMatchGameRoute extends _i18.PageRouteInfo<void> {
  const MemoryMatchGameRoute({List<_i18.PageRouteInfo>? children})
    : super(MemoryMatchGameRoute.name, initialChildren: children);

  static const String name = 'MemoryMatchGameRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i10.MemoryMatchGamePage();
    },
  );
}

/// generated route for
/// [_i11.OnboardPage]
class OnboardRoute extends _i18.PageRouteInfo<void> {
  const OnboardRoute({List<_i18.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i11.OnboardPage();
    },
  );
}

/// generated route for
/// [_i12.SettingPage]
class SettingRoute extends _i18.PageRouteInfo<void> {
  const SettingRoute({List<_i18.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingPage();
    },
  );
}

/// generated route for
/// [_i13.SigninPage]
class SigninRoute extends _i18.PageRouteInfo<void> {
  const SigninRoute({List<_i18.PageRouteInfo>? children})
    : super(SigninRoute.name, initialChildren: children);

  static const String name = 'SigninRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i13.SigninPage();
    },
  );
}

/// generated route for
/// [_i14.SnakeGamePage]
class SnakeGameRoute extends _i18.PageRouteInfo<void> {
  const SnakeGameRoute({List<_i18.PageRouteInfo>? children})
    : super(SnakeGameRoute.name, initialChildren: children);

  static const String name = 'SnakeGameRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i14.SnakeGamePage();
    },
  );
}

/// generated route for
/// [_i15.TapTheTargetGamePage]
class TapTheTargetGameRoute extends _i18.PageRouteInfo<void> {
  const TapTheTargetGameRoute({List<_i18.PageRouteInfo>? children})
    : super(TapTheTargetGameRoute.name, initialChildren: children);

  static const String name = 'TapTheTargetGameRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i15.TapTheTargetGamePage();
    },
  );
}

/// generated route for
/// [_i16.TermsconditionPage]
class TermsconditionRoute extends _i18.PageRouteInfo<void> {
  const TermsconditionRoute({List<_i18.PageRouteInfo>? children})
    : super(TermsconditionRoute.name, initialChildren: children);

  static const String name = 'TermsconditionRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i16.TermsconditionPage();
    },
  );
}

/// generated route for
/// [_i17.WordleGamePage]
class WordleGameRoute extends _i18.PageRouteInfo<void> {
  const WordleGameRoute({List<_i18.PageRouteInfo>? children})
    : super(WordleGameRoute.name, initialChildren: children);

  static const String name = 'WordleGameRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i17.WordleGamePage();
    },
  );
}
