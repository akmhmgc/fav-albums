module.exports = {
  purge: {
    content: [
      './app/**/*.html.erb',
      './app/**/*.js.erb',
      './app/helpers/**/*.rb'
    ],
    options: {
      safelist: ['a','opacity-20'],
      keyframes: true,
      fontFace: true,
    },
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
