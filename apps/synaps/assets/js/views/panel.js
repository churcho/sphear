export default class PanelView {
    // It will be executed when the document loads...
    mount() {
        console.log("PanelView init JS");
        /* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
        particlesJS.load('particles-js', 'particlesjs-config.json', function() {
            console.log('Panel - Particles loaded');
        });
    }

    // It will be executed when the document unloads...
    unmount() {}
}