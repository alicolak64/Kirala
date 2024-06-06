//
//  Searchable.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

/// A protocol to provide a customized search bar.
protocol Searchable: UISearchBarDelegate {
    /// The search bar used in the conforming view controller.
    var searchBar: UISearchBar { get }
}

// MARK: - Default Implementation

extension Searchable where Self: UIViewController {
    
    var searchBar: UISearchBar {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = Strings.Common.searchBarPlaceholder.localized
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            if let leftView = searchTextField.leftView as? UIImageView {
                leftView.tintColor = ColorPalette.appPrimary.dynamicColor
            }
        }
        searchBar.delegate = self
        return searchBar
    }
}


