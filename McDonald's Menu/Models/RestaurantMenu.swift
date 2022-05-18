//
//  RestaurantMenu.swift
//  McDonald's Menu
//
//  Created by Juan Jose Lovera on 17/05/2022.
//

import Foundation

struct RestaurantMenu: Codable {
    let id, name, description, phone: String
    let location: Location?
    let operationDays: [OperationDay]
    let privateParking: Bool
    let currency: String
    let menus: [Menu]
    
    // MARK: - Location
    struct Location: Codable {
        let lat, log, address1, address2: String
        let city, state, postalCode, country: String
    }

    // MARK: - Menu
    struct Menu: Codable {
        let name: String
        let items: [Item]
    }

    // MARK: - Item
    struct Item: Codable, Identifiable {
        var id: String? { name }
        let name, description: String
        let price: Double
        let url: String?
    }

    // MARK: - OperationDay
    struct OperationDay: Codable {
        let day, startAt, endAt: String
    }
    
    static func placeholderData() -> RestaurantMenu {
        var menus: [RestaurantMenu.Menu] = []
        var items: [RestaurantMenu.Item] = []
        for i in 0...3 {
            items.append(RestaurantMenu.Item(name: "Item Title \(i)", description: "This is the description", price: 10, url: "https://s7d1.scene7.com/is/image/mcdonalds/t-mcdonalds-Hamburger:product-header-desktop?wid=829&hei=455&dpr=off"))
        }
        for i in 0...3 {
            menus.append(RestaurantMenu.Menu(name: "Category \(i)", items: items))
        }
        return RestaurantMenu(id: "", name: "McDonald's", description: "", phone: "", location: nil, operationDays: [], privateParking: true, currency: "USD", menus: menus)
    }
}
