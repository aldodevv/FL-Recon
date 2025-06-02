class BalanceResponseEntity {
  final int statusCode;
  final String status;
  final String message;
  final String displayMessage;
  final BalanceEntity response;

  BalanceResponseEntity({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.displayMessage,
    required this.response,
  });

  factory BalanceResponseEntity.fromJson(Map<String, dynamic> json) {
    return BalanceResponseEntity(
      statusCode: json['statusCode'],
      status: json['status'],
      message: json['message'],
      displayMessage: json['displayMessage'] ?? '',
      response: BalanceEntity.fromJson(json['response']),
    );
  }
}

class BalanceEntity {
  final List<BalanceHistory> balanceHisList;
  final DateTime lastUpdated;

  BalanceEntity({
    required this.balanceHisList,
    required this.lastUpdated,
  });

  factory BalanceEntity.fromJson(Map<String, dynamic> json) {
    return BalanceEntity(
      balanceHisList: (json['balanceHisList'] as List)
          .map((e) => BalanceHistory.fromJson(e))
          .toList(),
      lastUpdated: _parseIndonesianDate(json['lastUpdated']['date']),
    );
  }

  static DateTime _parseIndonesianDate(String dateStr) {
    final parts = dateStr.split(' ');
    final day = int.parse(parts[0]);
    final month = _monthStringToInt(parts[1]);
    final year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  static int _monthStringToInt(String month) {
    const months = {
      'Januari': 1,
      'Februari': 2,
      'Maret': 3,
      'April': 4,
      'Mei': 5,
      'Juni': 6,
      'Juli': 7,
      'Agustus': 8,
      'September': 9,
      'Oktober': 10,
      'November': 11,
      'Desember': 12,
    };
    return months[month] ?? 1;
  }
}

class BalanceHistory {
  final int balance;
  final int month;
  final String accountType;

  BalanceHistory({
    required this.balance,
    required this.month,
    required this.accountType,
  });

  factory BalanceHistory.fromJson(Map<String, dynamic> json) {
    return BalanceHistory(
      balance: json['balance'],
      month: json['month'],
      accountType: json['accountType'],
    );
  }
}
