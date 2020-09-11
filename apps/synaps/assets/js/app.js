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

gsap.set('svg', {
    visibility: 'visible'
})

let svgns = "http://www.w3.org/2000/svg";
let container = select("#lava_container");
let twoPi = Math.PI * 2;

for (let i = 0; i < 25; i++) {
    createCircle();
}

function createCircle() {

    var circle = document.createElementNS(svgns, "circle");
    container.appendChild(circle);

    var radius = Math.random() < 0.35 ? gsap.utils.random(-30, 30) : gsap.utils.random(-50, 50);


    gsap.set(circle, {
        attr: { r: gsap.utils.random(4, 7), cx: "50%", cy: 170 },
        x: gsap.utils.random(-twoPi, twoPi),
        y: gsap.utils.random(-twoPi, twoPi)
    });

    let swarmTl = gsap.timeline();
    swarmTl.to(circle, {
            duration: gsap.utils.random(2, 7),
            x: "+=" + twoPi,
            repeat: -1,
            modifiers: {
                x: gsap.utils.unitize(x => (Math.cos(x) * radius), 'px')
            },
            ease: 'none'
        })
        .to(circle, {
            duration: 2,
            y: "+=" + twoPi,
            repeat: -1,
            modifiers: {
                y: gsap.utils.unitize(y => (Math.sin(y) * radius), 'px')
            },
            ease: 'none'
        }, 0);
}

gsap.set('#reflection', {
    scaleY: -1,
    y: 210,
    opacity: 0.12
})

gsap.to('#gridBox, #ring', {
    duration: 0.061,
    opacity: 'random(0.64, 0.97)',
    ease: 'sine.inOut',
    repeatRefresh: true,
    repeat: -1
})

gsap.to('.gridBox', {
    attr: {
        y: gsap.utils.wrap(['+=40', '+=20', 0])
    },
    ease: 'sine.inOut',
    repeat: -1,
    yoyo: true,
    duration: 1.4,
})

gsap.to('#ring', {
    scale: 1.25,
    transformOrigin: '50% 50%',
    ease: 'sine.inOut',
    repeat: -1,
    yoyo: true,
    duration: 1.4,
})
gsap.to('#ring2', {
    scale: 1.1,
    y: 3,
    transformOrigin: '50% 50%',
    ease: 'sine.inOut',
    repeat: -1,
    yoyo: true,
    duration: 1.4,
    stagger: 0.5
})


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