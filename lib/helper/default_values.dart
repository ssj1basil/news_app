

//Contains the default values of the dropdown list
class default_values {
  static String sortby_default_value = 'Recent';
  static String country_default_value = 'India';

  String get_country_value() {
    if (country_default_value != null)
      return country_default_value;
    else
      return null;
  }

  String get_sortby_value() {
    if (sortby_default_value != null)
      return sortby_default_value;
    else
      return null;
  }
}
