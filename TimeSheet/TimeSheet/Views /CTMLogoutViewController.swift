

import UIKit

class CTMLogoutViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleCancelButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var cancelDisconnectButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    
    var cancelClick:(()->Void)!
    var disconnectClick:(()->Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    init(frame: CGRect) {
        super.init(nibName: "CTMLogoutViewController", bundle: nil)
        view.frame = frame
        initUI()
    }
    
    func presentView(parentViewController: UIViewController) {
        parentViewController.addChildViewController(self)
        parentViewController.view.addSubview(self.view)
        parentViewController.view.bringSubviewToFront(self.view)
        self.didMoveToParentViewController(parentViewController)
        view.alpha = 0.0
        UIView.animateWithDuration(0.25) {
            self.view.alpha = 1.0
        }
    }
    
    private func closeView() {
        UIView.animateWithDuration(0.35,
                                   delay: 0,
                                   usingSpringWithDamping: 1,
                                   initialSpringVelocity: 0.5,
                                   options: .CurveEaseOut,
                                   animations: {
                                    self.view.alpha = 0.0
        }) { [unowned self] (finished) in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func cancelDisconnectPressed(sender: AnyObject) {
        closeView()
        
    }
    
    @IBAction func disconnectPressed(sender: AnyObject) {
        closeView()
        if disconnectButton != nil {
            disconnectClick()
        }
    }
    
}

// MARK: PRIVATE METHOD
private extension CTMLogoutViewController {
    func initUI() {
        titleView.backgroundColor = UIColor(hex: Color.titleHeaderBackground)
        titleLabel.textColor = UIColor(hex: Color.titleHeaderText)
        noticeLabel.textColor = UIColor(hex: Color.contentDetailNews)
        cancelDisconnectButton.setTitleColor(UIColor(hex: Color.contentDetailNews), forState: .Normal)
        disconnectButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
}
