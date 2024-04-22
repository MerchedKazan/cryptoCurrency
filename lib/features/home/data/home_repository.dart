// import 'dart:convert';

// import 'package:crypto_currency_test/features/home/application/prices_service.dart';
// import 'package:crypto_currency_test/features/home/domain/assets_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:web_socket_channel/io.dart';

// class HomeRepository{
// final PriceHomeService _homeService=PriceHomeService();
//  List<AssetsModel> assets=[];
// Future<List<AssetsModel>> getAllAssets()async{
//   assets=await _homeService.getAllAssets();
//  return assets;
// }
// Future<List<AssetsModel>> getTradingAssets()async{
//   print(assets);
//   return  assets;
// }
// getStreamData(){
//    final channel=IOWebSocketChannel.connect("wss://ws.coincap.io/prices?assets=bitcoin,ethereum,monero,litecoin",headers: {
//     "Authorization":"Bearer ${tokenn}"
//   });
//   return channel.stream.map((message) {
//        var data = json.decode(message);
//        data.forEach((key,value){
//          assets.firstWhere((element) =>element.id==key.toString(),orElse: () {
//           return AssetsModel();
//         },).priceUsd=value;
//        });
//   } );
// }
// }
// final homeProv=Provider((ref) => HomeRepository());
// final getAllAssetsProv=FutureProvider.autoDispose((ref) {
//   final homeRepo=ref.watch(homeProv);
//   return homeRepo.getAllAssets();
// });
// final getAllTradingAssetsProv=FutureProvider.autoDispose<List<AssetsModel>>((ref) {
//   final homeRepo=ref.watch(homeProv);
//   return homeRepo.getTradingAssets();
// });
// final priceStreamProvider=StreamProvider.autoDispose((ref) {
//   final homeRepo=ref.watch(homeProv);
//   return homeRepo.getStreamData();
// //   homeRepo.getAllAssets();
// //   final channel=IOWebSocketChannel.connect("wss://ws.coincap.io/prices?assets=bitcoin,ethereum,monero,litecoin",headers: {
// //     "Authorization":"Bearer ${tokenn}"
// //   });
// //   // final channel=IOWebSocketChannel.connect("wss://ws.coincap.io/trades/binance");
// //   // print(channel.stream.length);
// //   return channel.stream.map((data) {
// //     print(data.toString());
// //     return
// // data.toString();
// //   } );
// });