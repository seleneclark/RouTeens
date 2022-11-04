//
//  ContentView.swift
//  Routeens
//
//  Created by Selene on 11/2/22.
//

import SwiftUI

struct ContentView: View {
   @StateObject var routines = Routines()
	  
   
   
   
    var body: some View {
	   NavigationView {
		  List{
			 ForEach(routines.routine) { item in
				ForEach (item.tasks){ item2 in
				   HStack {
					  Text(item2.name)
					  Text("Hello World")
						 .padding()
				}
				   
				}
				
				
			 }
			 
		  }
			  
		  
		  
		  .navigationTitle("Routeens")
	   }
	   
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
