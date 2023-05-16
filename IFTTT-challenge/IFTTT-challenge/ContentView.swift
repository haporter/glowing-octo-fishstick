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
        AppletListView()
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
