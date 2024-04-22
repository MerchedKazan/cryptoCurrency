

class TradeHistoryModel {
   String? priceUsd;
   int? time;

  TradeHistoryModel({ this.priceUsd,  this.time});

  TradeHistoryModel.fromJson(Map<String,dynamic> json){
    priceUsd=json["priceUsd"];
    time=json['time'];
  }
}
