//
//  ViewShoppingList.swift
//  GreenOasisGardeningCentre
//
//  Created by Daniel Sergeev on 19/5/2025.
//

import SwiftUI

struct ViewShoppingList: View {
    
    @State private var currentItem: String = ""
    @State private var opacity: Double = 0.0
    @State private var shoppingReports: [ShoppingReportItem] = loadShoppingReports()
    @State private var delete: Bool = false // delete confirmation
    
    var body: some View {
        ZStack
        {
            LoadBackgroundTheme()
            
            VStack
            {
                Text(currentItem) //new tip every 4.5 seconds
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .opacity(opacity)
                    .animation(.easeInOut(duration: 1.5), value: opacity)
                    .frame(maxWidth: .infinity, alignment: .top)
                
                Spacer()
                
                Text("Shopping List")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                                
                // ScrollView to display saved reports
                ScrollView
                {
                    VStack(spacing: 10)
                    {
                        ForEach(shoppingReports, id: \.name)
                        { report in
                            HStack
                            {
                                VStack(alignment: .leading)
                                {
                                    Text(report.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Quantity: \(report.quantity)")
                                        .foregroundColor(.white)
                                    Text("Total: $\(report.totalPrice, specifier: "%.2f")")
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                
                                // Delete Button
                                Button(action: {
                                    deleteReport(report)
                                    
                                    delete = true
                                }) {
                                    Image(systemName: "trash")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.white.opacity(0.1))
                                        .clipShape(Circle())
                                        .shadow(radius: 5)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    }
                }
                .alert(isPresented: $delete) {
                    Alert(
                        title: Text("Delete?"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .padding(.top, 20)
                            
                Spacer()
                                
                // Button to navigate to EditShoppingList
                HStack
                {
                    Spacer()
                    NavigationLink(destination: EditShoppingList(reportItems: $shoppingReports))
                    {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.7))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, 30)
                    .padding(.bottom, 30)
                }
            }
                
        }
        .onAppear()
        {
            // first 2 lines make sure there is always a gardening tip on startup
            currentItem = tipArray.randomElement() ?? ""
            opacity = 1.0
            cycleTip()
        }
    }
    
    // picks a random gardening tip from the tiparray every 7 seconds
    func cycleTip()
    {
        Timer.scheduledTimer(withTimeInterval: 7.0, repeats: true)
        { _ in
            // Pick a new random item
            currentItem = tipArray.randomElement() ?? ""
            
            // Fade in
            withAnimation {
                opacity = 1.0
            }
            
            // Fade out after 4.5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5)
            {
                withAnimation {
                    opacity = 0.0
                }
            }
        }
    }
    
    // Function to delete a report
        func deleteReport(_ report: ShoppingReportItem) {
            // Remove the selected report from the array
            if let index = shoppingReports.firstIndex(where: { $0.id == report.id }) {
                shoppingReports.remove(at: index)
                
                // Save the updated shopping reports to UserDefaults
                saveShoppingReports(shoppingReports)
            }
        }

}



#Preview {
    ViewShoppingList()
}
