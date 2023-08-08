module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require("daisyui")
  ],
  daisyui: {
    themes: [
      "fantasy",
    ],
  },
  theme: {
    extend: {
      fontFamily: {
        'dotgothic': ['DotGothic16', 'sans-serif'],
        'rocknroll': ['RocknRoll One', 'sans-serif'],
        'rowdies': ['Rowdies', 'cursive'],
        'yusei': ['Yusei Magic', 'sans-serif']
      }
    }
  },
}
