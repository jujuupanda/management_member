import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/entity/blank_entity.dart';
import '../entities/news_entity.dart';
import '../use_cases/create_news_use_case.dart';
import '../use_cases/delete_news_use_case.dart';
import '../use_cases/edit_news_use_case.dart';
import '../use_cases/get_news_use_case.dart';

abstract class NewsRepository {
  Future<Either<Failure, BlankEntity>> createNews(CreateNewsParam params);

  Stream<Either<Failure, List<NewsEntity>>> getNews(GetNewsParam params);

  Future<Either<Failure, BlankEntity>> editNews(EditNewsParam params);

  Future<Either<Failure, BlankEntity>> deleteNews(DeleteNewsParam params);
}
