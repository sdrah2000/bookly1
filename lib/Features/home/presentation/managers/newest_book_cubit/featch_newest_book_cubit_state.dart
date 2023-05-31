part of 'featch_newest_book_cubit_cubit.dart';

@immutable
abstract class FeatchNewestBookCubitState {}

class FeatchNewestBookCubitInitial extends FeatchNewestBookCubitState {}
class FetchNewestBookLoading extends FeatchNewestBookCubitState {}

class FetchNewestBookFailure extends FeatchNewestBookCubitState {
  final String errorMessage;

  FetchNewestBookFailure(this.errorMessage);
}

class FetchNewestBookSuccess extends FeatchNewestBookCubitState {
  final List<BookEntity> books;

  FetchNewestBookSuccess(this.books);
}

