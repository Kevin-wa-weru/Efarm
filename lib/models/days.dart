class TimeDayes {
  final String dayname;
  bool active;
  final String openTime;
  final String closeTime;

  TimeDayes(this.dayname, this.active, this.openTime, this.closeTime);
}

List<TimeDayes> allDayes = [
  TimeDayes('Mon', true, '07:00am', '05:00 pm'),
  TimeDayes('Tue', false, '07:00am', '05:00 pm'),
  TimeDayes('Wed', false, '07:00am', '05:00 pm'),
  TimeDayes('Thu', true, '07:00am', '05:00 pm'),
  TimeDayes('Fri', true, '07:00am', '05:00 pm'),
  TimeDayes('Sat', false, '07:00am', '05:00 pm'),
  TimeDayes('Sun', true, '07:00am', '05:00 pm'),
];
