import 'package:flutter/foundation.dart' show immutable;
//import 'package:flutter/rendering.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class LoadNextUrlEvent implements AppEvent {
  const LoadNextUrlEvent();
}
