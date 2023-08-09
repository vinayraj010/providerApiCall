import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:extest/contoller/provider.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: Consumer<AppState>(
          builder: (context, detaildataProvider, _) {
            if (detaildataProvider.dataModel == null) {
              detaildataProvider.fetchDataModel();
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final dataModel = detaildataProvider.dataModel!;
              return detaildataProvider.isLoading == true
                  ? CircularProgressIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Model ID: ${dataModel.id.toString()}'),
                        Text('Title: ${dataModel.title}'),
                        Text('Body: ${dataModel.body}'),
                      ],
                    );
            }
          },
        ),
      ),
    );
  }
}
