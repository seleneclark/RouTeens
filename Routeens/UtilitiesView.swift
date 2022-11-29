//
//  Utilities.swift
//  Routeens
//
//  Created by Selene on 11/28/22.
//

import SwiftUI
import UserNotifications

struct UtilitiesView: View {
   @State private var notificationState:Bool = false
   @Environment(\.dismiss) var dismiss

   
    var body: some View {
	   Section {
		  Text("Notifications").bold().padding()
		  Toggle(isOn: $notificationState, label: {
			 Text("Notifications allowed")
		  }).padding()
		  Button ("Request Permission"){
			 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
				 if success {
					 print("All set!")
				 } else if let error = error {
					 print(error.localizedDescription)
					notificationState = false
				 }
			 }
		  }
		  
		  //I probably need to put this notification code in Routine Manager I think
		  Button("Schedule Notification"){
			 let content = UNMutableNotificationContent()
			 content.title = "Feed the cat"
			 content.subtitle = "It looks hungry"
			 content.sound = UNNotificationSound.default

			 // show this notification five seconds from now
			 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

			 // choose a random identifier
			 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

			 // add our notification request
			 UNUserNotificationCenter.current().add(request)
		  }
		  
		  Spacer()
		  Button("Done"){
			 dismiss()
		  }
		  Spacer()
	   }
        
    }
}

struct Utilities_Previews: PreviewProvider {
    static var previews: some View {
        UtilitiesView()
    }
}
