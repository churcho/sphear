import MainView from './main';
import { gsap } from "gsap";
import { ScrollToPlugin } from "gsap/ScrollToPlugin";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { Draggable } from "gsap/Draggable";
import { InertiaPlugin } from "gsap/InertiaPlugin";
import { Physics2DPlugin } from "gsap/Physics2DPlugin";

gsap.registerPlugin(ScrollToPlugin);
gsap.registerPlugin(ScrollTrigger);
gsap.registerPlugin(Draggable);
gsap.registerPlugin(InertiaPlugin);
gsap.registerPlugin(Physics2DPlugin);

export default class Demo2 extends MainView {
    mount() {
        /* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
        particlesJS.load('particles-js2', 'particlesjs-config.json', function() {
            console.log('Demo2 - Particles loaded');
        });

        /* Battery Pill */
        var colors = ['#B83280', '#E53E3E', '#ED8936', '#FAF089', '#48BB78', '#4299E1'];

        var dur = 1.2;
        var orientation = '';

        if (window.matchMedia("(max-width: 767px)").matches) {
            orientation = 'bottom';
        } else {
            orientation = 'right';
        }

        var tl = gsap.timeline({ repeat: -1, repeatDelay: 2 });
        gsap.utils.toArray(".box").forEach((box, i) => {
            tl.to(box, dur, { css: { 'opacity': 0.75, 'background-image': 'linear-gradient(to ' + orientation + ', ' + colors[i] + ',' + colors[i + 1] } }, '+=' + dur / 2)
        });
        tl.play();

        /* demo 2 */
        const slides = document.querySelectorAll("section");
        const container = document.querySelector("#panelWrap");
        let dots = document.querySelector(".dots");
        let toolTips = document.querySelectorAll(".toolTip");
        let oldSlide = 0;
        let activeSlide = 0;
        let lastSlide = 0;
        let navDots = [];
        let dura = 0.6;
        let offsets = [];
        let toolTipAnims = [];
        let ih = window.innerHeight;
        document.querySelector("#upArrow").addEventListener("click", slideAnim);
        document.querySelector("#downArrow").addEventListener("click", slideAnim);

        document.querySelector("#goto_cell").addEventListener("click", function() {
            activeSlide = 1;
            gsap.to(container, dura, { y: offsets[activeSlide], ease: "power2.inOut", onUpdate: tweenDot });
        });

        document.querySelector("#goto_demo").addEventListener("click", function() {
            activeSlide = 2;
            gsap.to(container, dura, { y: offsets[activeSlide], ease: "power2.inOut", onUpdate: tweenDot });
        });

        // create nev dots and add tooltip listeners
        for (let i = 0; i < slides.length; i++) {
            let tl = gsap.timeline({ paused: true, reversed: true });
            gsap.set(slides[i], { backgroundColor: 'transparent' });
            let newDot = document.createElement("div");
            newDot.className = "dot";
            newDot.index = i;
            navDots.push(newDot);
            newDot.addEventListener("click", slideAnim);
            newDot.addEventListener("mouseenter", dotHover);
            newDot.addEventListener("mouseleave", dotHover);
            dots.appendChild(newDot);
            offsets.push(-slides[i].offsetTop);
            tl.to(toolTips[i], 0.25, { opacity: 1, ease: "none" });
            toolTipAnims.push(tl);
        }

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
                if ((lastSlide + 1000) < Date.now()) {
                    lastSlide = Date.now();
                    if (this.endY > offsets[oldSlide]) {
                        activeSlide = activeSlide -= 1;
                    } else if (this.endY < offsets[oldSlide]) {
                        activeSlide = activeSlide += 1;
                    }
                }
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
                    if ((lastSlide + 1000) < Date.now()) {
                        lastSlide = Date.now();
                        activeSlide = e.deltaY > 0 ? (activeSlide += 1) : (activeSlide -= 1);
                    }
                }
            }
            // make sure we're not past the end or beginning slide
            activeSlide = activeSlide < 0 ? 0 : activeSlide;
            activeSlide = activeSlide > slides.length - 1 ? slides.length - 1 : activeSlide;
            if (oldSlide === activeSlide) {
                return;
            }
            // Restart pill if slide 1
            if (activeSlide == 1) {
                tl.restart();
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
            inertia: true,
            zIndexBoost: false,
            allowNativeTouchScrolling: false,
            bounds: "#masterWrap",
            dragClickables: false,
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

        /* demo button */

        let tl_demo = gsap.timeline({
            paused: true,
            onComplete: () => {
                tl_demo.pause();
                tl_demo.seek(0);
            }
        })

        let demo_dots = [],
            bg = document.querySelector("#featureBackground"),
            j, demo_dot;

        // create 80 dot elements and put them in an array
        for (j = 0; j < 80; j++) {
            demo_dot = document.createElement("div");
            demo_dot.setAttribute("class", "demo_dot");
            bg.appendChild(demo_dot);
            demo_dots.push(demo_dot);
        }

        //set the initial position of all the dots, and pick a random color for each from an array of colors
        tl_demo.set(demo_dots, {
            backgroundColor: "random([#663399,#84d100,#cc9900,#0066cc,#993333])",
            scale: "random(0.2, 0.5)",
            transformOrigin: "0% -0.5rem",
            x: 0,
            y: 0
        });

        tl_demo.to("#demo_button", {
            duration: 0,
            scale: 0.85
        });
        tl_demo.to("#demo_button", {
            duration: 0.7,
            ease: "elastic",
            scale: 1
        });
        tl_demo.to(demo_dots, {
            duration: 1.5,
            physics2D: {
                velocity: "random(200, 550)",
                angle: "random(0, 360)",
                friction: 0.05
            },
            delay: "random(0, 0.2)"
        }, "-=0.7");
        tl_demo.to(demo_dots, {
            duration: 1,
            opacity: 0
        }, "-=1");

        document.getElementById("demo_button").addEventListener("click", (event) => {
            tl_demo.seek(0);
            tl_demo.play();
        })


        super.mount();
    }

    unmount() {
        super.unmount();
    }
}