

import UIKit

class UBLogoutViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var cancelDisconnectButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    // MARK: - Open variable
    open var cancelClick:(()->Void)?
    open var disconnectClick:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    init(frame: CGRect) {
//        super.init(nibName: "UBLogoutViewController", bundle: nil)
//        view.frame = frame
//    }
//    
//    init() {
//         super.init(nibName: "UBLogoutViewController", bundle: nil)
//    }
    
    open func presentView(parentViewController: UIViewController,
                     title: String,
                     content: String,
                     cancelButtonTitle: String = "Cancel",
                     okButtonTitle: String = "Ok") {
        titleLabel.text = title
        noticeLabel.text = content
        cancelDisconnectButton.setTitle(cancelButtonTitle, for: .normal)
        disconnectButton.setTitle(okButtonTitle, for: .normal)
        
        parentViewController.addChildViewController(self)
        parentViewController.view.addSubview(self.view)
        parentViewController.view.bringSubview(toFront: self.view)
        self.didMove(toParentViewController: parentViewController)
        view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
        }
    }
    
    private func closeView() {
        UIView.animate(withDuration: 0.35,
                                   delay: 0,
                                   usingSpringWithDamping: 1,
                                   initialSpringVelocity: 0.5,
                                   options: .curveEaseOut,
                                   animations: {
                                    self.view.alpha = 0.0
        }) { [unowned self] (finished) in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
            
        }
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBAction func cancelDisconnectPressed(sender: AnyObject) {
        closeView()
        guard let cancleDidClick = cancelClick else { return }
        cancleDidClick()
    }
    
    @IBAction func disconnectPressed(sender: AnyObject) {
        closeView()
        guard let disconnectDidClick = disconnectClick else { return }
        disconnectDidClick()
    }
    
}

// MARK: PRIVATE METHOD
private extension UBLogoutViewController {
    func initUI() {

    }
}
