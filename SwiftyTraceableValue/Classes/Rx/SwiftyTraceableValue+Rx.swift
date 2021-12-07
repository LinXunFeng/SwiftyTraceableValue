//
//  SwiftyTraceableValue.swift
//  SwiftyTraceableValue
//
//  Created by LinXunFeng on 2021/12/7.
//

import RxSwift

public extension ObservableType {
    func mapDistinctUntilTraceableValueChanged<T>(
        _ transform: @escaping (Element) throws -> SwiftyTraceableValue<T>
    ) -> Observable<T> {
        return self
            .map(transform)
            .distinctUntilChanged { $0.tracker == $1.tracker }
            .map { $0.value }
    }
}
