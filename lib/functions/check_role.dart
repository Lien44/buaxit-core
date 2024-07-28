
class CheckRole {
  CheckRole({
    required this.roleId,
  });
  final String roleId;

  @override
  String toString() {
    if (roleId == '1') {
      return 'admin';
    } else if (roleId == '2') {
      return 'mananger';
    } else if (roleId == '3') {
      return 'staff';
    }
    return '';
  }
}
