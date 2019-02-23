//
//  BaseViewModel.swift
//  Autism Helper iOS
//
//  Created by UHP Digital Mac 3 on 14.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BaseViewModel<M: Persistable> {
    
    var stateRelay = BehaviorRelay<ViewState>.init(value: .content)
    var dataRelay = BehaviorRelay<M?>.init(value: nil)
    
    let disposeBag = DisposeBag()
    
    var data: M? {
        return self.dataRelay.value
    }
    
    func setData(data: M) {
        self.dataRelay.accept(data)
        self.stateRelay.accept(ViewState.content)
    }
    
    func setLoading() {
        self.stateRelay.accept(ViewState.loading)
    }
    
    func setMessage(_ message: String, isError: Bool = false) {
        self.stateRelay.accept(isError ? ViewState.error(message) : ViewState.info(message))
    }
    
    func setState(_ state: ViewState) {
        self.stateRelay.accept(state)
    }
    
    func setEvent(event: Event) {
        self.stateRelay.accept(ViewState.customEvent(event))
    }
}
