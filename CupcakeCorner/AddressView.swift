//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Adrian Mowat on 31/12/2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zip)

            }

            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
                .disabled(order.hasValidAddress == false)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
