//
//  LBCommentTableViewCell.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
protocol LBCommentTableViewCellDelegate {
    func textViewDidEndEditing(_ textView: UITextView)
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String)->Bool
}
class LBCommentTableViewCell: UITableViewCell {
    
    var delegate:LBCommentTableViewCellDelegate?

    fileprivate let textView = UITextView()
    fileprivate var isFirstEditing = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        contentView.addSubview(textView)
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textView]-|",
                                                                  options: NSLayoutFormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: ["textView":textView]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textView]-|",
                                                                  options: NSLayoutFormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: ["textView":textView]))
        
    }
    private func configTextView()  {
        
        textView.text = "亲，对商家服务还满意吗？快来评价哟~"
        textView.font = FONT_36PX
        textView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

        let paregraphStyle = NSMutableParagraphStyle()
        paregraphStyle.lineSpacing = 10
    
        let attributes = [NSFontAttributeName:FONT_36PX,
                          NSParagraphStyleAttributeName:paregraphStyle
            ] as [String : Any]
        textView.typingAttributes = attributes
        
        let textAttributes = [NSKernAttributeName:1.6,
                              NSParagraphStyleAttributeName:paregraphStyle] as [String:Any]
        textView.attributedText = NSAttributedString(string: textView.text, attributes: textAttributes)
        textView.textColor = COLOR_999999

    }
}
extension LBCommentTableViewCell:UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.textViewDidEndEditing(textView)
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if isFirstEditing == true {
            textView.text = nil
            isFirstEditing = false
        }
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return (delegate?.textView(textView,shouldChangeTextIn:range,replacementText:text))!
        
    }
   
    
}




