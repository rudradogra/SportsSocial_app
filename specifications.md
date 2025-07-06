# Sports Social Mobile App - Complete Development Prompt

## Project Overview
Create a cross-platform mobile application (React Native or Flutter) that replicates the entire Sports Social web application. This is a comprehensive social platform for sports and esports enthusiasts to connect, discover events, create communities, and engage through real-time messaging and reviews.

## Core Features & User Flows

### 1. Authentication System
- **Registration Flow:**
  - Multi-step form with username, email, password, bio, sports interests, and tags
  - Real-time validation (username availability, email format, password strength)
  - Phone number input with country code selection and 10-digit formatting
  - OTP verification system via email using NodeMailer
  - Welcome email after successful registration
- **Login Flow:**
  - Email/username and password authentication
  - JWT token-based session management
  - "Remember me" functionality
  - Password reset via email OTP
- **Profile Setup:**
  - Profile picture and cover photo upload
  - Bio, location, sports skills, and availability settings
  - Privacy settings and notification preferences

### 2. Home Feed & Discovery
- **Dynamic Feed:**
  - Location-based post discovery using PostGIS geospatial queries
  - Smart filters: sport type (traditional/esports), location radius, date, tags
  - Interest-based algorithm showing relevant posts
  - Exclude user's own posts from main feed
- **Post Types:**
  - Sports events (football, basketball, tennis, etc.)
  - Esports tournaments (Valorant, League of Legends, BGMI, etc.)
  - Casual meetups and training sessions
- **Interactive Elements:**
  - "Show Interest" button that auto-joins group chats
  - Real-time interest count with heart icons
  - Navigation to group messaging upon interest

### 3. Event Management System
- **Create Events:**
  - Rich form with sport selection, skill level, location picker
  - Google Places API integration for location search
  - Date/time picker, participant limits, description
  - Tag system for better discoverability
- **Event Registration:**
  - Dedicated registration page with detailed event info
  - Participant management and limits
  - Event creator dashboard
- **Event Discovery:**
  - Grid layout with event cards
  - Filtering by sport, location, date, skill level
  - Registration status tracking

### 4. Real-time Messaging
- **Direct Messages:**
  - One-on-one conversations
  - Real-time delivery using Socket.io
  - Message status indicators (sent, delivered, read)
  - User search and conversation initiation
- **Group Chats:**
  - Auto-created when users show interest in posts
  - Group naming based on event details
  - Participant management
  - Real-time message synchronization
- **Message Features:**
  - Text messages with emoji support
  - Typing indicators
  - Unread message counts and badges
  - Message history and pagination

### 5. User Profiles & Social Features
- **Profile Management:**
  - Editable profile with banner and avatar images
  - Bio, contact information, sports skills
  - Posts history and review showcases
  - Following/followers system
- **Social Actions:**
  - Follow/unfollow users
  - View other users' profiles
  - Direct message initiation
  - Activity statistics display
- **Privacy Controls:**
  - Profile visibility settings
  - Contact information privacy
  - Message restrictions

### 6. Review System
- **Create Reviews:**
  - 5-star rating system
  - Category-based reviews (venues, equipment, experiences)
  - Rich text descriptions with tag support
  - Photo upload capabilities
- **Review Discovery:**
  - Filter by category, rating, tags
  - Search functionality
  - Author profile integration
  - Helpful/unhelpful voting system

### 7. Search & Discovery
- **People Search:**
  - Username and name-based search
  - Filter by location, sports, skill level
  - Profile preview cards
  - Follow/message actions from search results
- **Content Search:**
  - Posts, events, and reviews search
  - Advanced filtering options
  - Location-based results

### 8. Notifications System
- **Real-time Notifications:**
  - New messages and group chat activity
  - Event registrations and updates
  - New followers and profile interactions
  - System announcements
- **Notification Management:**
  - Mark as read/unread
  - Notification history
  - Push notification settings
  - Email notification preferences

### 9. Settings & Preferences
- **Account Settings:**
  - Profile information editing
  - Password change functionality
  - Email and notification preferences
  - Privacy and security settings
- **App Preferences:**
  - Theme selection (dark/light modes)
  - Language preferences
  - Location services settings
  - Push notification toggles

## UI/UX Design Requirements

### Design System
- **Color Scheme:**
  - Primary: Orange gradient (#FF6B35 to #FF9800)
  - Background: Dark theme with #1A1A1A primary, #2D2D2D secondary
  - Text: #FFFFFF primary, #B3B3B3 secondary, #808080 tertiary
  - Accents: Success (#4CAF50), Warning (#FFC107), Error (#F44336)
  - Borders: #333333 primary, #404040 secondary

### Typography
- **Font Family:** Inter, system fonts as fallback
- **Font Sizes:** 12px (xs) to 32px (xxxl) with responsive scaling
- **Font Weights:** 400 (normal), 500 (medium), 600 (semibold), 700 (bold)
- **Line Heights:** 1.2 (tight), 1.5 (normal), 1.8 (loose)

### Layout & Navigation
- **Bottom Tab Navigation:**
  - Home, Events, Search, Messages, Profile
  - Orange active state with badge notifications
  - Icons from React Native Vector Icons or similar
- **Header Navigation:**
  - Screen titles with gradient text effects
  - Action buttons (notifications, settings)
  - Search bars where applicable
- **Sidebar/Drawer (if needed):**
  - Quick access to all app sections
  - User profile summary
  - Settings and about links

### Component Patterns
- **Cards & Lists:**
  - Rounded corners (8px-16px)
  - Subtle shadows and borders
  - Hover/press effects with elevation changes
  - Consistent spacing and padding
- **Buttons:**
  - Primary: Orange gradient with white text
  - Secondary: Dark background with border
  - Rounded corners (8px-25px for pill buttons)
  - Press animations with scale/shadow effects
- **Forms:**
  - Consistent input styling with focus states
  - Real-time validation feedback
  - Clear error messaging
  - Progressive disclosure for complex forms

### Responsive Design
- **Mobile-First Approach:**
  - Optimized for screens 375px and up
  - Touch-friendly tap targets (44px minimum)
  - Appropriate spacing for thumb navigation
- **Adaptive Layouts:**
  - Single column layouts for mobile
  - Flexible grid systems
  - Collapsible sections for content-heavy screens
- **Performance Considerations:**
  - Lazy loading for images and lists
  - Optimized images and assets
  - Smooth animations at 60fps

## Backend Integration

### API Endpoints Structure
- **Authentication:** `/api/auth/*`
  - POST `/send-otp`, `/verify-otp`, `/login`, `/register`
  - GET `/me`, `/verify-token`
- **Users:** `/api/users/*`
  - GET `/profile/:id`, `/search`, `/followers/:id`
  - POST `/follow/:id`, `/unfollow/:id`
  - PUT `/profile`, `/avatar`, `/banner`
- **Posts:** `/api/posts/*`
  - GET `/` (with filters), `/:id`, `/user/:id`
  - POST `/`, `/:id/interest`
  - PUT `/:id`, DELETE `/:id`
- **Messages:** `/api/messages/*` & `/api/direct-messages/*`
  - GET `/conversations`, `/unread-count`
  - POST `/send`, `/group/create`
- **Reviews:** `/api/reviews/*`
  - GET `/` (with filters), `/user/:id`
  - POST `/create`
- **Events:** `/api/event-registrations/*`
  - GET `/`, `/user/:id`
  - POST `/register`, `/unregister`
- **Notifications:** `/api/notifications/*`
  - GET `/`, `/unread-count`
  - PUT `/:id/read`

### Real-time Features
- **Socket.io Integration:**
  - Connection management and authentication
  - Message delivery and receipt confirmation
  - Typing indicators and presence
  - Group chat synchronization
  - Notification broadcasting

### Data Models
- **User Model:** Profile info, preferences, stats, relationships
- **Post Model:** Event details, location, participants, metadata
- **Message Model:** Content, sender, conversation, timestamps
- **Review Model:** Rating, category, content, tags
- **Notification Model:** Type, content, read status, timestamps

## Technical Implementation

### Architecture Requirements
- **Cross-Platform Framework:** React Native (preferred) or Flutter
- **State Management:** Redux Toolkit or Zustand for React Native / Bloc for Flutter
- **Navigation:** React Navigation 6+ or Flutter Navigator 2.0
- **Real-time:** Socket.io client integration
- **HTTP Client:** Axios for React Native / Dio for Flutter
- **Storage:** AsyncStorage/Expo SecureStore or Flutter Secure Storage

### Key Libraries & Dependencies
- **UI Components:** NativeBase, React Native Elements, or custom component library
- **Maps Integration:** React Native Maps with Google Places API
- **Image Handling:** React Native Image Picker with upload functionality
- **Push Notifications:** Firebase Cloud Messaging integration
- **Authentication:** JWT token management with secure storage
- **Form Handling:** React Hook Form or Formik for React Native

### Performance Optimizations
- **List Virtualization:** FlatList optimization for large datasets
- **Image Optimization:** WebP format, lazy loading, caching
- **Bundle Optimization:** Code splitting and tree shaking
- **Memory Management:** Proper cleanup of listeners and subscriptions

### Security Implementation
- **Token Security:** Secure storage for JWT tokens
- **API Security:** Request interceptors for authentication
- **Input Validation:** Client-side validation matching backend rules
- **Deep Linking:** Secure URL handling for shared content

## Additional Features

### Location Services
- **Current Location:** GPS integration for nearby events
- **Location Picker:** Google Places autocomplete
- **Geofencing:** Location-based notifications
- **Distance Calculations:** PostGIS integration for radius searches

### Offline Capabilities
- **Message Queue:** Store messages when offline
- **Caching Strategy:** Cache user data and recent conversations
- **Sync Mechanism:** Background sync when connection restored

### Accessibility
- **Screen Reader Support:** Proper labeling and navigation
- **Voice Control:** Voice input for messages and search
- **High Contrast:** Support for system accessibility settings
- **Font Scaling:** Respect system font size preferences

### Analytics & Monitoring
- **Usage Analytics:** Track user engagement and popular features
- **Crash Reporting:** Automatic crash detection and reporting
- **Performance Monitoring:** Track app performance metrics
- **User Feedback:** In-app feedback and rating prompts

## Development Guidelines

### Code Quality Standards
- **TypeScript:** Strong typing throughout the application
- **ESLint/Prettier:** Consistent code formatting and linting
- **Component Architecture:** Reusable, composable components
- **Error Handling:** Comprehensive error boundaries and fallbacks

### Testing Strategy
- **Unit Tests:** Component and utility function testing
- **Integration Tests:** API integration and user flow testing
- **E2E Tests:** Critical user journey automation
- **Performance Tests:** Load testing for list rendering and animations

### DevOps & Deployment
- **CI/CD Pipeline:** Automated testing and building
- **Code Signing:** iOS and Android app signing
- **App Store Deployment:** Automated release to app stores
- **Version Management:** Semantic versioning and changelog

## Success Metrics

### User Engagement
- Daily/monthly active users
- Session duration and frequency
- Feature adoption rates
- Message volume and response times

### Technical Performance
- App startup time < 3 seconds
- Navigation transitions < 300ms
- Crash rate < 0.1%
- 4.5+ star rating on app stores

## Deliverables

1. **Complete Mobile Application** with all specified features
2. **Source Code** with proper documentation and comments
3. **API Integration** with the existing backend system
4. **UI/UX Implementation** matching the web application design
5. **Testing Suite** with comprehensive test coverage
6. **Deployment Configuration** for iOS and Android app stores
7. **User Documentation** including feature guides and troubleshooting

---

This prompt provides a comprehensive blueprint for creating a mobile application that perfectly mirrors the Sports Social web platform while leveraging mobile-specific capabilities and following platform best practices. The app should feel native to mobile users while maintaining feature parity with the web version.