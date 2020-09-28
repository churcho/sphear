export default class TiderView {
    // It will be executed when the document loads...
    mount() {
        console.log("TiderView init JS");
        /* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
        particlesJS.load('particles-js', 'particlesjs-config.json', function() {
            console.log('Tider - Particles loaded');
        });
    }

    // It will be executed when the document unloads...
    unmount() {}
}