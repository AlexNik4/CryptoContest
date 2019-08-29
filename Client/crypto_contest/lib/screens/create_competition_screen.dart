import 'package:crypto_contest/blocs/create_competition_bloc.dart';
import 'package:flutter/material.dart';

class CreateCompetitionScreen extends StatefulWidget {
  @override
  _CreateCompetitionScreenState createState() => _CreateCompetitionScreenState();
}

/// From screen for creating a new competition
class _CreateCompetitionScreenState extends State<CreateCompetitionScreen>
    with SingleTickerProviderStateMixin {
  final _title = "New Competition";
  final CreateCompetitionScreenBloc _bloc = CreateCompetitionScreenBloc();

  void _onCreateFABPressed() {
    if (_bloc.onCreateCompetitionPressed()) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe6e6e6),
        appBar: AppBar(
          title: Text(_title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onCreateFABPressed(),
          tooltip: 'Create Contest',
          child: const Icon(Icons.create),
        ),
        body: Form(
          key: _bloc.formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 80),
              child: Column(
                children: <Widget>[
                  // Competition title
                  TextFormField(
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 100,
                    maxLengthEnforced: true,
                    keyboardType: TextInputType.text,
                    onSaved: (value) => _bloc.viewModel.title = value,
                    validator: (value) => _bloc.validateTitleValue(value),
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Title",
                      fillColor: Colors.black,
                      border: const OutlineInputBorder(
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 120,
                        // Competition prize value
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (value) => _bloc.viewModel.prizeValue = value,
                          validator: (value) => _bloc.validatePrizeValue(value),
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            labelText: "Prize Value",
                            fillColor: Colors.black,
                            border: const OutlineInputBorder(
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        // Competition prize coin type
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (value) => _bloc.viewModel.coinSymbol = value,
                          validator: (value) => _bloc.validateCoinValue(value),
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            labelText: "Coin",
                            fillColor: Colors.black,
                            border: const OutlineInputBorder(
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    // The mode of competition (community, creator, random)
                    children: List<Widget>.generate(
                      _bloc.numberOfCompetitionModes,
                      (int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ChoiceChip(
                            avatar: Icon(_bloc.getSelectModeIcon(index)),
                            labelStyle: TextStyle(color: Colors.black),
                            selectedColor: const Color(0xff0066ff),
                            label: Text(_bloc.getSelectModeText(index)),
                            selected: _bloc.viewModel.selectedCompetitionMode == index,
                            onSelected: (bool selected) {
                              setState(() {
                                // TODO : Alex - Use enums
                                _bloc.viewModel.selectedCompetitionMode = selected ? index : null;
                              });
                            },
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  // The competition duration
                  RaisedButton(
                    onPressed: () => _bloc.selectDate(context),
                    child: Text(_bloc.viewModel.selectedEndDate.toLocal().toString()),
                  ),
                  SizedBox(height: 10),
                  // Additional instructions/details for the competition
                  TextFormField(
                    minLines: 2,
                    maxLines: 8,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Instruction",
                      fillColor: Colors.black,
                      border: const OutlineInputBorder(
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
