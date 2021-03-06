/*
 * deploy.api.js
 * Copyright (C) 2019 Vivify Ideas
 *
 * Distributed under terms of the BSD-3-Clause license.
 */

import Axios from 'axios';

export default class DeployApi {
	static updateStack(services) {
		return Axios.post('/deploy', services);
	}

	static checkStackUpdate(taskId) {
		return Axios.get(`/tasks/${taskId}`);
	}
}

