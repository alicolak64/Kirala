//
//  File.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

public protocol ApiCallListener {
    func onPreExecute()
    func onPostExecute()
}
