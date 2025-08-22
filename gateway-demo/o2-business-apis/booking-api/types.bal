// User and Authentication Types
public type User record {|
    string userId;
    string email;
    string firstName;
    string lastName;
    string? phoneNumber;
    string? profilePicture;
    string registrationDate;
    string userType; // "GUEST", "PREMIUM"
    UserClaims? authClaims;
|};

public type UserClaims record {|
    string sub;
    string email;
    string given_name;
    string family_name;
    string phone_number?;
    string picture?;
    string[] groups?;
    string preferred_username?;
    string[] roles?;
    string organization?;
|};

public type AuthContext record {|
    string userId;
    UserClaims userClaims;
|};

// Hotel Booking Types
public type Hotel record {|
    string hotelId;
    string hotelName;
    string description;
    string address;
    string city;
    string country;
    string[] images;
    decimal rating;
    int reviewCount;
    string[] amenities;
    string[] propertyType;
    Location location;
    ContactInfo contactInfo;
    CheckInOutPolicy checkInOutPolicy;
    decimal lowestPrice;
    boolean isAvailable;
|};

public type Location record {|
    decimal latitude;
    decimal longitude;
    string landmark?;
    decimal distanceFromCenter?;
|};

public type ContactInfo record {|
    string phone;
    string email;
    string? website;
|};

public type CheckInOutPolicy record {|
    string checkInTime;
    string checkOutTime;
    string cancellationPolicy;
|};

public type Room record {|
    string roomId;
    string hotelId;
    string roomType;
    string roomName;
    string description;
    int maxOccupancy;
    decimal pricePerNight;
    string[] images;
    string[] amenities;
    BedConfiguration bedConfiguration;
    decimal roomSize; // size in square meters
    int availableCount;
|};

public type BedConfiguration record {|
    int singleBeds;
    int doubleBeds;
    int kingBeds;
    int queenBeds;
|};

public type HotelSearchRequest record {|
    string? destination;
    string? checkInDate;
    string? checkOutDate;
    int guests;
    int rooms;
    decimal? minPrice;
    decimal? maxPrice;
    decimal? minRating;
    string[]? amenities;
    string[]? propertyTypes;
    string? sortBy;
    int page;
    int pageSize;
|};

public type HotelSearchResponse record {|
    Hotel[] hotels;
    SearchMetadata metadata;
|};

public type SearchMetadata record {|
    int totalResults;
    int currentPage;
    int totalPages;
    int pageSize;
    SearchFilters appliedFilters;
|};

public type SearchFilters record {|
    string? destination;
    string? checkInDate;
    string? checkOutDate;
    int guests;
    int rooms;
    PriceRange? priceRange;
    decimal? minRating;
    string[]? amenities;
    string[]? propertyTypes;
|};

public type PriceRange record {|
    decimal min;
    decimal max;
|};

public type BookingRequest record {|
    string userId;
    string hotelId;
    RoomConfiguration[] rooms;
    string checkInDate;
    string checkOutDate;
    int numberOfGuests;
    int numberOfRooms;
    GuestDetails primaryGuest;
    SpecialRequests? specialRequests;
|};

public type RoomConfiguration record {|
    string roomId;
    int numberOfRooms;
|};

public type GuestDetails record {|
    string firstName;
    string lastName;
    string email;
    string phoneNumber;
    // string? nationality?;
|};

public type SpecialRequests record {|
    string? dietaryRequirements?;
    string? accessibilityNeeds?;
    string? bedPreference;
    boolean petFriendly?;
    string otherRequests?;
|};

public type Booking record {|
    string bookingId;
    string hotelId;
    RoomConfiguration[] rooms;
    string userId;
    string checkInDate;
    string checkOutDate;
    int numberOfGuests;
    GuestDetails primaryGuest;
    BookingPricing[] pricing;
    string bookingStatus;
    string bookingDate;
    string confirmationNumber;
    SpecialRequests? specialRequests;
|};

public type BookingPricing record {|
    decimal roomRate;
    int numberOfNights;
    decimal subtotal;
    decimal taxes;
    decimal serviceFees;
    decimal totalAmount;
    string currency;
|};

public type BookingResponse record {|
    string bookingId;
    string confirmationNumber;
    string message;
    Booking bookingDetails;
|};

public type Review record {|
    string reviewId;
    string hotelId;
    string userId;
    string userName;
    decimal rating;
    string title;
    string comment;
    string reviewDate;
    ReviewCategories categories;
    boolean isVerifiedStay;
|};

public type ReviewCategories record {|
    decimal cleanliness;
    decimal comfort;
    decimal location;
    decimal 'service;
    decimal valueForMoney;
|};

public type ReviewRequest record {|
    decimal rating;
    string title;
    string comment;
    ReviewCategories categories;
|};

// Response Types
public type ErrorResponse record {|
    string message;
    string errorCode;
    string timestamp;
|};

public type SuccessResponse record {|
    string message;
    string timestamp;
|};

public type HotelDetailsResponse record {|
    Hotel hotel;
    Room[] rooms;
    Review[] recentReviews;
    NearbyAttractions[] nearbyAttractions;
|};

public type NearbyAttractionsResponse record {|
    string hotelId;
    NearbyAttractions[] attractions;
|};

public type NearbyAttractions record {|
    string name;
    string category;
    decimal distance;
    Location location;
|};

public type AvailabilityResponse record {|
    string hotelId;
    string checkInDate;
    string checkOutDate;
    Room[] availableRooms;
    int totalAvailable;
|};

type UserBooking record {|
    string hotelName;
    string hotelDescription;
    string hotelCity;
    string hotelCountry;
    decimal hotelRating;
    string[] hotelAmenities;
    string[] hotelPropertyType;
    string hotelRoomDescription;
    string[] hotelRoomAmenities;
    BedConfiguration hotelBedConfiguration;
    decimal hotelRoomSize;
|};
