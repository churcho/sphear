export default class LoginView {
    // It will be executed when the document loads...
    mount() {
        console.log("LoginView init JS");
        /* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
        particlesJS.load('particles-js', 'particlesjs-config.json', function() {
            console.log('Login - Particles loaded');
        });
    }

    // It will be executed when the document unloads...
    unmount() {}
}