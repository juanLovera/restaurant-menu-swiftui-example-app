//
//  MainMenuViewModel.swift
//  McDonald's Menu
//
//  Created by Juan Jose Lovera on 17/05/2022.
//

import SwiftUI

protocol MenuItemDetailsViewModelProtocol: ObservableObject {
    
    var currencyCode: String { get }
}

final class MenuItemDetailsViewModel: MenuItemDetailsViewModelProtocol {
    
    var currencyCode: String = "USD"
}
