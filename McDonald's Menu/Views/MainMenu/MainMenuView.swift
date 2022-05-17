//
//  ContentView.swift
//  McDonald's Menu
//
//  Created by Juan Jose Lovera on 16/05/2022.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack {
            Image("mcdonalds_logo")
                .frame(width: 120, height: 120)
            Divider()
            Spacer()
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
