//
//  AnyIterator.swift
//  CSV
//
//  Created by Yasuhiro Hatta on 2016/06/21.
//  Copyright © 2016 yaslab. All rights reserved.
//

internal struct AnyIterator<T>: IteratorProtocol {
    
    private var _base_next: (() -> T?)
    
    internal init<U: IteratorProtocol>(base: U) where U.Element == T {
        var base = base
        _base_next = { base.next() }
    }
    
    internal mutating func next() -> T? {
        return _base_next()
    }
    
}
