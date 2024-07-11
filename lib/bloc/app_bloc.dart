import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftips_bloc_fetch_api/bloc/app_state.dart';
import 'package:ftips_bloc_fetch_api/bloc/bloc_events.dart';
import 'dart:math' as math;

typedef AppRandomUrlPicker = String Function(Iterable<String> allUrls);

extension Random<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();
  AppBloc({
    required Iterable<String> urls,
    Duration? waitBeforeLoading,
    AppRandomUrlPicker? urlPicker,
  }) : super(
          const AppState.empty(),
        ) {
    on<LoadNextUrlEvent>((event, emit) async {
      emit(
        const AppState(
          isLoading: true,
          data: null,
          error: null,
        ),
      );
      final url = (urlPicker ?? _pickRandomUrl(urls)) as String;
      try {
        if (waitBeforeLoading != null) {
          await Future.delayed(waitBeforeLoading);
        }
        final bundle = NetworkAssetBundle(Uri.parse(url));
        final data = (await bundle.load(url)).buffer.asUint8List();

        emit(
          AppState(
            isLoading: false,
            data: data,
            error: null,
          ),
        );
      } catch (e) {
        emit(
          AppState(
            isLoading: true,
            data: null,
            error: e,
          ),
        );
      }
    });
  }
}
