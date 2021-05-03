var express = require('express');
var router = express.Router();

// Require controller modules.
var report_controller = require('../controllers/ReportController');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

// GET request for report
router.get('/report', report_controller.download);


module.exports = router;
