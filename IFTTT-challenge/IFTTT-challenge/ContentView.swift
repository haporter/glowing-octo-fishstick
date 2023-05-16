//
//  ContentView.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: AppletListViewModel = .init()
    
    var body: some View {
        NavigationView {
                AppletListView()
                .navigationTitle("Applets")
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
