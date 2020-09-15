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


// Slider(all Slides in a container)
const slider = document.querySelector(".slider3")
    // All trails 
const trail = document.querySelector(".trail").querySelectorAll("div")

// Transform value
let value = 0
    // trail index number
let trailValue = 0
    // interval (Duration)
let interval = 4000

// Function to slide forward
const slide = (condition) => {
    // CLear interval
    clearInterval(start)
        // update value and trailValue
    condition === "increase" ? initiateINC() : initiateDEC()
        // move slide
    move(value, trailValue)
        // Restart Animation
    animate()
        // start interal for slides back 
    start = setInterval(() => slide("increase"), interval);
}

// function for increase(forward, next) configuration
const initiateINC = () => {
    // Remove active from all trails
    trail.forEach(cur => cur.classList.remove("active"))
        // increase transform value
    value === 80 ? value = 0 : value += 20
        // update trailValue based on value
    trailUpdate()
}

// function for decrease(backward, previous) configuration
const initiateDEC = () => {
    // Remove active from all trails
    trail.forEach(cur => cur.classList.remove("active"))
        // decrease transform value
    value === 0 ? value = 80 : value -= 20
        // update trailValue based on value
    trailUpdate()
}

// function to transform slide 
const move = (S, T) => {
    // transform slider
    slider.style.transform = `translateX(-${S}%)`
        //add active class to the current trail
    trail[T].classList.add("active")
}

const tl3 = gsap.timeline({ defaults: { duration: 0.6, ease: "power2.inOut" } })
tl3.from(".bg", { x: "-100%", opacity: 0 })
    .from("p", { opacity: 0 }, "-=0.3")
    .from("h1", { opacity: 0, y: "30px" }, "-=0.3")
    .from("button", { opacity: 0, y: "-40px" }, "-=0.8")

// function to restart animation
const animate = () => tl3.restart()

// function to update trailValue based on slide value
const trailUpdate = () => {
    if (value === 0) {
        trailValue = 0
    } else if (value === 20) {
        trailValue = 1
    } else if (value === 40) {
        trailValue = 2
    } else if (value === 60) {
        trailValue = 3
    } else {
        trailValue = 4
    }
}

// Start interval for slides
let start = setInterval(() => slide("increase"), interval)

// Next  and  Previous button function (SVG icon with different classes)
document.querySelectorAll("svg").forEach(cur => {
    // Assign function based on the class Name("next" and "prev")
    cur.addEventListener("click", () => cur.classList.contains("next") ? slide("increase") : slide("decrease"))
})

// function to slide when trail is clicked
const clickCheck = (e) => {
    // CLear interval
    clearInterval(start)
        // remove active class from all trails
    trail.forEach(cur => cur.classList.remove("active"))
        // Get selected trail
    const check = e.target
        // add active class
    check.classList.add("active")

    // Update slide value based on the selected trail
    if (check.classList.contains("box1")) {
        value = 0
    } else if (check.classList.contains("box2")) {
        value = 20
    } else if (check.classList.contains("box3")) {
        value = 40
    } else if (check.classList.contains("box4")) {
        value = 60
    } else {
        value = 80
    }
    // update trail based on value
    trailUpdate()
        // transfrom slide
    move(value, trailValue)
        // start animation
    animate()
        // start interval
    start = setInterval(() => slide("increase"), interval)
}

// Add function to all trails
trail.forEach(cur => cur.addEventListener("click", (ev) => clickCheck(ev)))

// Mobile touch Slide Section
const touchSlide = (() => {
    let start, move, change, sliderWidth

    // Do this on initial touch on screen
    slider.addEventListener("touchstart", (e) => {
        // get the touche position of X on the screen
        start = e.touches[0].clientX
            // (each slide with) the width of the slider container divided by the number of slides
        sliderWidth = slider.clientWidth / trail.length
    })

    // Do this on touchDrag on screen
    slider.addEventListener("touchmove", (e) => {
        // prevent default function
        e.preventDefault()
            // get the touche position of X on the screen when dragging stops
        move = e.touches[0].clientX
            // Subtract initial position from end position and save to change variabla
        change = start - move
    })

    const mobile = (e) => {
            // if change is greater than a quarter of sliderWidth, next else Do NOTHING
            change > (sliderWidth / 4) ? slide("increase") : null;
            // if change * -1 is greater than a quarter of sliderWidth, prev else Do NOTHING
            (change * -1) > (sliderWidth / 4) ? slide("decrease"): null;
            // reset all variable to 0
            [start, move, change, sliderWidth] = [0, 0, 0, 0]
        }
        // call mobile on touch end
    slider.addEventListener("touchend", mobile)
})()

//reset scrollbar position after refresh
window.onbeforeunload = function() {
    window.scrollTo(0, 0);
}