/*
 * deploy.api.js
 * Copyright (C) 2019 pavle <pavle.portic@tilda.center>
 *
 * Distributed under terms of the BSD-3-Clause license.
 */

import Axios from 'axios';

export default class DeployApi {
	static updateStack() {
		return Axios.post('/deploy');
	}
}
