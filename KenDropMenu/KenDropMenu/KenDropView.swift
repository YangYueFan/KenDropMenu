//
//  KenDropView.swift
//  KenDropMenu
//
//  Created by 科技部iOS on 2018/3/7.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

typealias SelectedBlock = (String,Int) -> ()

@IBDesignable
class KenDropView: UIView ,UITableViewDelegate,UITableViewDataSource{
    
    var selectedBlock : SelectedBlock?
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    
    var dataArr = [String]()
    
    
    lazy var menuTable : UITableView  = {
       
        let table = UITableView.init(frame: CGRect.init(x: 0, y: self.height, width: self.width, height: 0), style: .plain)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    
    @IBInspectable
    var rowHeight: CGFloat = 44 {
        didSet{
            self.menuTable.reloadData()
        }
    }
    @IBInspectable
    var rowTextSize: CGFloat = 15 {
        didSet{
            self.menuTable.reloadData()
        }
    }
    
    @IBInspectable
    var rowTextColor: UIColor = UIColor.black {
        didSet{
            self.menuTable.reloadData()
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable
    var placeholder: String? {
        didSet {
            titleLabel.text = placeholder
        }  
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialFromXib()
    }
    
    func initialFromXib() {
        let bundle = Bundle.init(for: KenDropView.self)
        let nib = UINib(nibName: "KenDropView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        contentView.frame = bounds
        addSubview(contentView)
        addSubview(menuTable)
    }
    
    

    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier:  "Cell")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: rowTextSize)
            cell?.textLabel?.textColor = rowTextColor
        }
        cell?.textLabel?.text = self.dataArr[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedBlock?(self.dataArr[indexPath.row],indexPath.row)
        self.titleLabel.text = self.dataArr[indexPath.row]
        UIView.animate(withDuration: 0.25) {
            self.menuTable.height = 0
            self.height -= CGFloat(self.dataArr.count > 5 ? 5:self.dataArr.count) * self.rowHeight
        }
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.25) {
            if self.menuTable.height == 0 {
                self.menuTable.height = CGFloat(self.dataArr.count > 5 ? 5:self.dataArr.count) * self.rowHeight
                self.height += CGFloat(self.dataArr.count > 5 ? 5:self.dataArr.count) * self.rowHeight
            }else{
                self.menuTable.height = 0
                self.height -= CGFloat(self.dataArr.count > 5 ? 5:self.dataArr.count) * self.rowHeight
            }
        }
        

        
    }
    
}
