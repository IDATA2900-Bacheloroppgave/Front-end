import SwiftUI

struct NewProductCardView: View {
    var product: Product
    var itemAvailanle: Bool
    var availableQuantity: Int

    @Binding var productAmounts: [Int: Int]
    @Binding var itemSelected: Bool

    var body: some View {
        let amountBinding = Binding<Int>(
            get: {
                self.productAmounts[self.product.productId] ?? 0 
            },
            set: {
                self.productAmounts[self.product.productId] = $0
                self.itemSelected = $0 > 0
            }
        )

        return HStack {
            NavigationStack {
                NavigationLink {
                    ProductView(product: product)
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "fork.knife.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(setColor())
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 0))
                        VStack(alignment: .leading, spacing: 2) {
                            Text(product.name)
                                .foregroundStyle(.bluePicker)
                                .fontWeight(.medium)
                            Text(product.supplier)
                                .font(.system(size: 14))
                            VStack(alignment: .leading) {
                                Text("Batch: \(String(product.batch))")
                                    .foregroundStyle(.greyText)
                                    .font(.system(size: 12))
                                Text("Best before: \(product.bestBeforeDate)")
                                    .foregroundStyle(.greyText)
                                    .font(.system(size: 12))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                    }
                }
            }
            Spacer()
            VStack {
                Text("\(amountBinding.wrappedValue) D-Pk") // Reflect the bound amount
                    .foregroundStyle(.bluePicker)
                Stepper("", value: amountBinding, in: 0...availableQuantity)
                    .labelsHidden()
                    .opacity(1.0)
                    .disabled(false)
            }
            .frame(maxWidth: 100)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 1)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .padding(.horizontal)
    }

    func setColor() -> Color {
        var color = Color.dryGoods
        if self.product.productType == "REFRIGERATED_GOODS" {
            color = Color.iconVeggie
        } else if self.product.productType == "FROZEN_GOODS" {
            color = Color.freezedGoods
        }
        return color
    }
}

#Preview {
    NewProductCardView(product: Product(productId: 12, name: "", description: "", supplier: "", bestBeforeDate: "", productType: "", price: 12, gtin: 12, batch: 12, inventory: Inventory(totalStock: 12, reservedStock: 12, availableStock: 12), packaging: Packaging(packageType: "", quantityPrPackage: 12, weightInGrams: 12, dimensionInCm3: 12)), itemAvailanle: true, availableQuantity: 2, productAmounts: .constant([12: 1]), itemSelected: .constant(false))
}
