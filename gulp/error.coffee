play = require 'play'
conf = require './conf'

module.exports = (arg)->
    if not conf.silent
        play.sound 'misc/error.mp3'
    console.warn "plugin: #{arg.plugin}"
    console.warn "error: #{arg.message}"
    process.exit 1



