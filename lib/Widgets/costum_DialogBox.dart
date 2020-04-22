import 'package:flutter/material.dart';
import 'package:urawai_pos/constans/utils.dart';

class CostumDialogBox {
  static showDialogInformation({
    BuildContext context,
    String title,
    IconData icon,
    Color iconColor,
    String contentText,
    Function onTap,
  }) {
    showDialog(
      barrierDismissible: false,
      child: AlertDialog(
        title: Text(title, style: kDialogTextStyle),
        content: Row(
          children: <Widget>[
            Icon(
              Icons.info,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(width: 10),
            Text(contentText, style: kDialogTextStyle),
          ],
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: onTap,
              //{
              //   Navigator.pop(context);

              //   orderlistState
              //       .resetOrderList();
              // },
              child: Text('OK', style: kDialogTextStyle))
        ],
      ),
      context: context,
    );
  }

  static showInputDialogBox({
    TextEditingController textEditingController,
    BuildContext context,
    String title,
    String confirmButtonTitle,
    Function onConfirmPressed,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        child: AlertDialog(
          title: Text(
            title,
            style: kDialogTextStyle,
          ),
          content: TextField(
            controller: textEditingController,
            maxLength: 20,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Batal',
                style: kDialogTextStyle,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text(
                confirmButtonTitle,
                style: kDialogTextStyle,
              ),
              onPressed: onConfirmPressed,
            )
          ],
        ));
  }

  static Future<void> showCostumDialogBox({
    BuildContext context,
    String title,
    String contentString,
    IconData icon,
    Color iconColor,
    String confirmButtonTitle,
    Function onConfirmPressed,
  }) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text(
            title,
            style: kDialogTextStyle,
          ),
          content: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 30,
                color: iconColor,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  contentString,
                  style: kDialogTextStyle,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Batal',
                style: kDialogTextStyle,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text(
                confirmButtonTitle,
                style: kDialogTextStyle,
              ),
              onPressed: onConfirmPressed,
            )
          ],
        ));
  }
}
