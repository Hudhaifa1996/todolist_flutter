import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../API/api.dart';
import '../providers/listprovider.dart';
import 'loadingwidget.dart';

class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: switch (Provider.of<ListProvider>(context, listen: false)
              .getWaitingType) {
            "save" => API().saveData(context),
            "edit" => API().editData(context),
            "delete" => API().deleteData(context),
            // TODO: Handle this case.
            String() => throw UnimplementedError(),
          },
          initialData: 'wait',
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await API().fetchData(context);
                context.go('/home');
              });
            }
            return const LoadingWidget();
          }),
    );
  }
}
