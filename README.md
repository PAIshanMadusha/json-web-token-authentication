# 🛡️ Json Web Token (JWT) Authentication

A simple **Client-Server Architecture** project built using **Flutter** for the frontend and **Node.js** (Express) for the backend. This app demonstrates user authentication with **JWT Token** handling, including user **registration**, **login**, **login persistence** (token saved in SharedPreferences), secure **password hashing** using bcryptjs, and **logout** functionality.

---

## ✨ Features:

- **📝 User Registration**: (Name, Email, Password, Confirm Password).
- **✅ Email Validation**: Using Regular Expressions.
- **✅ Password Validation**: (minimum 6 characters).
- **🔐 Password Hashing**: Passwords are securely hashed using `bcryptjs` before storing in MongoDB.
- **🔓 Login with Email and Password**: Users can log into the system by entering valid credentials.
- **🔑 JWT Token Handling**: Token generated on successful login, token saved in `SharedPreferences` for login persistence, and token expiry set to **2 hours**.
- **🔄 Logout**: Removes token from `SharedPreferences`.
- **✅ Navigation**: After login, the user navigates to the Main Page.
- **🎨 Attractive UI Design**: The app features a modern and user-friendly interface for a seamless experience.

---

## 📂 Project Structure:

```
json-web-token-authentication/
├── flutter_client/
│   ├── lib/
│   │   ├── pages/
|   |   |   ├── authentication_home_page.dart
│   │   │   ├── login_page.dart
│   │   │   ├── register_page.dart
│   │   │   └── main_page.dart
│   │   ├── services/
│   │   │   └── authentication_service.dart
│   │   ├── widgets/
│   │   |   ├── reusable_widgets/
│   │   │   |   ├── custom_button.dart
│   │   │   |   └── custom_input_field.dart
│   │   └── main.dart
│   ├── pubspec.yaml
├── node_backend/
│   ├── models/
│   │   └── user.js
│   ├── routes/
│   │   └── authentication.js
│   ├── server.js
│   ├── package.json
│   ├── .env
├── .gitignore
└── README.md
```

## ⚙️ Tech Stack:
The following tech stack is used in this project:

| Parts                | Technologies Used                           |
|----------------------|---------------------------------------------|
| 📱 Flutter Client   | Flutter, Dart, HTTP, SharedPreferences, Google Fonts, Flutter SVG |
| 🧱 Node Backend     | Node.js, Express.js, BcryptJS, JWT, Mongoose, Dotenv, CORS |
| 🛢️ Database         | MongoDB (Localhost)                      |

---

## 📦 Dependencies:
The following dependencies are used in this project:

### 📱 Flutter Client:
```yaml
dependencies:
  http: ^1.3.0
  shared_preferences: ^2.5.3
  google_fonts: ^6.2.1
  flutter_svg: ^2.1.0
```

### 🧱 Node Backend:
```json
"dependencies": {
  "axios": "^1.9.0",
  "bcryptjs": "^3.0.2",
  "cors": "^2.8.5",
  "dotenv": "^16.5.0",
  "express": "^5.1.0",
  "jsonwebtoken": "^9.0.2",
  "mongoose": "^8.13.3",
  "nodemon": "^3.1.10"
  }
```
### 📦 Extra Packages:
- **axios**: Installed but not actively used. Needed only if future external API requests are required from the backend.

---

## 🚀 How to Run the Project:
### 1. **✅ Frontend Configuration (Flutter):**

#### Clone the repository:
```bash
https://github.com/PAIshanMadusha/json-web-token-authentication.git
```

#### Navigate to the project directory and to the **Client Side**:
```bash
cd json-web-token-authentication
cd flutter_client
```

#### Install dependencies:
```bash
flutter pub get
```

#### Update the base URL in the client side:

1. Open `flutter_client\lib\services\authentication_service.dart`.
2. Replace the **base URL** on **line 8** (e.g., `"http://192.168.8.150:5000/api/auth"`) with your **IP address**.

**How to find your IP address**:
- Open **Command Prompt** on your Windows machine.
- Type `ipconfig` and press Enter.
- Look for the **IPv4 Address** under the **Wireless LAN adapter Wi-Fi** section and use that as the IP to replace `192.168.8.150`.

---

### 2. **✅ Backend Configuration (Node.js):**

#### Navigate to the **Backend** directory:
```bash
cd node_backend
```

#### Install dependencies:
```bash
npm install
```

---

### 3. **✅ Database Setup (MongoDb):**

Install **MongoDB** if you haven’t already, or start it if it’s already installed. Then, create a `.env` file in the root of the `node_backend` directory and add the following content:

```env
PORT = 5000
MONGODB_URL = mongodb://127.0.0.1:27017/jwt_authentication
JWT_SECRET = [Your-JWT-Secret]
```
- Replace **[Your-JWT-Secret]** with your actual secret key. You can use any **random secure key** or generate one using **online key generator tools**.

#### Start the backend server:
```bash
npm start
```

If the server starts successfully, you should see the following message in your terminal:
```
Server Running On Port: 5000
MongoDb Connected Successfully!
```

#### ✅ Now you can run the app. Make sure you're inside the flutter_client directory and there are no errors:

```bash
cd flutter_client
flutter run
```
## 📸 System Screenshots:

---

<p align="center">
  <img src="https://github.com/user-attachments/assets/c43c71be-701e-4c4c-8c74-b6d389b92edb" alt="Screenshot 1" width="175">&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/13ada501-c14d-45a6-b1b4-777b979620e1" alt="Screenshot 2" width="175">&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/f563951a-6572-4f11-892b-e755ff536a03" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/e431b625-8371-40fc-82de-00a20547ec23" alt="Screenshot 4" width="175">&nbsp;&nbsp;&nbsp;
</p>

---

### 👨‍💻 Created by: 
**Ishan Madhusha**  
GitHub: [PAIshanMadusha](https://github.com/PAIshanMadusha)

Feel free to explore my work and get in touch if you'd like to collaborate! 🚀

---

## 📝 License:  
This project is open-source and available under the MIT License.
