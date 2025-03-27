<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            min-height: 100vh;
            background-image: url("https://png.pngtree.com/thumb_back/fh260/background/20221121/pngtree-large-passenger-airplane-boeing-fuselage-blue-photo-image_7404058.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            justify-content: center;
            align-items: center;
            font-family: 'Poppins', sans-serif;
        }

        .login-container {
            width: 400px;
            background: rgba(0, 0, 0, 0.7); /* Làm tối khung đăng nhập */
            padding: 30px;
            border-radius: 12px;
            backdrop-filter: blur(5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            text-align: center;
            transition: 0.3s;
        }

        .login-container:hover {
            transform: scale(1.02);
        }

        h3 {
            color: #f8f9fa;
            font-weight: bold;
        }

        .form-label {
            color: #d1d1d1;
            font-weight: 500;
        }

        .form-control {
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 10px;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #e06656, #fd9c5d);
            transform: translateY(-2px);
        }

        .text-link {
            color: #ffcc70;
            text-decoration: none;
            font-size: 14px;
        }

        .text-link:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #ff4d4d;
            margin-top: 10px;
        }

        .btn-outline-light {
            border: 1px solid #ffcc70;
            color: #ffcc70;
        }

        .btn-outline-light:hover {
            background: #ffcc70;
            color: #000;
        }

    </style>
</head>
<body>
    <div class="login-container">
        <h3>Login</h3>
        <form action="<%= request.getContextPath() %>/login" method="post">  
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required placeholder="Enter your username">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required placeholder="Enter your password">
            </div>
            <div class="mb-3 form-check text-start">
                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" value="true">
                <label class="form-check-label" for="rememberMe" style="color: #d1d1d1;">Remember me</label>
            </div>
            <div class="mb-3">
                <button type="submit" class="btn btn-primary w-100">Login</button>
            </div>
            <div>
                <a href="<%= request.getContextPath()%>/resetpassword" class="text-link">Forgot Password?</a>
            </div>
            <p class="error-message">${error}</p>
            <hr style="border-color: rgba(255, 255, 255, 0.3);">
            <p style="color: #d1d1d1;">Don't have an account?</p>
            <a href="<%= request.getContextPath() %>/register" class="btn btn-outline-light w-100">Register here</a>
        </form>
    </div>
</body>
</html>
