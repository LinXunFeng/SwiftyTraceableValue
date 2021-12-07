//
//  LXFSection.swift
//  SwiftyTraceableValue_Example
//
//  Created by LinXunFeng on 2021/12/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import RxDataSources

enum LXFSection {
    case list([LXFSectionItem])
}

extension LXFSection: SectionModelType {
    init(original: LXFSection, items: [LXFSectionItem]) {
        switch original {
        case .list: self = .list(items)
        }
    }
    
    var items: [LXFSectionItem] {
        switch self {
        case .list(let items): return items
        }
    }
}

enum LXFSectionItem {
    case item(LXFCellReactor)
}
