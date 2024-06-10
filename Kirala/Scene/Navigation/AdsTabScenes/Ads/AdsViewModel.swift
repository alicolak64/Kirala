//
//  AdsViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import Foundation

struct Ad {
    let brand: String
    let name: String
    let price: String
    let imageUrl: String
    let id: String
    
    private static let mockAds = [
        Ad(brand: "META", name: "Quest 3 128 Gb Kablosuz Vr Sanal Gerçeklik Gözlüğü", price: "20000", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240516/05/4fe5b52b-9683-30b8-8f02-8f27427563ce/1_org_zoom.jpg", id: "1"),
        Ad(brand: "Fancy&Dancy", name: "Kadın Siyah Dalgıç Kumaş Özel Üretim Şık Spor Şort Etek", price: "200", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty523/product/media/images/20220906/10/169669516/559695008/1/1_org_zoom.jpg", id: "2"),
        Ad(brand: "MUCE", name: "Concept Siyah Cam Beyaz Çerçeve Kadın Güneş Gözlüğü Uv 400 Ultraviyole Korumalı", price: "84,90", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty524/product/media/images/20220906/23/169944258/473258342/1/1_org_zoom.jpg", id: "3"),
        Ad(brand: "King", name: "P-637 Grillmax Mor Izgara Ve Tost Makinesi", price: "1.250", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1217/product/media/images/prod/SPM/PIM/20240311/22/99113d09-65de-3c1a-af43-632c965fb05e/1_org_zoom.jpg", id: "4"),
        Ad(brand: "KORKMAZ", name: "A369 Demtez Elektrikli &ccedil;aydanlık Inox-siyah", price: "1.746,78", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1244/product/media/images/prod/SPM/PIM/20240405/20/b0799cb4-d205-3193-be0a-7399a4929d55/1_org_zoom.jpg", id: "5"),
        Ad(brand: "Philips", name: "3000 Serisi Airfryer, 0.8kg, 4.1L Kapasite, Siyah, HD9243/90", price: "₺2.589", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1187/product/media/images/prod/SPM/PIM/20240224/17/e382a0cd-ad62-3611-aa9a-14e2ce302389/1_org_zoom.jpg", id: "6"),
    ]
    
    static func getAds() -> [Ad] {
        // random count of ads return
        let count = Int.random(in: 0...mockAds.count)
        return mockAds.shuffled().prefix(count).map { $0 }
    }
    
}

final class AdsViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: AdsViewProtocol?
    
    private let router: AdsRouterProtocol
    private let authService: AuthService
    
    private let ads: [Ad] = Ad.getAds()
    
    // MARK: - Initializers
    
    init(router: AdsRouterProtocol, dependencies: [DependencyType: Any]) {
        self.router = router
        self.authService = dependencies[.authService] as! AuthService
    }
    
}

extension AdsViewModel: AdsViewModelProtocol {
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        delegate?.prepareNavigationBar()
        delegate?.prepareUI()
    }
    
    func viewWillAppear() {
        guard !authService.isLoggedIn else {
            delegate?.showEmptyState(with: .noLoginAds)
            return
        }
        delegate?.addAddAdButtonNavigationItem()
        
        guard !ads.isEmpty else {
            delegate?.showEmptyState(with: .noAds)
            return
        }
        
        delegate?.prepareTableView()
        delegate?.reloadTableView()
        
    }
    
    func viewDidAppear() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func viewDidLayoutSubviews() {
        delegate?.prepareConstraints()
    }
    
    // MARK: - Actions
    
    func didTapEmptyStateActionButton() {
        
        guard authService.isLoggedIn else {
            router.navigate(to: .auth)
            return
        }
        
        router.navigate(to: .add(.addAd))
        
    }
    
    func didTapAddAdButton() {
        router.navigate(to: .add(.addAd))
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        ads.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> AdCellArguments? {
        guard ads.indices.contains(indexPath.row) else {
            return nil
        }
        
        let ad = ads[indexPath.row]
        return AdCellArguments(brand: ad.brand, name: ad.name, imageUrl: ad.imageUrl, price: ad.price)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
        guard ads.indices.contains(indexPath.row) else {
            return
        }
        
        let argument = EditAddAdArguments(id: ads[indexPath.row].id)
        
        router.navigate(to: .add(.editAd(argument)))
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        80
    }
    
}
