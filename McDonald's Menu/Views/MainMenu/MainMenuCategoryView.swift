//
//  MainMenuCategoryView.swift
//  McDonald's Menu
//
//  Created by Juan Jose Lovera on 16/05/2022.
//

import SwiftUI

struct MainMenuCategoryView: View {
    
    @State var menu: RestaurantMenu.Menu
    @State var selectedItem: RestaurantMenu.Item?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(menu.name)
                .font(.system(size: 30))
                .bold()
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(menu.items, id: \.name) { item in
                        MainMenuItemView(item: item)
                            .onTapGesture {
                                self.selectedItem = item
                            }
                    }
                }
            }
            .sheet(item: self.$selectedItem, onDismiss: {
                self.selectedItem = nil
            }) { item in
                MenuItemDetailsView(item: item)
            }
        }
        .padding()
        .frame(height: 280, alignment: .leading)
        .listRowSeparator(.hidden)
    }
}

struct MainMenuCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuCategoryView(menu: RestaurantMenu.placeholderData().menus.first!)
            .previewLayout(.sizeThatFits)
            .frame(width: 500, height: 300)
    }
}
