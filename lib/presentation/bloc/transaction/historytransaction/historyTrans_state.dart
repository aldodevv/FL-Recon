import 'package:equatable/equatable.dart';
import 'package:recon/domain/entitites/history.dart';

class HistorytransState extends Equatable {
  final bool isLoadingHistory;
  final String messageError;
  final List<TranHistoryEntity>? historyData;
  final LastUpdatedEntity? lastUpdated;


  const HistorytransState({
    required this.isLoadingHistory,
    required this.messageError,
    required this.historyData,
    required this.lastUpdated,
  });

  factory HistorytransState.initial() =>
      const HistorytransState(isLoadingHistory: false, messageError: '', historyData: [], lastUpdated: null);

  HistorytransState copyWith({
    bool? isLoadingHistory,
    String? messageError,
    List<TranHistoryEntity>? historyData,
    LastUpdatedEntity? lastUpdated,
  }) {
    return HistorytransState(
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
      messageError: messageError ?? this.messageError,
      historyData: historyData ?? this.historyData,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [isLoadingHistory, messageError, historyData, lastUpdated];
}
