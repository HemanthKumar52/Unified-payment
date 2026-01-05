const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const paymentRoutes = require('./routes/paymentRoutes');

const app = express();

app.use(cors());
app.use(bodyParser.json());

app.use('/payments', paymentRoutes);

app.get('/', (req, res) => {
  res.send({ status: 'UnifiedPay API is running' });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`UnifiedPay Backend running on port ${PORT}`);
});
