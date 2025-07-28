//
//  MapView.swift
//  GreenOasisGardeningCentre
//
//  Created by Daniel Sergeev on 13/5/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var mapData: [StoreLocations] = []
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -32.04, longitude: 115.87),
        span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
    )
    
    @State private var showAlert = false
    @State private var alertMessage = "An error occurred."
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map(coordinateRegion: $mapRegion, interactionModes: [.all], annotationItems: mapData) { location in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title)

                        Text(location.name)
                            .font(.system(size: 12, weight: .semibold))
                            .shadow(color: .black, radius: 2, x: 0, y: 1)
                    }
                }
                .preferredColorScheme(.dark)
                .ignoresSafeArea()
                .task {
                    await loadLocations()
                }
                .alert("Error", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(alertMessage)
                }

                VStack {
                    Spacer()
                    HStack {
                        NavigationLink(destination: ViewCatalouge()) {
                            Image(systemName: "cart.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func loadLocations() async {
        let urlString = "https://davidmcmeekin.com/comp2010/StoreLocations.json"
        
        guard let url = URL(string: urlString) else {
            alertMessage = "Invalid URL."
            showAlert = true
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([StoreLocations].self, from: data)
            mapData = decoded
        } catch {
            alertMessage = "Failed to load map data: \(error.localizedDescription)"
            showAlert = true
        }
    }
}




#Preview {
    MapView()
}



// alternative URL is david mcmeekin URL doesnt work
//https://raw.githubusercontent.com/ElitePengui37/testData/main/mapData.json
