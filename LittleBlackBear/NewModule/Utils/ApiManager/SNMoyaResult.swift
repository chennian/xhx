//
//  SNRx+ResponseMapper.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/3.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum SNMoyaError : Error {
    case fail(code: Int?, msg: String?)
}

public enum SNMoyaResult<T> {
    case success(T)
    case fail(code: String?, msg: String?)
    case bool(msg: String)
    ///特殊类
    case sp_success(T,code : Int , msg : String)
}

extension UILabel {
    public var rx_text: ControlProperty<String> {
        // 观察text
        let source: Observable<String> = self.rx.observe(String.self, "text").map { $0 ?? "" }
        let setter: (UILabel, String) -> Void = { $0.text = $1 }
        let bindingObserver = UIBindingObserver(UIElement: self, binding: setter)
        return ControlProperty<String>(values: source, valueSink: bindingObserver)
    }
}

extension SNMoyaResult {
    
    func filterValue() -> Observable<T> {
        switch self {
        case .success(let value):
            return Observable.just(value)
        case .fail(let code,let msg):
            return Observable.empty()
        default:
            return Observable.empty()
        }
    }
    
    func filterError() -> Observable<String> {
        switch self {
        case .success(_):
            return Observable.empty()
        case .fail(let code,let msg):
            return Observable.just(msg ?? "")
        default:
            return Observable.empty()
        }
    }
}
