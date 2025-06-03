// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:recon/presentation/bloc/login/login_bloc.dart' as _i581;
import 'package:recon/presentation/bloc/me/me_bloc.dart' as _i610;
import 'package:recon/presentation/bloc/transaction/balance/balance_bloc.dart'
    as _i141;
import 'package:recon/presentation/bloc/transaction/historytransaction/historyTrans_bloc.dart'
    as _i416;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i581.LoginBloc>(() => _i581.LoginBloc());
    gh.factory<_i141.BalanceBloc>(() => _i141.BalanceBloc());
    gh.factory<_i416.HistorytransBloc>(() => _i416.HistorytransBloc());
    gh.factory<_i610.MeBloc>(() => _i610.MeBloc());
    return this;
  }
}
