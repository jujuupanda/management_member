part of 'news_data_source.dart';

class NewsRemoteDataSource extends NewsDataSource {
  final firebaseDB = DatabaseService().firebaseFirestore;

  @override
  Future<Either<Failure, BlankModel>> createNews(CreateNewsParam params) async {
    try {
      final fullName = await SecureStorageService().retrieveString("fullName");
      final docRef = firebaseDB.collection("news").doc();
      final docId = docRef.id;
      await docRef.set({
        ...params.news.toJson(),
        "id": docId,
        "author": fullName,
        "published_at": DateTime.now().toString(),
      });
      return Right(BlankModel());
    } catch (e) {
      return Left(ServerFailure("Terjadi kesalahan saat membuat berita"));
    }
  }

  @override
  Stream<Either<Failure, List<NewsModel>>> getNews(GetNewsParam params) async* {
    final docRef = firebaseDB.collection("news");
    final newsSnapshot = docRef.snapshots();
    yield* newsSnapshot.map(
      (snapshot) {
        try {
          final listNews =
              snapshot.docs.map((e) => NewsModel.fromJson(e.data())).toList();
          return Right(listNews);
        } catch (e) {
          return Left(ServerFailure("Terjadi kesalahan saat mengambil berita"));
        }
      },
    );
  }

  @override
  Future<Either<Failure, BlankModel>> editNews(EditNewsParam params) async {
    try {
      final docRef = firebaseDB.collection("news").doc(params.news.id);
      await docRef.update(params.news.toJson());
      await docRef.get();
      return Right(BlankModel());
    } catch (e) {
      return Left(ServerFailure("Gagal memperbarui berita"));
    }
  }

  @override
  Future<Either<Failure, BlankModel>> deleteNews(DeleteNewsParam params) async {
    try {
      final docRef = firebaseDB.collection("news").doc(params.news.id);
      await docRef.delete();
      return Right(BlankModel());
    } catch (e) {
      return Left(ServerFailure("Gagal menghapus berita"));
    }
  }
}
