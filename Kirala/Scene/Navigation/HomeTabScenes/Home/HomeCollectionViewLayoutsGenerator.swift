//
//  HomeCollectionViewLayouts.swift
//  Kirala
//
//  Created by Ali Çolak on 19.05.2024.
//

import UIKit

protocol HomeCollectionViewLayoutsGeneratorProtocol {
    var delegate: HomeViewProtocol? { get set }
    func getLayout(type: HomeCompositionalLayoutSection) -> NSCollectionLayoutSection
}

final class HomeCollectionViewLayoutsGenerator: HomeCollectionViewLayoutsGeneratorProtocol {
    
    weak var delegate: HomeViewProtocol?
    
    func getLayout(type: HomeCompositionalLayoutSection) -> NSCollectionLayoutSection {
        switch type {
        case .campaign:
            return campaignSection()
        case .newAdded:
            return newAddedSection()
        case .bestSellers:
            return bestSellerSection()
        case .mostRated:
            return mostRatedSection()
        }
    }
    
    private func campaignSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            let indexPath = items.last!.indexPath
            self.delegate?.didScrollToItem(at: indexPath)
        }
            
        return section
    }
    
    private func newAddedSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(150), heightDimension: .absolute(260)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),
        ]
        
        return section
    }
    
    private func bestSellerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(150), heightDimension: .absolute(260)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),
        ]
        
        return section
    }
    
    private func mostRatedSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(150), heightDimension: .absolute(260)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),
        ]
        
        return section
    }
    
    
    
}
