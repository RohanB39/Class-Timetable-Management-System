package com.cyber.controller;

import java.util.List;
import com.cyber.DAO.UserDAO;
import com.cyber.model.TimetableEntry;
import java.util.List;

public class Debug {

    public static void main(String[] args) {

       String[] timetable = new String[7]; // 7 classrooms

        // Retrieve timetable entries for a specific date
        List<TimetableEntry> entries2 = UserDAO.getTimetableEntriesByDate("2024-07-16");
        System.out.println("Total Entries in table: "+entries2.size());
//        fields
        String s1 = "Success 1";
        String s2 = "Success 2";
        String s3 = "Success 3";
        String s4 = "Success 4";
        String s5 = "Success 5";
        String s6 = "Success 6";
        
        System.out.print(s1);
        System.out.print("        "+s2);
        System.out.print("        "+s3);
        System.out.print("        "+s4);
        System.out.print("        "+s5);
        System.out.print("        "+s6);
        
//        <%else if(entry.getClassroom().equals("Success 2")){
//		%>
//			
//			<%}%>
        
        
        
        
        
        for(TimetableEntry entry: entries2) {
        	if (entry.getClassroom().equalsIgnoreCase(s1)) {
				System.out.println(entry.getSubject());
				System.out.println(entry.getTeacher());
				System.out.print(entry.getTimeFrom()+" ");
				System.out.println(entry.getTimeTo());
				System.out.println();
			}else if (entry.getClassroom().equalsIgnoreCase(s2)) {
				System.out.println(entry.getSubject());
				System.out.println(entry.getTeacher());
				System.out.print(entry.getTimeFrom()+" ");
				System.out.println(entry.getTimeTo());
				System.out.println();
			}else if (entry.getClassroom().equalsIgnoreCase(s3)) {
				System.out.println(entry.getSubject());
				System.out.println(entry.getTeacher());
				System.out.print(entry.getTimeFrom()+" ");
				System.out.println(entry.getTimeTo());
				System.out.println();
			}else if (entry.getClassroom().equalsIgnoreCase(s4)) {
				System.out.println(entry.getSubject());
				System.out.println(entry.getTeacher());
				System.out.print(entry.getTimeFrom()+" ");
				System.out.println(entry.getTimeTo());
				System.out.println();
			}else if (entry.getClassroom().equalsIgnoreCase(s5)) {
				System.out.println(entry.getSubject());
				System.out.println(entry.getTeacher());
				System.out.print(entry.getTimeFrom()+" ");
				System.out.println(entry.getTimeTo());
				System.out.println();
			}else if (entry.getClassroom().equalsIgnoreCase(s6)) {
				System.out.println(entry.getSubject());
				System.out.println(entry.getTeacher());
				System.out.print(entry.getTimeFrom()+" ");
				System.out.println(entry.getTimeTo());
				System.out.println();
			}
        }
        
//        function fetchTimetableEntries(date) {
//            const xhr = new XMLHttpRequest();
//            xhr.open('GET', 'fetchTimetableEntries?date=' + date, true);
//            xhr.onreadystatechange = function() {
//                if (xhr.readyState === 4 && xhr.status === 200) {
//                    const timetableEntriesDiv = document.querySelector('.timetable-entries');
//                    timetableEntriesDiv.innerHTML = xhr.responseText;
//                    attachEditButtonListeners();
//                }
//            };
//            xhr.send();
//        }
        
        
        
    }
}
