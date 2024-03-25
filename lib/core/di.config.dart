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
    as _i8;
import 'package:skatewars/features/add_skate_spot_page/data/repositories/add_skate_spot_repo_imp.dart'
    as _i12;
import 'package:skatewars/features/add_skate_spot_page/domain/repositories/add_skate_spot_repo.dart'
    as _i11;
import 'package:skatewars/features/add_skate_spot_page/domain/usecases/add_skate_spot_usecase.dart'
    as _i13;
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_skate_spot_cubit.dart'
    as _i16;
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_spot_map_bloc/add_spot_map_cubit.dart'
    as _i14;
import 'package:skatewars/features/show_skate_spots_page/data/datasources/show_skate_spots_data_source.dart'
    as _i7;
import 'package:skatewars/features/show_skate_spots_page/data/repositories/show_skate_spot_repo_imp.dart'
    as _i10;
import 'package:skatewars/features/show_skate_spots_page/domain/repositories/show_skate_spots_repo.dart'
    as _i9;
import 'package:skatewars/features/show_skate_spots_page/domain/usecases/show_skate_spots_usecase.dart'
    as _i15;
import 'package:skatewars/features/show_skate_spots_page/presentation/bloc/show_skate_spots_cubit.dart'
    as _i17;
import 'package:skatewars/features/user_relations/data/datasources/user_relations_data_source.dart'
    as _i3;
import 'package:skatewars/features/user_relations/data/repositories/user_relations_repo_imp.dart'
    as _i5;
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart'
    as _i4;
import 'package:skatewars/features/user_relations/domain/usecases/get_user_curret_position_usecase.dart'
    as _i6;

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
    gh.singleton<_i3.UserRelationsDataSource>(
        () => _i3.UserRelationsDataSourceImp());
    gh.singleton<_i4.UserRelationsRepo>(() => _i5.UserRelationsRepoImp(
        dataSource: gh<_i3.UserRelationsDataSource>()));
    gh.factory<_i6.GetUserCurrentPositionUseCase>(() =>
        _i6.GetUserCurrentPositionUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.singleton<_i7.ShowSkateSpotsDataSource>(
        () => _i7.ShowSkateSpotDataSourceImp());
    gh.singleton<_i8.AddSkateSpotDataSource>(() => _i8.AddSkateSpotDataImp());
    gh.singleton<_i9.ShowSkateSpotsRepo>(() => _i10.ShowSkateSpotRepoImp(
        showSkateSpotsDataSource: gh<_i7.ShowSkateSpotsDataSource>()));
    gh.singleton<_i11.AddSkateSpotRepo>(() => _i12.AddSkateSpotRepoImp(
        addSkateSpotDataSource: gh<_i8.AddSkateSpotDataSource>()));
    gh.factory<_i13.AddSkateSpotUseCase>(
        () => _i13.AddSkateSpotUseCase(repo: gh<_i11.AddSkateSpotRepo>()));
    gh.factory<_i14.AddSpotMapCubit>(() => _i14.AddSpotMapCubit(
        getUserCurrentPositionUseCase:
            gh<_i6.GetUserCurrentPositionUseCase>()));
    gh.factory<_i15.ShowSkateSpotsUseCase>(() => _i15.ShowSkateSpotsUseCase(
        showSkateSpotsRepo: gh<_i9.ShowSkateSpotsRepo>()));
    gh.factory<_i16.AddSkateSpotCubit>(() => _i16.AddSkateSpotCubit(
          addSkateSpotUseCase: gh<_i13.AddSkateSpotUseCase>(),
          getUserCurrentPositionUseCase:
              gh<_i6.GetUserCurrentPositionUseCase>(),
        ));
    gh.factory<_i17.ShowSkateSpotsCubit>(() => _i17.ShowSkateSpotsCubit(
          showSkateSpotsUseCase: gh<_i15.ShowSkateSpotsUseCase>(),
          getUserCurrentPositionUseCase:
              gh<_i6.GetUserCurrentPositionUseCase>(),
        ));
    return this;
  }
}
