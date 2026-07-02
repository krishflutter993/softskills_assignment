class VaultItem {
  final String id;
  final String title;
  final String? username;
  final String? email;
  final String password;
  final String? website;
  final String? notes;
  final String category;
  final bool favorite;
  final DateTime createdAt;
  final DateTime updatedAt;

  VaultItem({
    required this.id,
    required this.title,
    this.username,
    this.email,
    required this.password,
    this.website,
    this.notes,
    required this.category,
    this.favorite = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'username': username,
      'email': email,
      'password': password,
      'website': website,
      'notes': notes,
      'category': category,
      'favorite': favorite ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory VaultItem.fromMap(Map<String, dynamic> map) {
    return VaultItem(
      id: map['id'],
      title: map['title'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      website: map['website'],
      notes: map['notes'],
      category: map['category'],
      favorite: map['favorite'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  VaultItem copyWith({
    String? id,
    String? title,
    String? username,
    String? email,
    String? password,
    String? website,
    String? notes,
    String? category,
    bool? favorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VaultItem(
      id: id ?? this.id,
      title: title ?? this.title,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      website: website ?? this.website,
      notes: notes ?? this.notes,
      category: category ?? this.category,
      favorite: favorite ?? this.favorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
