//
//  ViewShoppingList.swift
//  GreenOasisGardeningCentre
//
//  Created by Daniel Sergeev on 13/5/2025.
//

import SwiftUI

import SwiftUI

var GlobalCatalougeArray: [SaleItems] = []

struct ViewCatalouge: View {
    @State public var catalogueData: [SaleItems] = []
    @State private var isLoading = true
    @State private var errorMessage: String? = nil

    var body: some View {
        ZStack {
            LoadBackgroundTheme()
                .ignoresSafeArea()

            if isLoading {
                ProgressView("Loading...")
                    .foregroundColor(.white)
            } else if let error = errorMessage {
                Text("Failed to load: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                VStack {
                    Text("Welcome to Catalogue")
                        .fontWeight(.bold)
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .padding()

                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(catalogueData, id: \.productName) { item in
                                HStack(alignment: .top, spacing: 15) {
                                    Image(systemName: item.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.green)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(item.productName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        
                                        Text(item.description)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)

                                        HStack {
                                            Text("Was: $\(String(format: "%.2f", item.wasPrice))")
                                                .strikethrough()
                                                .foregroundColor(.red)
                                            Text("Now: $\(String(format: "%.2f", item.nowPrice))")
                                                .foregroundColor(.green)
                                        }
                                        .font(.subheadline)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        NavigationLink(destination: MapView()) {
                            Image(systemName: "map")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray.opacity(0.7))
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.leading, 30)
                        Spacer()
                        NavigationLink(destination: ViewShoppingList()) {
                            Image(systemName: "list.bullet.clipboard")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray.opacity(0.7))
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 30)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
        .task {
            await loadCatalogueData()
        }
    }

    private func loadCatalogueData() async {
        let urlString = "https://davidmcmeekin.com/comp2010/ListSpecials.json"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL."
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode([SaleItems].self, from: data)
            catalogueData = decodedData
            
            GlobalCatalougeArray = decodedData
        } catch {
            errorMessage = "Failed to load data: \(error.localizedDescription)"
        }
        isLoading = false
    }
}



#Preview {
    ViewCatalouge()
}


// alternative URL if david mcmeekin url doesnt work
//https://raw.githubusercontent.com/ElitePengui37/testData/main/diffHost.json
