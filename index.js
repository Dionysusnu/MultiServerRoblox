const express = require('express');
const app = express();

app.use(express.json());

const servers = new Map();

app.post('/bot', async (req, res) => {
	console.log(new Date() + ': POST on /bot');
	switch (req.body.type) {
	case 'heartbeat': {
		servers.set(req.body.jobId, req.body.table);
		res.sendStatus(204);
		break;
	}
	case 'getservers': {
		// console.log(servers);
		res.status(200).json(Object.fromEntries(servers));
		break;
	}
	case 'serverclose': {
		servers.delete(req.body.jobId);
		res.sendStatus(204);
	}
	}
});

app.get('/bot', async (req, res) => {
	res.sendStatus(405);
});

const port = process.env.PORT || process.env.OPENSHIFT_NODEJS_PORT || 8080,
	ip = process.env.IP || process.env.OPENSHIFT_NODEJS_IP || '0.0.0.0';

app.listen(port, ip);
console.log('App listening on http://%s:%s', ip, port);