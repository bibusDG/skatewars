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
    as _i16;
import 'package:skatewars/features/add_skate_spot_page/data/repositories/add_skate_spot_repo_imp.dart'
    as _i20;
import 'package:skatewars/features/add_skate_spot_page/domain/repositories/add_skate_spot_repo.dart'
    as _i19;
import 'package:skatewars/features/add_skate_spot_page/domain/usecases/add_skate_spot_usecase.dart'
    as _i23;
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_skate_spot_cubit.dart'
    as _i26;
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_spot_map_bloc/add_spot_map_cubit.dart'
    as _i24;
import 'package:skatewars/features/show_skate_spots_page/data/datasources/show_skate_spots_data_source.dart'
    as _i12;
import 'package:skatewars/features/show_skate_spots_page/data/repositories/show_skate_spot_repo_imp.dart'
    as _i18;
import 'package:skatewars/features/show_skate_spots_page/domain/repositories/show_skate_spots_repo.dart'
    as _i17;
import 'package:skatewars/features/show_skate_spots_page/domain/usecases/show_skate_spots_usecase.dart'
    as _i25;
import 'package:skatewars/features/show_skate_spots_page/presentation/bloc/show_skate_spots_cubit.dart'
    as _i27;
import 'package:skatewars/features/spot_details_page/data/datasources/spot_details_data_source.dart'
    as _i6;
import 'package:skatewars/features/spot_details_page/data/repositories/spot_details_repo_imp.dart'
    as _i14;
import 'package:skatewars/features/spot_details_page/domain/repositories/spot_details_repo.dart'
    as _i13;
import 'package:skatewars/features/spot_details_page/domain/usecases/get_spot_details_usecase.dart'
    as _i15;
import 'package:skatewars/features/spot_details_page/presentation/bloc/spot_details_cubit.dart'
    as _i22;
import 'package:skatewars/features/user_relations/data/datasources/user_relations_data_source.dart'
    as _i3;
import 'package:skatewars/features/user_relations/data/repositories/user_relations_repo_imp.dart'
    as _i5;
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart'
    as _i4;
import 'package:skatewars/features/user_relations/domain/usecases/get_user_curret_position_usecase.dart'
    as _i7;
import 'package:skatewars/features/user_relations/domain/usecases/log_out_user_usecase.dart'
    as _i10;
import 'package:skatewars/features/user_relations/domain/usecases/login_with_google_usecase.dart'
    as _i8;
import 'package:skatewars/features/user_relations/domain/usecases/register_new_user_usecase.dart'
    as _i9;
import 'package:skatewars/features/user_relations/domain/usecases/set_user_account_usecase.dart'
    as _i11;
import 'package:skatewars/features/user_relations/presentation/bloc/user_auth_cubit.dart'
    as _i21;

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
    gh.singleton<_i6.SpotDetailsDatasource>(
        () => _i6.SpotDetailsDataSourceImp());
    gh.factory<_i7.GetUserCurrentPositionUseCase>(() =>
        _i7.GetUserCurrentPositionUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.factory<_i8.LoginWithGoogleUseCase>(
        () => _i8.LoginWithGoogleUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.factory<_i9.RegisterNewUserUseCase>(
        () => _i9.RegisterNewUserUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.factory<_i10.LogOutUserUseCase>(
        () => _i10.LogOutUserUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.factory<_i11.SetUserAccountUseCase>(
        () => _i11.SetUserAccountUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.singleton<_i12.ShowSkateSpotsDataSource>(
        () => _i12.ShowSkateSpotDataSourceImp());
    gh.singleton<_i13.SpotDetailsRepo>(() => _i14.SpotDetailsRepoImp(
        spotDetailsDatasource: gh<_i6.SpotDetailsDatasource>()));
    gh.factory<_i15.GetSpotDetailsUseCase>(
        () => _i15.GetSpotDetailsUseCase(repo: gh<_i13.SpotDetailsRepo>()));
    gh.singleton<_i16.AddSkateSpotDataSource>(() => _i16.AddSkateSpotDataImp());
    gh.singleton<_i17.ShowSkateSpotsRepo>(() => _i18.ShowSkateSpotRepoImp(
        showSkateSpotsDataSource: gh<_i12.ShowSkateSpotsDataSource>()));
    gh.singleton<_i19.AddSkateSpotRepo>(() => _i20.AddSkateSpotRepoImp(
        addSkateSpotDataSource: gh<_i16.AddSkateSpotDataSource>()));
    gh.factory<_i21.UserAuthCubit>(() => _i21.UserAuthCubit(
          setUserAccountUseCase: gh<_i11.SetUserAccountUseCase>(),
          registerNewUseUseCase: gh<_i9.RegisterNewUserUseCase>(),
          loginWithGoogleUseCase: gh<_i8.LoginWithGoogleUseCase>(),
          logOutUserUseCase: gh<_i10.LogOutUserUseCase>(),
        ));
    gh.factory<_i22.SpotDetailsCubit>(() => _i22.SpotDetailsCubit(
        getSpotDetailsUseCase: gh<_i15.GetSpotDetailsUseCase>()));
    gh.factory<_i23.AddSkateSpotUseCase>(
        () => _i23.AddSkateSpotUseCase(repo: gh<_i19.AddSkateSpotRepo>()));
    gh.factory<_i24.AddSpotMapCubit>(() => _i24.AddSpotMapCubit(
        getUserCurrentPositionUseCase:
            gh<_i7.GetUserCurrentPositionUseCase>()));
    gh.factory<_i25.ShowSkateSpotsUseCase>(() => _i25.ShowSkateSpotsUseCase(
        showSkateSpotsRepo: gh<_i17.ShowSkateSpotsRepo>()));
    gh.factory<_i26.AddSkateSpotCubit>(() => _i26.AddSkateSpotCubit(
          addSkateSpotUseCase: gh<_i23.AddSkateSpotUseCase>(),
          getUserCurrentPositionUseCase:
              gh<_i7.GetUserCurrentPositionUseCase>(),
        ));
    gh.factory<_i27.ShowSkateSpotsCubit>(() => _i27.ShowSkateSpotsCubit(
          showSkateSpotsUseCase: gh<_i25.ShowSkateSpotsUseCase>(),
          getUserCurrentPositionUseCase:
              gh<_i7.GetUserCurrentPositionUseCase>(),
        ));
    return this;
  }
}
