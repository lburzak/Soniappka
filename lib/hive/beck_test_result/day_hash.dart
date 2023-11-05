extension DayHash on DateTime {
  int get dayHashCode => year.hashCode ^ month.hashCode ^ day.hashCode;
}
