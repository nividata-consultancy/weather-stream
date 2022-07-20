import 'package:weather_stream/utils/countries.dart';

class CurrencyPickerUtils {
  static String getCountryByIsoCode(String isoCode) {
    try {
      return countryList
          .firstWhere(
            (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
          )
          .name;
    } catch (error) {
      return isoCode;
    }
  }
}
