class User {
  final String id;
  final String username;
  final String email;
  final int totalSteps;
  final int energy;
  final int wins;
  final int losses;
  final List<String> achievements;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.totalSteps,
    required this.energy,
    required this.wins,
    required this.losses,
    required this.achievements,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      totalSteps: json['totalSteps'],
      energy: json['energy'],
      wins: json['wins'],
      losses: json['losses'],
      achievements: List<String>.from(json['achievements']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'totalSteps': totalSteps,
      'energy': energy,
      'wins': wins,
      'losses': losses,
      'achievements': achievements,
    };
  }
}
