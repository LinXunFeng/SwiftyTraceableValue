//
//  ViewController.swift
//  SwiftyTraceableValue
//
//  Created by LinXunFeng on 12/07/2021.
//  Copyright (c) 2021 LinXunFeng. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxDataSources
import LXFProtocolTool
import Reusable
import Then
import SwiftyTraceableValue

class ViewController: UIViewController, View, Refreshable, EmptyDataSetable {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    fileprivate lazy var dataSource = self.dataSourceFactory()
    
    // UI
    fileprivate var tableView = UITableView(frame: .zero).then {
        $0.register(cellType: LXFCell.self)
        $0.rowHeight = 270
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = LXFReactor()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.frame = CGRect(
            x: 0,
            y: Configs.Screen.navibarH,
            width: Configs.Screen.width,
            height: Configs.Screen.height - Configs.Screen.navibarH - Configs.Screen.bottomH
        )
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.reactor?.action.onNext(.beginRefresh)
        }
    }
    
    fileprivate func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<LXFSection> {
        return .init(configureCell: { (dataSource, tableView, indexPath, sectionItem) -> LXFCell in
            let cell: LXFCell = tableView.dequeueReusableCell(for: indexPath)
            switch sectionItem {
            case let .item(reactor):
                cell.reactor = reactor
            }
            return cell
        })
    }
    
    func bind(reactor: LXFReactor) {
        
        // DIY header footer
        self.rx.refresh(reactor, tableView)
            .map { .fetchList($0 == .header) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.rx.tapEmptyView(tableView)
            .map { _ in .beginRefresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
//        reactor.state.map { $0.sections }
//        .do(onNext: { [weak self] sections in
//            print("x1")
//        })
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
            
        reactor.state.mapDistinctUntilTraceableValueChanged { $0.$sections }
            .do(onNext: { [weak self] sections in
                print("x1")
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.emptyConfig }
            .bind(to: tableView.rx.emptyConfig)
            .disposed(by: disposeBag)
    }

}

