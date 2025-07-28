//
//  EditShoppingList.swift
//  GreenOasisGardeningCentre
//
//  Created by Daniel Sergeev on 20/5/2025.
//

import SwiftUI

struct EditShoppingList: View {
    @Binding var reportItems: [ShoppingReportItem]
    
    @State private var selectedProductName: String = ""
    @State private var quantity: Int = 1
    @State private var saved: Bool = false //boolean to show save alert
    
    var selectedItem: SaleItems? {
        GlobalCatalougeArray.first { $0.productName == selectedProductName }
    }
    
    var body: some View {
        ZStack
        {
            LoadBackgroundTheme()
            
            VStack(spacing: 20) {
                Text("Add Item to Shopping List")
                    .font(.title)
                    .foregroundColor(.white)
                
                // Dropdown Picker
                Picker("Select Item", selection: $selectedProductName) {
                    ForEach(GlobalCatalougeArray, id: \.productName)
                    { item in
                        Text(item.productName).tag(item.productName)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .cornerRadius(8)
                .foregroundColor(.white)
                
                // Quantity Stepper
                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...100)
                    .padding()
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .background(Color.gray.opacity(0.2))
                
                // Total price calculation
                if let item = selectedItem {
                    let total = Double(quantity) * item.nowPrice
                    Text("Total Price: $\(total, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.white)
                } else {
                    Text("Select an item to see price.")
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                HStack
                {
                    // Save button
                    Button(action: {
                        if let item = selectedItem {
                            let newReport = ShoppingReportItem(
                                name: item.productName,
                                quantity: quantity,
                                totalPrice: Double(quantity) * item.nowPrice
                            )
                            reportItems.append(newReport)
                            
                            saveShoppingReports(reportItems)
                            
                            saved = true
                        }
                    }) {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    NavigationLink(destination: ViewShoppingList()) {
                        Image(systemName: "list.bullet.clipboard")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.7))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }

            }
            .alert(isPresented: $saved) {
                Alert(
                    title: Text("Saved"),
                    message: Text("Your shopping list has been updated."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .padding()
            .onAppear {
                if selectedProductName.isEmpty, let first = GlobalCatalougeArray.first {
                    selectedProductName = first.productName
                }
            }
        }
    }
}

#Preview {
    EditShoppingList(reportItems: .constant([]))
}
