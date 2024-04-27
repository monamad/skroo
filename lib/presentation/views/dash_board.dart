import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skroo/presentation/widgets/add_score_bottom_sheet.dart';
import 'package:skroo/logics/players_provider.dart';

class Dashboard extends StatelessWidget {
  static const String routeName = '/Dashboard';
  const Dashboard({super.key});

  TableRow buildheaderrow(context) {
    List<Widget> elements = Provider.of<PlayersProvider>(context)
        .players
        .map(
          (e) => Text(
            e.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )
        .toList();
    elements.insert(
      0,
      const Text(
        'round',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
    return TableRow(children: elements);
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      snackBar: const SnackBar(
        content: Text("are you sure you want to exit ?"),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: DoubleTapToExit(
            snackBar: const SnackBar(
              content: Text("are you sure you want to exit ?"),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Provider.of<PlayersProvider>(context, listen: false).reset();
                NavigatorState nav = Navigator.of(context);
                nav.pop();
              },
            ),
          ),
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const AddScoreBottomSheet();
                    });
              },
            )
          ],
          centerTitle: true,
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Table(
              border: TableBorder.all(),
              children: createtable(context),
            ),
            SizedBox(
              height: 20,
            ),
            Table(border: TableBorder.all(), children: [
              totalScoreRow(context),
            ]),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.brown,
              child: Center(
                child: Text(
                  'current round is ${Provider.of<PlayersProvider>(context).currntRound + 1}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow totalScoreRow(BuildContext context) {
    return TableRow(
      decoration: const BoxDecoration(),
      children: [
        SizedBox(
            height: 50,
            child: Center(
                child: const Text(
              'Total',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ))),
        for (int i = 0;
            i < Provider.of<PlayersProvider>(context).players.length;
            i++)
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                '${Provider.of<PlayersProvider>(context).players[i].totalScore}',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
      ],
    );
  }

  List<TableRow> createtable(BuildContext context) {
    List<TableRow> table = [buildheaderrow(context)];

    for (int i = 0;
        i < Provider.of<PlayersProvider>(context).currntRound;
        i++) {
      table.add(TableRow(
        children: [
          Text(
            '${i + 1}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          for (int j = 0;
              j < Provider.of<PlayersProvider>(context).players.length;
              j++)
            Provider.of<PlayersProvider>(context).players[j].score[i] == 0
                ? Container(
                    width: double.infinity,
                    color: Colors.grey,
                    child: Text(
                      '${Provider.of<PlayersProvider>(context).players[j].score[i]}',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                : Text(
                    '${Provider.of<PlayersProvider>(context).players[j].score[i]}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
        ],
      ));
    }
    return table;
  }
}
