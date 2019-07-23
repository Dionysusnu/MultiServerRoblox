const express = require('express');
const app = express();

app.use(express.json());

const servers = [];

app.post('/bot', async (req, res) => {
	switch (req.body.type) {
	case 'heartbeat': {
		servers[req.body.num] = req.body.players;
		res.end();
		break;
	}
	case 'getservers': {
		res.json(servers);
		break;
	}
	}
});

app.get('/bot', async (req, res) => {
	res.status(405).end();
});

const port = process.env.PORT || process.env.OPENSHIFT_NODEJS_PORT || 8080,
	ip = process.env.IP || process.env.OPENSHIFT_NODEJS_IP || '0.0.0.0';

app.listen(port, ip);
console.log('App listening on http://%s:%s', ip, port);