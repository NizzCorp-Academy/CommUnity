class Community {
  final String id;
  final String admin;
  final String description;
  final String name;
  final List<dynamic> members;

  Community({
    required this.id,
    required this.admin,
    required this.name,
    required this.description,
    required this.members,
  });
}
