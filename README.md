# 🎵 Musicly

A full-stack music streaming application with a **Flutter frontend** and a **FastAPI backend**.  
Users can browse, play, and manage music with a dynamic and responsive UI. Admins can upload songs with cover images and metadata via an integrated backend.

---

## 📁 Project Structure


---

## 🚀 Features

### ✅ Frontend (Flutter)
- 🎨 Dynamic color-changing UI based on song cover
- 🎶 Add, play, and favorite songs
- 💾 Local & cloud storage integration
- 🔁 MVVM architecture with Riverpod
- ⚙️ Responsive design for Android & Web

### ✅ Backend (FastAPI)
- 🔐 RESTful APIs with FastAPI
- 🗃️ PostgreSQL for data persistence
- ☁️ Media uploads to Cloudinary
- 🧱 Pydantic for schema validation
- 📦 Modular structure: routers, models, middleware

---

## 🔧 Getting Started

### 📦 Prerequisites

- Flutter SDK
- Python 3.9+
- PostgreSQL
- Cloudinary account (for backend media)

---

### 🚀 Run the Backend

```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
