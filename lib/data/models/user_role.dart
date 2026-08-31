enum UserRole {
  rider,
  driver;

  String get label => this == rider ? 'Rider' : 'Driver';

  static UserRole? fromStorage(String? value) {
    for (final role in UserRole.values) {
      if (role.name == value) return role;
    }
    return null;
  }
}
