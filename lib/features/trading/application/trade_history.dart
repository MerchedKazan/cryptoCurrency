import 'dart:convert';

import 'package:crypto_currency_test/features/trading/domain/trade_history_model.dart';
import 'package:http/http.dart' as http;
class TradeHistoryService{
 Future<List<TradeHistoryModel>> getHistory(String id)async{
  List<TradeHistoryModel> list=[];
    try{
      var response=await http.get(Uri.parse("https://api.coincap.io/v2/assets/$id/history?interval=d1"));
      var rspStr=utf8.decode(response.bodyBytes);
      var rspData=jsonDecode(rspStr);
      if(response.statusCode==200){
      list=List.from(rspData['data'].map((e)=>TradeHistoryModel.fromJson(e)));
      return list;
      }else{
        throw ("error");
      }
    }catch(e){
rethrow;
    }
  }
 Future<List<TradeHistoryModel>> getHistoryForSingleAsset(String id)async{
  List<TradeHistoryModel> list=[];
    try{
 int now = DateTime.now().millisecondsSinceEpoch;
int twentyFourHoursAgo = DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;

 

      var response=await http.get(Uri.parse("https://api.coincap.io/v2/assets/$id/history?interval=h1&start=$twentyFourHoursAgo&end=$now"),
     
      );
      var rspStr=utf8.decode(response.bodyBytes);
      var rspData=jsonDecode(rspStr);
      if(response.statusCode==200){
      list=List.from(rspData['data'].map((e)=>TradeHistoryModel.fromJson(e)));
      return list;
      }else{
        throw ("error");
      }
    }catch(e){
rethrow;
    }
  }
}