//
//  ZJHeadTopicViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJHeadTopicViewModel: SNBaseViewModel {
    
    var models : [ZJHeadTopicCellModel] = []
    
    let reloadPublish = PublishSubject<Int>()
 

    func getData(){
        SNRequest(requestType: API.getHeadTopicList(size: "10", page: "0"), modelType: ZJHeadTopicModel.self).subscribe(onNext: { (result) in
            switch result{
            case .success(let models):
                self.models = models.lists
                self.reloadPublish.onNext(models.lists.count)
            case .fail(_, let msg):
                ZJLog(messagr: msg)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
    func setLike(id : String,btn : UIButton){
        
        ZJLog(messagr: id)
        ZJLog(messagr: LBKeychain.get(CURRENT_MERC_ID))
//        if btn.isSelected =
        ZJLog(messagr: btn.isSelected ? "1" : "0")
        SNRequestBool(requestType: API.setLike(mercId: LBKeychain.get(CURRENT_MERC_ID), headlineId: id, state: btn.isSelected ? "1" : "0")).subscribe(onNext: { (reseult) in
            switch reseult{
            case .bool(_):
                var Count : Int
                if btn.isSelected{
                    Count = (btn.currentTitle! as NSString).integerValue + 1
                }else{
                    Count = (btn.currentTitle! as NSString).integerValue - 1
                }
                btn.setTitle(String(format: "%2d", Count), for: .normal)
//                break
            case .fail(let code , let msg):
                btn.isSelected = !btn.isSelected
                ZJLog(messagr: code)
                SZHUD("请求失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
    }

}
extension ZJHeadTopicViewModel : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ZJHeadTopicCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = models[indexPath.row]
        cell.buttonClick.subscribe(onNext: { (type) in
            switch type{
            case .share(let model):
                let vc = ZJHeadTopicShareController()
                self.jumpSubject.onNext(SNJumpType.push(vc: vc, anmi: true))
            case .common(let model):
                let vc = ZJHeadTopicDetailVC()
                vc.model = model
                vc.beginEdit = true
                self.jumpSubject.onNext(SNJumpType.push(vc: vc, anmi: true))
            case .like(let id ,let btn):
                self.setLike(id: id, btn: btn)
            }
        }).disposed(by: cell.disposeBag)
        
        cell.clickPub.subscribe(onNext: { (index,imgs) in
            let preview = ZJSinglePhotoPreviewVC()
            
            preview.selectImages = imgs
//            preview.sourceDelegate = self
            preview.currentPage = index
//
            self.jumpSubject.onNext(SNJumpType.show(vc: preview, anmi: true))
        }).disposed(by: cell.disposeBag)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
    
        return models[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ZJHeadTopicDetailVC()
        vc.model = models[indexPath.row]
        self.jumpSubject.onNext(SNJumpType.push(vc: vc, anmi: true))
    }
}
