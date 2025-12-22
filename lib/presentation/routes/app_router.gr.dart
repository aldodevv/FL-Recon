// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:recon/presentation/pages/auth/forgetpassword_page.dart' as _i6;
import 'package:recon/presentation/pages/auth/onboard_page.dart' as _i11;
import 'package:recon/presentation/pages/auth/termscondition_page.dart' as _i15;
import 'package:recon/presentation/pages/games/memory_match_game_page.dart'
    as _i10;
import 'package:recon/presentation/pages/games/snake_game_page.dart' as _i13;
import 'package:recon/presentation/pages/games/tap_the_target_game_page.dart'
    as _i14;
import 'package:recon/presentation/pages/games/wordle_game_page.dart' as _i18;
import 'package:recon/presentation/pages/tools/base32_page.dart' as _i1;
import 'package:recon/presentation/pages/tools/bridging_page.dart' as _i2;
import 'package:recon/presentation/pages/tools/datepicker_page.dart' as _i3;
import 'package:recon/presentation/pages/tools/flushbar_page.dart' as _i5;
import 'package:recon/presentation/pages/tools/form_page.dart' as _i7;
import 'package:recon/presentation/pages/tools/lazy_page.dart' as _i8;
import 'package:recon/presentation/pages/tools/maintool_page.dart' as _i9;
import 'package:recon/presentation/pages/tools/settings_page.dart' as _i12;
import 'package:recon/presentation/pages/tools/webview_page.dart' as _i17;
import 'package:recon/presentation/pages/transaction/detail_transaction_page.dart'
    as _i4;
import 'package:recon/presentation/pages/wildcard/unknow_page.dart' as _i16;

/// generated route for
/// [_i1.Base32Page]
class Base32Route extends _i19.PageRouteInfo<void> {
  const Base32Route({List<_i19.PageRouteInfo>? children})
    : super(Base32Route.name, initialChildren: children);

  static const String name = 'Base32Route';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i1.Base32Page();
    },
  );
}

/// generated route for
/// [_i2.BridgingPage]
class BridgingRoute extends _i19.PageRouteInfo<void> {
  const BridgingRoute({List<_i19.PageRouteInfo>? children})
    : super(BridgingRoute.name, initialChildren: children);

  static const String name = 'BridgingRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i2.BridgingPage();
    },
  );
}

/// generated route for
/// [_i3.DatePickerPage]
class DatePickerRoute extends _i19.PageRouteInfo<void> {
  const DatePickerRoute({List<_i19.PageRouteInfo>? children})
    : super(DatePickerRoute.name, initialChildren: children);

  static const String name = 'DatePickerRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i3.DatePickerPage();
    },
  );
}

/// generated route for
/// [_i4.DetailTransactionPage]
class DetailTransactionRoute extends _i19.PageRouteInfo<void> {
  const DetailTransactionRoute({List<_i19.PageRouteInfo>? children})
    : super(DetailTransactionRoute.name, initialChildren: children);

  static const String name = 'DetailTransactionRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i4.DetailTransactionPage();
    },
  );
}

/// generated route for
/// [_i5.FlushbarPage]
class FlushbarRoute extends _i19.PageRouteInfo<void> {
  const FlushbarRoute({List<_i19.PageRouteInfo>? children})
    : super(FlushbarRoute.name, initialChildren: children);

  static const String name = 'FlushbarRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i5.FlushbarPage();
    },
  );
}

/// generated route for
/// [_i6.ForgetpasswordPage]
class ForgetpasswordRoute extends _i19.PageRouteInfo<void> {
  const ForgetpasswordRoute({List<_i19.PageRouteInfo>? children})
    : super(ForgetpasswordRoute.name, initialChildren: children);

  static const String name = 'ForgetpasswordRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i6.ForgetpasswordPage();
    },
  );
}

/// generated route for
/// [_i7.FormPage]
class FormRoute extends _i19.PageRouteInfo<void> {
  const FormRoute({List<_i19.PageRouteInfo>? children})
    : super(FormRoute.name, initialChildren: children);

  static const String name = 'FormRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i7.FormPage();
    },
  );
}

/// generated route for
/// [_i8.LazyPage]
class LazyRoute extends _i19.PageRouteInfo<void> {
  const LazyRoute({List<_i19.PageRouteInfo>? children})
    : super(LazyRoute.name, initialChildren: children);

  static const String name = 'LazyRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i8.LazyPage();
    },
  );
}

/// generated route for
/// [_i9.MaintoolPage]
class MaintoolRoute extends _i19.PageRouteInfo<MaintoolRouteArgs> {
  MaintoolRoute({
    _i20.Key? key,
    required String username,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         MaintoolRoute.name,
         args: MaintoolRouteArgs(key: key, username: username),
         initialChildren: children,
       );

  static const String name = 'MaintoolRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MaintoolRouteArgs>();
      return _i9.MaintoolPage(key: args.key, username: args.username);
    },
  );
}

class MaintoolRouteArgs {
  const MaintoolRouteArgs({this.key, required this.username});

  final _i20.Key? key;

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
class MemoryMatchGameRoute extends _i19.PageRouteInfo<void> {
  const MemoryMatchGameRoute({List<_i19.PageRouteInfo>? children})
    : super(MemoryMatchGameRoute.name, initialChildren: children);

  static const String name = 'MemoryMatchGameRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i10.MemoryMatchGamePage();
    },
  );
}

/// generated route for
/// [_i11.OnboardPage]
class OnboardRoute extends _i19.PageRouteInfo<void> {
  const OnboardRoute({List<_i19.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i11.OnboardPage();
    },
  );
}

/// generated route for
/// [_i12.SettingPage]
class SettingRoute extends _i19.PageRouteInfo<void> {
  const SettingRoute({List<_i19.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingPage();
    },
  );
}

/// generated route for
/// [_i13.SnakeGamePage]
class SnakeGameRoute extends _i19.PageRouteInfo<void> {
  const SnakeGameRoute({List<_i19.PageRouteInfo>? children})
    : super(SnakeGameRoute.name, initialChildren: children);

  static const String name = 'SnakeGameRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i13.SnakeGamePage();
    },
  );
}

/// generated route for
/// [_i14.TapTheTargetGamePage]
class TapTheTargetGameRoute extends _i19.PageRouteInfo<void> {
  const TapTheTargetGameRoute({List<_i19.PageRouteInfo>? children})
    : super(TapTheTargetGameRoute.name, initialChildren: children);

  static const String name = 'TapTheTargetGameRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i14.TapTheTargetGamePage();
    },
  );
}

/// generated route for
/// [_i15.TermsconditionPage]
class TermsconditionRoute extends _i19.PageRouteInfo<void> {
  const TermsconditionRoute({List<_i19.PageRouteInfo>? children})
    : super(TermsconditionRoute.name, initialChildren: children);

  static const String name = 'TermsconditionRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i15.TermsconditionPage();
    },
  );
}

/// generated route for
/// [_i16.UnknowPage]
class UnknowRoute extends _i19.PageRouteInfo<void> {
  const UnknowRoute({List<_i19.PageRouteInfo>? children})
    : super(UnknowRoute.name, initialChildren: children);

  static const String name = 'UnknowRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i16.UnknowPage();
    },
  );
}

/// generated route for
/// [_i17.WebViewPage]
class WebViewRoute extends _i19.PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    _i20.Key? key,
    required String initialUrl,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         WebViewRoute.name,
         args: WebViewRouteArgs(key: key, initialUrl: initialUrl),
         initialChildren: children,
       );

  static const String name = 'WebViewRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return _i17.WebViewPage(key: args.key, initialUrl: args.initialUrl);
    },
  );
}

class WebViewRouteArgs {
  const WebViewRouteArgs({this.key, required this.initialUrl});

  final _i20.Key? key;

  final String initialUrl;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, initialUrl: $initialUrl}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WebViewRouteArgs) return false;
    return key == other.key && initialUrl == other.initialUrl;
  }

  @override
  int get hashCode => key.hashCode ^ initialUrl.hashCode;
}

/// generated route for
/// [_i18.WordleGamePage]
class WordleGameRoute extends _i19.PageRouteInfo<void> {
  const WordleGameRoute({List<_i19.PageRouteInfo>? children})
    : super(WordleGameRoute.name, initialChildren: children);

  static const String name = 'WordleGameRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i18.WordleGamePage();
    },
  );
}
