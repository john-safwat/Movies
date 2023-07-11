abstract class BaseCubitState {}
class LoadingState extends BaseCubitState{}
class ErrorState extends BaseCubitState{
  String errorMessage ;
  ErrorState(this.errorMessage);
}

class HideDialog extends BaseCubitState{}
class ShowLoadingState extends BaseCubitState{
  String message ;
  ShowLoadingState(this.message);
}
class ShowErrorMessageState extends BaseCubitState{
  String message;
  ShowErrorMessageState(this.message);
}
class ShowSuccessMessageState extends BaseCubitState{
  String message;
  ShowSuccessMessageState(this.message);
}
class MovieDetailsAction extends BaseCubitState{
  num movie;
  MovieDetailsAction(this.movie);
}

