Model = require 'models/base/model'

module.exports = class Photo extends Model
  defaults:
    author: null
    data: null
    location: null
    path: null
    stars: null
    tags: []
