//
//  ContentView.swift
//  McDonald's Menu
//
//  Created by Juan Jose Lovera on 16/05/2022.
//

import SwiftUI
import Shimmer

struct MainMenuView: View {
    
    @ObservedObject var viewModel = MainMenuViewModel()
    
    var body: some View {
        VStack {
            Image("mcdonalds_logo")
                .frame(width: 100, height: 100)
            Divider()
            if isError() {
                errorView()
            } else {
                categoryListContentView((viewModel.restaurantMenu ?? RestaurantMenu.placeholderData()).menus)
                    .listStyle(.plain)
                    .redacted(reason: isLoading() ? .placeholder : [])
                    .shimmering(active: isLoading())
                    .disabled(isLoading())
            }
        }
        .onAppear {
            Task { await viewModel.loadMenu() }
        }
    }
    
    private func errorView() -> some View {
        VStack {
            Spacer()
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 60))
                .padding()
            Text("An error has ocurred while loading the menu")
                .multilineTextAlignment(.center)
                .padding([.bottom], 4)
            Button("Try again") {
                Task { await viewModel.loadMenu() }
            }
            .font(.title2)
            Spacer()
        }
    }
            
    private func categoryListContentView(_ categories: [RestaurantMenu.Menu]) -> some View {
        List {
            ForEach(categories, id: \.name) { menu in
                MainMenuCategoryView(menu: menu)
            }
        }
    }
    
    private func isLoading() -> Bool {
        return viewModel.networkStatus == .loading
    }
    
    private func isError() -> Bool {
        return viewModel.networkStatus == .error
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
