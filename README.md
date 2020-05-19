# Transitionz
## Collection of transitions for UIKit

This project was created to demonstrate how to create and use different transition effects.

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

## Adding your own transition animations

The first thin you need to do is implement a class that subclasses `NSObject` and conforms to protocol `UIViewControllerAnimatedTransitioning`.

```Swift
class FancyTransition: NSObject, UIViewControllerAnimatedTransitioning
{
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
  { ... }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
  { ... }
}
```

In `transitionDuration(...)` you just need to return the duration of the animation in seconds. `TimeInterval` is a typealias for `Double`.

In `animateTransition(...)` you'll implement the animation itself. Check the code if you're not sure how to do this.

After that, you need to register your new animation with the Transition Controller. Upon registering a transition animation, you need to provide four things, the transition animation and its reverse, so the system knows what to do when you go back, and one unique identifier for each.

Notice that, when passing the transition object, we actually pass a closure that returns the transition. This way, you can have different durations for each transition, even if they are the same type.

``` Swift
transitionController.register(
    transitionName: "slide.up",
    for: { duration in return VerticalSlideTransition(duration: duration, upwards: true) },
    oppositeName: "slide.down",
    for: { duration in return VerticalSlideTransition(duration: duration, upwards: false) })
```

After this, you're good to go. You can use your new transition animation just like any other.
