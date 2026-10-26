async function syncLocalToRemote() {
  try {
    const text = await navigator.clipboard.readText();
    if (text !== window.lastSyncedText) {
      window.lastSyncedText = text;
      // Send string to KasmVNC clipboard buffer API
      vncClient.sendClipboard(text);
    }
  } catch (err) {
    console.warn('Clipboard read permission denied');
  }
}
