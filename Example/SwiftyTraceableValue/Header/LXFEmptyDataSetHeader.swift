//
//  LXFEmptyDataSetHeader.swift
//  SwiftyTraceableValue_Example
//
//  Created by LinXunFeng on 2021/12/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import LXFProtocolTool

// 常用配置
struct LXFEmptyDataSetHeader {
    
    static let none = EmptyDataSetConfigure()
    
    static let normal = EmptyDataSetConfigure(
        tipFont: UIFont.systemFont(ofSize: 14),
        tipColor: UIColor.gray,
        tipImage: UIImage(named: "LXFEmptyDataPic"),
        spaceHeight: 15,
        backgroundColor: .yellow,
        description: NSAttributedString(
            string: "Hello World",
            attributes: [
                .foregroundColor : UIColor.green,
                .font: UIFont.systemFont(ofSize: 13)
            ]
        )
    )
    static let noData = { () -> EmptyDataSetConfigure in
        var config = LXFEmptyDataSetHeader.normal
        config.tipStr = "暂无数据"
        return config
    }()
}
