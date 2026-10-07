(function() {
    const safeSite = 'https://google.com';
    const panicKeyCode = 'Equal';

    function redirectToSafeSite() {
        window.location.replace(safeSite);
    }

    window.addEventListener('keydown', (event) => {
        if (event.code === panicKeyCode && !event.altKey && !event.ctrlKey && !event.shiftKey && !event.metaKey) {
            event.preventDefault();
            redirectToSafeSite();
        }
    });
 //Code adapted from ramazing
    console.log('Panic key active: Press the equal key to hide this page.');
})();
