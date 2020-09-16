import MainView from './main';
import { gsap } from "gsap";
import { ScrollToPlugin } from "gsap/ScrollToPlugin";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { Draggable } from "gsap/Draggable";
import { InertiaPlugin } from "gsap/InertiaPlugin";

gsap.registerPlugin(ScrollToPlugin);
gsap.registerPlugin(ScrollTrigger);
gsap.registerPlugin(Draggable);
gsap.registerPlugin(InertiaPlugin);

export default class Demo extends MainView {
    mount() {
        /* particlesJS.load(@dom-id, @path-json, @callback (optional)); */
        particlesJS.load('particles-js', 'particlesjs-config.json', function() {
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

        super.mount();
    }

    unmount() {
        super.unmount();
    }
}