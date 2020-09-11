module.exports = {
    purge: [
        "../**/*.html.eex",
        "../**/*.html.leex",
        "../**/views/**/*.ex",
        "../**/live/**/*.ex",
        "./js/**/*.js",
    ],
    theme: {
        extend: {
            boxShadow: {
                top: '0px -5px 5px 1px rgba(0, 0, 0, 0.3)'
            },
            scale: {
                '60': '.6'
            }
        },
    },
    variants: {},
    plugins: [],
}