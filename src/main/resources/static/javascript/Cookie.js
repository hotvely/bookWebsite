/**
 * 
 */

const getCookie = (key) => {
	const cookies = document.cookie.split(';');
	for (let elem of cookies) {
		let cookie = elem.trim();
		if (cookie.startsWith(key + '=')) {
			return decodeURIComponent(cookie.substring(key.length + 1));
		}
	}
	return null;
}

const setCookie = (key, value, min) => {
	let date = new Date();
	date.setMinutes(date.getMinutes() + min);
	// 설정 일수만큼 현재시간에 만료값으로 지정
	value = decodeURIComponent(value) + ((min == null) ? '' : ';expires=' + date.toUTCString()
		+ ";domain=localhost;path=/");

	document.cookie = `${key}=${value}`;
	console.log(document.cookie);
}