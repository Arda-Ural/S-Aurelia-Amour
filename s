<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>S'Aurelia Amour | Maison de Parfum</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;400;600&family=Playfair+Display:ital,wght@1,400;1,700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --black: #050505; --soft-gray: #1a1a1a; --text: #e0e0e0; }
        
        * { box-sizing: border-box; transition: all 0.4s cubic-bezier(0.25, 1, 0.5, 1); }
        body { background: var(--black); color: var(--text); font-family: 'Montserrat', sans-serif; margin: 0; }
        
        /* --- NAVIGATION --- */
        nav { padding: 30px; text-align: center; border-bottom: 1px solid var(--soft-gray); position: sticky; top: 0; background: rgba(5,5,5,0.9); z-index: 1000; backdrop-filter: blur(10px); }
        .brand { font-family: 'Playfair Display', serif; font-style: italic; font-size: 3rem; color: var(--gold); margin: 0; cursor: pointer; text-shadow: 0 0 15px rgba(212, 175, 55, 0.2); }
        .nav-links { margin-top: 15px; font-size: 0.8rem; letter-spacing: 2px; text-transform: uppercase; }
        .nav-links span { margin: 0 15px; cursor: pointer; color: #888; }
        .nav-links span:hover { color: var(--gold); }

        /* --- FORMS (LOGIN/REGISTER) --- */
        .auth-container { max-width: 400px; margin: 100px auto; padding: 40px; border: 1px solid var(--gold); background: #0c0c0c; text-align: center; display: none; }
        input { width: 100%; padding: 15px; margin: 10px 0; background: #151515; border: 1px solid #333; color: white; border-radius: 0; }
        input:focus { border-color: var(--gold); outline: none; }
        .gold-btn { background: var(--gold); color: black; border: none; padding: 15px 30px; width: 100%; cursor: pointer; font-weight: bold; text-transform: uppercase; letter-spacing: 2px; margin-top: 10px; }
        .gold-btn:hover { background: #fff; box-shadow: 0 0 20px var(--gold); }

        /* --- PRODUCT GRID --- */
        .main-content { max-width: 1400px; margin: 0 auto; padding: 50px 20px; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 50px; }
        .card { background: #0c0c0c; border: 1px solid #151515; overflow: hidden; position: relative; }
        .card:hover { border-color: var(--gold); transform: translateY(-10px); }
        .card img { width: 100%; height: 450px; object-fit: cover; opacity: 0.8; }
        .card:hover img { opacity: 1; transform: scale(1.05); }
        .card-info { padding: 25px; text-align: center; }
        .card-title { font-family: 'Playfair Display', serif; font-style: italic; font-size: 1.8rem; color: var(--gold); margin-bottom: 10px; }
        .card-price { color: #888; letter-spacing: 2px; }

        /* --- ADMIN PANEL --- */
        #admin-panel { display: none; position: fixed; inset: 0; background: var(--black); z-index: 2000; padding: 50px; overflow-y: auto; }
        .admin-header { border-bottom: 1px solid var(--gold); padding-bottom: 20px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; }
        
        /* --- UTILS --- */
        .active { display: block !important; }
        .hidden { display: none !important; }
    </style>
</head>
<body>

    <nav>
        <div class="brand" onclick="showPage('home')">S'Aurelia Amour</div>
        <div class="nav-links">
            <span onclick="showPage('home')">Koleksiyon</span>
            <span id="nav-auth" onclick="showPage('login')">Giriş / Kayıt</span>
            <span id="nav-user" class="hidden">Hoş geldin, <b id="user-display" style="color:var(--gold)"></b> | <a onclick="logout()" style="color:red; cursor:pointer">Çıkış</a></span>
            <span onclick="checkAdmin()">Yönetim</span>
        </div>
    </nav>

    <div class="main-content">
        <!-- HOME PAGE -->
        <div id="page-home" class="page active">
            <div style="text-align: center; margin-bottom: 60px;">
                <h2 style="font-family: 'Playfair Display', serif; font-style: italic; font-weight: 200; font-size: 1.2rem; letter-spacing: 5px; color: var(--gold);">ETHEREAL LUXURY</h2>
            </div>
            <div id="product-list" class="product-grid">
                <!-- Ürünler buraya yüklenir -->
            </div>
        </div>

        <!-- LOGIN PAGE -->
        <div id="page-login" class="page auth-container">
            <h2 class="brand" style="font-size: 1.5rem;">Giriş Yap</h2>
            <input type="text" id="login-user" placeholder="Kullanıcı Adı">
            <input type="password" id="login-pass" placeholder="Şifre">
            <button class="gold-btn" onclick="handleLogin()">Giriş</button>
            <p style="font-size: 0.7rem; margin-top: 20px; color: #555;">Hesabın yok mu? <a href="#" onclick="showPage('register')" style="color:var(--gold)">Kayıt Ol</a></p>
        </div>

        <!-- REGISTER PAGE -->
        <div id="page-register" class="page auth-container">
            <h2 class="brand" style="font-size: 1.5rem;">Kayıt Ol</h2>
            <input type="text" id="reg-user" placeholder="Kullanıcı Adı">
            <input type="email" id="reg-email" placeholder="E-posta">
            <input type="password" id="reg-pass" placeholder="Şifre">
            <button class="gold-btn" onclick="handleRegister()">Hesap Oluştur</button>
        </div>
    </div>

    <!-- ADMIN PANEL -->
    <div id="admin-panel">
        <div class="admin-header">
            <h2 class="brand" style="font-size: 2rem;">S'Aurelia Control Center</h2>
            <button onclick="closeAdmin()" style="background:none; border:1px solid red; color:red; padding:10px; cursor:pointer;">PANELİ KAPAT</button
