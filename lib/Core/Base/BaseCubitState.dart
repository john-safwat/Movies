abstract class BaseCubitState {}
class LoadingState extends BaseCubitState{}
class ErrorState extends BaseCubitState{
  String errorMessage ;
  ErrorState(this.errorMessage);
}