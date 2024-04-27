import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skroo/logics/players_provider.dart';
import 'package:skroo/logics/number_of_player_provider.dart';
import 'package:skroo/presentation/widgets/custom_text_field.dart';
import 'package:skroo/presentation/widgets/show_snackbar.dart';

class AddPlayersBottomSheet extends StatefulWidget {
  const AddPlayersBottomSheet({super.key});

  @override
  State<AddPlayersBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<AddPlayersBottomSheet> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> namescontrollers = List.generate(
        Provider.of<NumberOfPlayerProvider>(context).numberOfPlayer,
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
              const Text('Enter players name:'),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: Provider.of<NumberOfPlayerProvider>(context)
                      .numberOfPlayer,
                  itemBuilder: (BuildContext context, int index) =>
                      CustomTextField(
                    hint: 'player${index + 1} name',
                    isnumber: false,
                    myController: namescontrollers[index],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      asignplayer(context, namescontrollers);
                      Navigator.pushNamed(context, '/Dashboard');
                    } on PlayersProvider catch (e) {
                      showsnackbar(context, e.message);
                    }
                  }
                },
                child: const Text('start game'),
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

  void asignplayer(
      BuildContext context, List<TextEditingController> namescontrollers) {
    Provider.of<PlayersProvider>(context, listen: false)
        .addPlayer(namescontrollers.map((e) => e.text).toList().toList());
  }
}
