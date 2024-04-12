//
//  LandingPageView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        ZStack{
            VStack{
                Button(action:{}){
                    Text("Scan to order")
                        .foregroundStyle(Color.black)
                        .font(.system(size: 30))
                    Spacer()
                    Image(systemName:"barcode.viewfinder")
                        .foregroundColor(.black).font(.system(size: 30))
                   
                } .background(Color(red: 1.00, green: 0.83, blue: 0.00))
                    .padding()
                    .frame(width: 300,height: 400)
            }
        }
    }
}


#Preview {
    LandingPageView()
}
