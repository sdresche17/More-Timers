import 'dart:math';

String uniqueid() {
  String _rndnumber = "";
  var rnd = new Random();
  for (var i = 0; i < 9; i++) {
    _rndnumber = _rndnumber + rnd.nextInt(9).toString();
  }
  return _rndnumber;
}
