(function() {
    var style = document.createElement('style');
    style.innerHTML = `
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
        border-radius: 50%; /* Changed to circle */
        width: 60px;
        height: 60px;
        background-color: #800000;
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
        background-color: darken(#800000, 10%);
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
    `;
    document.head.appendChild(style);

    var button = document.createElement('button');
    button.className = 'floating-button';
    button.onclick = openPopup;

    var popup = document.createElement('div');
    popup.id = 'popup';
    popup.className = 'popup';
    popup.innerHTML = `
      <button class="close-button" onclick="closePopup()">×</button>
      <iframe src="https://floater.jessejesse.xyz" title="Floater Content"></iframe>
    `;

    document.body.appendChild(button);
    document.body.appendChild(popup);

    function openPopup() {
      document.getElementById('popup').style.display = 'block';
    }

    window.closePopup = function() {
      document.getElementById('popup').style.display = 'none';
    };
})();
