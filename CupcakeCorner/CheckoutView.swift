//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Adrian Mowat on 31/12/2024.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order

    let currencyCode = Locale.current.currency?.identifier ?? "USD"

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

                Button("Checkout", action: {})
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)

    }
}

#Preview {
    CheckoutView(order: Order())
}
