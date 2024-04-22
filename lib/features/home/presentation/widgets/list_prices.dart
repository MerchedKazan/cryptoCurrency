
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:crypto_currency_test/features/home/data/home_repository.dart';
import 'package:crypto_currency_test/features/home/domain/assets_model.dart';
import 'package:crypto_currency_test/features/home/presentation/controller/list_price_controller.dart';
import 'package:crypto_currency_test/features/trading/data/trade_history_repository.dart';
import 'package:crypto_currency_test/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ListPricesHome extends ConsumerStatefulWidget {
  const ListPricesHome({super.key});

  @override
  ConsumerState<ListPricesHome> createState() => _ListPricesHomeState();
}

class _ListPricesHomeState extends ConsumerState<ListPricesHome> {
  final scrollController=ScrollController();
  
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
         ref.read(cryptoPriceProvider.notifier).updateLimit();
                  ref.read(cryptoPriceProvider.notifier).fetchInitialData();
        }
    });
    
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // List<AssetsModel>? prices=ref.watch(cryptoPriceProvider).valueOrNull;
    // final prices=ref.watch(listPriceProv);
  //   ref.listen(cryptoPriceProvider,(prev,next){
  //   if(next.isLoading && prev!=null){
  // print("prev in loading ${prev!.value!.length}");
  // // prices=prev.value!;

  //   }
  //     print("next${next!.value!.length}");
    
  //   });
    // final prices=ref.watch(getAllAssetsProv);
    // final stream=ref.watch(priceStreamProvider);
    final price=ref.watch(listPriceProv);
    return
    
     ListView(
          // physics: NeverScrollableScrollPhysics(),
          controller: scrollController,
          shrinkWrap: true,
          children: price.map((e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.symbol.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 16
                      ),),
                      Text("${e.changePercent24Hr.toString()} %",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: secondaryTextColor
                      ),)
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: Consumer(
                        builder: (context,ref,_) {
                          final getHistory=ref.watch(getHistoryForSingleAssetProv(e.id??""));
                          return 
                          getHistory.when(data: (data) {
                            if(data.isNotEmpty){
                             return Sparkline(
                          data: data.map((e) => double.parse(e.priceUsd??"0")).toList(),
                          lineWidth: 5.0,
                          lineColor: Colors.purple,
                          );
                            }else{
                             return Text("no data");
                            }
                          },
                          error: (e,st)=>Center(child: Text("error"),
                          ),
                          loading: ()=>Center(child: LinearProgressIndicator(),)
                          );
                          
                        }
                      ),
                    ),
                  ),
                  Text("${double.parse(e.priceUsd!).toStringAsFixed(2)}\$",style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 16
                      ))
                ],
              ),
            );
            // ListTile(
            //   title: Text(e.symbol.toString()),
            //   trailing: Text("\$${e.priceUsd}"),
            // );
          }).toList(),
    );
       }
     
    // return prices.when(data: (data){
    //   return ListView.builder(
    //     shrinkWrap: true
    //     ,itemBuilder: ((context, index) {
    //     return Text(data[index].priceUsd.toString());
    //   }),itemCount: data.length,);
    // }, error: (e,st)=>Center(child: Text(e.toString()),), loading: ()=>Center(child: CircularProgressIndicator.adaptive(),));
  
}