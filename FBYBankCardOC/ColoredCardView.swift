
import UIKit

import FBYBankCard

class ColoredCardView: CardView, UITableViewDataSource, UITableViewDelegate {
    
    @objc var cardLogo: UIImageView!
    
    @objc var cardName: UILabel!
    
    @objc var cardAddress: UILabel!
    
    @objc var cardNumber: UILabel!
    
    @objc var cardTableView: UITableView!
    
    @objc var bankCardView: UIView!
    
    @objc var removeCardViewButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) 还没有运行")
    }
    
    func setupSubViews() {
        self.layer.cornerRadius  = 10
        self.layer.masksToBounds = true
        
        let screenw = self.frame.width
        let screenh = self.frame.height
        
        bankCardView = UIView(frame: CGRect(x: 0, y: 0, width: screenw, height: screenw/2))
        bankCardView.layer.contents = UIImage(named: "建设")?.cgImage
        
        cardLogo = UIImageView(frame: CGRect(x: 15, y: 15, width: 40, height: 40))
        cardLogo.image = UIImage(named: "建设logo")
        
        cardName = UILabel(frame: CGRect(x: 60, y: 10, width: screenw/3, height: 30))
        cardName.textColor = UIColor.white
        cardName.text = "中国建设银行"
        
        cardAddress = UILabel(frame: CGRect(x: 60, y: 40, width: screenw/3, height: 20))
        cardAddress.text = "储蓄卡"
        cardAddress.font = UIFont.systemFont(ofSize: 13.0)
        cardAddress.textColor = UIColor.white
        
        cardNumber = UILabel(frame: CGRect(x: screenw/2, y: 25, width: screenw/2-15, height: 30))
        cardNumber.text = "＊＊＊＊ 8888"
        cardNumber.font = UIFont.systemFont(ofSize: 18.0)
        cardNumber.textColor = UIColor.white
        cardNumber.textAlignment = .right
        
        cardTableView = UITableView(frame: CGRect(x: 0, y: screenw/2, width: screenw, height: 200))
        cardTableView.dataSource = self
        cardTableView.delegate = self
        cardTableView.isHidden = true
        
        removeCardViewButton = UIButton(frame: CGRect(x: (screenw-250)/2, y: screenh-50, width: 250, height: 50))
        removeCardViewButton.setTitle("解除绑定", for: .normal)
        removeCardViewButton.setTitleColor(UIColor.red, for: .normal)
        removeCardViewButton.addTarget(self, action: #selector(removeButtonClick(removeButton:)), for: .touchUpInside)
        removeCardViewButton.isHidden = true
        
        self.addSubview(bankCardView)
        bankCardView.addSubview(cardLogo)
        bankCardView.addSubview(cardName)
        bankCardView.addSubview(cardAddress)
        bankCardView.addSubview(cardNumber)
        self.addSubview(cardTableView)
        self.addSubview(removeCardViewButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let screenw = self.frame.width
        let screenh = self.frame.height
        bankCardView.frame = CGRect(x: 0, y: 0, width: screenw, height: screenw/2)
        cardLogo.frame = CGRect(x: 15, y: 15, width: 40, height: 40)
        cardName.frame = CGRect(x: 60, y: 10, width: screenw/3, height: 30)
        cardAddress.frame = CGRect(x: 60, y: 40, width: screenw/3, height: 20)
        cardNumber.frame = CGRect(x: screenw/2, y: 25, width: screenw/2-15, height: 30)
        removeCardViewButton.frame = CGRect(x: (screenw-250)/2, y: screenh-50, width: 250, height: 50)
        
        cardTableView.frame = CGRect(x: 0, y: screenw/2, width: screenw, height: 250)
    }
    
    @objc public var cardImage: String = "招商.png"{
        didSet {
            print(cardImage)
            bankCardView.layer.contents = UIImage(named: cardImage)?.cgImage
            
            if cardImage == "招商" {
                cardName.text = "中国招商银行"
                cardLogo.image = UIImage(named: "招商logo")
            }else if cardImage == "建设" {
                cardName.text = "中国建设银行"
                cardLogo.image = UIImage(named: "建设logo")
            }else {
                cardName.text = "中国农业银行"
                cardLogo.image = UIImage(named: "农业logo")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        presentedDidUpdate()

    }
    
//MARK: UITableViewDataSource
    // cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    // UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "cardCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        let imageLogo = ["转账","排序","网点","银行","银行卡"]
        let nameText = ["去转账","查看扣款顺序","查看网点","银行服务","银行卡管理"]
        
        cell?.imageView?.image = UIImage(named: imageLogo[indexPath.row])
        cell?.textLabel?.text = nameText[indexPath.row]
        
        return cell!
    }
    
//MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    override var presented: Bool { didSet { presentedDidUpdate() } }
    
    func presentedDidUpdate() {
        
        removeCardViewButton.isHidden = !presented
        cardTableView.isHidden = !presented
//        contentView.backgroundColor = presented ? presentedCardViewColor : depresentedCardViewColor
//        contentView.addTransitionFade()
//        cardView.backgroundColor = presented ? presentedCardViewColor : depresentedCardViewColor
    }
    
    @objc func removeButtonClick(removeButton:UIButton) {
        walletView?.remove(cardView: self, animated: true)
    }
    
}
