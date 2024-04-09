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
    as _i23;
import 'package:skatewars/features/add_skate_spot_page/data/repositories/add_skate_spot_repo_imp.dart'
    as _i27;
import 'package:skatewars/features/add_skate_spot_page/domain/repositories/add_skate_spot_repo.dart'
    as _i26;
import 'package:skatewars/features/add_skate_spot_page/domain/usecases/add_skate_spot_usecase.dart'
    as _i28;
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_skate_spot_cubit.dart'
    as _i36;
import 'package:skatewars/features/add_skate_spot_page/presentation/bloc/add_spot_map_bloc/add_spot_map_cubit.dart'
    as _i29;
import 'package:skatewars/features/show_skate_spots_page/data/datasources/show_skate_spots_data_source.dart'
    as _i15;
import 'package:skatewars/features/show_skate_spots_page/data/repositories/show_skate_spot_repo_imp.dart'
    as _i25;
import 'package:skatewars/features/show_skate_spots_page/domain/repositories/show_skate_spots_repo.dart'
    as _i24;
import 'package:skatewars/features/show_skate_spots_page/domain/usecases/add_spot_to_favorites_usecase.dart'
    as _i32;
import 'package:skatewars/features/show_skate_spots_page/domain/usecases/get_spot_by_id_usecase.dart'
    as _i31;
import 'package:skatewars/features/show_skate_spots_page/domain/usecases/remove_spot_from_favorites_usecase.dart'
    as _i30;
import 'package:skatewars/features/show_skate_spots_page/domain/usecases/show_skate_spots_usecase.dart'
    as _i34;
import 'package:skatewars/features/show_skate_spots_page/presentation/bloc/show_skate_spots_cubit.dart'
    as _i37;
import 'package:skatewars/features/spot_details_page/data/datasources/spot_details_data_source.dart'
    as _i6;
import 'package:skatewars/features/spot_details_page/data/repositories/spot_details_repo_imp.dart'
    as _i17;
import 'package:skatewars/features/spot_details_page/domain/repositories/spot_details_repo.dart'
    as _i16;
import 'package:skatewars/features/spot_details_page/domain/usecases/add_user_to_spot_usecase.dart'
    as _i19;
import 'package:skatewars/features/spot_details_page/domain/usecases/get_comment_by_id_usecase.dart'
    as _i22;
import 'package:skatewars/features/spot_details_page/domain/usecases/get_spot_details_usecase.dart'
    as _i18;
import 'package:skatewars/features/spot_details_page/domain/usecases/rate_spot_usecase.dart'
    as _i21;
import 'package:skatewars/features/spot_details_page/domain/usecases/remove_user_from_spot_usecase.dart'
    as _i20;
import 'package:skatewars/features/spot_details_page/presentation/bloc/spot_details_cubit.dart'
    as _i35;
import 'package:skatewars/features/user_relations/data/datasources/user_relations_data_source.dart'
    as _i3;
import 'package:skatewars/features/user_relations/data/repositories/user_relations_repo_imp.dart'
    as _i5;
import 'package:skatewars/features/user_relations/domain/repositories/user_relations_repo.dart'
    as _i4;
import 'package:skatewars/features/user_relations/domain/usecases/create_email_password_user_usecase.dart'
    as _i14;
import 'package:skatewars/features/user_relations/domain/usecases/get_user_by_id_usecase.dart'
    as _i12;
import 'package:skatewars/features/user_relations/domain/usecases/get_user_curret_position_usecase.dart'
    as _i7;
import 'package:skatewars/features/user_relations/domain/usecases/get_user_id_usecase.dart'
    as _i13;
import 'package:skatewars/features/user_relations/domain/usecases/log_out_user_usecase.dart'
    as _i10;
import 'package:skatewars/features/user_relations/domain/usecases/login_with_google_usecase.dart'
    as _i8;
import 'package:skatewars/features/user_relations/domain/usecases/logint_with_email_usecase.dart'
    as _i11;
import 'package:skatewars/features/user_relations/domain/usecases/register_new_user_usecase.dart'
    as _i9;
import 'package:skatewars/features/user_relations/presentation/bloc/user_auth_cubit.dart'
    as _i33;

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
    gh.factory<_i11.LoginWithEmailUseCase>(
        () => _i11.LoginWithEmailUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.factory<_i12.GetUserByIDUseCase>(
        () => _i12.GetUserByIDUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.factory<_i13.GetUserIDUseCase>(
        () => _i13.GetUserIDUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.factory<_i14.CreateEmailPasswordUserUseCase>(() =>
        _i14.CreateEmailPasswordUserUseCase(repo: gh<_i4.UserRelationsRepo>()));
    gh.singleton<_i15.ShowSkateSpotsDataSource>(
        () => _i15.ShowSkateSpotDataSourceImp());
    gh.singleton<_i16.SpotDetailsRepo>(() => _i17.SpotDetailsRepoImp(
        spotDetailsDatasource: gh<_i6.SpotDetailsDatasource>()));
    gh.factory<_i18.GetSpotDetailsUseCase>(
        () => _i18.GetSpotDetailsUseCase(repo: gh<_i16.SpotDetailsRepo>()));
    gh.factory<_i19.AddUserToSpotUseCase>(
        () => _i19.AddUserToSpotUseCase(repo: gh<_i16.SpotDetailsRepo>()));
    gh.factory<_i20.RemoveUserFromSpotUseCase>(
        () => _i20.RemoveUserFromSpotUseCase(repo: gh<_i16.SpotDetailsRepo>()));
    gh.factory<_i21.RateSpotUseCase>(
        () => _i21.RateSpotUseCase(repo: gh<_i16.SpotDetailsRepo>()));
    gh.factory<_i22.GetCommentByIdUseCase>(
        () => _i22.GetCommentByIdUseCase(repo: gh<_i16.SpotDetailsRepo>()));
    gh.singleton<_i23.AddSkateSpotDataSource>(() => _i23.AddSkateSpotDataImp());
    gh.singleton<_i24.ShowSkateSpotsRepo>(() => _i25.ShowSkateSpotRepoImp(
        showSkateSpotsDataSource: gh<_i15.ShowSkateSpotsDataSource>()));
    gh.singleton<_i26.AddSkateSpotRepo>(() => _i27.AddSkateSpotRepoImp(
        addSkateSpotDataSource: gh<_i23.AddSkateSpotDataSource>()));
    gh.factory<_i28.AddSkateSpotUseCase>(
        () => _i28.AddSkateSpotUseCase(repo: gh<_i26.AddSkateSpotRepo>()));
    gh.factory<_i29.AddSpotMapCubit>(() => _i29.AddSpotMapCubit(
        getUserCurrentPositionUseCase:
            gh<_i7.GetUserCurrentPositionUseCase>()));
    gh.factory<_i30.RemoveSpotFromFavoritesUseCase>(() =>
        _i30.RemoveSpotFromFavoritesUseCase(
            repo: gh<_i24.ShowSkateSpotsRepo>()));
    gh.factory<_i31.GetSpotByIdUseCase>(
        () => _i31.GetSpotByIdUseCase(repo: gh<_i24.ShowSkateSpotsRepo>()));
    gh.factory<_i32.AddSpotToFavoritesUseCase>(() =>
        _i32.AddSpotToFavoritesUseCase(repo: gh<_i24.ShowSkateSpotsRepo>()));
    gh.factory<_i33.UserAuthCubit>(() => _i33.UserAuthCubit(
          getSpotByIdUseCase: gh<_i31.GetSpotByIdUseCase>(),
          removeSpotFromFavoritesUseCase:
              gh<_i30.RemoveSpotFromFavoritesUseCase>(),
          createEmailPasswordUserUseCase:
              gh<_i14.CreateEmailPasswordUserUseCase>(),
          loginWithEmailUseCase: gh<_i11.LoginWithEmailUseCase>(),
          getUserIDUseCase: gh<_i13.GetUserIDUseCase>(),
          registerNewUseUseCase: gh<_i9.RegisterNewUserUseCase>(),
          loginWithGoogleUseCase: gh<_i8.LoginWithGoogleUseCase>(),
          getUserByIDUseCase: gh<_i12.GetUserByIDUseCase>(),
          logOutUserUseCase: gh<_i10.LogOutUserUseCase>(),
        ));
    gh.factory<_i34.ShowSkateSpotsUseCase>(() => _i34.ShowSkateSpotsUseCase(
        showSkateSpotsRepo: gh<_i24.ShowSkateSpotsRepo>()));
    gh.factory<_i35.SpotDetailsCubit>(() => _i35.SpotDetailsCubit(
          getSpotDetailsUseCase: gh<_i18.GetSpotDetailsUseCase>(),
          getCommentByIdUseCase: gh<_i22.GetCommentByIdUseCase>(),
          rateSpotUseCase: gh<_i21.RateSpotUseCase>(),
          removeUserFromSpotUseCase: gh<_i20.RemoveUserFromSpotUseCase>(),
          addUserToSpotUseCase: gh<_i19.AddUserToSpotUseCase>(),
          getUserByIDUseCase: gh<_i12.GetUserByIDUseCase>(),
        ));
    gh.factory<_i36.AddSkateSpotCubit>(() => _i36.AddSkateSpotCubit(
          addSkateSpotUseCase: gh<_i28.AddSkateSpotUseCase>(),
          getUserCurrentPositionUseCase:
              gh<_i7.GetUserCurrentPositionUseCase>(),
        ));
    gh.factory<_i37.ShowSkateSpotsCubit>(() => _i37.ShowSkateSpotsCubit(
          showSkateSpotsUseCase: gh<_i34.ShowSkateSpotsUseCase>(),
          getUserCurrentPositionUseCase:
              gh<_i7.GetUserCurrentPositionUseCase>(),
          getUserByIDUseCase: gh<_i12.GetUserByIDUseCase>(),
          addSpotToFavoritesUseCase: gh<_i32.AddSpotToFavoritesUseCase>(),
        ));
    return this;
  }
}
