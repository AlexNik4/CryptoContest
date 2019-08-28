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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
          backgroundColor: const Color(0xffe6e6e6),
          appBar: AppBar(
            title: Text(_title),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _bloc.onCreateCompetitionPressed(),
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
                    TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      maxLength: 100,
                      maxLengthEnforced: true,
                      keyboardType: TextInputType.text,
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
                          child: TextFormField(
                            keyboardType: TextInputType.number,
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
                          child: TextFormField(
                            keyboardType: TextInputType.text,
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
                              selected: _bloc.selectedCompetitionMode == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  _bloc.selectedCompetitionMode = selected ? index : null;
                                });
                              },
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    RaisedButton(
                      onPressed: () => _bloc.selectDate(context),
                      child: Text(_bloc.selectedEndDate.toLocal().toString()),
                    ),
                    SizedBox(height: 10),
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
          )),
    );
  }
}
