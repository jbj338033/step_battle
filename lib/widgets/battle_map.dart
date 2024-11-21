import 'package:flutter/material.dart';

class BattleMap extends StatelessWidget {
  final List<String> team1;
  final List<String> team2;
  final int team1Energy;
  final int team2Energy;

  const BattleMap({
    super.key,
    required this.team1,
    required this.team2,
    required this.team1Energy,
    required this.team2Energy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // 배경 맵
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: BattleMapPainter(),
          ),
          // 팀1 기지
          Positioned(
            left: 20,
            top: 20,
            child: _buildBase('Team 1', team1Energy, Colors.blue),
          ),
          // 팀2 기지
          Positioned(
            right: 20,
            bottom: 20,
            child: _buildBase('Team 2', team2Energy, Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildBase(String team, int energy, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(team),
          Text('$energy'),
        ],
      ),
    );
  }
}

class BattleMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 격자 그리기
    const gridSize = 40.0;
    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, size.height),
        paint,
      );
    }
    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
