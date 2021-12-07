//
//  LXFReactor.swift
//  SwiftyTraceableValue_Example
//
//  Created by LinXunFeng on 2021/12/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import ReactorKit
import RxSwift
import LXFProtocolTool
import SwiftyTraceableValue

final class LXFReactor: Reactor, RefreshControllable {
    
    enum Action {
        case fetchList(Bool)
        case beginRefresh
    }
    
    enum Mutation {
        case setSections([LXFSection])
        case setRefreshStatus(RefreshStatus)
        case setEmptyConfig(EmptyDataSetConfigure?)
    }
    
    struct State {
        @SwiftyTraceableValue var sections : [LXFSection] = []
        var emptyConfig : EmptyDataSetConfigure? = nil
    }
    
    fileprivate var pageIndex = 1
    fileprivate var pageSize = 10
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .fetchList(reload):
            return fetchList(reload)
        case .beginRefresh:
            return Observable.just(.setRefreshStatus(.beginHeaderRefresh))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSections(sections):
            newState.sections = sections
        case let .setRefreshStatus(status):
            lxf.refreshStatus.accept(status)
        case let .setEmptyConfig(config):
            newState.emptyConfig = config
        }
        return newState
    }
}

extension LXFReactor {
    fileprivate func fetchList(_ reload: Bool) -> Observable<Mutation> {
        pageIndex = reload ? 0 : pageIndex+1
        
        let endHeaderRefresh = Observable.just(Mutation.setRefreshStatus(.endHeaderRefresh))
        
        let fetchList = lxfNetTool.rx.request(.data(type: .pet, size: pageSize, index: pageIndex))
//            .do(onSuccess: { resp in
//                print("json -- \(resp.fetchJSONString())")
//            })
            .flatMap {
                .just((try? JSONDecoder().decode(LXFModel.self, from: $0.data))?.data ?? [])
            }
            .asObservable()
            .do(onNext: { [weak self] models in
                guard let `self` = self else { return }
                if models.count < self.pageSize {
                    self.lxf.refreshStatus.accept(.noMoreData)
                } else {
                    self.lxf.refreshStatus.accept(.resetNoMoreData)
                }
            })
            .flatMap { [weak self] models -> Observable<Mutation> in
                var setEmptyConfig = Observable.just(Mutation.setEmptyConfig(nil))
                // 测试占位图使用
                // let items: [LXFRefreshableSectionItem] = []
                var items = models.map {
                    LXFSectionItem.item(LXFCellReactor(model: $0))
                }
                if !reload {
                    items = (self?.currentState.sections.first?.items ?? []) + items
                }
                if items.isEmpty {
                    setEmptyConfig = Observable.just(Mutation.setEmptyConfig(LXFEmptyDataSetHeader.noData))
                }
                
                let sections = [LXFSection.list(items)]
                let setSections = Observable.just(Mutation.setSections(sections))
                return Observable.concat([setSections, setEmptyConfig])
            }
        
        return Observable.concat([fetchList, endHeaderRefresh])
    }
}
