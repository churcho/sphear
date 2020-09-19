import MainView from './main';
import { gsap } from "gsap";
import { ScrollToPlugin } from "gsap/ScrollToPlugin";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { Draggable } from "gsap/Draggable";
import { InertiaPlugin } from "gsap/InertiaPlugin";
import { Physics2DPlugin } from "gsap/Physics2DPlugin";
import { TextPlugin } from "gsap/TextPlugin";
import { EasePack } from "gsap/EasePack";

gsap.registerPlugin(ScrollToPlugin);
gsap.registerPlugin(ScrollTrigger);
gsap.registerPlugin(Draggable);
gsap.registerPlugin(InertiaPlugin);
gsap.registerPlugin(Physics2DPlugin);
gsap.registerPlugin(TextPlugin);
gsap.registerPlugin(EasePack);

export default class Demo extends MainView {
    mount() {
        /* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
        particlesJS.load('particles-js2', 'particlesjs-config.json', function() {
            console.log('Demo - Particles loaded');
        });

        /* Front page text */
        const words = ["Möjligheter.", "Kanaler.", "Rutiner.", "Lösningar.", "🚀"]

        gsap.to('.cursor', { opacity: 0, duration: 1, ease: "power2.inOut", repeat: -1 })
        let masterTl = gsap.timeline({ repeat: -1 }).pause()

        words.forEach(word => {
            let tl_text = gsap.timeline({ repeat: 1, yoyo: true, repeatDelay: 1 })
            tl_text.to('.text', { duration: 1.5, text: word })
            masterTl.add(tl_text)
        });
        masterTl.play();

        /* Battery Pill */
        var colors = ['#B83280', '#E53E3E', '#ED8936', '#FAF089', '#48BB78', '#4299E1'];

        var dur = 1.2;
        var orientation = '';

        if (window.matchMedia("(max-width: 767px)").matches) {
            orientation = 'bottom';
        } else {
            orientation = 'right';
        }

        /* order svg */
        var order_body_fills = ["#a5cdff", "#8abfff", "#ff6978", "#eb616f", "#ccf49f", "#b3e59f", "#71aaf0", "#db4b59", "#95d6a4"];
        var order_head_fills = ["#ffcbbe", "#ffcbbe", "#477b9e", "#ffe5a0", "#ffcbbe", "#d09080", "#f7beaf", "#f2ce7e", "#f7beaf", "#be694f", "#f7beaf", "#365e7d"];
        var order_board_fills = ["#cbe2ff", "#cbe2ff", "#cbe2ff", "#f2ce7e", "#f2ce7e", "#f2ce7e"];
        var order_info_fills = ["#95d6a4", "#c19ee3", "#79b2ff", "#477b9e", "#477b9e", "#477b9e"];
        const order_board_1 = document.querySelector("#order_board_1");
        const order_board_2 = document.querySelector("#order_board_2");
        const order_board_3 = document.querySelector("#order_board_3");

        /* stats svg */
        var stats_dude_fills = ["#ffcbbe", "#ffcbbe", "#d8a595", "#d09080", "#ffe5a0", "#477b9e", "#b3e59f", "#d7bef0", "#8abfff", "#f7beaf", "#be694f", "#f7beaf", "#f2ce7e", "#d09080", "#365e7d", "#ebd2ff", "#a5cdff", "#ccf49f"];
        const stats_bg_1 = document.querySelector("#stats_bg_1");
        const stats_bg_2 = document.querySelector("#stats_bg_2");
        const stats_bar_1 = document.querySelector("#stats_bar_1");
        const stats_bar_2 = document.querySelector("#stats_bar_2");
        const stats_bar_3 = document.querySelector("#stats_bar_3");
        const stats_bar_4 = document.querySelector("#stats_bar_4");
        const stats_graph = document.querySelector("#stats_graph");

        /* booking svg */
        const booking_bg = document.querySelector(".booking_bg");
        const booking_mobile_a = document.querySelector("#booking_mobile_a")
        const booking_mobile_b = document.querySelector("#booking_mobile_b")
        const booking_mobile_c = document.querySelector("#booking_mobile_c")
        const booking_mobile_d = document.querySelector("#booking_mobile_d")
        const booking_mobile_e = document.querySelector("#booking_mobile_e")
        const booking_mobile_f = document.querySelector("#booking_mobile_f")
        const booking_mobile_g = document.querySelector("#booking_mobile_g")
        const booking_mobile_h = document.querySelector("#booking_mobile_h")
        const booking_mobile_i = document.querySelector("#booking_mobile_i")
        const booking_mobile_j = document.querySelector("#booking_mobile_j")

        const booking_calendar = document.querySelector("#booking_calendar")
        const booking_cal_a = document.querySelector("#booking_cal_a")
        const booking_cal_b = document.querySelector("#booking_cal_b")
        const booking_cal_c = document.querySelector("#booking_cal_c")
        const booking_cal_d = document.querySelector("#booking_cal_d")
        const booking_cal_e = document.querySelector("#booking_cal_e")
        const booking_cal_f = document.querySelector("#booking_cal_f")
        const booking_cal_g = document.querySelector("#booking_cal_g")
        const booking_cal_h = document.querySelector("#booking_cal_h")

        /* swish svg */
        const swish_text = document.querySelector(".swish_text");
        const swish_left_swirl_1 = document.querySelector(".swish_left_swirl_1");
        const swish_left_swirl_2 = document.querySelector(".swish_left_swirl_2");
        const swish_right_swirl_1 = document.querySelector(".swish_right_swirl_1");
        const swish_right_swirl_2 = document.querySelector(".swish_right_swirl_2");
        /* bank id svg */
        const bankid_text = document.querySelector(".bankid_text");
        const bankid_left = document.querySelector(".bankid_left");
        const bankid_right = document.querySelector(".bankid_right");

        var tl = gsap.timeline({ repeat: -1, repeatDelay: 2 });
        gsap.utils.toArray(".box").forEach((box, i) => {
            tl.to(box, dur / 2, { css: { 'opacity': 0.75, 'background-image': 'linear-gradient(to ' + orientation + ', ' + colors[i] + ',' + colors[i + 1] } }, '+=' + dur / 3)
            if (i == 0) {
                tl.to(booking_bg, dur / 4, { css: { 'fill': '#55a4f9' } }, "bg")
                tl.to(booking_mobile_a, dur / 4, { css: { 'fill': '#453d83' } }, 'bg+=' + dur / 5)
                tl.to(booking_mobile_b, dur / 4, { css: { 'fill': '#51489a' } }, 'bg+=' + dur / 5)
                tl.to(booking_mobile_c, dur / 4, { css: { 'fill': '#e9f3fe' } }, 'bg+=' + dur / 3)
                tl.to(booking_mobile_d, dur / 4, { css: { 'fill': '#82cd64' } }, 'bg+=' + dur / 4)
                tl.to(booking_mobile_e, dur / 4, { css: { 'fill': '#c0e6b1' } }, 'bg+=' + dur / 3)
                tl.to(booking_mobile_f, dur / 4, { css: { 'fill': '#6dc54a' } }, 'bg+=' + dur / 3)
                tl.to(booking_mobile_g, dur / 4, { css: { 'fill': '#a7d0fc' } }, 'bg+=' + dur / 2)
                tl.to(booking_mobile_h, dur / 4, { css: { 'fill': '#5db33a' } }, 'bg+=' + dur / 2)
                tl.to(booking_mobile_i, dur / 4, { css: { 'fill': '#c50048' } }, 'bg+=' + dur)
                tl.to(booking_mobile_j, dur / 4, { css: { 'fill': '#f44545' } }, 'bg+=' + dur)

                tl.to(booking_calendar, dur, { css: { 'opacity': 1 } }, "cal")
                tl.to(booking_cal_a, dur / 4, { css: { 'fill': '#ffe1aa' } }, 'cal+=' + dur / 2)
                tl.to(booking_cal_b, dur / 4, { css: { 'fill': '#ffd993' } }, 'cal+=' + dur / 2)
                tl.to(booking_cal_c, dur / 4, { css: { 'fill': '#c50048' } }, 'cal+=' + dur / 4)
                tl.to(booking_cal_d, dur / 4, { css: { 'fill': '#f44545' } }, 'cal+=' + dur / 4)
                tl.to(booking_cal_e, dur / 4, { css: { 'fill': '#ffc14f' } }, 'cal+=' + dur / 4)
                tl.to(booking_cal_f, dur / 4, { css: { 'fill': '#82cd64' } }, 'cal+=' + dur)
                tl.to(booking_cal_g, dur / 4, { css: { 'fill': '#6dc54a' } }, 'cal+=' + dur)
                tl.to(booking_cal_h, dur / 4, { css: { 'fill': '#fff5f5' } }, 'cal+=' + dur)
            }
            if (i == 1) {
                tl.to(order_board_1, dur / 2, { css: { 'fill': '#e1f1ff' } }, "order");
                tl.to(order_board_2, dur / 2, { css: { 'fill': '#e1f1ff' } });
                tl.to(order_board_3, dur / 2, { css: { 'fill': '#e1f1ff' } });
                for (let ii = 3; ii < order_board_fills.length + 3; ii++) {
                    /* skip first harcoded 3 */
                    const g = document.querySelector("#order_board_" + (ii + 1));
                    tl.to(g, dur / 4, { css: { 'fill': order_board_fills[ii - 3] } }, 'order+=0.2');
                }
                for (let ii = 0; ii < order_info_fills.length; ii++) {
                    const g = document.querySelector("#order_info_" + (ii + 1));
                    tl.to(g, dur / 2, { css: { 'fill': order_info_fills[ii] } }, 'order+=0.3');
                }
                for (let ii = 0; ii < order_head_fills.length; ii++) {
                    const g = document.querySelector("#order_head_" + (ii + 1));
                    tl.to(g, dur / 2, { css: { 'fill': order_head_fills[ii] } }, 'order+=1');
                }
                for (let ii = 0; ii < order_body_fills.length; ii++) {
                    const g = document.querySelector("#order_body_" + (ii + 1));
                    tl.to(g, dur, { css: { 'fill': order_body_fills[ii] } }, 'order+=1.4');
                }
            }
            if (i == 2) {
                tl.to(stats_bg_1, dur / 2, { css: { 'fill': "#e1f1ff", 'opacity': 0 } }, "stats")
                for (let ii = 0; ii < stats_dude_fills.length; ii++) {
                    const g = document.querySelector("#stats_dude_" + (ii + 1));
                    tl.to(g, dur / 2, { css: { 'fill': stats_dude_fills[ii] } }, 'stats+=0.2');
                }
                tl.to(stats_bar_1, dur / 2, { css: { 'fill': "#3eba0d", 'opacity': 1 } }, "stats+=1")
                tl.to(stats_bar_2, dur / 2, { css: { 'fill': "#3eba0d", 'opacity': 1 } }, "stats+=1")
                tl.to(stats_bar_3, dur / 2, { css: { 'fill': "#3eba0d", 'opacity': 1 } }, "stats+=1")
                tl.to(stats_bar_4, dur / 2, { css: { 'fill': "#3eba0d", 'opacity': 1 } }, "stats+=1")

                tl.to(stats_graph, dur / 2, { css: { 'fill': "#90ee90" } }, "stats+=1.3")
            }
            if (i == 3) {
                tl.to(swish_text, dur / 2, { css: { 'fill': '#000' } }, "swish")
                tl.to(swish_left_swirl_1, 0, { css: { 'fill': "url(#linearGradient-3)" } }, '>' + dur / 5)
                tl.to(swish_left_swirl_2, 0, { css: { 'fill': "url(#linearGradient-4)" } }, '>' + dur / 5)
                tl.to(swish_right_swirl_1, 0, { css: { 'fill': "url(#linearGradient-1)" } }, '>' + dur / 5)
                tl.to(swish_right_swirl_2, 0, { css: { 'fill': "url(#linearGradient-2)" } }, '>' + dur / 5)
            }
            if (i == 4) {
                tl.to(bankid_text, dur / 3, { css: { 'fill': '#000' } }, "bankid")
                tl.to(bankid_left, dur / 3, { css: { 'fill': '#479CBE' } }, 'bankid+=' + dur / 3)
                tl.to(bankid_right, dur / 3, { css: { 'fill': '#235971' } }, 'bankid+=' + dur / 2)
            }
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
            // Restart pill
            tl.restart();
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
            newDot.addEventListener("touchleave", dotHover);
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
            zIndexBoost: true,
            bounds: "#masterWrap",
            dragClickables: false,
            snap: offsets
        });

        dragMe[0].id = "dragger";
        newSize();
        gsap.to(container, 0, { y: offsets[0] });

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

        // create 90 dot elements and put them in an array
        for (j = 0; j < 90; j++) {
            demo_dot = document.createElement("div");
            demo_dot.setAttribute("class", "demo_dot");
            bg.appendChild(demo_dot);
            demo_dots.push(demo_dot);
        }

        //set the initial position of all the dots, and pick a random color for each from an array of colors
        tl_demo.set(demo_dots, {
            backgroundColor: '#828282', //"random([#663399,#84d100,#cc9900,#0066cc,#993333])",
            scale: "random(0.05, 0.1)",
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

        gsap.globalTimeline.timeScale(1.1);
        super.mount();
    }

    unmount() {
        super.unmount();
    }
}