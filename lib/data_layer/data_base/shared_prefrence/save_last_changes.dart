abstract class SaveLastData {
  Future<void> putDataInDatabase({required String putedData});
  Future<String> getDataFromDatabase();
}
