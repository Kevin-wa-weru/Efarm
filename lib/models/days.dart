class TimeDayes {
  final String dayname;
  bool active;
  final String openTime;
  final String closeTime;

  TimeDayes(this.dayname, this.active, this.openTime, this.closeTime);
}

List<TimeDayes> allDayes = [
  TimeDayes('Mon', false, '00:00am', '00:00 pm'),
  TimeDayes('Tue', false, '00:00am', '00:00 pm'),
  TimeDayes('Wed', false, '00:00am', '00:00 pm'),
  TimeDayes('Thu', false, '00:00am', '00:00 pm'),
  TimeDayes('Fri', false, '00:00am', '00:00 pm'),
  TimeDayes('Sat', false, '00:00am', '00:00 pm'),
  TimeDayes('Sun', false, '00:00am', '00:00 pm'),
];
