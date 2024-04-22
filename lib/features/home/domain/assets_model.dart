class AssetsModel {
  String? id;
  String? rank;
  String? symbol;
  String? name;
  String? supply;
  String? maxSupply;
  String? marketCapUsd;
  String? volumeUsd24Hr;
  String? priceUsd;
  String? changePercent24Hr;
  String? vwap24Hr;

  AssetsModel(
      {this.id,
      this.rank,
      this.symbol,
      this.name,
      this.supply,
      this.maxSupply,
      this.marketCapUsd,
      this.volumeUsd24Hr,
      this.priceUsd,
      this.changePercent24Hr,
      this.vwap24Hr});

  AssetsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    rank = json['rank']??"";
    symbol = json['symbol']??"";
    name = json['name']??"";
    supply = json['supply']??"";
    maxSupply = json['maxSupply']??"";
    marketCapUsd = json['marketCapUsd']??"";
    volumeUsd24Hr = json['volumeUsd24Hr']??"";
    priceUsd = json['priceUsd']??"";
    changePercent24Hr = json["changePercent24Hr"]!=null? json['changePercent24Hr'].toString().substring(0,4):"";
    vwap24Hr = json['vwap24Hr']??"";


  }

  void updatePrice(String newPrice) {
    priceUsd = newPrice;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['rank'] = this.rank;
  //   data['symbol'] = this.symbol;
  //   data['name'] = this.name;
  //   data['supply'] = this.supply;
  //   data['maxSupply'] = this.maxSupply;
  //   data['marketCapUsd'] = this.marketCapUsd;
  //   data['volumeUsd24Hr'] = this.volumeUsd24Hr;
  //   data['priceUsd'] = this.priceUsd;
  //   data['changePercent24Hr'] = this.changePercent24Hr;
  //   data['vwap24Hr'] = this.vwap24Hr;
  //   return data;
  // }
}
