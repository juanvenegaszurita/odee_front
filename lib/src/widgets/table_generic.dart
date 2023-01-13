import 'package:flutter/material.dart';

class TableGeneric extends StatelessWidget {
  const TableGeneric({
    super.key,
    required this.columns,
    required this.rows,
  });

  final List<String> columns;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columns
          .map<DataColumn>(
            (e) => DataColumn(
              label: Expanded(
                child: Text(
                  e,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
          .toList(),
      rows: rows
          .map<DataRow>((dr) => DataRow(
                cells: dr
                    .map<DataCell>(
                      (dc) => DataCell(Text(dc)),
                    )
                    .toList(),
              ))
          .toList(),
    );
  }
}
