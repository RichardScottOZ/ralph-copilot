# Example: Todo API Execution Files

This shows example PROMPT.md and TODO.md files that would be generated from the clarify session.

## PROMPT.md

```markdown
# PROMPT.md

## Project
Build a RESTful Todo Management API with user authentication

## Requirements
Read clarify-session.md for full requirements. Key points:
- Node.js/Express API with JWT authentication
- CRUD operations for user-specific todos
- SQLite for development, PostgreSQL-ready
- Input validation, rate limiting, and comprehensive testing
- API documentation with Swagger

## Instructions

1. Read TODO.md to see current tasks
2. Pick the highest priority incomplete task (top `- [ ]` item)
3. Read any files before editing them
4. Implement the task completely
5. Run tests/validation relevant to the task
6. If tests fail, fix them before continuing
7. Mark task complete in TODO.md by changing `- [ ]` to `- [x]`
8. Commit changes: `git add -A && git commit -m "descriptive message"`
9. Continue to next task

## Signs (Guardrails)

- Always read files before editing
- Never skip failing tests
- If tests fail 3 times on same issue, output: STUCK - [describe issue]
- Don't refactor unrelated code
- Keep changes focused on current task
- Update TODO.md immediately after completing each task
- Never commit secrets or hardcoded passwords
- Use environment variables for all configuration
- Always validate user input before processing
- Ensure all database queries use parameterized statements
- Test both success and error cases

## Completion

When all tasks in TODO.md are marked `[x]` and all tests pass, output:

DONE
```

## TODO.md

```markdown
# TODO

## Critical (MVP - Must Complete)
- [ ] Set up project structure (package.json, folders, initial files)
- [ ] Install dependencies (express, knex, sqlite3, jsonwebtoken, bcrypt, etc.)
- [ ] Configure environment variables with dotenv (.env.example and .env)
- [ ] Set up Knex configuration for SQLite and PostgreSQL
- [ ] Create database migration for users table
- [ ] Create database migration for todos table
- [ ] Create User model with bcrypt password hashing
- [ ] Create Todo model with CRUD methods
- [ ] Implement POST /api/auth/register endpoint with validation
- [ ] Implement POST /api/auth/login endpoint returning JWT
- [ ] Create authentication middleware to verify JWT tokens
- [ ] Implement POST /api/todos endpoint (create todo)
- [ ] Implement GET /api/todos endpoint (list user's todos with pagination)
- [ ] Implement GET /api/todos/:id endpoint (get single todo)
- [ ] Implement PUT /api/todos/:id endpoint (update todo)
- [ ] Implement DELETE /api/todos/:id endpoint (delete todo)
- [ ] Add input validation middleware using express-validator
- [ ] Create centralized error handler middleware
- [ ] Add basic Jest test setup
- [ ] Write tests for authentication endpoints
- [ ] Write tests for todo CRUD endpoints
- [ ] **HARD STOP** - Verify all CRUD operations work end-to-end with authentication

## High Priority
- [ ] Add rate limiting middleware (100 req/15min per user)
- [ ] Implement filtering todos by completed status
- [ ] Implement sorting todos by createdAt or title
- [ ] Add CORS configuration with allowed origins from env
- [ ] Add Morgan for request logging
- [ ] Implement GET /health endpoint for health checks
- [ ] Create database seed script for development data
- [ ] Add Swagger/OpenAPI documentation
- [ ] Add validation for max title length (100 chars)
- [ ] Add validation for max description length (500 chars)
- [ ] Test rate limiting behavior
- [ ] Test pagination edge cases (empty list, single page, multiple pages)
- [ ] Test user isolation (users can't access others' todos)
- [ ] **HARD STOP** - Review all endpoints and security before polish

## Medium Priority
- [ ] Add README with setup and API documentation
- [ ] Create Docker configuration for easy deployment
- [ ] Add npm scripts for common tasks (dev, test, migrate, seed)
- [ ] Improve error messages for better developer experience
- [ ] Add request ID tracking for debugging
- [ ] Document environment variables in .env.example
- [ ] Add integration tests for complex workflows
- [ ] Test PostgreSQL compatibility

## Low Priority / Nice-to-Have
- [ ] Add todo categories or tags
- [ ] Add todo due dates
- [ ] Add todo priority levels
- [ ] Implement search functionality for todos
- [ ] Add API versioning (e.g., /api/v1/)
- [ ] Add refresh token functionality
- [ ] Add password reset functionality
- [ ] Create Postman collection for API testing

---
## Completed
(Completed tasks will be moved here)
```
