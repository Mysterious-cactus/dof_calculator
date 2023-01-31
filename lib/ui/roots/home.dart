import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class _HomeViewModelState {
  final double? circle;
  final double? aperture;
  final double? distance;
  final double? lens;

  const _HomeViewModelState({
    this.circle,
    this.aperture,
    this.distance,
    this.lens,
  });

  _HomeViewModelState copyWith({
    double? circle,
    double? aperture,
    double? distance,
    double? lens,
  }) {
    return _HomeViewModelState(
      circle: circle ?? this.circle,
      aperture: aperture ?? this.aperture,
      distance: distance ?? this.distance,
      lens: lens ?? this.lens,
    );
  }
}

class _HomeViewModel extends ChangeNotifier {
  BuildContext context;
  var apertureTec = TextEditingController();
  var lensTec = TextEditingController();
  var distanceTec = TextEditingController();
  var circleTec = TextEditingController();
  _HomeViewModel({required this.context}) {
    apertureTec.addListener(() {
      var val = double.tryParse(apertureTec.text);
      state = state.copyWith(aperture: val != null && val > 0 ? val : -1);
    });
    lensTec.addListener(() {
      var val = double.tryParse(lensTec.text);
      state = state.copyWith(lens: val != null && val > 0 ? val : -1);
    });
    distanceTec.addListener(() {
      var val = double.tryParse(distanceTec.text);
      state = state.copyWith(distance: val != null && val > 0 ? val : -1);
    });
    circleTec.addListener(() {
      var val = double.tryParse(circleTec.text);
      state =
          state.copyWith(circle: val != null && val > 0 && val <= 1 ? val : -1);
    });
  }

  var _state = const _HomeViewModelState();
  _HomeViewModelState get state => _state;
  set state(_HomeViewModelState val) {
    _state = val;
    notifyListeners();
  }

  double _result = 0;
  double get result => _result;
  set result(double val) {
    _result = val;
    notifyListeners();
  }

  double _r1 = 0;
  double get r1 => _r1;
  set r1(double val) {
    _r1 = val;
    notifyListeners();
  }

  double _r2 = 0;
  double get r2 => _r2;
  set r2(double val) {
    _r2 = val;
    notifyListeners();
  }

  bool checkFields() {
    return (state.aperture == null || state.aperture == -1 ? false : true) &&
        (state.circle == null || state.circle == -1 ? false : true) &&
        (state.distance == null || state.distance == -1 ? false : true) &&
        (state.lens == null || state.lens == -1 ? false : true);
  }

  String? validateCircle(String value) {
    var val = double.tryParse(value);
    if (val != null && val <= 1 && val > 0) {
      return null;
    } else {
      return "Значение должно быть от 0 до 1";
    }
  }

  String? validateAperture(String value) {
    var val = double.tryParse(value);
    if (val != null && val > 0) {
      return null;
    } else {
      return "Значение должно быть больше 0";
    }
  }

  String? validateDistance(String value) {
    var val = double.tryParse(value);
    if (val != null && val > 0) {
      return null;
    } else {
      return "Значение должно быть больше 0";
    }
  }

  String? validateLens(String value) {
    var val = double.tryParse(value);
    if (val != null && val > 0) {
      return null;
    } else {
      return "Значение должно быть больше 0";
    }
  }

  void clearAll() {
    lensTec.clear();
    distanceTec.clear();
    apertureTec.clear();
    circleTec.clear();
    result = 0;
    r1 = 0;
    r2 = 0;
  }

  void calculate() {
    FocusManager.instance.primaryFocus?.unfocus();
    r1 = (state.distance! * state.lens! / 1000 * state.lens! / 1000) /
        (state.lens! / 1000 * state.lens! / 1000 +
            state.aperture! *
                (state.distance! - state.lens! / 1000) *
                state.circle! /
                1000);
    r2 = (state.distance! * state.lens! / 1000 * state.lens! / 1000) /
        (state.lens! / 1000 * state.lens! / 1000 -
            state.aperture! *
                (state.distance! - state.lens! / 1000) *
                state.circle! /
                1000);
    result = r2 - r1;
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var viewModel = context.watch<_HomeViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Рассчитать ГРИП",
            style: Theme.of(context).primaryTextTheme.titleMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          )
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Center(
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(children: [
                        TextFormField(
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                          //textAlign: TextAlign.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: viewModel.circleTec,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                          ],
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            suffix: Text(
                              "мм",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                            //suffixIconConstraints: BoxConstraints(),
                            labelText: "Круг нерезкости",
                            errorText: null,
                            errorMaxLines: 2,
                          ),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return viewModel.validateCircle(value);
                            } else {
                              return null;
                            }
                          },
                        ),
                      ]),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Expanded(
                      child: Column(children: [
                        TextFormField(
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: viewModel.apertureTec,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                          ],
                          decoration: InputDecoration(
                            labelText: "Диафрагма",
                            errorText: null,
                            errorMaxLines: 2,
                            prefix: Text(
                              "f / ",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                              textAlign: TextAlign.end,
                            ),
                            //prefixIconConstraints: const BoxConstraints(),
                          ),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return viewModel.validateAperture(value);
                            } else {
                              return null;
                            }
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(children: [
                        TextFormField(
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: viewModel.lensTec,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                          ],
                          decoration: InputDecoration(
                            labelText: "Фокусное расстояние",
                            errorText: null,
                            errorMaxLines: 2,
                            suffix: Text(
                              "мм",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                          ),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return viewModel.validateLens(value);
                            } else {
                              return null;
                            }
                          },
                        ),
                      ]),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Expanded(
                      child: Column(children: [
                        TextFormField(
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: viewModel.distanceTec,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                          ],
                          decoration: InputDecoration(
                            labelText: "Дистанция до объекта",
                            errorText: null,
                            errorMaxLines: 2,
                            suffix: Text(
                              "м",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                          ),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return viewModel.validateDistance(value);
                            } else {
                              return null;
                            }
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: viewModel.clearAll,
                        child: const Text("Очистить все"),
                      ),
                    ),
                  ],
                ),
                //const Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Theme.of(context)
                                .disabledColor // Background Color
                            ),
                        onPressed: viewModel.checkFields()
                            ? viewModel.calculate
                            : null,
                        child: const Icon(Icons.check),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Глубина резкости:",
                            style: Theme.of(context).primaryTextTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  viewModel.result
                                      .toStringAsFixed(3)
                                      .toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge),
                              Text(" м",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ближняя граница:",
                            style: Theme.of(context).primaryTextTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(viewModel.r1.toStringAsFixed(3).toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge),
                              Text(" м",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Дальняя граница:",
                            style: Theme.of(context).primaryTextTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(viewModel.r2.toStringAsFixed(3).toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge),
                              Text(" м",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  static Widget create() {
    return ChangeNotifierProvider<_HomeViewModel>(
      create: (context) => _HomeViewModel(context: context),
      child: const Home(),
    );
  }
}
