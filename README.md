# Railway Ticket Reservation System

A full-stack Railway Ticket Reservation system where users can register, log in, book tickets, and cancel bookings. The system is designed to handle user registration, ticket booking, cancellation, and more, and is built using:

* **Backend**: Java with Servlets
* **Database**: MySQL
* **Frontend**: HTML, CSS, Handlebars, JavaScript

---

## Features

* **User Registration & Login**:
  Users can create an account by providing their **username**, **password**, and **email**. Once registered, they can log in with their credentials to access their account.
  After logging in, users can:

  * **View and Edit Profile**: Users can see and modify their profile details, like their username and email.
  * **Check PNR Status**: Users can check the **PNR status** of their booked tickets to see the current status (whether the ticket is confirmed, waitlisted, or canceled).
  * **Upcoming & Completed Journeys**: Users can view a history of all their bookings. This includes upcoming trips (booked tickets for future dates) and completed journeys (tickets from past trips).

* **Train Availability**:
  Users can search for available trains between two stations by selecting the **source station** and **destination station**.
  The system will display all the available trains that run between the selected stations, including:

  * **Train number**
  * **Departure and arrival times**
  * **Available seats** in different classes (First Class, Second Class, Third Class)

  This helps users to quickly check which trains are available for their planned journey.

* **Ticket Booking**:
  Users can book tickets between the selected source and destination. They can:

  * **Choose from Three Classes**: Users can select between **First Class**, **Second Class**, and **Third Class** based on their preference and budget.
  * **Seat Allocation**: After selecting the class, users are assigned a **berth** (a seat) in the chosen class. Once a ticket is booked, the system confirms the booking and assigns a unique **PNR number**.
  * **PNR Status**: Users can always check the **PNR status** of their ticket after booking, which will display details like:

    * **Train number**
    * **Date of journey**
    * **Seat status** (whether the ticket is confirmed, in waitlist, or canceled)

* **Ticket Cancellation**:
  Users can cancel their ticket if their plans change. Once canceled, the seat will become available for other users to book.
  The cancellation process also ensures that:

  * If the ticket was on the **waitlist**, the **next user in line** on the waitlist will be automatically allocated the berth once it’s canceled.
  * The system updates the available seats accordingly, ensuring that no berth is left unused.
