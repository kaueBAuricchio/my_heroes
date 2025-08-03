import 'package:equatable/equatable.dart';

abstract class CubitState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  CubitState._();

  factory CubitState.empty() => EmptyCubitState();
  factory CubitState.loading() => LoadingCubitState();
  factory CubitState.success({required value}) =>
      SuccessCubitState(value: value);
  factory CubitState.error({required String message, String? statusCode}) =>
      ErrorCubitState(message: message, statusCode: statusCode);
}

class EmptyCubitState extends CubitState {
  EmptyCubitState() : super._();

  @override
  List<Object?> get props => [];
}

class LoadingCubitState extends CubitState {
  LoadingCubitState() : super._();

  @override
  List<Object?> get props => [];
}

class SuccessCubitState<T> extends CubitState {
  final T value;

  SuccessCubitState({required this.value}) : super._();

  @override
  List<Object?> get props => [value];
}

class ErrorCubitState extends CubitState {
  final String message;
  final String? statusCode;

  ErrorCubitState({
    this.message = 'Error! \n Try again',
    this.statusCode,
  }) : super._();

  @override
  List<Object?> get props => [message, statusCode];
}
