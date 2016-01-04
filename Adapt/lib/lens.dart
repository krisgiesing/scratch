import 'dart:collection';

import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

abstract class Lens {
  dynamic get(String key);
}

class LensState extends Lens {
  LensState(this.name, this.map);
  final String name;
  final HashMap<String, dynamic> map;
  dynamic get(String key) {
    return map[key];
  }
}

class LensTransition extends Lens {
  LensTransition(this.from, this.to);
  LensState from;
  LensState to;
  HashMap<String, AnimatedValue> animations;
  dynamic get(String key) {
    if (animations.containsKey(key)) {
      return animations[key].value;
    } else {
      return to.map[key];
    }
  }
  void update(PerformanceView performance) {
    animations.values.forEach((AnimatedValue v) {
      performance.updateVariable(v);
    });
  }
}

typedef Performance LensSwitcher(LensState from, LensState to, LensTransition transition);
typedef Widget LensedWidgetBuilder(Lens lens, BuildContext context);

class Applique extends StatefulComponent {
  const Applique(this.lens, this.switcher, this.builder, { Key key })
    : super(key: key);
  final LensState lens;
  final LensSwitcher switcher;
  final LensedWidgetBuilder builder;
  AppliqueState createState() => new AppliqueState();
}

class AppliqueState extends State<Applique> {

  LensTransition _transition = null;
  Performance _performance = null;

  void initState() {
    switchLenses(null, config.lens);
    super.initState();
  }

  void didUpdateConfig(Applique oldConfig) {
    if (oldConfig.lens.name != config.lens.name) {
      setState(() {
        switchLenses(oldConfig.lens, config.lens);
      });
    }
  }

  switchLenses(Lens from, Lens to) {
    if (_performance != null)
      _performance.stop();
    _transition = new LensTransition(from, to);
    _performance = config.switcher(from, to, _transition);
    if (_performance != null)
      _performance.play();
    else {
      _performance = null;
      _transition = null;
    }
  }

  Widget build(BuildContext context) {
    Lens lens = _transition == null ?
      config.lens :
      (_transition..update(_performance));
    return config.builder(lens, context);
  }
}
