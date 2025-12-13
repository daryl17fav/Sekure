/// User Model
/// 
/// Represents an authenticated user in the application

class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? role;
  final String? location;
  final bool? isVerified;
  final DateTime? createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.role,
    this.location,
    this.isVerified,
    this.createdAt,
  });

  /// Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      name: json['name'] ?? json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? json['phoneNumber'],
      role: json['role'],
      location: json['location'],
      isVerified: json['isVerified'] ?? json['verified'],
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt']) 
          : null,
    );
  }

  /// Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'location': location,
      'isVerified': isVerified,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  /// Create a copy of User with updated fields
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? location,
    bool? isVerified,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      location: location ?? this.location,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: $role)';
  }
}
