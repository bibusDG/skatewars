import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';

part 'spot_details_state.dart';
part 'spot_details_cubit.freezed.dart';
@injectable
class SpotDetailsCubit extends Cubit<SpotDetailsState> {
  SpotDetailsCubit() : super(const SpotDetailsState.initial());
}
