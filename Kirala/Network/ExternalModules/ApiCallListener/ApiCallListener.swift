//
//  File.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 17.11.2021.
//

import Foundation

public protocol ApiCallListener {
    func onPreExecute()
    func onPostExecute()
}
