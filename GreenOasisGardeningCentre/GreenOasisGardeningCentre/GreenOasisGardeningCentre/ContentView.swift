//
//  ContentView.swift
//  GreenOasisGardeningCentre
//
//  Created by Daniel Sergeev on 13/5/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack
        {
            ZStack
            {
                LoadBackgroundTheme()
                
                VStack
                {
                    NavigationLink(destination: MapView()) // navigation link to map view
                    {
                        ZStack
                        {
                            Image("MapThumbnail")
                                .resizable()
                                .aspectRatio(16/9, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(16) // Rounded edges
                                .padding(8)
                            Text("Store Locations")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .fontWeight(.black)
                        }
                    }
                    .ignoresSafeArea()
                    
                    NavigationLink(destination: ViewCatalouge()) // navigation link to the shopping list view
                    {
                        ZStack
                        {
                            Image("NightGarden2")
                                .resizable()
                                .aspectRatio(16/9, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(16)
                                .padding(8)
                            Text("Catalouge")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .fontWeight(.black)
                        }
                    }
                    
                }
                
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
