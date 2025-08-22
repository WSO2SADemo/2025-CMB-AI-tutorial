
type RoomDetailsItem record {|
    string roomName;
    string roomDescription;
    string[] roomAminities;
|};

type RoomDetails RoomDetailsItem[];

type BookingDetailsItem record {|
    string hotelId;
    string hotelName;
    string hotelDescription;
    string[] hotelType;
    string[] hotelAmenities;
    string hotelCity;
    string hotelCountry;
    RoomDetails roomDetails;
    string noOfGuests;
    string checkInDate;
    string specialRequirements;
    string nearByAttractions;
    string recentReviews;
|};

type BookingDetails BookingDetailsItem[];

type ReviewDetailsItem record {|
    string hotelId;
    string comment;
    decimal rating;
|};

type ReviewDetails ReviewDetailsItem[];

type UserActivity record {|
    BookingDetails bookingDetails;
    ReviewDetails reviewDetails;
|};
