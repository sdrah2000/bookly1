part of 'fetch_feautred_book_cubit.dart';

@immutable
abstract class FetchFeautredBookState {}

class FetchFeautredBookInitial extends FetchFeautredBookState {}

class FetchFeautredBookLoading extends FetchFeautredBookState {}
class FetchFeautredPagBookLoading extends FetchFeautredBookState {}

class FetchFeautredBookFailure extends FetchFeautredBookState {
  final String errorMessage;

  FetchFeautredBookFailure(this.errorMessage);
}

class FetchFeautredBookSuccess extends FetchFeautredBookState {
  final List<BookEntity> books;

  FetchFeautredBookSuccess(this.books);
}
