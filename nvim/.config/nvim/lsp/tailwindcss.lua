return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ" },
  root_markers = {
    -- Generic
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
    -- Phoenix
    'assets/tailwind.config.js',
    'assets/tailwind.config.cjs',
    'assets/tailwind.config.mjs',
    'assets/tailwind.config.ts',
    -- Django
    'theme/static_src/tailwind.config.js',
    'theme/static_src/tailwind.config.cjs',
    'theme/static_src/tailwind.config.mjs',
    'theme/static_src/tailwind.config.ts',
    'theme/static_src/postcss.config.js',
    -- Rails
    'app/assets/stylesheets/application.tailwind.css',
    'app/assets/tailwind/application.css',
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      includeLanguages = {
        eelixir = "html-eex",
        elixir = "phoenix-heex",
        eruby = "erb",
        heex = "phoenix-heex",
        htmlangular = "html",
        templ = "html"
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true
    }
  }
}
