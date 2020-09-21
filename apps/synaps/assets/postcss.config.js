module.exports = {
    plugins: [
        require('tailwindcss'),
        require('autoprefixer'),
        require('postcss-fail-on-warn')
    ],
    options: {
        from: "tailwind.css"
    }
}