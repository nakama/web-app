Collection = require 'models/base/collection'
Photo      = require 'models/photo'

module.exports = class Photos extends Collection
  model: Photo
  url: '/photos.json'
