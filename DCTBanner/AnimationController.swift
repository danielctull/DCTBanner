
import Foundation

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {

	let duration = NSTimeInterval(0.6)
	let delay = NSTimeInterval(0)
	let damping = CGFloat(0.6)
	let initialVelocity = CGFloat(0)

	enum State {
		case Presenting
		case Dismissing
	}

	let state: State
	init(state: State) {
		self.state = state
	}

	func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return duration
	}

	func animateTransition(context: UIViewControllerContextTransitioning) {

		let view: UIView
		let frame: CGRect
		switch (state) {

			case .Dismissing:

				guard
					let fromView = context.viewForKey(UITransitionContextFromViewKey)
				else {
					return
				}

				view = fromView
				frame = hiddenFrame(fromView.frame)

			case .Presenting:

				guard
					let containerView = context.containerView(),
					let presentedViewController = context.viewControllerForKey(UITransitionContextToViewControllerKey),
					let toView = context.viewForKey(UITransitionContextToViewKey)
				else {
					return
				}

				view = toView
				frame = context.finalFrameForViewController(presentedViewController)

				containerView.addSubview(view)
				view.frame = hiddenFrame(frame)
		}

		UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: initialVelocity, options: [], animations: {

			view.frame = frame

		}, completion: { finished in

			context.completeTransition(finished)
		})
	}

	private func hiddenFrame(visibleFrame: CGRect) -> CGRect {
		var hiddenFrame = visibleFrame
		hiddenFrame.origin.y = -10 - CGRectGetHeight(hiddenFrame)
		return hiddenFrame
	}
}

