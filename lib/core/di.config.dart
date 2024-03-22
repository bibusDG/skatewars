// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:skatewars/features/add_skate_spot_page/data/datasources/add_skate_spot_data_source.dart'
    as _i3;
import 'package:skatewars/features/add_skate_spot_page/data/repositories/add_skate_spot_repo_imp.dart'
    as _i5;
import 'package:skatewars/features/add_skate_spot_page/domain/repositories/add_skate_spot_repo.dart'
    as _i4;
import 'package:skatewars/features/add_skate_spot_page/domain/usecases/add_skate_spot_usecase.dart'
    as _i6;
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_skate_spot_cubit.dart'
    as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AddSkateSpotDataSource>(() => _i3.AddSkateSpotDataImp());
    gh.singleton<_i4.AddSkateSpotRepo>(() => _i5.AddSkateSpotRepoImp(
        addSkateSpotDataSource: gh<_i3.AddSkateSpotDataSource>()));
    gh.factory<_i6.AddSkateSpotUseCase>(
        () => _i6.AddSkateSpotUseCase(repo: gh<_i4.AddSkateSpotRepo>()));
    gh.factory<_i7.AddSkateSpotCubit>(() => _i7.AddSkateSpotCubit(
        addSkateSpotUseCase: gh<_i6.AddSkateSpotUseCase>()));
    return this;
  }
}
