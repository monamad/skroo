import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skroo/logics/number_of_player_provider.dart';
import 'package:skroo/logics/players_provider.dart';
import 'package:skroo/presentation/widgets/add_players_bottom_sheet.dart';
import 'package:skroo/presentation/widgets/custom_text_field.dart';
import 'package:skroo/presentation/widgets/show_snackbar.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/HomeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

void addnumberofoplayer(context, numberofoplayer) {
  Provider.of<PlayersProvider>(context, listen: false)
      .setNumberOfPlayer(int.parse(numberofoplayer));
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return DoubleTapToExit(
      snackBar: const SnackBar(
        content: Text("Tag again to exit !"),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('choose number of players'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hint: 'enter number of players',
                isnumber: true,
                myController: textEditingController,
              ),
              ElevatedButton(
                  onPressed: () {
                    try {
                      addnumberofoplayer(context, textEditingController.text);
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const AddPlayersBottomSheet();
                          });
                    } on NumberOfPlayerException catch (e) {
                      showsnackbar(context, e.message);
                    } catch (e) {
                      showsnackbar(context, 'please enter a number');
                    }
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'submit',
                        textAlign: TextAlign.center,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
