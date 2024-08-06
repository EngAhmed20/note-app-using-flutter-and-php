part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class ChangeImg extends HomeState {}

class HomeGetNoteLoading extends HomeState {}

class HomeGetNoteSuccess extends HomeState {
  final dynamic response;

  HomeGetNoteSuccess({required this.response});

}

class HomeGetNoteError extends HomeState {
 final String errMsg;
 HomeGetNoteError({required this.errMsg});
}
class AddNoteLoading extends HomeState {}
class AddNoteSuccess extends HomeState {}
class AddNoteError extends HomeState {
 final String errMsg;
 AddNoteError({required this.errMsg});
}
class EditNoteLoading extends HomeState {}
class EditNoteSuccess extends HomeState {}
class EditNoteError extends HomeState {
 final String errMsg;
 EditNoteError({required this.errMsg});
}
class DeleteNoteLoading extends HomeState {}
class DeleteNoteSuccess extends HomeState {}
class DeleteNoteError extends HomeState {
 final String errMsg;
 DeleteNoteError({required this.errMsg});
}




