//
//  LXFModel.swift
//  SwiftyTraceableValue_Example
//
//  Created by LinXunFeng on 2021/12/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

struct LXFModel: Codable {
    
    var data: [LXFDataModel] = []
}

struct LXFDataModel: Codable {
    var url : String = ""
}
