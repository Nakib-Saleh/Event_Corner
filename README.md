# Event Corner

A full-stack event management platform for educational institutions. Organizers create and manage events, participants discover and register, and admins oversee the platform — all with integrated payments, AI assistance, and email notifications.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | React 19, Vite, Tailwind CSS, DaisyUI, Firebase Auth |
| Backend | Node.js, Express.js, Supabase (PostgreSQL) |
| AI Service | Python, FastAPI, EasyOCR, Google Gemini |
| Payments | SSLCommerz (bKash, Nagad, Visa, Mastercard) |
| Media | Cloudinary CDN |
| Email | Gmail SMTP via Nodemailer |

## Features

- **Multi-role system** — Super Admin, Admin, Institution, Organizer, Participant
- **AI-assisted event creation** — Upload a poster for OCR extraction or describe your event via chat
- **Custom registration forms** — Drag-and-drop form builder with team support
- **Secure payments** — SSLCommerz integration with configurable refund policies (full/partial/none/custom)
- **Deferred registration** — Paid event registrations only finalize after successful payment
- **Email notifications** — Automated emails for approvals, rejections, cancellations, and refunds
- **Event cancellation** — Bulk refunds and participant notification
- **Maps & Calendar** — Leaflet venue picker, FullCalendar schedule view
- **External event crawling** — Discover events from third-party websites
- **AI Chatbot** — Role-aware platform assistant powered by Gemini

## Prerequisites

- **Node.js** 18+ and npm
- **Python** 3.10+
- **Supabase** project (free tier works)
- **Firebase** project (for authentication)
- **Cloudinary** account (for image hosting)
- **SSLCommerz** sandbox account (for payments)
- **Google AI** API key (for Gemini)
- **Gmail** account with App Password (for emails)

## Project Structure

```
Event_Corner/
├── frontend/          # React SPA (Vite + Tailwind)
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── providers/
│   │   └── config/
│   └── .env.local     # Frontend environment variables
├── backend/
│   ├── server.js      # Express entry point
│   ├── routes/        # Modular route files
│   ├── services/      # Email, SSLCommerz services
│   ├── migrations/    # SQL migration files
│   ├── sql/           # Stored procedures
│   ├── ai/            # Python FastAPI AI server
│   │   ├── ai_server.py
│   │   ├── banner_analyzer.py
│   │   ├── crawler.py
│   │   └── requirements.txt
│   └── .env           # Backend environment variables
└── package.json       # Root scripts (runs both services)
```

## Setup & Run

### 1. Clone and install dependencies

```bash
git clone <repo-url>
cd Event_Corner

# Install root dependencies
npm install

# Install backend dependencies
cd backend
npm install

# Install frontend dependencies
cd ../frontend
npm install

cd ..
```

### 2. Set up the database

1. Create a [Supabase](https://supabase.com) project
2. Run the SQL files in the Supabase SQL Editor in this order:
   ```
   backend/sql/01_core_tables.sql
   backend/sql/02_user_roles.sql
   backend/sql/03_event_management.sql
   backend/sql/04_payment_system.sql
   backend/sql/05_registration_participants.sql
   backend/sql/06_bookmarks.sql
   backend/sql/07_crawled_events.sql
   backend/sql/08_chatbot.sql
   ```
3. Then run any migration files in `backend/migrations/` if needed.

### 3. Configure environment variables

**Backend** — create `backend/.env`:

```env
# Supabase
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
PORT=5000

# Gmail SMTP (enable 2FA, then create App Password)
GMAIL_USER=your-email@gmail.com
GMAIL_APP_PASSWORD=your_16_char_app_password

# Base URL for email links
BASE_URL=http://localhost:5000

# Google Gemini API
GOOGLE_API_KEY=your_gemini_api_key
EXTRACTION_METHOD=LOCAL

# SSLCommerz Sandbox
SSLCOMMERZ_STORE_ID=your_store_id
SSLCOMMERZ_STORE_PASSWORD=your_store_password
SSLCOMMERZ_IS_LIVE=false

# For payment callbacks (use ngrok for local dev)
NGROK_URL=http://localhost:5000
FRONTEND_URL=http://localhost:5173
```

**Frontend** — create `frontend/.env.local`:

```env
VITE_API_BASE_URL=http://localhost:5000

# Firebase (from Firebase Console > Project Settings)
VITE_FIREBASE_API_KEY=your_firebase_api_key
VITE_FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your_project_id
VITE_FIREBASE_STORAGE_BUCKET=your_project.firebasestorage.app
VITE_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
VITE_FIREBASE_APP_ID=your_app_id

# Cloudinary
VITE_CLOUDINARY_CLOUD_NAME=your_cloud_name
VITE_CLOUDINARY_UPLOAD_PRESET=your_upload_preset
```

### 4. Set up the AI server (optional)

```bash
cd backend/ai

# Create virtual environment
python -m venv venv

# Activate it
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### 5. Run the application

**Option A — Run everything with one command:**

```bash
npm run dev
```

This starts both the backend (port 5000) and frontend (port 5173) concurrently.

**Option B — Run services individually:**

```bash
# Terminal 1: Backend
cd backend
npm run dev

# Terminal 2: Frontend
cd frontend
npm run dev

# Terminal 3: AI server (optional)
cd backend/ai
python ai_server.py
```

### 6. Open the app

Navigate to **http://localhost:5173** in your browser.

## Payment Testing (SSLCommerz Sandbox)

For local development, SSLCommerz requires a public URL for IPN callbacks:

1. Install [ngrok](https://ngrok.com/) and run `ngrok http 5000`
2. Copy the forwarding URL (e.g., `https://xxxx.ngrok-free.dev`)
3. Update `NGROK_URL` in `backend/.env` with this URL
4. Restart the backend

Use SSLCommerz sandbox test credentials to simulate payments.
