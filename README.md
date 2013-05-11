# SKBounceAnimation

`SKBounceAnimation` is a `CAKeyframeAnimation` subclass that creates an animation for you based on start and end values and a number of bounces. It’s based on the math and technology in this blogpost: [khanlou.com/2012/01/cakeyframeanimation-make-it-bounce/](http://khanlou.com/2012/01/cakeyframeanimation-make-it-bounce/) which in turn was based partially on Matt Gallagher’s work here: [cocoawithlove.com/2008/09/parametric-acceleration-curves-in-core.html](http://cocoawithlove.com/2008/09/parametric-acceleration-curves-in-core.html).

## Usage

Basic code is simple:

	
	
	NSString *keyPath = @"position.y";
	id finalValue = [NSNumber numberWithFloat:300];
	[view.layer setValue:finalValue forKeyPath:keyPath];

	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
	bounceAnimation.fromValue = [NSNumber numberWithFloat:view.center.x];
	bounceAnimation.toValue = finalValue;
	bounceAnimation.duration = 0.5f;
	bounceAnimation.numberOfBounces = 2;

	[view.layer addAnimation:bounceAnimation forKey:@"someKey"];

We set the value of our keypath to the final value, and then perform the animation. When the animation finishes, it is automatically removed from the layer, and the `finalValue` takes over. If you do not use `-(void)setValue:forKeyPath:`, the original value for the keyPath will take over and the animation will snap back to original location after the animation is over.

## Math

To learn more about the math, check out the [blogpost](http://khanlou.com/2012/01/cakeyframeanimation-make-it-bounce/) and [the informational post](http://khanlou.com/2012/01/dampers-and-their-role-in-physical-models/) preceding it for exact details, but essentially the system behaves with oscillating exponential decay in the form of the equation: `x = Ae^(-αt)•cos(ωt) + B`.

A is the difference between start and end values, B is the end value, α is determined by the number of frames required to get the exponential decay portion to close enough to 0, and ω is determined by the number of periods required to get the desired number of bounces.

## Extras

`shouldOvershoot` is a property that you can change. It defaults to `YES`; if you set it to `NO`, the animation will bounce as if it were hitting a wall, instead of overshooting the target value and bouncing back. It looks a lot like the Anvil effect in Keynote.

`shake` is a property that controls the oscillation function. Setting it to `YES` lets you shake the element instead of moving it. To use it, set the `fromValue` to the maximum amount you want it to go to and `toValue` to its current location. It uses a sine wave for the oscillation instead of cosine, since it starts at 0 (i.e., the current location.)

`stiffness` is a property that determines how stiff the "spring" component should be. Acceptable values are

* `SKBounceAnimationStiffnessLight`
* `SKBounceAnimationStiffnessMedium`
* `SKBounceAnimationStiffnessHeavy`

The default is `SKBounceAnimationStiffnessMedium`.


## Demo app

The demo app contains demos for several different animations that are supported by `SKBounceAnimation`.

* One-axis animation: Using a keypath like `position.x`, we can animate along one axis.
* Two-axis animation: Using a keypath like `position`, `SKBounceAnimation` will generate a path, and your layer will follow it.
* Size: Using the `bounds` keypath, we can make the size increase. The center of the size increase is determined by `anchorPoint`, which can be moved. It defaults to the center of the layer
* Color: I have no idea why anyone would want to bounce a color animation, but I was feeling whimsical, so I added support for this as well.
* Scale: Using a `CATransform3D` struct and the `transform` keypath, we can scale objects. This is very useful to create an effect like UIAlerts bouncing in. The `anchorPoint` also judges how this effect happens.
* Scale & Rotate: Using multiple CATransform3Ds on top of each other, we can do super weird effects like scale and rotating. They look really cool.
* Rect: The last demo creates two `SKBounceAnimations` with two different `keyPath`s (`position` and `bounds`) but attaches them to the same layer. The effect looks like a `frame` animation.

## Other notes

`SKBounceAnimation` doesn’t support the `byValue` property. 