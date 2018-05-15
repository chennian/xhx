//
//  ZJCommonViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 15/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJCommonViewModel: SNBaseViewModel {

    var models : [ZJReplayModel] = []
    
    let publish = PublishSubject<Int>()
    func requestData(shopid : String){
        SNRequest(requestType: API.getCommonList(shopId: shopid), modelType: [ZJReplayModel.self]).subscribe(onNext: { (res) in
            switch res{
            case .success(let models):
                self.models = models
                self.publish.onNext(models.count)
            case .fail:
                SZHUD("获取评论失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}


extension ZJCommonViewModel : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = models[indexPath.row].description
        
        return (text as NSString).boundingRect(with: CGSize.init(width: fit(635), height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : Font(28)], context: nil).height  + fit(120)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ZJCommonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = models[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
}
