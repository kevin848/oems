# OEMS - Complete Setup Guide

## Prerequisites

- Node.js (v18+)
- MySQL (v8.0+)
- npm or yarn

## Database Setup

### Step 1: Create MySQL Database

```bash
mysql -u root -p
```

Then run:
```sql
CREATE DATABASE oems_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Step 2: Configure Database Connection

Create a `.env` file in the `backend` directory:

```bash
cp backend/.env.example backend/.env
```

Edit `backend/.env` and update the database credentials:
```
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=oems_db
```

## Backend Setup

### Step 1: Install Dependencies

```bash
cd backend
npm install
```

### Step 2: Build TypeScript

```bash
npm run build
```

### Step 3: Run Migrations (Create Tables)

```bash
npm run migrate
```

This will automatically create all necessary tables in your MySQL database.

### Step 4: Start Backend Server

```bash
npm run dev
```

The backend server will start at `http://localhost:5000`

You should see:
```
✓ Database connected successfully
✓ All migrations completed successfully
✓ Server running on http://localhost:5000
```

## Frontend Setup

### Step 1: Install Dependencies

```bash
cd frontend
npm install
```

### Step 2: Configure Environment

```bash
cp frontend/.env.example frontend/.env
```

The `.env` file should have:
```
REACT_APP_API_URL=http://localhost:5000/api
```

### Step 3: Start Development Server

```bash
npm start
```

The frontend will start at `http://localhost:3000`

## Running Both Servers

### Option 1: Separate Terminals

**Terminal 1 - Backend:**
```bash
cd backend
npm run dev
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm start
```

### Option 2: Using Concurrently (Optional)

From the root directory, you can create a script to run both.

## Testing the Application

1. Open `http://localhost:3000` in your browser
2. Click on "Register here" to create an account
3. Fill in the registration form:
   - Choose "Instructor" or "Student" role
   - Complete other details
4. Click Register
5. Login with your credentials

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Exams
- `GET /api/exams/my-exams` - Get instructor's exams
- `GET /api/exams/available` - Get available exams for student
- `GET /api/exams/:id` - Get exam details
- `POST /api/exams` - Create new exam
- `PATCH /api/exams/:id/publish` - Publish exam

## Database Schema

### Tables Created:
1. **users** - User accounts (admin, instructor, student)
2. **exams** - Exam information
3. **questions** - Questions for each exam
4. **options** - Multiple choice options
5. **enrollments** - Student enrollments for exams
6. **submissions** - Exam submissions by students
7. **answers** - Student answers to questions
8. **activityLogs** - Track student activity during exams

## Troubleshooting

### Database Connection Error
- Ensure MySQL is running
- Verify credentials in `.env` file
- Check database exists: `mysql -u root -p -e "SHOW DATABASES;"`

### Port Already in Use
- Backend (5000): `lsof -i :5000` and kill the process
- Frontend (3000): `lsof -i :3000` and kill the process

### npm install Fails
- Delete `node_modules` and `package-lock.json`
- Run `npm install` again

### CORS Errors
- Ensure frontend URL in backend `.env` matches your frontend URL
- Default: `FRONTEND_URL=http://localhost:3000`

## Project Structure

```
oems/
├── backend/
│   ├── src/
│   │   ├── config/          # Database config
│   │   ├── database/        # Migrations
│   │   ├── middleware/      # Auth middleware
│   │   ├── routes/          # API routes
│   │   ├── types/           # TypeScript types
│   │   └── index.ts         # Main server file
│   ├── package.json
│   ├── tsconfig.json
│   └── .env.example
├── frontend/
│   ├── src/
│   │   ├── api/             # API client
│   │   ├── components/      # React components
│   │   ├── pages/           # Page components
│   │   ├── store/           # Zustand stores
│   │   ├── types/           # TypeScript types
│   │   ├── App.tsx
│   │   └── index.tsx
│   ├── public/
│   ├── package.json
│   ├── tsconfig.json
│   └── .env.example
├── README.md
└── CONTRIBUTING.md
```

## Next Steps

1. Implement additional routes for questions management
2. Add exam submission and grading features
3. Implement real-time proctoring with browser lockdown
4. Add analytics and reporting features
5. Implement email notifications
6. Add more comprehensive error handling

## Support

For issues or questions, please refer to the CONTRIBUTING.md file or create an issue on GitHub.
