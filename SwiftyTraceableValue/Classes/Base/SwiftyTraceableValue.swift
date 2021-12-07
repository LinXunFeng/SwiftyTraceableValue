//
//  SwiftyTraceableValue.swift
//  SwiftyTraceableValue
//
//  Created by LinXunFeng on 2021/12/7.
//

@propertyWrapper
public struct SwiftyTraceableValue<T> {
    public  var tracker: Int = 0
    public var value: T
    
    public var projectedValue: SwiftyTraceableValue {
        return self
    }
    
    public var wrappedValue: T {
        get {
            return self.value
        } set {
            self.tracker += 1
            self.value = newValue
        }
    }
    
    public init(wrappedValue: T) {
        self.value = wrappedValue
    }
}
