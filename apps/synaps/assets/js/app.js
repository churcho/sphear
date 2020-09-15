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

particlesJS.load('particles-js2', 'particlesjs-config.json', function() {
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

/*
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
*/

/* demo 2 */

const colorArray = ["#426F42", "#262626", "#36648B", "#683A5E", "#683A5E", "#36648B"];
const slides = document.querySelectorAll("section");
const container = document.querySelector("#panelWrap");
let dots = document.querySelector(".dots");
let toolTips = document.querySelectorAll(".toolTip");
let oldSlide = 0;
let activeSlide = 0;
let navDots = [];
let dura = 0.6;
let offsets = [];
let toolTipAnims = [];
let ih = window.innerHeight;
const mouseAnim = gsap.timeline({ repeat: -1, repeatDelay: 1 });
const handAnim = gsap.timeline({ repeat: -1, repeatDelay: 1 });
const cursorAnim = gsap.timeline({ repeat: -1, repeatDelay: 1 });
const arrowAnim = gsap.timeline({ repeat: -1, repeatDelay: 1 });
document.querySelector("#upArrow").addEventListener("click", slideAnim);
document.querySelector("#downArrow").addEventListener("click", slideAnim);

// create nev dots and add tooltip listeners
for (let i = 0; i < slides.length; i++) {
    let tl = gsap.timeline({ paused: true, reversed: true });
    gsap.set(slides[i], { backgroundColor: colorArray[i] });
    let newDot = document.createElement("div");
    newDot.className = "dot";
    newDot.index = i;
    navDots.push(newDot);
    newDot.addEventListener("click", slideAnim);
    newDot.addEventListener("mouseenter", dotHover);
    newDot.addEventListener("mouseleave", dotHover);
    dots.appendChild(newDot);
    offsets.push(-slides[i].offsetTop);
    tl.to(toolTips[i], 0.25, { opacity: 1, ease: Linear.easeNone });
    toolTipAnims.push(tl);
}

// icon animations for slide 1
mouseAnim.fromTo("#mouseRings circle", { attr: { r: 12 } }, { duration: 0.8, stagger: 0.25, attr: { r: 40 } });
mouseAnim.fromTo("#mouseRings circle", { opacity: 0 }, { duration: 0.4, stagger: 0.25, opacity: 1 }, 0);
mouseAnim.fromTo("#mouseRings circle", { opacity: 1 }, { duration: 0.4, stagger: 0.25, opacity: 0 }, 0.4);

handAnim.to("#hand", { duration: 0.75, y: -16, rotation: 5, transformOrigin: "right bottom" });
handAnim.to("#hand", { duration: 0.5, y: 15, ease: "power3.inOut" });
handAnim.to("#hand", { duration: 1, y: 0, rotation: 0 });

gsap.set("#cursor", { rotation: 240, transformOrigin: "center center", x: -25 });
cursorAnim.to("#cursor", 0.25, { duration: 0.25, y: -24 });
cursorAnim.to("#iconCircles circle", { duration: 0.5, stagger: 0.15, attr: { r: 6 } }, "expand");
cursorAnim.to("#cursor", { duration: 1.1, y: 50 }, "expand");
cursorAnim.to("#cursor", { duration: 0.75, y: 0 }, "contract");
cursorAnim.to("#iconCircles circle", { duration: 0.5, attr: { r: 4 } }, "contract");

arrowAnim.to("#caret", { duration: 0.5, attr: { points: "30 40, 50 65, 70 40" }, repeat: 3, yoyo: true, ease: "power2.inOut", repeatDelay: 0.25 });

// get elements positioned
gsap.set(".dots", { yPercent: -50 });
gsap.set(".toolTips", { yPercent: -50 });

// side screen animation with nav dots
const dotAnim = gsap.timeline({ paused: true });
dotAnim.to(
    ".dot", {
        stagger: { each: 1, yoyo: true, repeat: 1 },
        scale: 2.1,
        rotation: 0.1,
        ease: "none"
    },
    0.5
);
dotAnim.time(1);

// tooltips hovers
function dotHover() {
    toolTipAnims[this.index].reversed() ? toolTipAnims[this.index].play() : toolTipAnims[this.index].reverse();
}

// figure out which of the 4 nav controls called the function
function slideAnim(e) {

    oldSlide = activeSlide;
    // dragging the panels
    if (this.id === "dragger") {
        activeSlide = offsets.indexOf(this.endY);
    } else {
        if (gsap.isTweening(container)) {
            return;
        }
        // up/down arrow clicks
        if (this.id === "downArrow" || this.id === "upArrow") {
            activeSlide = this.id === "downArrow" ? (activeSlide += 1) : (activeSlide -= 1);
            // click on a dot
        } else if (this.className === "dot") {
            activeSlide = this.index;
            // scrollwheel
        } else {
            activeSlide = e.deltaY > 0 ? (activeSlide += 1) : (activeSlide -= 1);
        }
    }
    // make sure we're not past the end or beginning slide
    activeSlide = activeSlide < 0 ? 0 : activeSlide;
    activeSlide = activeSlide > slides.length - 1 ? slides.length - 1 : activeSlide;
    if (oldSlide === activeSlide) {
        return;
    }
    // if we're dragging we don't animate the container
    if (this.id != "dragger") {
        gsap.to(container, dura, { y: offsets[activeSlide], ease: "power2.inOut", onUpdate: tweenDot });
    }
}

gsap.set(".hideMe", { opacity: 1 });
window.addEventListener("wheel", slideAnim);
window.addEventListener("resize", newSize);

// make the container a draggable element
let dragMe = Draggable.create(container, {
    type: "y",
    edgeResistance: 1,
    onDragEnd: slideAnim,
    onDrag: tweenDot,
    onThrowUpdate: tweenDot,
    snap: offsets,
    inertia: true,
    zIndexBoost: false,
    allowNativeTouchScrolling: false,
    bounds: "#masterWrap"
});

dragMe[0].id = "dragger";
newSize();

// resize all panels and refigure draggable snap array
function newSize() {
    offsets = [];
    ih = window.innerHeight;
    gsap.set("#panelWrap", { height: slides.length * ih });
    gsap.set(slides, { height: ih });
    for (let i = 0; i < slides.length; i++) {
        offsets.push(-slides[i].offsetTop);
    }
    gsap.set(container, { y: offsets[activeSlide] });
    dragMe[0].vars.snap = offsets;
}

// tween the dot animation as the draggable moves
function tweenDot() {
    gsap.set(dotAnim, {
        time: Math.abs(gsap.getProperty(container, "y") / ih) + 1
    });
}