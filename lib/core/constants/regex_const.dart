class RegExpConst {
  static final RegExp email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp password = RegExp(
    r'^(?=(.*[A-Z]){2})(?=(.*[0-9]){2})(?=(.*[!@#$%^&*()\-_=+]){2})(?=(.*[a-z]){2}).{8,}$',
  );
  static final RegExp phone = RegExp(r'^(?:\+62|62|0)[2-9]{1}[0-9]{7,11}$');
  static final RegExp isEmailPersonal = RegExp(
    r'^[\w-\.]+@(gmail|yahoo|hotmail|live|outlook)\.com$',
  );
  static final RegExp isEmailCompany = RegExp(
    r'^[\w-\.]+@(?!gmail\.com|yahoo\.com|hotmail\.com|outlook\.com)[\w-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp postalCode = RegExp(r'^[0-9]{5}$');
  static final RegExp name = RegExp(r'^[A-Za-z\s]+$');
  static final RegExp isUrl = RegExp(
    r'^(https?:\/\/)?(www\.)?[\w-]+(\.[\w-]+)+([\/?].*)?$',
  );
  static final RegExp currencyIDR = RegExp(
    r'^(Rp|IDR)\s?\d{1,3}(?:\.\d{3})*(?:,\d{2})?$',
  );
  static final RegExp currencyUSD = RegExp(
    r'^(USD|\$)\s?\d{1,3}(?:,\d{3})*(?:\.\d{2})?$',
  );
  static final RegExp currencyCNY = RegExp(
    r'^(CNY|¥)\s?\d{1,3}(?:,\d{3})*(?:\.\d{2})?$',
  );
  static final RegExp address = RegExp(r"^[0-9a-zA-Z\s,.\'\-]{1,250}$");
  static final RegExp npwp = RegExp(
    r'^\d{2}\.\d{3}\.\d{3}\.\d{1}-\d{3}\.\d{3}$',
  );
}
