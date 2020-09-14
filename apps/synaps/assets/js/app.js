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

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let Hooks = {}
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

/* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
particlesJS.load('particles-js', 'particlesjs-config.json', function() {
    console.log('callback - particles.js config loaded');
});


let select = s => document.querySelector(s),
    selectAll = s => document.querySelectorAll(s);
/* Circles */

var tl2 = gsap.timeline({ repeat: -1, repeatDelay: 2 });

gsap.set('svg', {
    visibility: 'visible'
})


function goToSection(i, anim) {
    gsap.to(window, {
        scrollTo: { y: i * innerHeight, autoKill: false },
        duration: 0.1
    });

    if (i == 1) {
        console.log(i)
        tl2.restart();
    }

    if (anim) {
        anim.restart();
    }
}

var colors = ['#B83280', '#E53E3E', '#ED8936', '#FAF089', '#48BB78', '#4299E1'];

var dur = 1.2;
var orientation = '';

if (window.matchMedia("(max-width: 767px)").matches) {
    orientation = 'bottom';
} else {
    orientation = 'right';
}

gsap.utils.toArray(".box").forEach((box, i) => {

    tl2.to(box, dur, { css: { 'opacity': 0.75, 'background-image': 'linear-gradient(to ' + orientation + ', ' + colors[i] + ',' + colors[i + 1] } }, '+=' + dur / 2)
});
tl2.play();

gsap.utils.toArray(".panel").forEach((panel, i) => {
    ScrollTrigger.create({
        trigger: panel,
        onEnter: () => goToSection(i)
    });

    ScrollTrigger.create({
        trigger: panel,
        start: "bottom bottom",
        onEnterBack: () => goToSection(i)
    });
});

/* Menu */
const tl = gsap.timeline();
const menus = selectAll(".menu");
menus.forEach(function(menu) {
    const allLinks = menu.querySelectorAll(".link");
    const allDivs = selectAll(".menuDiv");
    const slider = menu.querySelector(".slider");
    const focus = slider.querySelector(".focus");

    //   remove previous active classes
    const removeActiveClass = () => {
        allLinks.forEach(function(item) {
            item.classList.remove("active");
        });
        allDivs.forEach(function(item) {
            gsap.to(item, {
                css: { opacity: 0, display: "none" },
                duration: 0.2,
                ease: Power4.easeOut
            })
        });
    };

    const addActiveState = (activeElement) => {
        // removeActiveClass();

        const icon = activeElement.querySelector(".icon");
        const div = select("." + activeElement.id);
        const sliderPos = activeElement.offsetLeft + icon.offsetWidth * 0.75;

        if (!tl.isActive()) {

            tl
                .to(focus, {
                    height: 0,
                    duration: 0.2,
                    ease: Power4.easeIn,
                    onComplete: removeActiveClass
                })
                .to(slider, {
                    css: { width: icon.offsetWidth, left: sliderPos },
                    duration: 0.8,
                    ease: Power4.easeInOut
                })
                .to(focus, {
                    height: activeElement.offsetHeight * 1.4,
                    duration: 0.2,
                    ease: Power4.easeOut,
                    onComplete: () => activeElement.classList.add("active")
                })
                .to(div, {
                    css: { opacity: 1, display: "block" },
                    ease: Power4.easeInOut
                })
                .play()
        }
    };

    allLinks.forEach((link) =>
        link.addEventListener("click", () => {
            addActiveState(link);
        })
    );

    addActiveState(allLinks[0]);
});

gsap.globalTimeline.timeScale(0.75)