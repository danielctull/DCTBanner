
import UIKit

public class BannerController: UIViewController {

	static let CornerRadius = CGFloat(10)

	public enum Style {
		case Success
		case Information
		case Error
	}

	let message: String?
	let style: Style
	let cornerRadius: CGFloat
	public init(style: Style, cornerRadius: CGFloat = BannerController.CornerRadius, title: String? = nil, message: String? = nil) {
		self.message = message
		self.style = style
		self.cornerRadius = cornerRadius
		super.init(nibName: "BannerController", bundle: NSBundle(forClass: BannerController.classForCoder()))
		self.title = title
		self.modalPresentationStyle = .Custom
		self.transitioningDelegate = self
	}

	public required init?(coder: NSCoder) {
		self.message = nil
		self.style = .Error
		self.cornerRadius = BannerController.CornerRadius
		super.init(coder: coder)
	}

	@IBOutlet private var titleLabel: UILabel?
	@IBOutlet private var messageLabel: UILabel?
	public override func viewDidLoad() {
		super.viewDidLoad()
		titleLabel?.text = title
		messageLabel?.text = message
		view.backgroundColor = color(style: style)
		view.layer.cornerRadius = cornerRadius
	}

	var timer: Timer?
	public override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		timer = Timer(timeInterval: duration(style: style), block: { [weak self] in
			self?.dismissViewControllerAnimated(true, completion: nil)
		})
	}

	private func duration(style style: Style) -> NSTimeInterval {
		switch (style) {
			case .Error: return 5
			case .Information: return 2
			case .Success: return 3
		}
	}

	private func color(style style: Style) -> UIColor {
		switch (style) {
			case .Error: return UIColor(red: 1, green: 0.131, blue: 0.131, alpha: 1)
			case .Information: return UIColor(red: 0, green: 0.498, blue: 1, alpha: 1)
			case .Success: return UIColor(red: 0.553, green: 0.714, blue: 0, alpha: 1)
		}
	}
}



extension BannerController: UIViewControllerTransitioningDelegate {

	public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return AnimationController(state: .Presenting)
	}

	public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return AnimationController(state: .Dismissing)
	}

	public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
		return PresentationController(presentedViewController: presented, presentingViewController: presenting, sourceViewController: source)
	}
}
