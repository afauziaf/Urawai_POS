import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:urawai_pos/Models/orderList.dart';
import 'package:urawai_pos/Models/postedOrder.dart';
import 'package:urawai_pos/Models/products.dart';
import 'package:urawai_pos/Pages/mainPage.dart';
import 'package:uuid/uuid.dart';

class OrderListProvider with ChangeNotifier {
  final Uuid _uuid = Uuid();
  List<OrderList> orderlist = [];
  int _quantity = 1;

  String _orderID = '';
  String _orderDate = '';
  String _cashierName = 'Dummy Cashier';
  String _referenceOrder = 'Meja 7';

  String get orderID => _orderID;
  set orderID(String newValue) {
    _orderID = newValue;
    notifyListeners();
  }

  String get cashierName => _cashierName;
  set cashierName(String newValue) {
    _cashierName = newValue;
    notifyListeners();
  }

  String get referenceOrder => _referenceOrder;
  set referenceOrder(String newValue) {
    _referenceOrder = newValue;
    notifyListeners();
  }

  String get orderDate => _orderDate;
  set orderDate(String newValue) {
    _orderDate = newValue;
    notifyListeners();
  }

  // double get grandTotal => _grandTotal;
  // set grandTotal(double newValue) {
  //   _grandTotal = newValue;
  //   notifyListeners();
  // }

  int get quantity => _quantity;
  set quantity(int newValue) {
    _quantity = newValue;
    notifyListeners();
  }

  void addToList(Product item) {
    orderlist.add(OrderList(
      id: _uuid.v1(),
      productName: item.name,
      price: item.price,
      dateTime: DateTime.now().toString(),
      quantity: 1,
    ));

    notifyListeners();
  }

  void removeFromList(int index) {
    orderlist.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    if (orderlist[index].quantity <= 999) {
      orderlist[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (orderlist[index].quantity > 1) {
      orderlist[index].quantity--;
      notifyListeners();
    }
  }

  void createNewOrder() {
    _orderID = _uuid.v1().substring(0, 8);
    _orderDate = DateFormat.yMEd().add_jms().format(DateTime.now());
    notifyListeners();
  }

  void resetOrderList() {
    orderlist.clear();
    orderID = '';
    orderDate = '';
    cashierName = '';
    referenceOrder = '';
    notifyListeners();
  }

  double get grandTotal {
    double _grandTotal = 0;
    double _tax = 0;
    double _subtotal = 0;

    orderlist.forEach((order) {
      _subtotal = order.quantity * order.price;
      _grandTotal = _grandTotal + _subtotal;
    });
    _subtotal = _grandTotal;

    _tax = _subtotal * 0.1;
    _grandTotal = _subtotal + _tax;

    //proses pembulatan kebawah
    _grandTotal = _grandTotal - (_grandTotal % 100);
    return _grandTotal;
  }

  double get subTotal {
    double _total = 0;
    double _subtotal = 0;

    orderlist.forEach((order) {
      _total = order.quantity * order.price;
      _subtotal = _subtotal + _total;
    });
    return _subtotal;
  }

  bool addPostedOrder(OrderListProvider orderlistState) {
    var orderBox = Hive.box<PostedOrder>(MainPage.postedBoxName);

    try {
      var hiveValue = PostedOrder(
        id: orderlistState.orderID,
        orderDate: orderlistState.orderDate,
        subtotal: orderlistState.subTotal,
        discount: 0,
        grandTotal: orderlistState.grandTotal,
        orderList: orderlistState.orderlist.toList(),
        paidStatus: PaidStatus.UnPaid,
        cashierName: orderlistState.cashierName,
        refernceOrder: orderlistState.referenceOrder,
      );

      //SAVE TO DATABASE
      orderBox.put(orderlistState.orderID, hiveValue);
      return true;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      print('save ${orderlistState.orderlist.length} Item(s) to DB');
    }
  }
}
