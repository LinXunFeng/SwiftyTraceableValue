//
//  LXFCell.swift
//  SwiftyTraceableValue_Example
//
//  Created by LinXunFeng on 2021/12/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import ReactorKit
import RxSwift
import Then
import Reusable

class LXFCell: UITableViewCell, View, Reusable {
    
    var disposeBag = DisposeBag()
    
    // MARK:- UI
    fileprivate let picView = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(picView)
        picView.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.size.width, height: 250)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: LXFCellReactor) {
        reactor.state.map { $0.model.url }
            .map { URL(string: $0) }
            .bind(to: self.picView.rx.image(options: []))
            .disposed(by: disposeBag)
    }
}

