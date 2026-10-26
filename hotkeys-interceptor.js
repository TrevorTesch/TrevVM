window.addEventListener('keydown', (e) => {
  // Prevent browser from closing tab or opening new windows on system hotkeys
  if ((e.ctrlKey || e.metaKey) && ['w', 't', 'n', 'r'].includes(e.key.toLowerCase())) {
    e.preventDefault();
    // Forward key code down to the KasmVNC canvas handler
    sendVncKeyEvent(e.code, true);
  }
}, { capture: true });
