import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/blank_entity.dart';
import '../../domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/news_repository.dart';
import '../../domain/use_cases/create_news_use_case.dart';
import '../../domain/use_cases/delete_news_use_case.dart';
import '../../domain/use_cases/edit_news_use_case.dart';
import '../../domain/use_cases/get_news_use_case.dart';
import '../data_sources/news_data_source.dart';

class NewsRepositoryImpl extends NewsRepository {
  NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BlankEntity>> createNews(
      CreateNewsParam params) async {
    final newsCreated = await remoteDataSource.createNews(params);
    return newsCreated.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Stream<Either<Failure, List<NewsEntity>>> getNews(GetNewsParam params) {
    final newsLoaded = remoteDataSource.getNews(params);
    return newsLoaded;
  }

  @override
  Future<Either<Failure, BlankEntity>> editNews(EditNewsParam params) async {
    final newsEdited = await remoteDataSource.editNews(params);
    return newsEdited.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, BlankEntity>> deleteNews(
      DeleteNewsParam params) async {
    final newsDeleted = await remoteDataSource.deleteNews(params);
    return newsDeleted.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
