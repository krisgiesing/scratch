import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

abstract class Lens extends StatelessComponent {
  const Lens(Key key) : super(key: key);
}

abstract class LensSwitcher {
  TransitionComponent switchLenses(Lens from, Lens to, PerformanceView performance);
}

class Applique extends StatefulComponent {
  const Applique(this.lens, this.switcher, { Key key }) : super(key: key);
  final Lens lens;
  final LensSwitcher switcher;
  AppliqueState createState() => new AppliqueState();
}

class AppliqueState extends State<Applique> {

  TransitionComponent _transition = null;
  Performance _performance = null;

  void initState() {
    switchLenses(null, config.lens);
    super.initState();
  }

  void didUpdateConfig(Applique oldConfig) {
    if (oldConfig.lens.key != config.lens.key) {
      setState(() {
        switchLenses(oldConfig.lens, config.lens);
      });
    }
  }

  switchLenses(Lens from, Lens to) {
    if (_performance != null)
      _performance.stop();
    _performance = new Performance(duration: new Duration(milliseconds: 500));
    _transition = config.switcher.switchLenses(from, to, _performance);
    if (_transition != null)
      _performance.play();
    else
      _performance = null;
  }

  Widget build(BuildContext context) {
    if (_transition != null)
      return _transition;
    else
      return config.lens.build(context);
  }
}
