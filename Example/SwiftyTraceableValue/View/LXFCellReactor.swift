//
//  LXFCellReactor.swift
//  SwiftyTraceableValue_Example
//
//  Created by LinXunFeng on 2021/12/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import ReactorKit
import RxSwift

final class LXFCellReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        var model : LXFDataModel
        
        init(model: LXFDataModel) {
            self.model = model
        }
    }
    
    var initialState: State
    
    init(model: LXFDataModel) {
        initialState = State(model: model)
    }
}
