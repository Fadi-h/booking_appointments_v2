

class UnvailedBooking {
  String day;
  int hour;
  String date;

  UnvailedBooking({required this.day, required this.hour, required this.date});

  factory UnvailedBooking.fromJson(Map<String, dynamic> json) {
    return UnvailedBooking(
      day: json['bookingDay'] as String,
      hour: int.parse(json['bookingHour']),
      date: json['bookinghistory']
    );
  }

}