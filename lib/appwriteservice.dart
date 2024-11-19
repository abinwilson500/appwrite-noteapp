
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  late  Client client;

  late Databases databases;

  static const endpoint = "https://cloud.appwrite.io/v1";
  static const projectId = "673bf761003d9fa02351";
  static const databaseId = "673bf7e900253c9e95da";
  static const collectionId = "673bf7f70001cb9713e8";

  AppwriteService() {
    client = Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases = Databases(client);
  }
  Future<List<Document>>getNotes() async{
    try{
      final result = await databases.listDocuments(
        collectionId:collectionId,
        databaseId:databaseId,
      );
      return result.documents;
    } catch (e) {
      print('error loading tasks:$e');
      rethrow;
    }
  }
  Future<Document>addNote(String title,String subtitle,String category,String data)async {
    try {
      final documentId = ID.unique();

      final result = await databases.createDocument(
        collectionId:collectionId,
        databaseId:databaseId,
        data:{
          'title':title,
          'subtitle':subtitle,
          'category':category,
          'data':data,
        },
        documentId:documentId
      );
      return result;
    }catch (e) {
      print('error creating task:$e');
      rethrow;
    }
  }
  Future<void>deleteNote(String documentId) async{
    try{
      await databases.deleteDocument(
        collectionId:collectionId,
        documentId:documentId,
        databaseId:databaseId,
      );
    } catch (e) {
      print('error deleting task:$e');
      rethrow;
    }
  }
}
