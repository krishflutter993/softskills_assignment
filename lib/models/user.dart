class User {
  final String id;
  final String name;
  final String email;
  final bool isPremium;
  final DateTime createdAt;
  final DateTime? lastLogin;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    this.isPremium = false,
    required this.createdAt,
    this.lastLogin,
  });
  
  User copyWith({
    String? id,
    String? name,
    String? email,
    bool? isPremium,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}