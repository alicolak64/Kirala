//
//  HTTPHeaders.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 8.10.2021.
//

import Foundation

public struct HTTPHeaders {
    
    private var headers: [HTTPHeader] = []
 
    public init() {}
    
    public init(_ dictionary: [String: String]) {
        self.init()

        dictionary.forEach { update(HTTPHeader(name: $0.key, value: $0.value)) }
    }
    
    public mutating func add(_ header: HTTPHeader) {
        update(header)
    }

    public mutating func update(name: String, value: String) {
        update(HTTPHeader(name: name, value: value))
    }

    public mutating func update(_ header: HTTPHeader) {
        guard let index = headers.firstIndex(of: header) else {
            headers.append(header)
            return
        }

        headers.replaceSubrange(index...index, with: [header])
    }
    
    public var dictionary: [String: String] {
        let namesAndValues = headers.map { ($0.name, $0.value) }

        return Dictionary(namesAndValues, uniquingKeysWith: { _, last in last })
    }
}
