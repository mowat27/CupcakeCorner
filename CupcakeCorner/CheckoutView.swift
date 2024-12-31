//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Adrian Mowat on 31/12/2024.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var order: Order

    let currencyCode = Locale.current.currency?.identifier ?? "USD"

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to place order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(
                for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order of \(decodedOrder.quantity) cupcakes has been received"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")

        }
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                AsyncImage(
                    url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")
                ) { image in
                    image
                        .resizable()
                        .scaledToFit()

                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text(
                    "Amount: \(order.cost, format: .currency(code: currencyCode))"
                )

                Button("Checkout") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Order complete", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }

    }
}

#Preview {
    CheckoutView(order: Order())
}
