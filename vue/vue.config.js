module.exports = {
    // Necessary entry to prevent errors when using "unknown" drugst.one html tag
    configureWebpack: {externals: {'drugst-one': 'ELEMENT'}}
}