#!/bin/bash

echo "Floater-xyz button API"
read -p "Enter the full URL for the floater button: " floater_url
read -p "Enter the color in hex, e.g., #000 for black: " floater_color

#floater.js
cat <<EOL > floater.js
(function() {
    var style = document.createElement('style');
    style.innerHTML = \`
      .floating-button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        transition: background-color 0.3s ease;
        z-index: 1000;
        border-radius: 50%;
        width: 60px;
        height: 60px;
        background-color: ${floater_color};
      }
      .floating-button::before {
        content: '+';
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: #ffffff;
        font-size: 24px;
        line-height: 1;
        text-align: center;
      }
      .floating-button:hover {
        background-color: darken(${floater_color}, 10%);
      }
      .popup {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 80%;
        max-width: 600px;
        background-color: #2d3748;
        color: #e5e7eb;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        z-index: 1001;
      }
      .popup iframe {
        width: 100%;
        height: 400px;
        border: none;
      }
      .popup .close-button {
        position: absolute;
        top: 10px;
        right: 10px;
        background-color: #e74c3c;
        border: none;
        color: #ffffff;
        border-radius: 50%;
        width: 30px;
        height: 30px;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
      }
    \`;
    document.head.appendChild(style);

    var button = document.createElement('button');
    button.className = 'floating-button';
    button.onclick = openPopup;

    var popup = document.createElement('div');
    popup.id = 'popup';
    popup.className = 'popup';
    popup.innerHTML = \`
      <button class="close-button" onclick="closePopup()">×</button>
      <iframe src="${floater_url}" title="Floater Content"></iframe>
    \`;

    document.body.appendChild(button);
    document.body.appendChild(popup);

    // Drag-and-drop functionality
    let isDragging = false;
    let offsetX, offsetY;

    button.addEventListener('mousedown', (e) => {
      isDragging = true;
      offsetX = e.clientX - button.getBoundingClientRect().left;
      offsetY = e.clientY - button.getBoundingClientRect().top;
      document.addEventListener('mousemove', onMouseMove);
      document.addEventListener('mouseup', onMouseUp);
    });

    function onMouseMove(e) {
      if (isDragging) {
        button.style.left = \`\${e.clientX - offsetX}px\`;
        button.style.top = \`\${e.clientY - offsetY}px\`;
      }
    }

    function onMouseUp() {
      isDragging = false;
      document.removeEventListener('mousemove', onMouseMove);
      document.removeEventListener('mouseup', onMouseUp);
    }

    function openPopup() {
      document.getElementById('popup').style.display = 'block';
    }

    window.closePopup = function() {
      document.getElementById('popup').style.display = 'none';
    };
})();
EOL

# index.html
cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Floater Bash Button</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
    </style>
</head>
<body class="bg-gray-900 text-gray-100 flex flex-col min-h-screen">
    <div class="flex-grow flex items-center justify-center">
        <h1 class="text-white text-6xl font-bold">npx floater-xyz</h1>
    </div>
    <!-- floater.js -->
    <script src="floater.js"></script>
    <footer class="text-gray-300 text-center p-2 text-sm mt-auto">
         JesseJesse.xyz
    </footer>
</body>
</html>
EOL

echo "Floater.xyz Button is complete!"

