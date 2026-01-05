const express = require('express');
const router = express.Router();
const paymentController = require('../controllers/paymentController');

router.post('/create', paymentController.createPayment);
router.post('/execute', paymentController.executePayment);
router.get('/:id', paymentController.getPaymentStatus);

module.exports = router;
