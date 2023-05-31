import 'package:bookly/Features/home/domain/repos/home_rep.dart';
import 'package:bookly/Features/home/domain/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entites/book_entity.dart';

class FetchNewestBooksUseCase extends UseCase<List<BookEntity>, NoParm> {
  final HomeRepo homeRepo;

  FetchNewestBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([NoParm? param]) async {
    // TODO: implement call
    return await homeRepo.fetchNewestBooks();
  }
}
