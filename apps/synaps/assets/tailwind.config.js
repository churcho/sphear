module.exports = {
    purge: {
        content: [
            "../**/*.html.eex",
            "../**/*.html.leex",
            "../**/views/**/*.ex",
            "../**/live/**/*.ex",
            "../js/**/*.js",
        ],
    },
    theme: {
        extend: {
            boxShadow: {
                top: '0px -5px 5px 1px rgba(0, 0, 0, 0.3)'
            },
            scale: {
                '60': '.6'
            },
            spacing: {
                '3-5': '0.91rem',
                '7': '1.69rem',
                '11': '2.65rem',
                '15': '3.79rem',
                '72': '20rem'
            }
        },
    },
    variants: {},
    plugins: [],
}