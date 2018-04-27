//
//  LBCommentViewController.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBCommentViewController: UIViewController {
    
    var orgCode:String = ""
    var commentText:String = ""
    var startCount:Int = 0
    var imgUrls:[String] = [String]()
    
    var pubishCompetionHandler:(()->())?
    fileprivate let tableView  = UITableView(frame: .zero, style: .grouped)
    fileprivate let headerView = LBCommentHeaderView()
    fileprivate let footerView = LBCommentFooterView()
    
    typealias PickedImageHandle = (UIImage) -> ()
    fileprivate var imagePickerFinishHandle: PickedImageHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addIamgeEvent()
        view.backgroundColor = COLOR_efefef
        navigationItem.title = "评价"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(commitAciton))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font:FONT_32PX,
                                                                   NSAttributedStringKey.foregroundColor:COLOR_e60013], for: .normal)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsetsMake(10, 0, -10, 0)
        
        tableView.register(LBCommentTableViewCell.self, forCellReuseIdentifier: "LBCommentTableViewCell")
        view.addSubview(tableView)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["tableView":tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["tableView":tableView]))
        
        tableView.tableFooterView = footerView
        tableView.tableHeaderView = headerView
        
    }
    
}
// NARK: addImageEvent
extension LBCommentViewController{
    
    fileprivate func addIamgeEvent() {
        
        headerView.selectCompletHandler = {[weak self] (count)in
            guard let strongSelf = self else { return }
            strongSelf.startCount = count
        }
        
        footerView.addImageAction = {[weak self] (btn)in
            
            guard let strongSelf = self else { return }
            guard strongSelf.footerView.images.count < 5  else {
                strongSelf.showAlertView(with: "最多上传5张图片")
                return
            }
            
            strongSelf.showPhotoPickerView(finishHandel: { (image) in
                Print(image)
                strongSelf.footerView.images.append(image)
                strongSelf.uploadImage(image: image, success: { (imgUrl) in
                    strongSelf.imgUrls.append(imgUrl)
                })
            })
        }
    }
    
    // 上传评价
    func commitAciton(){
        guard startCount > 0 else {
            UIAlertView(title: nil, message: "请评价商户星级", delegate: nil, cancelButtonTitle: "确定").show()
            return
        }
        guard commentText.count > 0 else {
            UIAlertView(title: nil, message: "请输入评价内容", delegate: nil, cancelButtonTitle: "确定").show()
            return
        }
        uploadCommentData()
    }
}

extension LBCommentViewController:LBCommentPresent{}
// MARK: - showAlertView
extension LBCommentViewController {
    
    fileprivate func showAlertView(with message: String) {
        let alertController = UIAlertController(title: "提示:", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .cancel) {(_)  in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
   fileprivate func showPhotoPickerView(finishHandel: @escaping PickedImageHandle) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "拍照", style: .default) {[weak self] (_)  in
            self?.showImagePickerController(sourceType: .camera, finishHandel: finishHandel)
        }
        let action1 = UIAlertAction(title: "相册", style: .default) {[weak self] (_)  in
            self?.showImagePickerController(sourceType: .photoLibrary, finishHandel: finishHandel)
        }
        let action2 = UIAlertAction(title: "取消", style: .cancel) {(_)  in
        }
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showImagePickerController(sourceType: UIImagePickerControllerSourceType, finishHandel: @escaping PickedImageHandle) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = false
        self.imagePickerFinishHandle = finishHandel
        present(imagePicker, animated: true, completion: nil)
    }
}
// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension LBCommentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        self.imagePickerFinishHandle?(image)
        picker.dismiss(animated: true, completion: nil)
    }
}
// MARK: UITableViewDelegate, UITableViewDataSource
extension LBCommentViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LBCommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBCommentTableViewCell", for: indexPath) as! LBCommentTableViewCell
        cell.delegate = self
        cell.separatorInset = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0 )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
// MARK: LBCommentTableViewCellDelegate
extension LBCommentViewController:LBCommentTableViewCellDelegate{
    
    func textViewDidEndEditing(_ textView: UITextView) {
        commentText = textView.text
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        commentText = textView.text + text
        return true
    }
}

// MARK:上传图片
extension LBCommentViewController{
    
    fileprivate func uploadImage(image:UIImage,parameters: [String:Any]?=nil,success:@escaping ((String)->())){
        
        let phone  = LBKeychain.get(PHONE_NUMBER)
        let parm = lb_md5Parameter(parameter: ["mobile":phone])
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        let imgName = formatter.string(from: Date())+".png-\(phone)"
        
        LBHttpService.LB_uploadSingleImage(.shopPicUpload, image, imgName, parameters: parm as! [String : String], success: { (json) in
            success(json["PICURL"].stringValue)
        }, failure: { (failItem) in
            UIAlertView(title: "提示", message: failItem.message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
        }) { (error) in
            UIAlertView(title: "提示", message: error.localizedDescription , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            
        }
    }
}





