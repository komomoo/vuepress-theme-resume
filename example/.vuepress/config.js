module.exports = {
  base: '/vuepress-theme-resume/example/dist/',
  dest: 'example/dist',
  theme: 'resume',
  themeConfig: {
    sidebar: [
      {
        collapsable: false,
        children: ['/']
      }
    ]
  }
}
