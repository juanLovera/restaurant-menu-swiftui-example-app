//
//  MenuItemDetailsView.swift
//  McDonald's Menu
//
//  Created by Juan Jose Lovera on 17/05/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MenuItemDetailsView: View {
    
    @State var item: RestaurantMenu.Item
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                WebImage(url: URL(string: item.url ?? ""))
                    .placeholder(Image(systemName: "photo").resizable())
                    .resizable()
                    .font(.system(size: 120))
                    .foregroundColor(Color("light_gray"))
                    .scaledToFit()
                    .padding([.bottom, .top])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Text(item.name)
                    .font(.title2)
                    .bold()
                    .padding([.bottom], 8)
                Text(item.price.formatted(.currency(code: "USD")))
                    .padding([.leading, .trailing], 12)
                    .padding([.bottom, .top], 2)
                    .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(.black, lineWidth: 1))
                Text(item.description)
                    .padding([.bottom, .leading, .trailing])
                    .padding([.top], 5)
                
            }
        }
    }
}

struct MenuItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemDetailsView(item: RestaurantMenu.placeholderData().menus.first!.items.first!)
            .previewDevice("iPhone 12 Pro")
    }
}
