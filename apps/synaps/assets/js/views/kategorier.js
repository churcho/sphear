export default class KategoriView {
    // It will be executed when the document loads...
    mount() {
        console.log("KategoriView init JS");
        /* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
        particlesJS.load('particles-js', 'particlesjs-config.json', function() {
            console.log('Kategorier - Particles loaded');
        });
    }

    // It will be executed when the document unloads...
    unmount() {}
}