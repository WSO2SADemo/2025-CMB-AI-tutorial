// Mock hotel data initialization
public function initializeHotels() returns Hotel[] {
    return [
        {
            hotelId: "HTL001",
            hotelName: "Grand Luxury Palace",
            description: "Experience ultimate luxury in the heart of the city with world-class amenities and exceptional service.",
            address: "123 Fifth Avenue",
            city: "New York",
            country: "United States",
            images: ["hotel1_1.jpg", "hotel1_2.jpg", "hotel1_3.jpg"],
            rating: 4.8,
            reviewCount: 2847,
            amenities: ["Free WiFi", "Swimming Pool", "Fitness Center", "Spa", "Restaurant", "Room Service", "Concierge", "Valet Parking"],
            propertyType: ["Hotel", "Luxury"],
            location: {
                latitude: 40.7589,
                longitude: -73.9851,
                landmark: "Near Central Park",
                distanceFromCenter: 2.5
            },
            contactInfo: {
                phone: "+1-555-0123",
                email: "info@grandluxurypalace.com",
                website: "www.grandluxurypalace.com"
            },
            checkInOutPolicy: {
                checkInTime: "15:00",
                checkOutTime: "11:00",
                cancellationPolicy: "Free cancellation up to 24 hours before check-in"
            },
            lowestPrice: 299.99,
            isAvailable: true
        },
        {
            hotelId: "HTL002",
            hotelName: "Oceanfront Paradise Resort",
            description: "Beachfront resort offering stunning ocean views, water sports, and tropical paradise experience.",
            address: "456 Ocean Drive",
            city: "Miami",
            country: "United States",
            images: ["hotel2_1.jpg", "hotel2_2.jpg", "hotel2_3.jpg"],
            rating: 4.6,
            reviewCount: 1923,
            amenities: ["Beach Access", "Water Sports", "Multiple Pools", "Spa", "5 Restaurants", "Kids Club", "Tennis Court"],
            propertyType: ["Resort", "Beach"],
            location: {
                latitude: 25.7617,
                longitude: -80.1918,
                landmark: "South Beach",
                distanceFromCenter: 8.2
            },
            contactInfo: {
                phone: "+1-555-0456",
                email: "reservations@oceanfrontparadise.com",
                website: "www.oceanfrontparadise.com"
            },
            checkInOutPolicy: {
                checkInTime: "16:00",
                checkOutTime: "12:00",
                cancellationPolicy: "Free cancellation up to 48 hours before check-in"
            },
            lowestPrice: 189.99,
            isAvailable: true
        },
        {
            hotelId: "HTL003",
            hotelName: "Mountain View Lodge",
            description: "Cozy mountain retreat perfect for nature lovers, offering hiking trails and scenic mountain views.",
            address: "789 Mountain Trail",
            city: "Aspen",
            country: "United States",
            images: ["hotel3_1.jpg", "hotel3_2.jpg"],
            rating: 4.4,
            reviewCount: 856,
            amenities: ["Mountain Views", "Hiking Trails", "Fireplace", "Restaurant", "Ski Storage", "Hot Tub"],
            propertyType: ["Lodge", "Mountain"],
            location: {
                latitude: 39.1911,
                longitude: -106.8175,
                landmark: "Aspen Mountain",
                distanceFromCenter: 5.1
            },
            contactInfo: {
                phone: "+1-555-0789",
                email: "info@mountainviewlodge.com",
                website: "www.mountainviewlodge.com"
            },
            checkInOutPolicy: {
                checkInTime: "15:00",
                checkOutTime: "11:00",
                cancellationPolicy: "Moderate cancellation policy"
            },
            lowestPrice: 159.99,
            isAvailable: true
        },
        {
            hotelId: "HTL004",
            hotelName: "Business Executive Suites",
            description: "Modern business hotel with state-of-the-art conference facilities and executive amenities.",
            address: "321 Business District",
            city: "Chicago",
            country: "United States",
            images: ["hotel4_1.jpg", "hotel4_2.jpg"],
            rating: 4.2,
            reviewCount: 1456,
            amenities: ["Business Center", "Conference Rooms", "Executive Lounge", "Fitness Center", "Restaurant"],
            propertyType: ["Hotel", "Business"],
            location: {
                latitude: 41.8781,
                longitude: -87.6298,
                landmark: "Downtown Chicago",
                distanceFromCenter: 1.2
            },
            contactInfo: {
                phone: "+1-555-0321",
                email: "business@executivesuites.com",
                website: "www.businessexecutivesuites.com"
            },
            checkInOutPolicy: {
                checkInTime: "14:00",
                checkOutTime: "12:00",
                cancellationPolicy: "Free cancellation up to 6 hours before check-in"
            },
            lowestPrice: 129.99,
            isAvailable: true
        },
        {
            hotelId: "HTL005",
            hotelName: "Royal Heritage Palace",
            description: "Historic palace hotel with traditional architecture, royal treatment, and heritage charm.",
            address: "789 Heritage Square",
            city: "London",
            country: "United Kingdom",
            images: ["hotel5_1.jpg", "hotel5_2.jpg", "hotel5_3.jpg", "hotel5_4.jpg"],
            rating: 4.9,
            reviewCount: 3245,
            amenities: ["Historic Architecture", "Butler Service", "Fine Dining", "Afternoon Tea", "Spa", "Valet Parking", "Concierge"],
            propertyType: ["Hotel", "Historic", "Luxury"],
            location: {
                latitude: 51.5074,
                longitude: -0.1278,
                landmark: "Near Buckingham Palace",
                distanceFromCenter: 1.8
            },
            contactInfo: {
                phone: "+44-20-1234-5678",
                email: "reservations@royalheritagepalace.co.uk",
                website: "www.royalheritagepalace.co.uk"
            },
            checkInOutPolicy: {
                checkInTime: "15:00",
                checkOutTime: "12:00",
                cancellationPolicy: "Free cancellation up to 48 hours before check-in"
            },
            lowestPrice: 450.00,
            isAvailable: true
        },
        {
            hotelId: "HTL006",
            hotelName: "Tropical Island Resort",
            description: "Exclusive private island resort with overwater bungalows and pristine beaches.",
            address: "Coral Atoll",
            city: "Malé",
            country: "Maldives",
            images: ["hotel6_1.jpg", "hotel6_2.jpg", "hotel6_3.jpg"],
            rating: 4.7,
            reviewCount: 2156,
            amenities: ["Overwater Bungalows", "Private Beach", "Diving Center", "Spa", "Multiple Restaurants", "Water Sports", "Seaplane Transfer"],
            propertyType: ["Resort", "Island", "Luxury"],
            location: {
                latitude: 4.1755,
                longitude: 73.5093,
                landmark: "Private Island",
                distanceFromCenter: 45.0
            },
            contactInfo: {
                phone: "+960-664-1234",
                email: "paradise@tropicalislandresort.mv",
                website: "www.tropicalislandresort.mv"
            },
            checkInOutPolicy: {
                checkInTime: "14:00",
                checkOutTime: "12:00",
                cancellationPolicy: "Free cancellation up to 7 days before check-in"
            },
            lowestPrice: 850.00,
            isAvailable: true
        },
        {
            hotelId: "HTL007",
            hotelName: "Urban Boutique Hotel",
            description: "Trendy boutique hotel in the arts district with contemporary design and local culture.",
            address: "456 Arts Avenue",
            city: "Tokyo",
            country: "Japan",
            images: ["hotel7_1.jpg", "hotel7_2.jpg"],
            rating: 4.3,
            reviewCount: 1876,
            amenities: ["Contemporary Design", "Art Gallery", "Rooftop Bar", "Restaurant", "Fitness Center", "Free WiFi"],
            propertyType: ["Hotel", "Boutique", "Urban"],
            location: {
                latitude: 35.6762,
                longitude: 139.6503,
                landmark: "Shibuya District",
                distanceFromCenter: 3.5
            },
            contactInfo: {
                phone: "+81-3-1234-5678",
                email: "info@urbanboutiquehotel.jp",
                website: "www.urbanboutiquehotel.jp"
            },
            checkInOutPolicy: {
                checkInTime: "15:00",
                checkOutTime: "11:00",
                cancellationPolicy: "Free cancellation up to 24 hours before check-in"
            },
            lowestPrice: 180.00,
            isAvailable: true
        },
        {
            hotelId: "HTL008",
            hotelName: "Safari Lodge",
            description: "Authentic safari experience with wildlife viewing, luxury tented accommodations, and guided tours.",
            address: "Serengeti National Park",
            city: "Arusha",
            country: "Tanzania",
            images: ["hotel8_1.jpg", "hotel8_2.jpg", "hotel8_3.jpg"],
            rating: 4.6,
            reviewCount: 987,
            amenities: ["Wildlife Viewing", "Guided Safari Tours", "Luxury Tents", "Restaurant", "Campfire Area", "Spa Treatments"],
            propertyType: ["Lodge", "Safari", "Nature"],
            location: {
                latitude: -2.3333,
                longitude: 34.8333,
                landmark: "Serengeti National Park",
                distanceFromCenter: 180.0
            },
            contactInfo: {
                phone: "+255-27-250-1234",
                email: "bookings@safarilodge.tz",
                website: "www.safarilodge.tz"
            },
            checkInOutPolicy: {
                checkInTime: "14:00",
                checkOutTime: "11:00",
                cancellationPolicy: "Moderate cancellation policy - 50% refund up to 7 days"
            },
            lowestPrice: 320.00,
            isAvailable: true
        },
        {
            hotelId: "HTL009",
            hotelName: "Budget Comfort Inn",
            description: "Clean, comfortable, and affordable accommodation perfect for budget travelers.",
            address: "123 Economy Street",
            city: "Bangkok",
            country: "Thailand",
            images: ["hotel9_1.jpg", "hotel9_2.jpg"],
            rating: 3.8,
            reviewCount: 2341,
            amenities: ["Free WiFi", "Air Conditioning", "24/7 Reception", "Breakfast", "Luggage Storage"],
            propertyType: ["Hotel", "Budget"],
            location: {
                latitude: 13.7563,
                longitude: 100.5018,
                landmark: "Khao San Road",
                distanceFromCenter: 2.8
            },
            contactInfo: {
                phone: "+66-2-123-4567",
                email: "info@budgetcomfortinn.th",
                website: "www.budgetcomfortinn.th"
            },
            checkInOutPolicy: {
                checkInTime: "14:00",
                checkOutTime: "12:00",
                cancellationPolicy: "Free cancellation up to 24 hours before check-in"
            },
            lowestPrice: 35.00,
            isAvailable: true
        },
        {
            hotelId: "HTL010",
            hotelName: "Alpine Ski Resort",
            description: "Premier ski resort with direct slope access, luxury amenities, and mountain adventure activities.",
            address: "1 Mountain Peak Drive",
            city: "Zermatt",
            country: "Switzerland",
            images: ["hotel10_1.jpg", "hotel10_2.jpg", "hotel10_3.jpg"],
            rating: 4.8,
            reviewCount: 1654,
            amenities: ["Ski-in/Ski-out", "Mountain Views", "Spa", "Multiple Restaurants", "Ski School", "Equipment Rental", "Heated Pool"],
            propertyType: ["Resort", "Ski", "Mountain", "Luxury"],
            location: {
                latitude: 46.0207,
                longitude: 7.7491,
                landmark: "Matterhorn",
                distanceFromCenter: 2.1
            },
            contactInfo: {
                phone: "+41-27-966-1234",
                email: "reservations@alpineskiresort.ch",
                website: "www.alpineskiresort.ch"
            },
            checkInOutPolicy: {
                checkInTime: "16:00",
                checkOutTime: "11:00",
                cancellationPolicy: "Free cancellation up to 7 days before check-in"
            },
            lowestPrice: 520.00,
            isAvailable: true
        }
    ];
}

public function initializeRooms() returns Room[] {
    return [
        // Grand Luxury Palace Rooms
        {
            roomId: "R001",
            hotelId: "HTL001",
            roomType: "Presidential Suite",
            roomName: "Manhattan Presidential Suite",
            description: "Luxurious presidential suite with panoramic city views and premium amenities",
            maxOccupancy: 4,
            pricePerNight: 899.99,
            images: ["room1_1.jpg", "room1_2.jpg"],
            amenities: ["City View", "Separate Living Room", "Marble Bathroom", "Butler Service", "Premium Minibar"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 1, queenBeds: 1},
            roomSize: 120.0,
            availableCount: 2
        },
        {
            roomId: "R002",
            hotelId: "HTL001",
            roomType: "Deluxe Room",
            roomName: "Deluxe City View",
            description: "Elegant room with modern amenities and city skyline views",
            maxOccupancy: 2,
            pricePerNight: 299.99,
            images: ["room2_1.jpg", "room2_2.jpg"],
            amenities: ["City View", "Marble Bathroom", "Premium Bedding", "Minibar"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 1, queenBeds: 0},
            roomSize: 45.0,
            availableCount: 8
        },
        // Oceanfront Paradise Resort Rooms
        {
            roomId: "R003",
            hotelId: "HTL002",
            roomType: "Ocean View Suite",
            roomName: "Premium Ocean Suite",
            description: "Spacious suite with direct ocean views and private balcony",
            maxOccupancy: 6,
            pricePerNight: 449.99,
            images: ["room3_1.jpg", "room3_2.jpg"],
            amenities: ["Ocean View", "Private Balcony", "Separate Living Area", "Kitchenette"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 1, kingBeds: 1, queenBeds: 0},
            roomSize: 75.0,
            availableCount: 5
        },
        {
            roomId: "R004",
            hotelId: "HTL002",
            roomType: "Beach Room",
            roomName: "Tropical Beach Room",
            description: "Comfortable room with beach access and tropical decor",
            maxOccupancy: 3,
            pricePerNight: 189.99,
            images: ["room4_1.jpg"],
            amenities: ["Beach Access", "Tropical Decor", "Mini Fridge"],
            bedConfiguration: {singleBeds: 1, doubleBeds: 0, kingBeds: 0, queenBeds: 1},
            roomSize: 35.0,
            availableCount: 12
        },
        // Mountain View Lodge Rooms
        {
            roomId: "R005",
            hotelId: "HTL003",
            roomType: "Mountain Cabin",
            roomName: "Rustic Mountain Cabin",
            description: "Cozy cabin with fireplace and stunning mountain views",
            maxOccupancy: 4,
            pricePerNight: 159.99,
            images: ["room5_1.jpg"],
            amenities: ["Mountain View", "Fireplace", "Rustic Decor", "Mini Kitchen"],
            bedConfiguration: {singleBeds: 2, doubleBeds: 0, kingBeds: 0, queenBeds: 1},
            roomSize: 50.0,
            availableCount: 6
        },
        // Business Executive Suites Rooms
        {
            roomId: "R006",
            hotelId: "HTL004",
            roomType: "Executive Suite",
            roomName: "Business Executive Suite",
            description: "Modern suite designed for business travelers with work area",
            maxOccupancy: 2,
            pricePerNight: 229.99,
            images: ["room6_1.jpg"],
            amenities: ["Work Desk", "High-Speed Internet", "Executive Lounge Access", "Coffee Machine"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 1, queenBeds: 0},
            roomSize: 55.0,
            availableCount: 10
        },
        {
            roomId: "R007",
            hotelId: "HTL004",
            roomType: "Standard Room",
            roomName: "Business Standard",
            description: "Comfortable room with business amenities and city views",
            maxOccupancy: 2,
            pricePerNight: 129.99,
            images: ["room7_1.jpg"],
            amenities: ["Work Desk", "High-Speed Internet", "City View", "Coffee Machine"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 0, queenBeds: 1},
            roomSize: 30.0,
            availableCount: 15
        },
        // Royal Heritage Palace Rooms
        {
            roomId: "R008",
            hotelId: "HTL005",
            roomType: "Royal Suite",
            roomName: "Windsor Royal Suite",
            description: "Opulent royal suite with antique furnishings and butler service",
            maxOccupancy: 4,
            pricePerNight: 1200.00,
            images: ["room8_1.jpg", "room8_2.jpg", "room8_3.jpg"],
            amenities: ["Butler Service", "Antique Furnishings", "Fireplace", "Separate Dining Room", "Premium Minibar"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 1, queenBeds: 1},
            roomSize: 150.0,
            availableCount: 3
        },
        {
            roomId: "R009",
            hotelId: "HTL005",
            roomType: "Heritage Room",
            roomName: "Classic Heritage Room",
            description: "Elegant room with period furnishings and modern comforts",
            maxOccupancy: 2,
            pricePerNight: 450.00,
            images: ["room9_1.jpg", "room9_2.jpg"],
            amenities: ["Period Furnishings", "Marble Bathroom", "High Ceilings", "City View"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 1, queenBeds: 0},
            roomSize: 40.0,
            availableCount: 12
        },
        // Tropical Island Resort Rooms
        {
            roomId: "R010",
            hotelId: "HTL006",
            roomType: "Overwater Bungalow",
            roomName: "Sunset Overwater Bungalow",
            description: "Luxury overwater bungalow with direct ocean access and glass floor",
            maxOccupancy: 2,
            pricePerNight: 1500.00,
            images: ["room10_1.jpg", "room10_2.jpg", "room10_3.jpg"],
            amenities: ["Ocean Access", "Glass Floor", "Private Deck", "Outdoor Shower", "Snorkeling Gear"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 1, queenBeds: 0},
            roomSize: 80.0,
            availableCount: 8
        },
        {
            roomId: "R011",
            hotelId: "HTL006",
            roomType: "Beach Villa",
            roomName: "Private Beach Villa",
            description: "Spacious beach villa with private beach access and tropical garden",
            maxOccupancy: 4,
            pricePerNight: 850.00,
            images: ["room11_1.jpg", "room11_2.jpg"],
            amenities: ["Private Beach", "Tropical Garden", "Outdoor Bathtub", "Butler Service"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 1, kingBeds: 1, queenBeds: 0},
            roomSize: 100.0,
            availableCount: 6
        },
        // Urban Boutique Hotel Rooms
        {
            roomId: "R012",
            hotelId: "HTL007",
            roomType: "Designer Suite",
            roomName: "Artist Loft Suite",
            description: "Contemporary suite with local artwork and modern Japanese design",
            maxOccupancy: 3,
            pricePerNight: 320.00,
            images: ["room12_1.jpg", "room12_2.jpg"],
            amenities: ["Local Artwork", "City View", "Modern Design", "Mini Bar", "Work Area"],
            bedConfiguration: {singleBeds: 1, doubleBeds: 0, kingBeds: 1, queenBeds: 0},
            roomSize: 45.0,
            availableCount: 5
        },
        {
            roomId: "R013",
            hotelId: "HTL007",
            roomType: "Standard Room",
            roomName: "Urban Style Room",
            description: "Stylish room with contemporary design and city conveniences",
            maxOccupancy: 2,
            pricePerNight: 180.00,
            images: ["room13_1.jpg"],
            amenities: ["Modern Design", "City View", "High-Speed WiFi", "Mini Fridge"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 0, queenBeds: 1},
            roomSize: 25.0,
            availableCount: 20
        },
        // Safari Lodge Rooms
        {
            roomId: "R014",
            hotelId: "HTL008",
            roomType: "Luxury Safari Tent",
            roomName: "Serengeti Luxury Tent",
            description: "Spacious luxury tent with wildlife views and authentic safari experience",
            maxOccupancy: 4,
            pricePerNight: 450.00,
            images: ["room14_1.jpg", "room14_2.jpg"],
            amenities: ["Wildlife Views", "Private Deck", "Outdoor Shower", "Safari Gear Storage"],
            bedConfiguration: {singleBeds: 2, doubleBeds: 0, kingBeds: 1, queenBeds: 0},
            roomSize: 60.0,
            availableCount: 8
        },
        {
            roomId: "R015",
            hotelId: "HTL008",
            roomType: "Safari Cabin",
            roomName: "Explorer Cabin",
            description: "Comfortable cabin with nature views and safari amenities",
            maxOccupancy: 2,
            pricePerNight: 320.00,
            images: ["room15_1.jpg"],
            amenities: ["Nature Views", "Safari Gear Storage", "Mosquito Netting", "Private Bathroom"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 0, queenBeds: 1},
            roomSize: 35.0,
            availableCount: 12
        },
        // Budget Comfort Inn Rooms
        {
            roomId: "R016",
            hotelId: "HTL009",
            roomType: "Standard Room",
            roomName: "Comfort Standard",
            description: "Clean and comfortable room with essential amenities",
            maxOccupancy: 2,
            pricePerNight: 35.00,
            images: ["room16_1.jpg"],
            amenities: ["Air Conditioning", "Free WiFi", "Private Bathroom", "TV"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 1, kingBeds: 0, queenBeds: 0},
            roomSize: 18.0,
            availableCount: 25
        },
        {
            roomId: "R017",
            hotelId: "HTL009",
            roomType: "Family Room",
            roomName: "Budget Family Room",
            description: "Spacious room perfect for families on a budget",
            maxOccupancy: 4,
            pricePerNight: 55.00,
            images: ["room17_1.jpg"],
            amenities: ["Air Conditioning", "Free WiFi", "Private Bathroom", "TV", "Mini Fridge"],
            bedConfiguration: {singleBeds: 2, doubleBeds: 1, kingBeds: 0, queenBeds: 0},
            roomSize: 28.0,
            availableCount: 15
        },
        // Alpine Ski Resort Rooms
        {
            roomId: "R018",
            hotelId: "HTL010",
            roomType: "Mountain Suite",
            roomName: "Matterhorn View Suite",
            description: "Luxury suite with panoramic mountain views and ski-in/ski-out access",
            maxOccupancy: 4,
            pricePerNight: 850.00,
            images: ["room18_1.jpg", "room18_2.jpg", "room18_3.jpg"],
            amenities: ["Mountain Views", "Ski Storage", "Fireplace", "Balcony", "Heated Floors"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 1, kingBeds: 1, queenBeds: 0},
            roomSize: 75.0,
            availableCount: 6
        },
        {
            roomId: "R019",
            hotelId: "HTL010",
            roomType: "Alpine Room",
            roomName: "Classic Alpine Room",
            description: "Cozy alpine room with mountain charm and modern amenities",
            maxOccupancy: 2,
            pricePerNight: 520.00,
            images: ["room19_1.jpg", "room19_2.jpg"],
            amenities: ["Mountain Views", "Ski Storage", "Alpine Decor", "Heated Floors"],
            bedConfiguration: {singleBeds: 0, doubleBeds: 0, kingBeds: 0, queenBeds: 1},
            roomSize: 35.0,
            availableCount: 18
        }
    ];
}

public isolated function initializeReviews() returns Review[] {
    return [
        {
            reviewId: "REV001",
            hotelId: "HTL001",
            userId: "asgardeo_user_123",
            userName: "John D.",
            rating: 4.8,
            title: "Exceptional luxury experience",
            comment: "Outstanding service and beautiful rooms. The staff went above and beyond to make our stay memorable.",
            reviewDate: "2024-01-20",
            categories: {
                cleanliness: 5.0,
                comfort: 4.8,
                location: 4.9,
                'service: 4.9,
                valueForMoney: 4.5
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV002",
            hotelId: "HTL002",
            userId: "asgardeo_user_456",
            userName: "Jane S.",
            rating: 4.6,
            title: "Perfect beach getaway",
            comment: "Amazing beachfront location with great amenities. The kids loved the pool and beach access.",
            reviewDate: "2024-02-25",
            categories: {
                cleanliness: 4.5,
                comfort: 4.7,
                location: 5.0,
                'service: 4.4,
                valueForMoney: 4.6
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV003",
            hotelId: "HTL003",
            userId: "asgardeo_user_789",
            userName: "Mike R.",
            rating: 4.4,
            title: "Great mountain retreat",
            comment: "Beautiful location with stunning mountain views. Perfect for hiking and relaxation. The fireplace was a nice touch.",
            reviewDate: "2024-03-10",
            categories: {
                cleanliness: 4.3,
                comfort: 4.5,
                location: 4.8,
                'service: 4.2,
                valueForMoney: 4.4
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV004",
            hotelId: "HTL004",
            userId: "asgardeo_user_321",
            userName: "Sarah L.",
            rating: 4.2,
            title: "Excellent for business travel",
            comment: "Great location in downtown Chicago. The business center and conference rooms were top-notch. WiFi was fast and reliable.",
            reviewDate: "2024-03-15",
            categories: {
                cleanliness: 4.1,
                comfort: 4.0,
                location: 4.6,
                'service: 4.3,
                valueForMoney: 4.0
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV005",
            hotelId: "HTL005",
            userId: "asgardeo_user_654",
            userName: "Emma W.",
            rating: 4.9,
            title: "Absolutely magnificent",
            comment: "This palace hotel is a dream come true. The heritage charm, butler service, and afternoon tea experience were exceptional. Worth every penny!",
            reviewDate: "2024-04-02",
            categories: {
                cleanliness: 4.9,
                comfort: 4.9,
                location: 4.8,
                'service: 5.0,
                valueForMoney: 4.7
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV006",
            hotelId: "HTL006",
            userId: "asgardeo_user_987",
            userName: "David M.",
            rating: 4.7,
            title: "Paradise on earth",
            comment: "The overwater bungalow was incredible! Waking up to crystal clear water beneath our feet was magical. Snorkeling right from our deck was amazing.",
            reviewDate: "2024-04-18",
            categories: {
                cleanliness: 4.8,
                comfort: 4.9,
                location: 5.0,
                'service: 4.5,
                valueForMoney: 4.2
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV007",
            hotelId: "HTL007",
            userId: "asgardeo_user_111",
            userName: "Yuki T.",
            rating: 4.3,
            title: "Stylish and modern",
            comment: "Love the contemporary design and local artwork. The rooftop bar has amazing city views. Great location in Shibuya district.",
            reviewDate: "2024-05-05",
            categories: {
                cleanliness: 4.4,
                comfort: 4.2,
                location: 4.6,
                'service: 4.1,
                valueForMoney: 4.3
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV008",
            hotelId: "HTL008",
            userId: "asgardeo_user_222",
            userName: "Robert K.",
            rating: 4.6,
            title: "Unforgettable safari experience",
            comment: "Seeing lions and elephants from our tent deck was incredible! The guided tours were informative and the luxury tent was very comfortable.",
            reviewDate: "2024-05-20",
            categories: {
                cleanliness: 4.4,
                comfort: 4.5,
                location: 5.0,
                'service: 4.7,
                valueForMoney: 4.6
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV009",
            hotelId: "HTL009",
            userId: "asgardeo_user_333",
            userName: "Lisa P.",
            rating: 3.8,
            title: "Good value for money",
            comment: "Clean and comfortable for the price. Location is great near Khao San Road. Basic amenities but everything you need for a budget stay.",
            reviewDate: "2024-06-01",
            categories: {
                cleanliness: 3.9,
                comfort: 3.7,
                location: 4.2,
                'service: 3.6,
                valueForMoney: 4.1
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV010",
            hotelId: "HTL010",
            userId: "asgardeo_user_444",
            userName: "Hans M.",
            rating: 4.8,
            title: "Ski paradise",
            comment: "Perfect ski-in/ski-out access and the Matterhorn views are breathtaking! The spa after a day of skiing was heavenly. Will definitely return!",
            reviewDate: "2024-06-15",
            categories: {
                cleanliness: 4.7,
                comfort: 4.9,
                location: 5.0,
                'service: 4.8,
                valueForMoney: 4.6
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV011",
            hotelId: "HTL001",
            userId: "asgardeo_user_555",
            userName: "Maria G.",
            rating: 4.9,
            title: "Luxury at its finest",
            comment: "The Presidential Suite was beyond our expectations. The butler service and city views were spectacular. Anniversary trip to remember!",
            reviewDate: "2024-06-28",
            categories: {
                cleanliness: 5.0,
                comfort: 4.9,
                location: 4.8,
                'service: 5.0,
                valueForMoney: 4.7
            },
            isVerifiedStay: true
        },
        {
            reviewId: "REV012",
            hotelId: "HTL002",
            userId: "asgardeo_user_666",
            userName: "Carlos R.",
            rating: 4.5,
            title: "Family friendly resort",
            comment: "Kids had a blast at the kids club and pool area. Beach access was convenient and the multiple restaurants gave us great dining options.",
            reviewDate: "2024-07-05",
            categories: {
                cleanliness: 4.4,
                comfort: 4.6,
                location: 4.8,
                'service: 4.3,
                valueForMoney: 4.5
            },
            isVerifiedStay: true
        }
    ];
}

// Mock booking data initialization
public function initializeBookings() returns Booking[] {
    return [
        {
            bookingId: "BKG001",
            hotelId: "HTL001",
            rooms: [
                {
                    roomId: "R001",
                    numberOfRooms: 1
                }
            ],
            userId: "asgardeo_user_123",
            checkInDate: "2024-08-15",
            checkOutDate: "2024-08-18",
            numberOfGuests: 2,
            primaryGuest: {
                firstName: "John",
                lastName: "Smith",
                email: "john.smith@email.com",
                phoneNumber: "+1-555-1234",
                nationality: "US"
            },
            pricing: [
                {
                    roomRate: 299.99,
                    numberOfNights: 3,
                    subtotal: 899.97,
                    taxes: 89.99,
                    serviceFees: 45.00,
                    totalAmount: 1034.96,
                    currency: "USD"
                }
            ],
            bookingStatus: "CONFIRMED",
            bookingDate: "2024-07-10",
            confirmationNumber: "CONF001234",
            specialRequests: {
                dietaryRequirements: "Vegetarian",
                accessibilityNeeds: (),
                bedPreference: "King bed",
                otherRequests: "Champagne for anniversary celebration"
            }
        },
        {
            bookingId: "BKG002",
            hotelId: "HTL002",
            rooms: [{roomId: "R004", numberOfRooms: 1}],
            userId: "asgardeo_user_123",
            checkInDate: "2024-06-20",
            checkOutDate: "2024-06-25",
            numberOfGuests: 2,
            primaryGuest: {
                firstName: "John",
                lastName: "Smith",
                email: "john.smith@email.com",
                phoneNumber: "+1-555-1234",
                nationality: "US"
            },
            pricing: [
                {
                    roomRate: 189.99,
                    numberOfNights: 5,
                    subtotal: 949.95,
                    taxes: 94.99,
                    serviceFees: 50.00,
                    totalAmount: 1094.94,
                    currency: "USD"
                }
            ],
            bookingStatus: "COMPLETED",
            bookingDate: "2024-05-15",
            confirmationNumber: "CONF002345",
            specialRequests: {
                dietaryRequirements: (),
                accessibilityNeeds: (),
                bedPreference: "Ocean view room",
                otherRequests: "Late checkout for 2 PM"
            }
        },
        {
            bookingId: "BKG003",
            hotelId: "HTL003",
            rooms: [{roomId: "R013", numberOfRooms: 1}],
            userId: "asgardeo_user_234",
            checkInDate: "2024-09-10",
            checkOutDate: "2024-09-14",
            numberOfGuests: 1,
            primaryGuest: {
                firstName: "Sarah",
                lastName: "Johnson",
                email: "sarah.j@email.com",
                phoneNumber: "+1-555-5678",
                nationality: "CA"
            },
            pricing: [
                {
                    roomRate: 159.99,
                    numberOfNights: 4,
                    subtotal: 639.96,
                    taxes: 63.99,
                    serviceFees: 32.00,
                    totalAmount: 735.95,
                    currency: "USD"
                }
            ],
            bookingStatus: "CONFIRMED",
            bookingDate: "2024-07-08",
            confirmationNumber: "CONF003456",
            specialRequests: {
                dietaryRequirements: (),
                accessibilityNeeds: (),
                bedPreference: "Quiet room",
                otherRequests: "Business traveler - need workspace"
            }
        },
        {
            bookingId: "BKG004",
            hotelId: "HTL001",
            rooms: [{roomId: "R002", numberOfRooms: 2}],
            userId: "asgardeo_user_345",
            checkInDate: "2024-05-01",
            checkOutDate: "2024-05-05",
            numberOfGuests: 4,
            primaryGuest: {
                firstName: "Michael",
                lastName: "Brown",
                email: "m.brown@email.com",
                phoneNumber: "+1-555-9012",
                nationality: "US"
            },
            pricing: [
                {
                    roomRate: 199.99,
                    numberOfNights: 4,
                    subtotal: 1599.92,
                    taxes: 159.99,
                    serviceFees: 80.00,
                    totalAmount: 1839.91,
                    currency: "USD"
                }
            ],
            bookingStatus: "COMPLETED",
            bookingDate: "2024-03-20",
            confirmationNumber: "CONF004567",
            specialRequests: {
                dietaryRequirements: "Gluten-free",
                accessibilityNeeds: (),
                bedPreference: "Adjacent rooms",
                otherRequests: "Family vacation with kids"
            }
        },
        {
            bookingId: "BKG005",
            hotelId: "HTL004",
            rooms: [{roomId: "R016", numberOfRooms: 1}],
            userId: "asgardeo_user_234",
            checkInDate: "2024-12-20",
            checkOutDate: "2024-12-27",
            numberOfGuests: 2,
            primaryGuest: {
                firstName: "Sarah",
                lastName: "Johnson",
                email: "sarah.j@email.com",
                phoneNumber: "+1-555-5678",
                nationality: "CA"
            },
            pricing: [
                {
                    roomRate: 249.99,
                    numberOfNights: 7,
                    subtotal: 1749.93,
                    taxes: 174.99,
                    serviceFees: 87.50,
                    totalAmount: 2012.42,
                    currency: "USD"
                }
            ],
            bookingStatus: "CONFIRMED",
            bookingDate: "2024-07-12",
            confirmationNumber: "CONF005678",
            specialRequests: {
                dietaryRequirements: "Wine pairing",
                accessibilityNeeds: (),
                bedPreference: "Mountain view",
                otherRequests: "Romantic getaway - champagne and roses"
            }
        },
        {
            bookingId: "BKG006",
            hotelId: "HTL005",
            rooms: [{roomId: "R008", numberOfRooms: 1}],
            userId: "asgardeo_user_456",
            checkInDate: "2024-07-28",
            checkOutDate: "2024-08-02",
            numberOfGuests: 3,
            primaryGuest: {
                firstName: "Emily",
                lastName: "Davis",
                email: "emily.d@email.com",
                phoneNumber: "+1-555-3456",
                nationality: "UK"
            },
            pricing: [
                {
                    roomRate: 229.99,
                    numberOfNights: 5,
                    subtotal: 1149.95,
                    taxes: 114.99,
                    serviceFees: 57.50,
                    totalAmount: 1322.44,
                    currency: "USD"
                }
            ],
            bookingStatus: "COMPLETED",
            bookingDate: "2024-06-10",
            confirmationNumber: "CONF006789",
            specialRequests: {
                dietaryRequirements: (),
                accessibilityNeeds: "Wheelchair accessible",
                bedPreference: "Ground floor",
                otherRequests: "Celebrating graduation with family"
            }
        }
    ];
}
