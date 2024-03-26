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
    as _i13;
import 'package:skatewars/features/add_skate_spot_page/data/repositories/add_skate_spot_repo_imp.dart'
    as _i17;
import 'package:skatewars/features/add_skate_spot_page/domain/repositories/add_skate_spot_repo.dart'
    as _i16;
import 'package:skatewars/features/add_skate_spot_page/domain/usecases/add_skate_spot_usecase.dart'
    as _i18;
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_skate_spot_cubit.dart'
    as _i21;
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_spot_map_bloc/add_spot_map_cubit.dart'
    as _i19;
import 'package:skatewars/features/show_skate_spots_page/data/datasources/show_skate_spots_data_source.dart'
    as _i9;
import 'package:skatewars/features/show_skate_spots_page/data/repositories/show_skate_spot_repo_imp.dart'
    as _i15;
import 'package:skatewars/features/show_skate_spots_page/domain/repositories/show_skate_spots_repo.dart'
    as _i14;
import 'package:skatewars/features/show_skate_spots_page/domain/usecases/show_skate_spots_usecase.dart'
    as _i20;
import 'package:skatewars/features/show_skate_spots_page/presentation/bloc/show_skate_spots_cubit.dart'
    as _i22;
import 'package:skatewars/features/spot_details_page/data/datasources/spot_details_data_source.dart'
    as _i7;
import 'package:skatewars/features/spot_details_page/data/repositories/spot_details_repo_imp.dart'
    as _i11;
import 'package:skatewars/features/spot_details_page/domain/repositories/spot_details_repo.dart'
    as _i10;
import 'package:skatewars/features/spot_details_page/domain/usecases/get_spot_details_usecase.dart'
    as _i12;
import 'package:skatewars/features/spot_details_page/presentation/bloc/spot_details_cubit.dart'
    as _i3;
import 'package:skatewars/features/user_relations/data/datasources/user_relations_data_source.dart'
    as _i4;
import 'package:skatewars/features/user_relations/data/repositories/user_relations_repo_imp.dart'
    as _i6;
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart'
    as _i5;
import 'package:skatewars/features/user_relations/domain/usecases/get_user_curret_position_usecase.dart'
    as _i8;

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
    gh.factory<_i3.SpotDetailsCubit>(() => _i3.SpotDetailsCubit());
    gh.singleton<_i4.UserRelationsDataSource>(
        () => _i4.UserRelationsDataSourceImp());
    gh.singleton<_i5.UserRelationsRepo>(() => _i6.UserRelationsRepoImp(
        dataSource: gh<_i4.UserRelationsDataSource>()));
    gh.singleton<_i7.SpotDetailsDatasource>(
        () => _i7.SpotDetailsDataSourceImp());
    gh.factory<_i8.GetUserCurrentPositionUseCase>(() =>
        _i8.GetUserCurrentPositionUseCase(repo: gh<_i5.UserRelationsRepo>()));
    gh.singleton<_i9.ShowSkateSpotsDataSource>(
        () => _i9.ShowSkateSpotDataSourceImp());
    gh.singleton<_i10.SpotDetailsRepo>(() => _i11.SpotDetailsRepoImp(
        spotDetailsDatasource: gh<_i7.SpotDetailsDatasource>()));
    gh.factory<_i12.GetSpotDetailsUseCase>(
        () => _i12.GetSpotDetailsUseCase(repo: gh<_i10.SpotDetailsRepo>()));
    gh.singleton<_i13.AddSkateSpotDataSource>(() => _i13.AddSkateSpotDataImp());
    gh.singleton<_i14.ShowSkateSpotsRepo>(() => _i15.ShowSkateSpotRepoImp(
        showSkateSpotsDataSource: gh<_i9.ShowSkateSpotsDataSource>()));
    gh.singleton<_i16.AddSkateSpotRepo>(() => _i17.AddSkateSpotRepoImp(
        addSkateSpotDataSource: gh<_i13.AddSkateSpotDataSource>()));
    gh.factory<_i18.AddSkateSpotUseCase>(
        () => _i18.AddSkateSpotUseCase(repo: gh<_i16.AddSkateSpotRepo>()));
    gh.factory<_i19.AddSpotMapCubit>(() => _i19.AddSpotMapCubit(
        getUserCurrentPositionUseCase:
            gh<_i8.GetUserCurrentPositionUseCase>()));
    gh.factory<_i20.ShowSkateSpotsUseCase>(() => _i20.ShowSkateSpotsUseCase(
        showSkateSpotsRepo: gh<_i14.ShowSkateSpotsRepo>()));
    gh.factory<_i21.AddSkateSpotCubit>(() => _i21.AddSkateSpotCubit(
          addSkateSpotUseCase: gh<_i18.AddSkateSpotUseCase>(),
          getUserCurrentPositionUseCase:
              gh<_i8.GetUserCurrentPositionUseCase>(),
        ));
    gh.factory<_i22.ShowSkateSpotsCubit>(() => _i22.ShowSkateSpotsCubit(
          showSkateSpotsUseCase: gh<_i20.ShowSkateSpotsUseCase>(),
          getUserCurrentPositionUseCase:
              gh<_i8.GetUserCurrentPositionUseCase>(),
        ));
    return this;
  }
}
