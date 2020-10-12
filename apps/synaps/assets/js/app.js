// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "alpinejs"
import "phoenix_html"
import { Socket } from "phoenix"
import NProgress from "nprogress"
import { LiveSocket } from "phoenix_live_view"
import "particles.js"

import { gsap } from "gsap";
import { Physics2DPlugin } from "gsap/Physics2DPlugin";
gsap.registerPlugin(Physics2DPlugin);

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
let Hooks = {};
Hooks.particlesjs = {
    mounted() {
        console.log('Particles loading..');
        if (typeof(window.pJSDom[0]) != "undefined") {
            window.pJSDom[0].pJS.fn.vendors.destroypJS();
            window["pJSDom"] = [];
        }
        /* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
        particlesJS.load('particles-js', 'particlesjs-config.json', function() {
            console.log('Particles initiated!');
        });
    }
}
Hooks.kontaktSent = {
    mounted() {
        let dots = [],
            bg = document.querySelector("#featureBackground"),
            i, dot;

        // create 80 dot elements and put them in an array
        for (i = 0; i < 100; i++) {
            dot = document.createElement("div");
            dot.setAttribute("class", "dot");
            bg.appendChild(dot);
            dots.push(dot);
        }

        //set the initial position of all the dots, and pick a random color for each from an array of colors
        gsap.set(dots, {
            backgroundColor: "random([#663399,#84d100,#cc9900,#0066cc,#993333])",
            scale: "random(0.4, 1)",
            x: document.body.clientWidth / 2,
            y: document.body.clientHeight
        });

        // create the physics2D animation
        let tween = gsap.to(dots, {
            duration: 15,
            physics2D: {
                velocity: "random(200, 450)",
                angle: "random(250, 290)",
                gravity: 85
            },
            delay: "random(0, 3)"
        });
    }
}

let liveSocket = new LiveSocket("/live", Socket, {
    dom: {
        onBeforeElUpdated(from, to) {
            if (from.__x) {
                window.Alpine.clone(from.__x, to)
            }
        }
    },
    hooks: Hooks,
    params: { _csrf_token: csrfToken }
})

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
window.liveSocket = liveSocket