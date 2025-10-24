#!/bin/bash

# ========================================
# 🚀 AutoEmpre SaaS - GitHub Setup Script
# ========================================

echo "========================================"
echo "🚀 Bienvenido al asistente de despliegue AutoEmpre SaaS"
echo "========================================"
echo ""
echo "Este script subirá tu proyecto a GitHub automáticamente."
echo ""

# Pedir datos del usuario
read -p "👉 Ingrese su nombre de usuario de GitHub: " GITHUB_USER
read -p "👉 Ingrese el nombre del repositorio (por defecto: autoempre-saas): " REPO_NAME
REPO_NAME=${REPO_NAME:-autoempre-saas}
read -p "👉 Ingrese su token personal de GitHub: " TOKEN

# Validar entrada
if [ -z "$GITHUB_USER" ] || [ -z "$TOKEN" ]; then
  echo "❌ Error: Debes ingresar usuario y token."
  exit 1
fi

echo ""
echo "✅ Creando repositorio remoto en GitHub..."
echo ""

# Crear repositorio remoto usando la API de GitHub
curl -u "$GITHUB_USER:$TOKEN" https://api.github.com/user/repos -d "{\"name\":\"$REPO_NAME\"}"

# Inicializar git si no existe
if [ ! -d ".git" ]; then
  git init
fi

git add .
git commit -m "🚀 Primer commit de AutoEmpre SaaS"
git branch -M main

# Configurar remoto
git remote remove origin 2>/dev/null
git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git

echo ""
echo "📤 Subiendo archivos al repositorio..."
git push -u origin main

echo ""
echo "✅ Proyecto subido exitosamente a:"
echo "👉 https://github.com/$GITHUB_USER/$REPO_NAME"
echo ""
echo "💡 Consejo: Ahora puedes conectarlo a Render, Railway o Vercel según la guía GUIDE.md"
echo "========================================"
