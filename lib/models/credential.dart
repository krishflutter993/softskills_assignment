class Credential {
  final String id;
  final String websiteName;
  final String websiteUrl;
  final String username;
  final String password;
  final String category;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;
  
  Credential({
    required this.id,
    required this.websiteName,
    required this.websiteUrl,
    required this.username,
    required this.password,
    required this.category,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
  });
  
  Credential copyWith({
    String? id,
    String? websiteName,
    String? websiteUrl,
    String? username,
    String? password,
    String? category,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) {
    return Credential(
      id: id ?? this.id,
      websiteName: websiteName ?? this.websiteName,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      username: username ?? this.username,
      password: password ?? this.password,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'websiteName': websiteName,
      'websiteUrl': websiteUrl,
      'username': username,
      'password': password,
      'category': category,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }
  
  factory Credential.fromJson(Map<String, dynamic> json) {
    return Credential(
      id: json['id'],
      websiteName: json['websiteName'],
      websiteUrl: json['websiteUrl'],
      username: json['username'],
      password: json['password'],
      category: json['category'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}