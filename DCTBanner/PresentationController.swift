
import UIKit

class PresentationController: UIPresentationController {

	let sourceViewController: UIViewController
	init(presentedViewController: UIViewController, presentingViewController: UIViewController, sourceViewController: UIViewController) {
		self.sourceViewController = sourceViewController
		super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
	}

	override func presentationTransitionDidEnd(completed: Bool) {
		super.presentationTransitionDidEnd(completed)
		self.containerView?.userInteractionEnabled = false
	}

	override func shouldPresentInFullscreen() -> Bool {
		return false
	}

	override func shouldRemovePresentersView() -> Bool {
		return false
	}

	override func frameOfPresentedViewInContainerView() -> CGRect {

		var fittingSize = presentingViewController.view.bounds.size
		fittingSize.height = 0
		fittingSize.width *= (2/3)

		guard
			let presentedView = presentedView(),
			let presentingView = presentingViewController.view
		else {
			return CGRect.zero
		}

		let size = presentedView.systemLayoutSizeFittingSize(fittingSize, withHorizontalFittingPriority: UILayoutPriorityDefaultHigh, verticalFittingPriority: UILayoutPriorityDefaultHigh)
		let presentingWidth = CGRectGetWidth(presentingView.bounds)

		var frame = CGRect()
		frame.origin.x = floor((presentingWidth - size.width) / 2.0)
		frame.origin.y = self.sourceViewController.topLayoutGuide.length + 10.0
		frame.size = size
		return frame;
	}

	override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
		coordinator.animateAlongsideTransition({ context in
			self.presentedView()?.frame = self.frameOfPresentedViewInContainerView()
		}, completion: nil)
	}
}
