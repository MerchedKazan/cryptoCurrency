
import 'package:crypto_currency_test/features/home/presentation/controller/list_price_controller.dart';
import 'package:crypto_currency_test/features/home/presentation/widgets/list_prices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Portfolio",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Icon(Icons.settings)
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                gradient: LinearGradient(

      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
      // Color(0xff6d34d1),
      // Color(0xffcf28ce),
      // Color(0xff7ccdeb),
      // Color(0xfff0abc5),
      Color(0xFF4E4DE0), // Deep blue
      Color(0xFFC045D6), // Vibrant purple
      Color(0xFFD758D4), // Bright pinkish-purple
      Color(0xFFCB8BE2), // Softer purple
      Color(0xFFAFCDED),
      

      ],
      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
      // colors: [
      //   Color(0xFFCBA5E6), // Start color of the gradient
      //   Color(0xFFFD1B2E7), // Middle color of the gradient
      //   Color(0xFFD1B2E7), // End color of the gradient
      //   Color(0xFFE7CFEA), //3
      //   Color(0xFFEFD6E9), //4
      //   Color(0xFFF1DBE9), //5
      //   Color(0xFFF1D6E1), //6
      //   Color(0xFF9F40DF), //7
      //   Color(0xFF808080), //8
      //   Color(0xFFCC6666), //9
      //   Color(0xFFA9C2FB), //10
      // ],
      // stops: [0.0,
      // 0.1,
      // 0.1,
      // 0.1,
      // 0.1,
      // 0.1,
      // 0.1,
      // 0.1,
      // 0.1,
      //  0.8, 
      //  1.0], // Stops for individual color transitions, adjust if needed
    ),
                // gradient: LinearGradient(
                //   colors: [Color(0xFFB46EFF), Color(0xFF79E0F8)],
                //   begin: Alignment(0.95, 0.32),
                //   end: Alignment(-0.95, -0.32),
                // )
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$49,329.77",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                    Icon(
                      Icons.currency_bitcoin,
                      color: Colors.white,
                    )
                  ],
                ),
                Text(
                  "Your balance is equivalent",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white.withOpacity(0.5)),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    child: Text("Deposit",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white
                    ),),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    child: Text("Withdraw",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white
                    ),),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Charts",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Color(0xFFAEB6CE),
              ),),
              Text("See All",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Color(0xFFF6543E),
              ),),
            ],
          ),
          Expanded(child: ListPricesHome()),
          Consumer(
            builder: (context,ref,_) {
              // final prices= ref.watch(cryptoPriceProvider);
              final price=ref.watch(cryptoPriceProvider);
              return InkWell(
                onTap: (){
                  ref.read(cryptoPriceProvider.notifier).updateLimit();
                  ref.read(cryptoPriceProvider.notifier).fetchInitialData();
                },
                child:price.isLoading?Center(
                  child: CircularProgressIndicator.adaptive(),
                ): SizedBox());
            }
          )
        ],
      ),
    ));
  }
}
