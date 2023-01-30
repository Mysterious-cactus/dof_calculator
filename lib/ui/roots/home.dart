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
      state = state.copyWith(aperture: double.tryParse(apertureTec.text));
    });
    lensTec.addListener(() {
      state = state.copyWith(lens: double.tryParse(lensTec.text));
    });
    distanceTec.addListener(() {
      state = state.copyWith(distance: double.tryParse(distanceTec.text));
    });
    circleTec.addListener(() {
      state = state.copyWith(circle: double.tryParse(circleTec.text));
    });
  }

  var _state = const _HomeViewModelState();
  _HomeViewModelState get state => _state;
  set state(_HomeViewModelState val) {
    _state = val;
    notifyListeners();
  }

  bool checkFields() {
    return (state.aperture == null ? false : true) &&
        (state.circle == null ? false : true) &&
        (state.distance == null ? false : true) &&
        (state.lens == null ? false : true);
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

  void calculate() {}
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var viewModel = context.watch<_HomeViewModel>();
    return Scaffold(
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
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: viewModel.checkFields()
                            ? viewModel.calculate
                            : null,
                        child: const Icon(Icons.check),
                      ),
                    ),
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
