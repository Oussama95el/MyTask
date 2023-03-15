import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class PaginationWidget extends StatefulWidget {
  @override
  _PaginationWidgetState createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  late ScrollController _scrollController;
  late List<DocumentSnapshot> _dataList;
  bool _loading = false;
  bool _hasMore = true;
  int _perPage = 5;

  @override
  void initState() {
    super.initState();
    _dataList = [];
    _scrollController = ScrollController()..addListener(_scrollListener);
    _getData();
    print(_dataList.length);
    print(_dataList);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _dataList.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _dataList.length) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListTile(
            title: Text(_dataList[index]['title']),
            subtitle: Text(_dataList[index]['description']),
          );
        }
      },
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getData();
    }
  }

  void _getData() async {
    // if (_loading || !_hasMore) {
    //   return;
    // }
    print("get data");
    setState(() => _loading = true);
    QuerySnapshot querySnapshot;
    if (_dataList.isEmpty) {
      querySnapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .orderBy('createdAt', descending: true)
          .limit(_perPage)
          .get();
    } else {
      DocumentSnapshot lastDocument = _dataList[_dataList.length - 1];
      querySnapshot = await FirebaseFirestore.instance
          .collection('my_collection')
          .orderBy('createdAt', descending: true)
          .startAfterDocument(lastDocument)
          .limit(_perPage)
          .get();
    }
    int documentCount = querySnapshot.docs.length;
    if (documentCount < _perPage) {
      _hasMore = false;
    }
    _dataList.addAll(querySnapshot.docs);
    setState(() => _loading = false);
  }
}