import 'package:extest/contoller/apiCall.dart';
import 'package:extest/view/detailpage.dart';
import 'package:extest/model/modeldata.dart';
import 'package:extest/contoller/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListData extends StatefulWidget {
  const ListData({Key? key}) : super(key: key);
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    List<DataModel> data = await DataUtil().getData();
    Provider.of<AppState>(context, listen: false).updateDataModel(data);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<AppState>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Api Data Page')),
          body: Container(
            height: size.height -
                const CupertinoNavigationBar().preferredSize.height,
            width: size.width,
            child: provider.dataList.isEmpty
                ? const Center(
                    child: Text("There is No data",))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      final dataModel = provider.dataList[index];
                      int? id = provider.dataList[index].id;
                      return GestureDetector(
                        onTap: () async {
                          provider.updateTemp(id);
                          provider.fetchDataModel();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text("${dataModel.title}"),
                            leading: Text("${dataModel.id}"),
                            subtitle: Text("${dataModel.body}"),
                          ),
                        ),
                      );
                    },
                    itemCount: provider.dataList.length,
                  ),
          ),
        );
      },
    );
  }
}
