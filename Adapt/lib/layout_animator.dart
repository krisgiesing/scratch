import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LayoutAnimator extends OneChildRenderObjectWidget {
  LayoutAnimator({ Widget child, this.progress }) : super(child: child);

  double progress;

  RenderLayoutAnimator createRenderObject() => new RenderLayoutAnimator(progress);

  void updateRenderObject(RenderLayoutAnimator renderObject, LayoutAnimator oldWidget) {
    renderObject.update(progress);
  }
}

typedef void DataVisitor(AnimatedBoxParentData data);

class RenderLayoutAnimator extends RenderProxyBox {
  RenderLayoutAnimator(this.progress);

  double progress;
  void performLayout() {
    _visitGrandchildData((AnimatedBoxParentData data) {
      data.animated = true;
    });
    super.performLayout();
  }

  void update(double value) {
    progress = value;
    _visitGrandchildData((AnimatedBoxParentData data) {
      data.update(progress ?? 1.0);
    });
  }

  void _visitGrandchildData(DataVisitor visitor) {
    if (child is ContainerRenderObjectMixin) {
      ContainerRenderObjectMixin container = child as ContainerRenderObjectMixin;
      RenderObject grandchild = container.firstChild;
      while (grandchild != null) {
        ParentData data = grandchild.parentData;
        if (data is AnimatedBoxParentData) {
          visitor(data);
        }
        grandchild = container.childAfter(grandchild);
      }
    }
  }
}
