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
                top: '0 0 0 1px rgba(0, 0, 0, 0.05)'
            }
        },
    },
    variants: {},
    plugins: [],
}