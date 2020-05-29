import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urawai_pos/core/Models/users.dart';
import 'package:urawai_pos/core/Services/firebase_auth.dart';
import 'package:urawai_pos/ui/utils/constans/utils.dart';
import 'package:urawai_pos/ui/utils/functions/routeGenerator.dart';

class DrawerMenu extends StatelessWidget {
  final FirebaseAuthentication _auth = FirebaseAuthentication();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          FutureBuilder<Users>(
              future: _auth.currentUserXXX,
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting)
                  return DrawerHeader(child: Text('Loading...'));

                // return Text(snapshot.data.username);
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    snapshot.data.username,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  accountEmail: Text(
                    snapshot.data.email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 80,
                    child: Text(
                      snapshot.data.username[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
                );
              }),
          Container(
            color: Color(0xFFebf2fd),
            child: ListTile(
              leading: Icon(Icons.home),
              title: (Text(
                'Beranda',
                style: kMainMenuStyle,
              )),
              selected: true,
              onTap: () {},
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.cashRegister),
            title: (Text(
              'Transaksi',
              style: kMainMenuStyle,
            )),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RouteGenerator.kRoutePOSPage);
            },
          ),
          ListTile(
              leading: FaIcon(FontAwesomeIcons.clipboardList),
              title: (Text(
                'Riwayat Transaksi',
                style: kMainMenuStyle,
              )),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                    context, RouteGenerator.kRouteTransactionHistory);
              }),
          ListTile(
              leading: FaIcon(FontAwesomeIcons.book),
              title: (Text(
                'Laporan',
                style: kMainMenuStyle,
              )),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                    context, RouteGenerator.kRouteTransactionReport);
              }),
          ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: (Text(
                'Pengaturan',
                style: kMainMenuStyle,
              )),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteGenerator.kRouteSettingsPage);
              }),
          ExpansionTile(
            title: Text(
              'Produk',
              style: kPriceTextStyle,
            ),
            leading: FaIcon(FontAwesomeIcons.instagram),
            children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cog),
                title: (Text(
                  'Tambah Produk',
                  style: kMainMenuStyle,
                )),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, RouteGenerator.kRouteAddProductPage);
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.instagram),
                title: (Text(
                  'List Produk',
                  style: kMainMenuStyle,
                )),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, RouteGenerator.kRouteProductListPage);
                },
              ),
            ],
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.lifeRing),
            title: (Text('Bantuan', style: kMainMenuStyle)),
          ),
          // ListTile(
          //   leading: FaIcon(FontAwesomeIcons.signOutAlt),
          //   title: (Text('Keluar', style: kMainMenuStyle)),
          //   onTap: () {
          //     CostumDialogBox.showCostumDialogBox(
          //         context: context,
          //         title: 'Konfirmasi',
          //         icon: FontAwesomeIcons.signOutAlt,
          //         iconColor: Colors.red,
          //         contentString: 'Keluar dari Aplikasi?',
          //         confirmButtonTitle: 'Keluar',
          //         onConfirmPressed: () async {
          //           await _auth.signOut();
          //           Navigator.pushNamedAndRemoveUntil(
          //               context,
          //               RouteGenerator.kRouteGateKeeper,
          //               ModalRoute.withName(RouteGenerator.kRouteGateKeeper));
          //         });
          //   },

          // ),
        ],
      ),
    );
  }
}
