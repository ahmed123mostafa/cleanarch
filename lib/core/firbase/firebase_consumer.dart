part of 'firebase.dart';


/// A reusable Firebase Firestore consumer interface
/// Similar to ApiConsumer pattern but for Firestore operations
abstract interface class FirebaseConsumer {
  // Document Operations
  /// Get a single document as a stream
  Stream<Either<Failure, T>> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
  });

  /// Get a single document as a future
  Future<Either<Failure, T>> getDocumentOnce<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
  });

  /// Get a collection as a stream
  Stream<Either<Failure, List<T>>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? orderBy,
    bool descending = false,
    int? limit,
  });

  /// Get a collection as a future (one-time read)
  Future<Either<Failure, List<T>>> getCollectionOnce<T>({
    required String path,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? orderBy,
    bool descending = false,
    int? limit,
  });

  /// Add a document to a collection (auto-generated ID)
  Future<Either<Failure, String>> addDocument({
    required String path,
    required Map<String, dynamic> data,
  });

  /// Set a document (creates or overwrites)
  Future<Either<Failure, void>> setDocument({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  });

  /// Update a document (only specified fields)
  Future<Either<Failure, void>> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  });

  /// Delete a document
  Future<Either<Failure, void>> deleteDocument({required String path});

  // Subcollection Operations
  /// Get a subcollection as a stream
  Stream<Either<Failure, List<T>>> getSubcollection<T>({
    required String parentPath,
    required String subcollectionName,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? orderBy,
    bool descending = false,
    int? limit,
  });

  /// Get a subcollection as a future
  Future<Either<Failure, List<T>>> getSubcollectionOnce<T>({
    required String parentPath,
    required String subcollectionName,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    String? orderBy,
    bool descending = false,
    int? limit,
  });

  /// Add a document to a subcollection
  Future<Either<Failure, String>> addToSubcollection({
    required String parentPath,
    required String subcollectionName,
    required Map<String, dynamic> data,
  });

  // Batch Operations
  /// Execute multiple operations in a batch
  Future<Either<Failure, void>> batch({
    required List<BatchOperation> operations,
  });
}

/// Represents a batch operation
class BatchOperation {
  final BatchOperationType type;
  final String path;
  final Map<String, dynamic>? data;

  const BatchOperation({required this.type, required this.path, this.data});
}

enum BatchOperationType { set, update, delete }