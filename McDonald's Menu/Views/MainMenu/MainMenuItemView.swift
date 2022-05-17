//
//  MainMenuItemView.swift
//  McDonald's Menu
//
//  Created by Juan Jose Lovera on 17/05/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainMenuItemView: View {
    
    @State var item: RestaurantMenu.Item
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: item.url ?? ""))
                .placeholder(Image(systemName: "photo").resizable())
                .resizable()
                .font(.system(size: 120))
                .foregroundColor(Color("light_gray"))
                .scaledToFit()
                .padding([.bottom])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Text(item.name)
                .font(.system(size: 17))
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .multilineTextAlignment(.center)
                .padding([.bottom])
        }
        .border(Color("light_gray"), width: 1)
        .frame(width: 180, height: 190)
    }
}

struct MainMenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuItemView(item: RestaurantMenu.placeholderData().menus.first!.items.first!)
            .previewLayout(.sizeThatFits)
            .frame(width: 250, height: 250)
    }
}
