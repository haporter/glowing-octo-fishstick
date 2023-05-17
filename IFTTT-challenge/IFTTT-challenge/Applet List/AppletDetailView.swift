//
//  AppletDetailView.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/16/23.
//

import SwiftUI
import Kingfisher

struct AppletDetailView: View {
    
    @ObservedObject var viewModel: AppletDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ForEach(0..<viewModel.channelIcons().count, id: \.self) { index in
                    KFImage(viewModel.channelIcons()[index])
                        .placeholder({
                            Image(systemName: "photo.fill")
                        })
                        .resizable()
                        .frame(width: 32, height: 32)
                        .cornerRadius(4)
                }
                Spacer()
                Text(viewModel.applet?.status.prettyName.uppercased() ?? "OFF")
                    .font(.system(.callout, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(viewModel.applet?.status.color ?? .black)
                    .cornerRadius(4)
            }
            .padding(.bottom, 32)
            Text(viewModel.applet?.name ?? "")
                .font(.title)
                .padding(.bottom, 16)
            Text(viewModel.applet?.author ?? "")
                .font(.callout)
                .padding(.bottom, 4)
            Text(viewModel.applet?.id ?? "")
                .font(.subheadline)
                .padding(.bottom, 24)
            Text(viewModel.applet?.description ?? "")
                .font(.body)
            
            Spacer()
        }
        .padding(24)
        .onAppear(perform: viewModel.fetchAppletDetail)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: navBar)
    }
    
    @ToolbarContentBuilder
    func navBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: "gear")
                .foregroundColor(.black)
        }
    }
}

struct AppletDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppletDetailView(viewModel: .init(id: ""))
    }
}
