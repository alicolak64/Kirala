//
//  ApiCallListener.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// A protocol that defines methods to be called before and after an API call.
protocol ApiCallListener {
    
    /// Called before the API call is executed.
    func onPreExecute()
    
    /// Called after the API call has completed.
    func onPostExecute()
}
