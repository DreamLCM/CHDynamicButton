# CHDynamicButton


##使用方法
#把项目classes文件夹导入到项目中，在使用的viewController，导入框架
var button: PurchaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = PurchaseButton.buttonWithFrame(frame: CGRect(x: 30, y: 300, width: self.view.frame.size.width - 2 * 30, height: 50), borderColor: .red, title: "$2.99", titleColor: .red, backColor: .clear, cornerRadiu: 50 / 2, buttonState: .PurchaseButtonStateNormal)
        button.delegate = self
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(self.actionControl(button:)), for: UIControlEvents.touchUpInside)
        
    }

