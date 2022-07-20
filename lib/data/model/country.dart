class Country {
  final String name;
  final String isoCode;
  final String iso3Code;
  final String currencyCode;
  final String currencyName;
  Country(
      {required this.isoCode,
      required this.iso3Code,
      required this.currencyCode,
      required this.currencyName,
      required this.name});

  factory Country.fromMap(Map<String, String> map) => Country(
        name: map['name']!,
        isoCode: map['isoCode']!,
        iso3Code: map['iso3Code']!,
        currencyCode: map['currencyCode']!,
        currencyName: map['currencyName']!,
      );
}
