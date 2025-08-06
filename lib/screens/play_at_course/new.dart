import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_flutter/screens/play_at_course/play_at_course_controller.dart';
import 'package:provider/provider.dart';

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayAtCourseController>(
        builder: (context, PlayAtCourseController controller, child) {
          return Scaffold   (
            appBar: AppBar(
              title: Text('Golf Scorecard'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage('assets/avatar.png'),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Andrew Wade / 31 hcp',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('Meadow Springs Golf And Country Club',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ],
                        )
                      ],
                    ),
                  ),

                  // Legend Section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _buildLegendIcon(Colors.green, 'Eagle'),
                            _buildLegendIcon(Colors.red, 'Birdie'),
                            _buildLegendIcon(Colors.blue, 'Par'),
                            _buildLegendIcon(Colors.orange, 'Bogey'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Score Table
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(color: Colors.grey, width: 0.5),
                      columnWidths: {
                        0: FractionColumnWidth(0.15),
                        1: FractionColumnWidth(0.15),
                        2: FractionColumnWidth(0.15),
                        3: FractionColumnWidth(0.15),
                        4: FractionColumnWidth(0.15),
                        5: FractionColumnWidth(0.15),
                      },
                      children: [
                        _buildTableRow(
                            ['Par', '4', '5', '4', '3', '4'], isHeader: true),
                        _buildTableRow(
                            ['Score', '11', '7', '9', '5', '12'], colors: [
                          Colors.red,
                          Colors.blue,
                          Colors.orange,
                          Colors.green,
                          Colors.red
                        ]),
                        _buildTableRow(['Net', '10', '6', '8', '4', '11']),
                        _buildTableRow(['Puts', '2', '0', '0', '2', '6']),
                        _buildTableRow(['Fairways', 'O', '<', 'O', '>', 'O']),
                        _buildTableRow(['GIR', '✓', 'X', '✓', 'X', '✓']),
                      ],
                    ),
                  ),

                  // Additional Player Rows
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _buildPlayerRow(
                            'Player 1', ['5', '7', '12', '10', '7']),
                        _buildPlayerRow(
                            'Player 2', ['9', '12', '9', '6', '11']),
                        _buildPlayerRow('Player 3', ['7', '10', '7', '8', '8']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

        TableRow _buildTableRow(List<String> cells, {bool isHeader = false, List<Color>? colors}) {
      return TableRow(
        children: cells.asMap().entries.map((entry) {
          final index = entry.key;
          final text = entry.value;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  color: colors != null && index > 0 ? colors[index - 1] : Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
      );
    }

    Widget _buildLegendIcon(Color color, String label) {
      return Row(
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: color,
          ),
          SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12)),
          SizedBox(width: 12),
        ],
      );
    }

    Widget _buildPlayerRow(String playerName, List<String> scores) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: scores.map((score) => Text(score)).toList(),
              ),
            ),
          ],
        ),
      );

}
  }
