import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/userName.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';
part 'now_playing_bloc.freezed.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  NowPlayingBloc() : super(NowPlayingState.initial()) {
    on<_Tapped>((event, emit) => emit(state.copyWith(loop: Colors.blue)));
    on<_Untapped>((event, emit) => emit(state.copyWith(loop: Colors.white)));
    on<_Ontaped>((event, emit) => emit(state.copyWith(shuffle: Colors.blue)));
    on<_Untap>((event, emit) => emit(state.copyWith(shuffle: Colors.white)));
    on<_Name>(
        (event, emit) => emit(state.copyWith(nmae: nameBox.values.toList())));
  }
}
