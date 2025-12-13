import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/statemanagement/withdraw_history/receipt_history_provider.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';
import 'package:provider/provider.dart';

class ReceiptHistoryWidget extends StatelessWidget {
  const ReceiptHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: context.screenWidth * .1,
        titleSpacing: 0,
        title: const Center(
          child: Text(
            "Receipts History",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Consumer<ManageReceiptHistory>(
        builder: (context, receiptHistory, child) {
          return receiptHistory.state.isEmpty
              ? const Center(
                  child: Text(
                    "Empty List",
                    style: TextStyle(
                      fontSize:/*  */ 20,
                      color: Colors.red,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: receiptHistory.state.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: padding(10),
                      margin: padding(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBE3D5),
                        borderRadius: borderRaduis(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receiptHistory.state[index].newReceipt,
                            overflow: TextOverflow.fade,
                            maxLines: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "view the full receipt >> ",
                                  style: TextStyle(
                                    fontFamily: FontFamily.mainFont,
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
