import 'package:audik_app/Model/songModel.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'allsongs_event.dart';
part 'allsongs_state.dart';
part 'allsongs_bloc.freezed.dart';

class AllsongsBloc extends Bloc<AllsongsEvent, AllsongsState> {
  AllsongsBloc() : super(AllsongsState.initial()) {
    /* on<_Started>(
        (event, emit) => emit(AllsongsState(allDbSongs: state.allDbSongs))); */
  }
}
