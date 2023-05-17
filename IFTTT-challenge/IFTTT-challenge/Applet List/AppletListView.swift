//
//  AppletListView.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/15/23.
//

import SwiftUI
import Kingfisher

struct AppletListView: View {
    
    @StateObject var viewModel = AppletListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.appletPreview) { applet in
                        NavigationLink(destination: AppletDetailView(viewModel: .init(id: applet.id))) {
                            view(for: applet)
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 32, trailing: 16))
                .navigationTitle("Applets")
            }
        }
    }
    
    func view(for applet: AppletPreview) -> some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0..<viewModel.channelIcons(for: applet).count, id: \.self) { index in
                    KFImage(viewModel.channelIcons(for: applet)[index])
                        .placeholder({
                            Image(systemName: "photo.fill")
                        })
                        .resizable()
                        .frame(width: 24, height: 24)
                        .cornerRadius(4)
                }
                Spacer()
                Text(applet.status.prettyName.uppercased())
                    .font(.system(.callout, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(applet.status.color)
                    .cornerRadius(4)
            }
            .padding(.bottom, 24)
            
            Text(applet.name)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 8)
            Text(applet.author)
                .font(.callout)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color(hex: applet.brandColor))
        .cornerRadius(8)
    }
}

struct AppletListView_Previews: PreviewProvider {
    static var previews: some View {
        AppletListView()
    }
}
