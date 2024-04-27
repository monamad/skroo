import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skroo/logics/players_provider.dart';
import 'package:skroo/presentation/widgets/custom_text_field.dart';
import 'package:skroo/presentation/widgets/show_snackbar.dart';

class AddScoreBottomSheet extends StatefulWidget {
  const AddScoreBottomSheet({super.key});

  @override
  State<AddScoreBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<AddScoreBottomSheet> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> scorecontrollers = List.generate(
        Provider.of<PlayersProvider>(context).numberOfPlayer,
        (index) => TextEditingController());
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Text(
                  'Enter round ${Provider.of<PlayersProvider>(context).currntRound + 1} Score:'),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      Provider.of<PlayersProvider>(context).numberOfPlayer,
                  itemBuilder: (BuildContext context, int index) =>
                      CustomTextField(
                    hint:
                        'enter ${Provider.of<PlayersProvider>(context).players[index].name} Score',
                    isnumber: true,
                    myController: scorecontrollers[index],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      if (Provider.of<PlayersProvider>(context, listen: false)
                              .currntRound ==
                          5) {
                        Navigator.pop(context);
                        showsnackbar(context,
                            'winner is ${Provider.of<PlayersProvider>(context, listen: false).winner().name} start a new game');
                        return;
                      }
                      Provider.of<PlayersProvider>(context, listen: false)
                          .addScore(
                              scorecontrollers.map((e) => e.text).toList());
                      Navigator.pop(context);
                    } on PlayersProvider catch (e) {
                      print(e);
                      showsnackbar(context, e.message);
                    }
                  }
                },
                child: const Text('add score'),
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
