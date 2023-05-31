class RentalDuration {
	String? unit;
	int? count;

	RentalDuration({this.unit, this.count});

	factory RentalDuration.fromJson(Map<String, dynamic> json) {
		return RentalDuration(
			unit: json['unit'] as String?,
			count: json['count'] as int?,
		);
	}



	Map<String, dynamic> toJson() => {
				'unit': unit,
				'count': count,
			};
}
