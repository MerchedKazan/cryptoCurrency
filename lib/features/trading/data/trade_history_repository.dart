import 'package:crypto_currency_test/features/trading/application/trade_history.dart';
import 'package:crypto_currency_test/features/trading/domain/trade_history_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TradeHistoryRepository{
 final TradeHistoryService tradeHistoryService=TradeHistoryService();
 Future<List<TradeHistoryModel>> getTradeHistory(String assetId)async{
    return await tradeHistoryService.getHistory(assetId);
  }
 Future<List<TradeHistoryModel>> getHistoryForSingleAsset(String assetId)async{
    return await tradeHistoryService.getHistoryForSingleAsset(assetId);
  }
}

final tradeHistoryRepoProv=Provider((ref) => TradeHistoryRepository());

final getTradeHistoryProv=FutureProvider.autoDispose.family<List<TradeHistoryModel>,String>((ref,assetId) {
final prov=ref.watch(tradeHistoryRepoProv);
return prov.getTradeHistory(assetId);
});
final getHistoryForSingleAssetProv=FutureProvider.family<List<TradeHistoryModel>,String>((ref,assetId) {
final prov=ref.watch(tradeHistoryRepoProv);
return prov.getHistoryForSingleAsset(assetId);
});