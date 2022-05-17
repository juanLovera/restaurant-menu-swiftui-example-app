//
//  MainMenuViewModel.swift
//  McDonald's Menu
//
//  Created by Juan Jose Lovera on 17/05/2022.
//

import SwiftUI

protocol MainMenuViewModelProtocol: ObservableObject {
    
    func loadMenu() async
}

final class MainMenuViewModel: MainMenuViewModelProtocol {
    
    @Published var restaurantMenu: RestaurantMenu?
    @Published var networkStatus = RequestStatus.idle
    
    func loadMenu() async {
        networkStatus = .loading
        let result: RequestResult<RestaurantMenu> = await NetworkManager.instance.request(
                                                                url: URL(string: APIEndpoints.menu)!,
                                                                query: [:],
                                                                method: .get,
                                                                body: Void(),
                                                                headers: [:])
        DispatchQueue.main.async {
            switch result {
            case .success(_, let result):
                self.restaurantMenu = result
                self.networkStatus = .idle
            case .error(_, _, _):
                self.networkStatus = .error
            }
        }
    }
}
