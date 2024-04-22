import 'dart:convert';

import 'package:crypto_currency_test/features/trading/domain/trade_history_model.dart';
import 'package:crypto_currency_test/features/trading/presentation/trading_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class TradeHistoryController extends StateNotifier<AsyncValue<List<TradeHistoryModel>>>{
  TradeHistoryController():super(const AsyncData([])){
    getHistory(Get.find<TradingUiController>().selectedId.value);
  }
  double maxPrice=0;
  getHistory(String id)async{
  List<TradeHistoryModel> list=[];
    try{
      state=const AsyncLoading();
      // {"error":"use valid interval: m1, m5, m15, m30, h1, h2, h6, h12, d1","timestamp":1701083661335}
      var response=await http.get(Uri.parse("https://api.coincap.io/v2/assets/$id/history?interval=d1"));
      var rspStr=utf8.decode(response.bodyBytes);
      var rspData=jsonDecode(rspStr);
      if(response.statusCode==200){
      list=List.from(rspData['data'].map((e)=>TradeHistoryModel.fromJson(e)));
      maxPrice=findMaxPrice(list);
      state=AsyncData(list);
      print(state.value!.length);
      print(state.value!.first.priceUsd);
      }else{
        throw ("error");
      }
    }catch(e){
rethrow;
    }
  }
}

final tradeHistoryCtrlProv=StateNotifierProvider<TradeHistoryController,AsyncValue<List<TradeHistoryModel>>>((ref) => TradeHistoryController());

double findMaxPrice(List<TradeHistoryModel> historyList) {
  return historyList.fold(0.0, (max, model) {
    double currentPrice = double.tryParse(model.priceUsd??"0") ?? 0.0;
    return currentPrice > max ? currentPrice : max;
  });
}