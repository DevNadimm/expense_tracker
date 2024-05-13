import 'package:flutter/material.dart';

import 'item_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _itemNameTEController = TextEditingController();
  final TextEditingController _itemAmountTEController = TextEditingController();

  List<ItemDetails> itemDetailsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker',style: TextStyle(fontWeight: FontWeight.w500),),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Item Name:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

            const SizedBox(height: 5,),

            TextField(
              controller: _itemNameTEController,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                  hintText: 'Enter item name',
                  hintStyle: TextStyle(fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 18)
              ),
            ),

            const SizedBox(height: 20,),

            const Text('Item Amount:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

            const SizedBox(height: 5,),

            TextField(
              controller: _itemAmountTEController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                  hintText: 'Enter item amount',
                  hintStyle: TextStyle(fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 18)
              ),
            ),

            const SizedBox(height: 20,),

            Row(
              children: [
                ElevatedButton(
                  onPressed: _addItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  child: const Text(
                    'Add Item', style: TextStyle(fontSize: 18),),
                ),

                const SizedBox(width: 10,),

                ElevatedButton(
                  onPressed: _clearAll,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  child: const Text(
                    'Clear All', style: TextStyle(fontSize: 18),),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('History',style: TextStyle(fontSize: 16),),
                  Text('Total Amount: \$${_getTotalAmount ()}',style: const TextStyle(fontSize: 16))
                ]

            ),

            const SizedBox(height: 20,),

            Expanded(
              child: ListView.builder(
                  itemCount: itemDetailsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 50,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f2f2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [

                          const SizedBox(width: 7,),

                          CircleAvatar(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            child: Text('${index + 1}'),
                          ),

                          const SizedBox(width: 10,),

                          Text(itemDetailsList[index].itemName,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

                          const SizedBox(width: 10,),

                          Text('\$${itemDetailsList[index].itemAmount}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  _addItem() {
    String itemNameAddItem = (_itemNameTEController.text).toString();
    int itemAmountAddItem = int.tryParse(_itemAmountTEController.text) ?? 0;

    itemDetailsList.add(ItemDetails(itemName: itemNameAddItem, itemAmount: itemAmountAddItem));
    setState(() {});

    return itemDetailsList;
  }

  _clearAll() {
    itemDetailsList.clear();
    _itemAmountTEController.clear();
    _itemNameTEController.clear();
    setState(() {});

    return itemDetailsList;
  }

  _getTotalAmount (){
    int totalAmount = 0;
    for(ItemDetails itemDetails in itemDetailsList){
      totalAmount += itemDetails.itemAmount;
    }
    return totalAmount;
  }

  @override
  void dispose() {
    _itemNameTEController.dispose();
    _itemAmountTEController.dispose();
    super.dispose();
  }
}
