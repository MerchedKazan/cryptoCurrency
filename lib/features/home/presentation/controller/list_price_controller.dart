import 'dart:convert';
import 'dart:ffi';

import 'package:crypto_currency_test/features/home/data/home_repository.dart';
import 'package:crypto_currency_test/features/home/domain/assets_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

final cryptoPriceProvider =
    StateNotifierProvider<CryptoPriceNotifier, AsyncValue<List<AssetsModel>>>(
        (ref) {
  return CryptoPriceNotifier(ref);
});

// final listPriceProv=StateProvider<List<AssetsModel>>((ref)=>[]);
class CryptoPriceNotifier extends StateNotifier<AsyncValue<List<AssetsModel>>> {
  CryptoPriceNotifier(this.ref) : super(const AsyncData([])) {
    fetchInitialData();
   _setupWebSocket();
  //  _setupWebSocketTrading();
  }
  final Ref ref;
  int limit = 10;

  updateLimit() {
    limit += 5;
  }

  Future<void> fetchInitialData() async {
    state=const AsyncLoading();
    var url = Uri.parse('https://api.coincap.io/v2/assets?limit=$limit');
    var response = await http.get(url);
    var data = json.decode(response.body)['data'];
  //    if(state.value==null ){
  //     state=AsyncData(List.from(data.map((e) => AssetsModel.fromJson(e))));
  //    }else{
  // List<AssetsModel> tempList=List.from(data.map((e) => AssetsModel.fromJson(e)));
  //   state.value!.forEach((e) {
  //     tempList.removeWhere((element) => element.id==e.id);
  //   });
  //   state.value!.addAll(tempList);
  //   ref.read(listPriceProv.notifier).update((st) => state.value!);
  //   print(ref.read(listPriceProv.notifier).state);
  //   state = AsyncData([]);
  //    }
    state = AsyncData([]);
      List<AssetsModel> tempList=List.from(data.map((e) => AssetsModel.fromJson(e)));
      // Get.find<PriceUpdateController>().priceList.value=tempList;
      ref.read(listPriceProv.notifier).state=tempList;
      // ref.read(listPriceProv.notifier).update((st) => tempList);
  }

  void _setupWebSocket() {
    final channel =
        IOWebSocketChannel.connect('wss://ws.coincap.io/prices?assets=ALL');
    channel.stream.listen((message) {
      var data = json.decode(message);
     
      data.forEach((key, value) {
        ref.read(listPriceProv.notifier).updateAssetPrice(key, value);
    //    if( Get.find<PriceUpdateController>().priceList.isNotEmpty){
    // //  List<AssetsModel>  update= Get.find<PriceUpdateController>().priceList;
    // //    update.firstWhere((element) => element.id == key, orElse: () {
    // //         return AssetsModel();
    // //       }).priceUsd = value;
    // //       Get.find<PriceUpdateController>().priceList.value=update;
    
    // Get.find<PriceUpdateController>().priceList.firstWhere((element) {
    //   if(element.id == key){
    //     print(element.id);
    //     ref.read(listPriceProv.notifier).updateAssetPrice(element.id??"", value);
    //     return true;
    //   }else{
    //     return false;
    //   }
    // }, orElse: () {
    //         return AssetsModel();
    //       }).updatePrice(value);
    //    }
       
       
        // if (state.value != null) {
        //   state.value!.firstWhere((element) => element.id == key, orElse: () {
        //     return AssetsModel();
        //   }).priceUsd = value;
        // }
      });
      // state = AsyncData(state.value!); // Trigger state update
    });
  }
  // void _setupWebSocketTrading() {
  //   final channel =
  //       IOWebSocketChannel.connect('wss://ws.coincap.io/trades/binance');
  //   channel.stream.listen((message) {
  //     var data = json.decode(message);
  //     print("trading data $data");
  //   });
  // }
}

class AssetsListNotifier extends StateNotifier<List<AssetsModel>> {
  AssetsListNotifier() : super([]);

  // Method to update the price of an asset
  void updateAssetPrice(String assetId, String newPrice) {
    state = [
      for (final asset in state)
        if (asset.id == assetId)
          // Using the updatePrice method from AssetsModel
          ...{asset..updatePrice(newPrice)}
        else
          ...{asset}
    ];
  }
}

final listPriceProv = StateNotifierProvider<AssetsListNotifier, List<AssetsModel>>((ref) => AssetsListNotifier());
