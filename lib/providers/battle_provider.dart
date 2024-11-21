import 'package:flutter/foundation.dart';

class BattleProvider with ChangeNotifier {
  final List<String> _team = [];
  int _battleEnergy = 0;

  List<String> get team => _team;
  int get battleEnergy => _battleEnergy;

  void joinBattle(String userId) {
    if (!_team.contains(userId)) {
      _team.add(userId);
      notifyListeners();
    }
  }

  void useEnergy(int amount) {
    if (_battleEnergy >= amount) {
      _battleEnergy -= amount;
      notifyListeners();
    }
  }
}
