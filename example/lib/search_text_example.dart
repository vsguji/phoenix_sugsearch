import 'package:flutter/material.dart';
import 'package:phoenix_base/phoenix.dart';
import 'package:phoenix_navbar/phoenix_navbar.dart';
import 'package:phoenix_sugsearch/phoenix_sugsearch.dart';
import 'package:phoenix_toast/phoenix_toast.dart';

/// 第二种searchba的示例，场景应用于 页面标题的下方
class SearchTextExample extends StatefulWidget {
  @override
  _SearchTextExampleState createState() => _SearchTextExampleState();
}

class _SearchTextExampleState extends State<SearchTextExample> {
  FocusNode focusNode = FocusNode();
  SearchTextController scontroller = SearchTextController();

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    textController.addListener(() {
      if (focusNode.hasFocus) {
        if (!PhoenixTools.isEmpty(textController.text)) {
          scontroller.isClearShow = true;
          scontroller.isActionShow = true;
        }
      }
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (!PhoenixTools.isEmpty(textController.text)) {
          scontroller.isClearShow = true;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PhoenixAppBar(
        title: '搜索输入框示例',
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 40,
          ),
          IOSSearchText(
            focusNode: focusNode,
            controller: textController,
            searchController: scontroller..isActionShow = true,
            onTextClear: () {
              debugPrint('sss');
              return false;
            },
            autoFocus: true,
            onActionTap: () {
              scontroller.isClearShow = false;
              scontroller.isActionShow = false;
              focusNode.unfocus();
              PhoenixToast.show('取消', context);
            },
            onTextCommit: (text) {
              PhoenixToast.show('提交内容 : $text', context);
            },
            onTextChange: (text) {
              PhoenixToast.show('输入内容 : $text', context);
            },
          ),
          Container(
            height: 20,
          ),
          Container(
            width: 200,
            child: IOSSearchText(
              innerPadding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              maxHeight: 60,
              innerColor: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              normalBorder: Border.all(
                  color: Color(0xFFF0F0F0), width: 1, style: BorderStyle.solid),
              activeBorder: Border.all(
                  color: Color(0xFF0984F9), width: 1, style: BorderStyle.solid),
              onTextClear: () {
                debugPrint('sss');
                focusNode.unfocus();
                return false;
              },
              autoFocus: true,
              action: Container(),
              onActionTap: () {
                PhoenixToast.show('取消', context);
              },
              onTextCommit: (text) {
                PhoenixToast.show('提交内容 : $text', context);
              },
              onTextChange: (text) {
                PhoenixToast.show('输入内容 : $text', context);
              },
            ),
          )
        ],
      )),
    );
  }
}
