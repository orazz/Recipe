//
//  ContentView.swift
//  Recipes
//
//  Created by Oraz Atakishiyev on 10/4/24.
//  Copyright © 2024 orazz.com. All rights reserved.


import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            RecipeList(viewModel: .init())
        }
    }
}

#Preview {
    ContentView()
}
