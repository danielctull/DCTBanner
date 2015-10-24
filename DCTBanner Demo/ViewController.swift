
import UIKit
import DCTBanner

class ViewController: UIViewController {

	@IBAction func presentSuccess() {
		let banner = BannerController(style: .Success, title: "Success", message: "It's all good!")
		self.presentViewController(banner, animated: true, completion: nil)
	}

	@IBAction func presentInformation() {
		let banner = BannerController(style: .Information, title: "Information", message: "Something happened.")
		self.presentViewController(banner, animated: true, completion: nil)
	}

	@IBAction func presentError() {
		let banner = BannerController(style: .Error, title: "Error", message: "There was an error with the networking or something.")
		self.presentViewController(banner, animated: true, completion: nil)
	}
}
