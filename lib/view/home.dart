import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolists/API/api.dart';
import 'package:todolists/providers/listprovider.dart';
import 'package:todolists/viewmodel/vm_home.dart';
import 'package:go_router/go_router.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    randomColorGenerator(context);
    return Scaffold(
      body: SafeArea(
        child: CustomRefreshIndicator(
            // triggerMode: IndicatorTriggerMode.onEdge,
            onRefresh: () async {
              await API().fetchData(context);
            },
            builder: (
              BuildContext context,
              Widget child,
              IndicatorController controller,
            ) {
              return Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  if (!controller.isIdle)
                    Positioned(
                      top: 35.0 * controller.value,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          value: !controller.isLoading
                              ? controller.value.clamp(0.0, 1.0)
                              : null,
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(0, 100.0 * controller.value),
                    child: child,
                  ),
                ],
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top),
                  child: Card(
                    child: Consumer<ListProvider>(
                      builder: (context, provider, child) => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),

                          // physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.getTodos.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                provider.isOneButton = false;
                                provider.setId(provider.getTodos[index]["id"]);
                                provider.setGestureIndex(index);
                                context.go('/listedit');
                              },
                              child: ListTile(
                                    title: Text(
                                        provider.getTodos[index]["title"]
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        )),
                                    subtitle: Text(
                                        provider.getTodos[index]["body"]
                                                ["content"]
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        )),
                                    tileColor: Color(provider.randomColor(index))
                                        .withOpacity(0.5)),
                            );
                          }),
                    ),
                  )),
            )),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Provider.of<ListProvider>(context, listen: false).isOneButton = true;
          context.go('/listedit');
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add, size: 65),
      ),
    );
  }
}
