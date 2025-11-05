class SyncOperation {
  final int? id;
  final String recipeId;
  final String operation;
  final int createdAt;

  SyncOperation({
    this.id,
    required this.recipeId,
    required this.operation,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipeId': recipeId,
      'operation': operation,
      'createdAt': createdAt,
    };
  }

  factory SyncOperation.fromMap(Map<String, dynamic> map) {
    return SyncOperation(
      id: map['id'],
      recipeId: map['recipeId'],
      operation: map['operation'],
      createdAt: map['createdAt'],
    );
  }

  @override
  String toString() => operation;
}
