import 'package:crypto_currency_test/features/home/data/home_repository.dart';
import 'package:crypto_currency_test/features/home/presentation/controller/list_price_controller.dart';
import 'package:crypto_currency_test/features/trading/data/trade_history_repository.dart';
import 'package:crypto_currency_test/features/trading/presentation/controller/trade_controller.dart';
import 'package:crypto_currency_test/theme/theme_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
class TradingUiController extends GetxController{
  var selectedId="bitcoin".obs;
  @override
  void onClose() {
    selectedId.value="";
    super.onClose();
  }
}
class TradingScreen extends StatelessWidget {
   TradingScreen({super.key});
 final List<SalesData> chartData = [
    SalesData('Mon', 10),
    SalesData('Tue', 20),
    SalesData('Wed', 35),
    SalesData('Thu', 40),
    SalesData('Fri', 15),
    SalesData('Sat', 25),
    SalesData('Sun', 20),
  ];
  final controllerUi=Get.put(TradingUiController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trading",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Icon(Icons.settings)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            
            Container(
              
              height: 30,
              child: Consumer(
                builder: (context,ref,_) {
                  final listAssets=ref.watch(listPriceProv);
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal
                    ,itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: (){
                        controllerUi.selectedId.value=listAssets[index].id??"";
                        print(controllerUi.selectedId.value);
                        ref.read(getTradeHistoryProv(controllerUi.selectedId.value).future);
                        ref.read(tradeHistoryCtrlProv.notifier).getHistory(listAssets[index].id??"");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () {
                            return Text("${listAssets[index].symbol}/USD",style: TextStyle(
                              color:controllerUi.selectedId.value==listAssets[index].id? primaryColor:Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              decoration:controllerUi.selectedId.value==listAssets[index].id? TextDecoration.underline:TextDecoration.none
                            ),);
                          }
                        ),
                      ),
                    );
                  }),itemCount: listAssets.length,);
                }
              ),
            ),
            SizedBox(height: 20,),
               Consumer(builder: (context,ref,_){
                final getHistory=ref.watch(tradeHistoryCtrlProv);
                final isLoading=ref.watch(tradeHistoryCtrlProv.notifier).state.isLoading;
                return isLoading?Center(
                  child: CircularProgressIndicator.adaptive(),
                ):
                Center(child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(getHistory.value!.length.toString()),
                      // Text(getHistory.value!.first.priceUsd.toString()),
                      SizedBox(
                            height: MediaQuery.of(context).size.height*0.4,
                            // width: MediaQuery.of(context).size.width*0.9,
                             child: LineChart(
                   LineChartData(
                     gridData: FlGridData(show: true), 
                     titlesData: FlTitlesData(show: true,
                     rightTitles: AxisTitles(),
                     topTitles: AxisTitles(),
                     bottomTitles: AxisTitles()
                     ), 
                     borderData: FlBorderData(show: false), // Hides chart border
                     minX: 0,
                     maxX: getHistory.value!.length.toDouble(), // Number of days
                     minY: 0,
                     maxY: ref.watch(tradeHistoryCtrlProv.notifier).maxPrice, // Max value on the y-axis
                     lineBarsData: [
                       LineChartBarData(
                              spots: 
                              List.generate(getHistory.value!.length, (index) => FlSpot(index.toDouble(), double.parse(getHistory.value![index].priceUsd??"0")))
                              // [
                              //   FlSpot(0, 3000),
                              //   FlSpot(1, 400),
                              //   FlSpot(2, 5000),
                              //   FlSpot(3, 6000),
                              //   FlSpot(4, 4500),
                              //   FlSpot(5, 5000),
                              //   FlSpot(6, 4500),
                              //   FlSpot(7, 3500),
                              //   // FlSpot(8, 4500),
                              //   // FlSpot(9, 5500),
                              //   // Add the rest of your data points here
                              // ],
                              ,
                              isCurved: false,
                              dotData: FlDotData(
                  show: false
                              ),
                              
                              color: Colors.red,
                              belowBarData: BarAreaData(
                  show: true,
                  color: Colors.red.withOpacity(0.3), // Adjust opacity for gradient look
                              ),
                       ),
                     ],
                   ),
                               ),
                           ),
                           SizedBox(height: 20,),
                           Text("Estimated purchase value",style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: secondaryTextColor
                           ) ,),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical:4.0),
                             child: Text("0.0031",style: Theme.of(context).textTheme.titleSmall,),
                           ),
                           Divider(),
                           Text("Trade value",style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: secondaryTextColor
                           ) ,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:4.0),
                              child: Text("345 USD",style: Theme.of(context).textTheme.titleSmall,),
                            ),
                            Divider(),
                    ],
                  ),
                ),);
              }),
           
          //  SizedBox(
          //   height: MediaQuery.of(context).size.height*0.4,
          //   // width: MediaQuery.of(context).size.width*0.9,
          //    child: LineChart(
              
          //        LineChartData(
          //          gridData: FlGridData(show: true), 
          //          titlesData: FlTitlesData(show: true,

          //          rightTitles: AxisTitles(),
          //          topTitles: AxisTitles(),
          //         // bottomTitles: AxisTitles(
          //         //   axisNameWidget: Text("data")
          //         // )
                   
                   
          //          ), 
          //          borderData: FlBorderData(show: false), // Hides chart border
          //          minX: 0,
          //          maxX: 363, // Number of days
          //          minY: 0,
          //          maxY: 15000, // Max value on the y-axis
          //          lineBarsData: [
          //            LineChartBarData(
          //     spots: [
          //       FlSpot(0, 3000),
          //       FlSpot(1, 400),
          //       FlSpot(2, 5000),
          //       FlSpot(3, 6000),
          //       FlSpot(4, 4500),
          //       FlSpot(5, 5000),
          //       FlSpot(6, 4500),
          //       FlSpot(7, 3500),
          //       // FlSpot(8, 4500),
          //       // FlSpot(9, 5500),
          //       // Add the rest of your data points here
          //     ],
          //     isCurved: true,
          //     color: Colors.red,
          //     belowBarData: BarAreaData(
          //       show: true,
          //       color: Colors.red.withOpacity(0.3), // Adjust opacity for gradient look
          //     ),
          //            ),
          //          ],
          //        ),
          //      ),
          //  ),
          // SfCartesianChart(
          //     primaryXAxis: CategoryAxis(),
          //     // Chart title
          //     title: ChartTitle(text: 'Half yearly sales analysis'),
          //     // Enable legend
          //     legend: Legend(isVisible: true),
          //     // Enable tooltip
          //     tooltipBehavior: TooltipBehavior(enable: true),
          //     series: <ChartSeries<SalesData, String>>[
          //       LineSeries<SalesData, String>(
          //           dataSource: chartData,
          //           xValueMapper: (SalesData sales, _) => sales.day,
          //           yValueMapper: (SalesData sales, _) => sales.sales,
          //           name: 'Sales',
          //           // Enable data label
          //           dataLabelSettings: DataLabelSettings(isVisible: true))
          //     ]),
             
          //  SizedBox(
          //   height: MediaQuery.of(context).size.height*0.4,
          //   width: MediaQuery.of(context).size.width*1,
          //    child: SfCartesianChart(
          //        // Title for the chart
          //        title: ChartTitle(text: 'Weekly Sales Analysis'),
          //        // Enable legend
          //        legend: Legend(isVisible: true),
          //        // Enable tooltip
          //        tooltipBehavior: TooltipBehavior(enable: true),
          //        // Initialize category axis
          //        primaryXAxis: CategoryAxis(
          //          title: AxisTitle(text: 'Day of the Week'), // X Axis title
          //        ),
          //        primaryYAxis: NumericAxis(
          //         //  labelFormat: '{value}k',
          //         //  numberFormat: NumberFormat.compact(),
          //          title: AxisTitle(text: 'Sales'), // Y Axis title
          //        ),
          //        series: <ChartSeries>[
          //          // Initialize line series
          //          LineSeries<SalesData, String>(
          //            dataSource:chartData,
          //            xValueMapper: (SalesData sales, _) => sales.day,
          //            yValueMapper: (SalesData sales, _) => sales.sales,
          //            // Enable data label
          //            dataLabelSettings: DataLabelSettings(isVisible: true),
          //          )
          //        ],
          //      ),
          //  )
          ]))));
          
  }
  
}
class SalesData {
  SalesData(this.day, this.sales);
  final String day;
  final double sales;
}