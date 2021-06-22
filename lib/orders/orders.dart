import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solosadmin/orders/neworders.dart';

import '../solosadmindrawer/solosadmindrawer.dart';
import 'createorder.dart';
import 'orderhistory.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.grey.shade800,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Createorder();
                }));
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            appBar: AppBar(
                elevation: 0,
                toolbarHeight: 80,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                title: Text('ORDERS',
                    style: GoogleFonts.koHo(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * .06)),
                bottom: TabBar(indicatorColor: Colors.white, tabs: [
                  Tab(
                      child: Text("NEW ORDERS",
                          style:
                              GoogleFonts.koHo(fontWeight: FontWeight.bold))),
                  Tab(
                    child: Text(
                      "ORDER HISTORY",
                      style: GoogleFonts.koHo(fontWeight: FontWeight.bold),
                    ),
                  )
                ])),
            drawer: SolosAdminDrawer(),
            body: TabBarView(children: [
              Neworders(),
              Orderhistory(),
            ])),
      ),
    );
  }
}
