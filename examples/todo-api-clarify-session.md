# Example: Todo API Clarify Session

This is an example of a completed clarify session for a simple todo API project.

## Discovery: Todo Management API

Started: 2024-01-10

## Questions Asked

1. What is the core purpose of this API? → Manage todo items (create, read, update, delete)
2. Who will use this API? → Frontend developers building todo applications
3. What programming language? → Node.js with Express
4. What database? → SQLite for simplicity (development), PostgreSQL for production
5. Authentication required? → Yes, JWT-based authentication
6. What fields should a todo item have? → id, title, description, completed (boolean), createdAt, updatedAt, userId
7. Should todos be user-specific? → Yes, each user can only see/modify their own todos
8. What HTTP methods for CRUD? → GET (list/single), POST (create), PUT (update), DELETE (delete)
9. Should there be pagination? → Yes, for listing todos (default 20 per page)
10. What error codes to return? → 200 (success), 201 (created), 400 (bad request), 401 (unauthorized), 404 (not found), 500 (server error)
11. Should there be input validation? → Yes, using express-validator
12. What about rate limiting? → Yes, max 100 requests per 15 minutes per user
13. Logging requirements? → Basic request logging with Morgan
14. Testing requirements? → Unit tests with Jest, integration tests for API endpoints
15. Should there be API documentation? → Yes, using Swagger/OpenAPI
16. Environment configuration? → Use dotenv for environment variables
17. What port to run on? → Configurable via PORT env var, default 3000
18. CORS requirements? → Enable CORS for specified origins (configurable)
19. Should support filtering todos? → Yes, by completed status
20. Should support sorting todos? → Yes, by createdAt or title
21. Password hashing? → Use bcrypt with salt rounds of 10
22. Token expiration? → JWT tokens expire after 24 hours
23. Database migrations? → Yes, use a migration tool (Knex.js)
24. Seed data for development? → Yes, create a seed script
25. Health check endpoint? → Yes, /health returns API status
26. Error handling strategy? → Centralized error handler middleware
27. Request validation timing? → Validate on input before processing
28. Should enforce max title length? → Yes, max 100 characters
29. Should enforce max description length? → Yes, max 500 characters
30. What about soft deletes? → No, hard delete is fine for this API

## Answers Received

- **Authentication**: JWT-based with bcrypt password hashing
- **Database**: SQLite for dev, PostgreSQL for production with Knex migrations
- **Framework**: Node.js with Express
- **Testing**: Jest for unit and integration tests
- **Security**: Rate limiting (100 req/15min), input validation, password hashing
- **Documentation**: Swagger/OpenAPI
- **Logging**: Morgan for HTTP request logging

## Emerging Requirements

### Core Functionality
- CRUD operations for todo items
- User authentication and registration
- User-specific todo lists (isolation)
- Pagination for todo lists (20 per page)
- Filtering by completion status
- Sorting by date or title

### Technical Stack
- Node.js with Express framework
- SQLite (dev) / PostgreSQL (prod)
- Knex.js for query building and migrations
- JWT for authentication
- bcrypt for password hashing
- express-validator for input validation
- dotenv for configuration

### API Endpoints
- POST /api/auth/register - Register new user
- POST /api/auth/login - Login and get JWT
- GET /api/todos - List user's todos (paginated, filterable, sortable)
- GET /api/todos/:id - Get single todo
- POST /api/todos - Create new todo
- PUT /api/todos/:id - Update todo
- DELETE /api/todos/:id - Delete todo
- GET /health - Health check

### Quality Attributes
- Input validation on all endpoints
- Rate limiting (100 requests per 15 minutes per user)
- Centralized error handling
- Comprehensive test coverage (unit + integration)
- API documentation via Swagger
- Request logging with Morgan
- CORS configuration
- Secure password storage (bcrypt)
- Token expiration (24 hours)

### Validation Rules
- Title: required, max 100 characters
- Description: optional, max 500 characters
- Completed: boolean, defaults to false
- Email: required for registration, must be valid email
- Password: required, min 8 characters

### Edge Cases & Error Handling
- Return 401 for invalid/expired tokens
- Return 404 for non-existent todos
- Return 403 if user tries to access another user's todo
- Return 400 for validation errors
- Return 500 for server errors
- Graceful handling of database connection failures
- Proper error messages in responses
