import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:odee_front/src/providers/providers.dart';
import 'package:odee_front/src/utils/utils.dart';
import 'package:odee_front/src/widgets/vertical_spacing.dart';
import 'package:odee_front/src/widgets/widgets.dart';

class TableResponsive<P extends MaintainerProvider> extends StatelessWidget {
  const TableResponsive({
    Key? key,
    required this.provider,
    required this.listTitle,
    required this.haveTitlePorc,
    required this.fields,
    required this.onPressedBtnEdit,
    this.width,
  }) : super(key: key);
  final double? width;
  final MaintainerProvider provider;
  final List<String> listTitle;
  final List<double> haveTitlePorc;
  final List<String> fields;
  final Function(int) onPressedBtnEdit;

  @override
  Widget build(BuildContext context) {
    double widthOp = width ??
        (PageUtils.width(context) > PageUtils.maxWidth
            ? PageUtils.maxWidth
            : PageUtils.width(context));
    bool haveTitle = widthOp > PageUtils.mdMax;
    return Column(
      children: [
        filter(),
        const VerticalSpace(),
        SizedBox(
          width: widthOp,
          height: PageUtils.height(context) - 250,
          child: provider.loadRead ||
                  provider.loadDeleted ||
                  provider.loadCreate ||
                  provider.loadUpdate
              ? const Loading()
              : ListView.builder(
                  itemCount: provider.listFilter.length + (haveTitle ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    int i = haveTitle ? index - 1 : index;
                    return index == 0 && haveTitle
                        ? Row(
                            children: [
                              GridResponsive(
                                xl: listTitle.length,
                                lg: listTitle.length,
                                md: 1,
                                sm: 1,
                                xs: 1,
                                xlPorc: haveTitlePorc,
                                lgPorc: haveTitlePorc,
                                children:
                                    listTitle.map((e) => _title(e)).toList(),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  GridResponsive(
                                    xl: listTitle.length,
                                    lg: listTitle.length,
                                    md: 1,
                                    sm: 1,
                                    xs: 1,
                                    xlPorc: haveTitlePorc,
                                    lgPorc: haveTitlePorc,
                                    paddingBottom: 0,
                                    paddingLeft: 0,
                                    paddingRight: 0,
                                    paddingTop: 0,
                                    children: [
                                      if (haveTitle) ...[
                                        ...fields.map((e) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              provider.listFilter[i]
                                                  .toMap()[e]
                                                  .toString(),
                                            ),
                                          );
                                        }).toList(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  onPressedBtnEdit(i),
                                              child:
                                                  const Icon(Icons.edit_note),
                                            ),
                                            SaveDeletedButton<P>(provider
                                                .listFilter[i].id
                                                .toString())
                                          ],
                                        ),
                                        ...List.generate(
                                          listTitle.length,
                                          (index) =>
                                              const Divider(thickness: 2.5),
                                        ).toList(),
                                      ] else ...[
                                        ...fields
                                            .asMap()
                                            .entries
                                            .map(
                                              (e) => GridResponsive(
                                                isExternal: false,
                                                tallaAll: 2,
                                                porcAll: const [20, 75],
                                                children: [
                                                  _title(listTitle[e.key]),
                                                  Text(provider.listFilter[i]
                                                      .toMap()[e.value]
                                                      .toString()),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                        GridResponsive(
                                          isExternal: false,
                                          tallaAll: 1,
                                          porcAll: const [95],
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      onPressedBtnEdit(i),
                                                  child: const Icon(
                                                      Icons.edit_note),
                                                ),
                                                const SizedBox(width: 10),
                                                SaveDeletedButton<P>(
                                                  provider.listFilter[i].id
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            const Divider(thickness: 2.5),
                                          ],
                                        ),
                                      ]
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                  },
                ),
        ),
      ],
    );
  }

  Text _title(String text) => Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
  filter() {
    return TextFormField(
      controller: provider.filterController,
      validator: null,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: const Icon(Icons.search),
        labelText: translate("input.filter"),
      ),
      onSaved: (value) => provider.filterController.text = value!,
      onChanged: (value) => provider.filter(value, fields),
    );
  }
}
