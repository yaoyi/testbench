(function (module) {

  "use strict";

  var mongoose = require('mongoose')
    , QrcodeSchema;

  QrcodeSchema = new mongoose.Schema({
    image: { 'type': String}
  });

  module.exports.schema = QrcodeSchema;
  module.exports = mongoose.model('Qrcode', QrcodeSchema);

}(module));