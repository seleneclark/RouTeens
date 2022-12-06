//
//  Utilities.swift
//  Routeens
//
//  Created by Selene on 11/28/22.
//

import SwiftUI
import UserNotifications

struct UtilitiesView: View {
   @State  var notificationState:Bool = false
   @Environment(\.dismiss) var dismiss

   //need to save this notificatinoState somewhere. probably the best place is
   // save it in RoutineManager and pass it to this utilities page.
   // right now, this is resetting to false every time you open the page
   
    var body: some View {
	   NavigationView {
		  VStack {
			 Toggle(isOn: $notificationState, label: {
				Text("Notifications allowed")
			 }).padding()
			.onChange(of: notificationState){ value in
			   print(value)
			   if (value == true) {
				  UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					  if success {
						  print("All set!")
					  } else if let error = error {
						  print(error.localizedDescription)
						 notificationState = false
					  }
				  }
			   } else {
				  UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
			   }
			}
			Spacer()
		  }
		  .navigationTitle("Notifications")
		  .navigationBarTitleDisplayMode(.inline)
		  .toolbar {
			 Button("Done"){
				dismiss()
			 }
		  }
	   }
    }
}

struct Utilities_Previews: PreviewProvider {
    static var previews: some View {
        UtilitiesView()
    }
}
