abstract class IApiService<T> {
  Future<List<T>> getItems({int? page});
  Future<List<T>> searchItems(String query);

  const IApiService();
}
