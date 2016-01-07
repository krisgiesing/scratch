import 'dart:collection';

import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

abstract class Lens {
  dynamic operator [](String key);
}

class LensState extends Lens {
  LensState(this.name, this.map);
  final String name;
  final HashMap<String, dynamic> map;
  dynamic operator [](String key) {
    return map[key];
  }
}

class LensTransitionSpec {
  const LensTransitionSpec({ this.duration, this.curve, this.animatedProperties });
  final Duration duration;
  final Curve curve;
  final List<String> animatedProperties;
}

class LensTransitionMap {
  LensTransitionMap(this.map);
  final Map<String, Map<String, LensTransitionSpec>> map;
  LensTransitionSpec specFor(LensState from, LensState to) {
    Map<String, LensTransitionSpec> dests = map[from?.name];
    return dests == null ? null : dests[to?.name];
  }
}

class LensTransition extends Lens {
  LensTransition(this.from, this.to, this.duration);

  LensTransition.fromSpec(this.from, this.to, LensTransitionSpec spec) {
    if (spec != null) {
      this.duration = spec.duration;
      List<String> properties = spec.animatedProperties;
      if (properties != null) {
        for (int i = 0; i < properties.length; i++) {
          addAnimation(properties[i]);
        }
      }
    }
  }

  LensState from;
  LensState to;
  Duration duration;
  HashMap<String, AnimatedValue> animations = new HashMap<String, AnimatedValue>();

  addAnimation(String property) {
    dynamic target = to[property];
    if (property == "lens:layout") {
      animations[property] = new AnimatedValue<double>(0.0, end: 1.0);
    } else if (target is Color) {
      Color source = from == null ? const Color(0) : from[property];
      animations[property] = new AnimatedColorValue(source, end: target);
    } else if (target is Size) {
      animations[property] = new AnimatedSizeValue(from[property], end: target);
    } else if (target is Rect) {
      animations[property] = new AnimatedRectValue(from[property], end: target);
    } else if (target is num) {
      animations[property] = new AnimatedValue<double>(from[property], end: target);
    } else {
      throw new ArgumentError("No way to interpolate property named " + property);
    }
  }

  dynamic operator [](String key) {
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

typedef Widget LensedWidgetBuilder(Lens lens, BuildContext context);

class Applique extends StatefulComponent {
  const Applique(this.lens, this.transitions, this.builder, { Key key })
    : super(key: key);
  final LensState lens;
  final LensTransitionMap transitions;
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
    LensTransitionSpec spec = config.transitions.specFor(from, to);
    if (spec != null) {
      _transition = new LensTransition.fromSpec(from, to, spec);
      _performance = new Performance(duration: _transition.duration);
      _performance.addListener(this.onProgressChanged);
      _performance.play();
    } else {
      _transition = null;
      _performance = null;
    }
  }

  void onProgressChanged() {
    setState(() {
      _transition.update(_performance);
    });
  }

  Widget build(BuildContext context) {
    return config.builder(_transition ?? config.lens, context);
  }
}
