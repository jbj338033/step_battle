class Battle {
  final String id;
  final List<String> team1;
  final List<String> team2;
  final int team1Energy;
  final int team2Energy;
  final DateTime startTime;
  final DateTime? endTime;
  final String? winnerId;

  Battle({
    required this.id,
    required this.team1,
    required this.team2,
    required this.team1Energy,
    required this.team2Energy,
    required this.startTime,
    this.endTime,
    this.winnerId,
  });

  factory Battle.fromJson(Map<String, dynamic> json) {
    return Battle(
      id: json['id'],
      team1: List<String>.from(json['team1']),
      team2: List<String>.from(json['team2']),
      team1Energy: json['team1Energy'],
      team2Energy: json['team2Energy'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      winnerId: json['winnerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team1': team1,
      'team2': team2,
      'team1Energy': team1Energy,
      'team2Energy': team2Energy,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'winnerId': winnerId,
    };
  }
}
