# Transitionz
## Collection of transitions for UIKit

This project was created to demonstrate how to create and use different transition effects.

So far, the transitions available are:
- Slide up/down
- Slide vertically (from and to each corner)
- Push and fade (view is pushed towards user and faded out, while the other view is faded in).

More detailed documentaion and more transitions to come.

## How to use

Subclass `TraNavigationController`, then set the transition effect you wish to use.

You can set the regular transition effect, which will be used in all transitions:

``` Swift
transitionController.regularAnimationType = "slide.up"
```

This only needs to be set once. The best place to do it is probably in the `viewDidLoad` method.

Or you can set only the next transition -- after which the regular animation will be used.

``` Swift
transitionController.nextAnimationType = "slide.inFrom.topRight"
```

The best place to change the next transition is in the `pushViewController` method.

``` Swift
override func pushViewController(_ viewController: UIViewController, animated: Bool)
{
  transitionController.nextAnimationType = "pushAndFade.forward"
  super.pushViewController(viewController, animated: animated)
}
```

Don't forget to call `super.pushViewController(...)`.

If no transition effect is set, the default one (Apple's default) is used.

The default transitions effects are:
- `nil` (Apple's default
- `slide.up`
- `slide.down`
- `slide.inFrom.topRight`
- `slide.outTo.topRight`
- `slide.inFrom.bottomRight`
- `slide.outTo.bottomRight`
- `slide.inFrom.bottomLeft`
- `slide.outTo.bottomLeft`
- `slide.inFrom.topLeft`
- `slide.outTo.topLeft`
- `pushAndFade.forward`
- `pushAndFade.backward`

Each of the transitions above has a reverse transition associated, so that, when the view is `pop`ed out, the animation occurs in the reverse direction.
