class TimeCalculations {
  static int getTimeDifferenceInSeconds(DateTime newTime, DateTime lastTime) {
    int newTimeMiliseconds = newTime.millisecondsSinceEpoch;
    int lastTimeMiliseconds = lastTime.millisecondsSinceEpoch;
    return (newTimeMiliseconds - lastTimeMiliseconds);
  }
}