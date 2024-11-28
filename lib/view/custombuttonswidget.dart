import 'package:flutter/material.dart';
import 'package:todolists/providers/listprovider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'listedit.dart';

class CustomButtons extends StatelessWidget {
  final TextEditingController myController;
  final TextEditingController myController2;

  const CustomButtons(
      {super.key, required this.myController, required this.myController2});

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ListProvider>(context, listen: false).isOneButton ==
        false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              if (titleForm.currentState!.validate()) {
                Provider.of<ListProvider>(context, listen: false)
                    .setTitle(myController.text);
                Provider.of<ListProvider>(context, listen: false)
                    .setDescription(myController2.text);
                Provider.of<ListProvider>(context, listen: false)
                    .setWaitingType("edit");
                context.go('/waiting');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            label: const Text(
              'Edit',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'calibri',
              ),
            ),
            //
          ),
          ElevatedButton.icon(
            onPressed: () {
              Provider.of<ListProvider>(context, listen: false)
                  .setWaitingType("delete");
              context.go('/waiting');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            label: const Text(
              'Delete',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'calibri',
              ),
            ),
            //
          ),
        ],
      );
    } else {
      return ElevatedButton.icon(
        onPressed: () async {
          if (titleForm.currentState!.validate()) {
            Provider.of<ListProvider>(context, listen: false)
                .setTitle(myController.text);
            Provider.of<ListProvider>(context, listen: false)
                .setDescription(myController2.text);
            Provider.of<ListProvider>(context, listen: false)
                .setWaitingType("save");
            context.go('/waiting');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(
          Icons.save,
          color: Colors.black,
        ),
        label: const Text(
          'Save',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'calibri',
          ),
        ),
//
      );
    }
  }
}
