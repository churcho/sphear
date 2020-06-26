module.exports = {
    purge: [
        "../**/*.html.eex",
        "../**/*.html.leex",
        "../**/views/**/*.ex",
        "../**/live/**/*.ex",
        "./js/**/*.js",
        "./**/templates/**/*.html.eex",
        "./**/templates/**/*.html.leex",
    ],
    theme: {
        textShadow: {
            default: '0 2px 0 #000',
            md: '0 2px 2px #000',
            h1: '0 0 3px #FF0000, 0 0 5px #0000FF',
            xl: '0 0 3px rgba(0, 0, 0, .8), 0 0 5px rgba(0, 0, 0, .9)',
            none: 'none',
        }
    },
    variants: {
        textShadow: ['responsive', 'hover'],
    },
    plugins: [
        require('tailwindcss-textshadow')
    ],
}