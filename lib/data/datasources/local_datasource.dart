import 'package:cloud_firestore/cloud_firestore.dart';

class LocalDatasource {
  
  static const String gameCollection = 'games';
  static const Duration _kTimeout = Duration(seconds: 30);

  CollectionReference get _database {
    return FirebaseFirestore.instance.collection(gameCollection);
  }


  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    final result = await _database.add(data).timeout(_kTimeout).onError((Exception e, _) => throw e);
    final doc = await result.get();
    return {
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>
    };
  }

  Future<void> delete(String id) async {
    await _database.doc(id).delete().timeout(_kTimeout).onError((Exception e, _) => throw e);
  }

  Future<List<Map<String, dynamic>>> read([String? id]) async {
    final result = await _database.get().timeout(_kTimeout).onError((Exception e, _) => throw e);
    return result.docs.map((element) => {
        'id': element.id,
        ...element.data() as Map<String, dynamic>
      }
    ).toList();
  }

  Future<Map<String, dynamic>> readById(String id) async {
    final doc = await _database.doc(id).get().timeout(_kTimeout).onError((Exception e, _) => throw e);
    return {
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>
    };
  }

  Future<void> update({required String id, required Map<String, dynamic> data}) async {
    await _database.doc(id).update(data).timeout(_kTimeout).onError((Exception e, _) => throw e);
  }

}