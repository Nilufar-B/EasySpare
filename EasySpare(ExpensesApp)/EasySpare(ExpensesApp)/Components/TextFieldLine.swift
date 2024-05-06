//
//  TextFieldLine.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI

struct TextFieldLine: View {
    @State var title: String = "Title"
    @State var placeholder: String = "Placeholder"
    @Binding var txt: String
    @State var keyboardType: UIKeyboardType = .default

    
    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
            
           
                TextField(placeholder, text: $txt)
                    .keyboardType(keyboardType)
                    .disableAutocorrection(true)
                    .frame(height: 40)
            
            Divider()
        }
        
    }
}

struct TextSecureLine: View {
    @State var title: String = "Title"
    @State var placeholder: String = "Placeholder"
    @Binding var txt: String
    @Binding var isShowPassword: Bool 
    
 
  
    
    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .frame(minWidth: 0
                       , maxWidth: .infinity, alignment: .leading)
            
            if(isShowPassword){
                
                TextField(placeholder, text: $txt)
                    .disableAutocorrection(true)
                    .modifier(PassShowButton(isShow: $isShowPassword))
                    .frame(height: 40)
                
            }else{
                SecureField(placeholder, text: $txt)
                    .modifier(PassShowButton(isShow: $isShowPassword))
                    .frame(height: 40)
                
            }
            
            
            Divider()
        }
        
    }
}

struct TextFieldLine_Previews: PreviewProvider {
    @State static var txt: String = "Test text"

    static var previews: some View {
        TextFieldLine(txt: $txt)
            .padding(20)
    }
}
