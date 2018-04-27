//
//  ZJPyErcodeVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 27/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJPyErcodeVC: SNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    let ercodeView = ZJPayErCodeContetnView().then({
        $0.layer.cornerRadius = fit(10)
    })
//    func backUP(){
//        navigationController?.popViewController(animated: true)
//    }
    
    let backButton = UIButton().then({
        $0.setTitle("返回", for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.setImage(UIImage(named:"map_return"), for: .normal)
        $0.setTextImageInsert(margin: fit(10))
    })
    override func viewAppear(_ animated: Bool) {
        super.viewAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        navigationController?.navigationBar.setBackgroundImage(createImageBy(color: Color(0xe8bc38)), for: .default)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)//UIBarButtonItem(title: "返回", imgName: "map_return", fontSize: fit(30), target: self, action: #selector(backUP))
//        navigationController?.navigationBar.barStyle =
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:COLOR_ffffff,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16*default_scale)]
    }
    let imgIcon = UIImageView(image: UIImage(named: "store"))
    let nameLab = UILabel().then({
        $0.font = Font(34)
        $0.textColor = Color(0xfefefe)
    })
    override func setupView() {
        view.backgroundColor = Color(0xe8bc38)
        
        title = "付款"
        view.addSubview(imgIcon)
        view.addSubview(nameLab)
        view.addSubview(ercodeView)
        
        imgIcon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(21)
        }
        nameLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(120)
        }
        
        ercodeView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(200)
            make.width.snEqualTo(682)
            make.height.snEqualTo(718)
        }
        
    }
    
    let  viewmodel = ZJPayErcodeViewModel()
    
    override func bindEvent() {
        viewmodel.checkPublish.subscribe(onNext: {[unowned self] (isExit,name) in
            if isExit{
                self.nameLab.text = name
                self.ercodeView.creatErcode()
            }
        }).disposed(by: disposeBag)
        
        backButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        ercodeView.btnClick.subscribe(onNext: {[unowned self] (url) in
            self.saveImg(qrString: url, icon: nil)
        }).disposed(by: disposeBag)
    }
    
    
    
    func saveImg(qrString : String ,icon : UIImage?){
        let alervc = UIAlertController(title: nil, message: "是否保存图片", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alervc.addAction(actionCancel)
        let actionCertain = UIAlertAction(title: "确定", style: .default) { (action) in
            UIImageWriteToSavedPhotosAlbum(ErCodeTool.creatQRCodeImage(text: qrString, size: fit(1000), icon: icon), self, #selector(self.saveFinshed(image:error:contextInfo:)), nil)
            
            
        }
        alervc.addAction(actionCertain)
        //        present(alervc, animated: true, completion: nil)
//        jumpSubject.onNext(SNJumpType.present(vc: alervc, anmi: true))
        self.present(alervc, animated: true, completion: nil)
    }
    @objc func saveFinshed(image : UIImage,error : NSError?,contextInfo : Any){
        if error == nil{
            
            SZHUD("保存成功", type: .info, callBack: nil)
        }
    }

}
