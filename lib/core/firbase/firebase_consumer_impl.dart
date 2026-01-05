part of 'firebase.dart';
class FirebaseConsumerImpl implements FirebaseConsumer {
  final FirebaseFirestore _firestore;

  FirebaseConsumerImpl(this._firestore);

  @override
  Stream<Either<Failure, T>> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
  }) async* {
    try {
      yield* _firestore.doc(path).snapshots().map((snapshot) {
        if (!snapshot.exists) {
          return Left(FirebaseFailure('Document does not exist'));
        }
        final data = snapshot.data();
        if (data == null) {
          return Left(FirebaseFailure('Document data is null'));
        }
        try {
          return Right(fromJson(data));
        } catch (e) {
          return Left(FirebaseFailure('Error parsing document: $e'));
        }
      });
    } catch (e) {
      yield Left(FirebaseFailure('Error getting document: $e'));
    }
  }

  @override
  Future<Either<Failure, T>> getDocumentOnce<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final snapshot = await _firestore.doc(path).get();
      if (!snapshot.exists) {
        return Left(FirebaseFailure('Document does not exist'));
      }
      final data = snapshot.data();
      if (data == null) {
        return Left(FirebaseFailure('Document data is null'));
      }
      try {
        return Right(fromJson(data));
      } catch (e) {
        return Left(FirebaseFailure('Error parsing document: $e'));
      }
    } catch (e) {
      return Left(FirebaseFailure('Error getting document: $e'));
    }
  }

  @override
  Stream<Either<Failure, List<T>>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) async* {
    try {
      Query query = _firestore.collection(path);

      // Apply query parameters (where clauses)
      if (queryParameters != null) {
        queryParameters.forEach((key, value) {
          query = query.where(key, isEqualTo: value);
        });
      }

      // Apply ordering
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

      // Apply limit
      if (limit != null) {
        query = query.limit(limit);
      }

      yield* query.snapshots().map((snapshot) {
        try {
          final items = snapshot.docs
              .map((doc) {
                try {
                  final data = doc.data() as Map<String, dynamic>;
                  data['id'] = doc.id; // Add document ID to data
                  return fromJson(data);
                } catch (e) {
                  return null;
                }
              })
              .whereType<T>()
              .toList();
          return Right(items);
        } catch (e) {
          return Left(FirebaseFailure('Error parsing collection: $e'));
        }
      });
    } catch (e) {
      yield Left(FirebaseFailure('Error getting collection: $e'));
    }
  }

  @override
  Future<Either<Failure, List<T>>> getCollectionOnce<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) async {
    try {
      Query query = _firestore.collection(path);

      // Apply query parameters
      if (queryParameters != null) {
        queryParameters.forEach((key, value) {
          query = query.where(key, isEqualTo: value);
        });
      }

      // Apply ordering
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

      // Apply limit
      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      try {
        final items = snapshot.docs
            .map((doc) {
              try {
                final data = doc.data() as Map<String, dynamic>;
                data['id'] = doc.id;
                return fromJson(data);
              } catch (e) {
                return null;
              }
            })
            .whereType<T>()
            .toList();
        return Right(items);
      } catch (e) {
        return Left(FirebaseFailure('Error parsing collection: $e'));
      }
    } catch (e) {
      return Left(FirebaseFailure('Error getting collection: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> addDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      final docRef = await _firestore.collection(path).add(data);
      return Right(docRef.id);
    } catch (e) {
      return Left(FirebaseFailure('Error adding document: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> setDocument({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    try {
      await _firestore.doc(path).set(data, SetOptions(merge: merge));
      return const Right(null);
    } catch (e) {
      return Left(FirebaseFailure('Error setting document: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.doc(path).update(data);
      return const Right(null);
    } catch (e) {
      return Left(FirebaseFailure('Error updating document: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDocument({required String path}) async {
    try {
      await _firestore.doc(path).delete();
      return const Right(null);
    } catch (e) {
      return Left(FirebaseFailure('Error deleting document: $e'));
    }
  }

  @override
  Stream<Either<Failure, List<T>>> getSubcollection<T>({
    required String parentPath,
    required String subcollectionName,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    final path = '$parentPath/$subcollectionName';
    return getCollection<T>(
      path: path,
      fromJson: fromJson,
      queryParameters: queryParameters,
      orderBy: orderBy,
      descending: descending,
      limit: limit,
    );
  }

  @override
  Future<Either<Failure, List<T>>> getSubcollectionOnce<T>({
    required String parentPath,
    required String subcollectionName,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    final path = '$parentPath/$subcollectionName';
    return getCollectionOnce<T>(
      path: path,
      fromJson: fromJson,
      queryParameters: queryParameters,
      orderBy: orderBy,
      descending: descending,
      limit: limit,
    );
  }

  @override
  Future<Either<Failure, String>> addToSubcollection({
    required String parentPath,
    required String subcollectionName,
    required Map<String, dynamic> data,
  }) {
    final path = '$parentPath/$subcollectionName';
    return addDocument(path: path, data: data);
  }

  @override
  Future<Either<Failure, void>> batch({
    required List<BatchOperation> operations,
  }) async {
    try {
      final batch = _firestore.batch();

      for (final operation in operations) {
        final docRef = _firestore.doc(operation.path);
        switch (operation.type) {
          case BatchOperationType.set:
            if (operation.data != null) {
              batch.set(docRef, operation.data!);
            }
            break;
          case BatchOperationType.update:
            if (operation.data != null) {
              batch.update(docRef, operation.data!);
            }
            break;
          case BatchOperationType.delete:
            batch.delete(docRef);
            break;
        }
      }

      await batch.commit();
      return const Right(null);
    } catch (e) {
      return Left(FirebaseFailure('Error executing batch: $e'));
    }
  }
}

